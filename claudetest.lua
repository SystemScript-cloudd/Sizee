-- ============================================================
-- SERVICES
-- ============================================================
local Players           = game:GetService("Players")
local RunService        = game:GetService("RunService")
local UserInputService  = game:GetService("UserInputService")
local TweenService      = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")
local Workspace         = game:GetService("Workspace")
local Lighting          = game:GetService("Lighting")
local TeleportService   = game:GetService("TeleportService")
local HttpService        = game:GetService("HttpService")

local Camera      = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer
local PlayerGui   = LocalPlayer:WaitForChild("PlayerGui")

-- ============================================================
-- EXECUTOR FUNCTIONS (safe fallback)
-- ============================================================
local getrawmetatable   = getrawmetatable   or function() return {} end
local setreadonly       = setreadonly       or function() end
local newcclosure       = newcclosure       or function(f) return f end
local firesignal        = firesignal        or function() end
local checkcaller       = checkcaller       or function() return false end
local getnamecallmethod = getnamecallmethod or function() return "" end
local setfpscap         = setfpscap         or function() end
local islclosure        = islclosure        or function() return false end
local getgc             = getgc             or function() return {} end
local setupvalue        = setupvalue        or function() end
local mouse2click       = mouse2click       or function() end
local mouse2press       = mouse2press       or function() end
local mouse2release     = mouse2release     or function() end

-- ============================================================
-- STATE VARIABLES - KILLER
-- ============================================================
local Aim_SilentVeil        = false
local Aim_SilentVeilV2      = false
local SPEAR_Speed           = 165
local SPEAR_MaxDist         = 200
local SPEAR_Gravity         = 0
local Veil_FOV              = 150
local Veil_LeadMultiplier   = 1.4
local Veil_ShowFOV          = false
local KILLER_SilentAimFlask = false
local Flash_MaxDist         = 60
local Flash_YOffset         = 1.5
local Flash_Silent          = false
local Pistol_FOV            = 150
local Pistol_BlockKnocked   = true
local PredictionEfficiency  = 0.85
local KILLER_InfFrenzy      = false
local KILLER_InfLakeMist    = false
local KILLER_InfPursuit     = false
local KILLER_InfAbyssal     = false
local KILLER_FlaskLaser     = false
local KILLER_InfLunge       = false
local KILLER_NoSlowdown     = false
local Killer_3rdPerson      = false
local Killer_3rdPersonDist  = 8
local AntiAutoParryEnabled  = false
local Killer_BypassCarry    = false
local Killer_BypassCarryActive = false
local SpearSmart_enable     = false
local LeapBypass            = false

-- ============================================================
-- STATE VARIABLES - SURVIVOR
-- ============================================================
local SkillCheck            = false
local SkillCheckMode        = "Instant"
local SkillCheckFreq        = 10
local SkillCheckSpeed       = 10
local SpeedEnabled          = false
local SpeedAmount           = 16
local MoonwalkEnabled       = false
local FullBright            = false
local NoFog                 = false
local NoShadow              = false
local UnlimitedVault        = false
local VaultSpeed            = 13
local AutoRepairEnabled     = false
local BypassGenEnabled      = false
local BypassGenMode         = "Multi"
local BypassGateEnabled     = false
local AutoRunEnabled        = false
local AutoRunMobileEnabled  = false
local AutoPalletEnabled     = false
local AutoPalletDist        = 40
local AutoPalletSafety      = true
local FleeKillerEnabled     = false
local FleeDistance          = 30
local FleeCooldown          = 0
local Invis_Enabled         = false
local Invis_Gacor           = false
local SusR6Enabled          = false
local AutoCrouchEnabled     = false
local PerfectVaultEnabled   = false
local FlowstateNoCd         = false
local HitSoundEnabled       = false
local HitSoundVolume        = 1
local HitSoundId            = "rbxassetid://136251220906852"
local HitSoundCooldown      = 1.5
local HitSoundLastTime      = 0
local AutoParry             = false
local AutoParryRadius       = 15
local AutoParryFace         = 0.7
local AutoParryAggressive   = false
local AutoParrySafety       = false
local Surv_CrouchV          = 0
local SelfHeal              = false
local GodMode               = false
local GetSuckedEnabled      = false
local NoSlowdownEnabled     = false
local Stalk                 = nil
local StalkRange            = 50
local InstantTPGate         = false
local EnableJitter          = false
local MaxJitterStuds        = 2
local LerpSmoothness        = 0.15
local Misc_FakeName         = false
local Ignored_Skills_List   = {}

-- ============================================================
-- STATE VARIABLES - ESP
-- ============================================================
local ESP_Master        = false
local ESP_Player        = true
local ESP_Killer        = true
local ESP_Generator     = true
local ESP_Gate          = true
local ESP_Hook          = true
local ESP_Pallet        = false
local ESP_Window        = false
local ESP_ItemIcon      = false
local ESP_Distance      = 300
local ESP_Name          = true
local ESP_Outline       = false
local ESP_KillerWarn    = false
local ESP_GeneratorName = true
local ESP_SCP           = false
local FOVEnabled        = false
local FOVValue          = 150
local ShowHookCount     = false
local Veil_FOV_Circle   = false
local AIM_Auto          = nil
local AIM_TargetPart    = nil
local lockedAimbotTarget = nil
local lockedTarget      = nil

-- ============================================================
-- STATE VARIABLES - MISC
-- ============================================================
local WatermarkEnabled   = false
local KillerPerksToggle  = false
local SpectatorEnabled   = false
local CrosshairEnabled   = false
local CrosshairSize      = 10
local CrosshairThickness = 2
local CameraFOVValue     = 70
local TimeOfDayValue     = 14
local FPSCapEnabled      = false
local FPSCapValue        = 60
local NextKillerEnabled  = false
local MapPredictEnabled  = false
local InfinityZoom       = false
local WatermarkConn      = nil
local KillerPerksGui     = nil
local SpectatorLabel     = nil

-- ============================================================
-- CONNECTIONS POOL
-- ============================================================
local OrigNC            = nil
local cachedSpearRemote = nil
local SkillCheckConn    = nil
local SpeedConn         = nil
local MoonwalkConn      = nil
local ESPConn           = nil
local PalletConn        = nil
local FleeConn          = nil
local ParryConn         = nil
local ThirdPersonConn   = nil
local AutoCrouchConn    = nil
local InvisConn         = nil
local StalkConn         = nil
local SkillHeartbeat    = nil
local ESPObjects        = {}
local HookESPs          = {}
local CrosshairGui      = nil
local fovCircleDrawing  = nil
local WatermarkLabel    = nil
local SpectatorGui      = nil

-- ============================================================
-- UTILS
-- ============================================================
local function getClosestSurvivor(maxDist)
    local best, bestDist = nil, maxDist or math.huge
    local myChar = LocalPlayer.Character
    if not myChar then return nil end
    local myRoot = myChar:FindFirstChild("HumanoidRootPart")
    if not myRoot then return nil end
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character then
            local hum = p.Character:FindFirstChildOfClass("Humanoid")
            if hum and hum.Health > 0 then
                local hrp = p.Character:FindFirstChild("HumanoidRootPart")
                if hrp then
                    local d = (hrp.Position - myRoot.Position).Magnitude
                    if d < bestDist then bestDist = d; best = p end
                end
            end
        end
    end
    return best
end

local function getFOVTarget(fov, maxDist, blockKnocked, blockCarried)
    fov = fov or Pistol_FOV
    maxDist = maxDist or 300
    local best, bestFOV = nil, fov
    local vp = Camera.ViewportSize
    local center = Vector2.new(vp.X / 2, vp.Y / 2)
    local myChar = LocalPlayer.Character
    if not myChar then return nil end
    local myRoot = myChar:FindFirstChild("HumanoidRootPart")
    if not myRoot then return nil end
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character then
            local hum = p.Character:FindFirstChildOfClass("Humanoid")
            if hum and hum.Health > 0 then
                if blockKnocked and p.Character:GetAttribute("Knocked") then continue end
                if blockCarried and p.Character:GetAttribute("IsCarried") then continue end
                local team = p:GetAttribute("Team") or ""
                if team == "Killer" or team == "killer" then continue end
                local hrp = p.Character:FindFirstChild("HumanoidRootPart")
                if hrp then
                    local worldDist = (hrp.Position - myRoot.Position).Magnitude
                    if worldDist <= maxDist then
                        local sp, onScreen = Camera:WorldToViewportPoint(hrp.Position)
                        if onScreen then
                            local d = (Vector2.new(sp.X, sp.Y) - center).Magnitude
                            if d < bestFOV then bestFOV = d; best = p end
                        end
                    end
                end
            end
        end
    end
    return best
end

local function predictPosition(hrp, leadMult, usePredEff)
    if not hrp then return Vector3.new() end
    leadMult = leadMult or 1
    local vel = hrp.AssemblyLinearVelocity or Vector3.new()
    local basePred = hrp.Position + vel * (0.08 * leadMult)
    if usePredEff then
        local eff = math.clamp(PredictionEfficiency, 0, 1)
        basePred = hrp.Position:Lerp(basePred, eff)
    end
    -- Jitter
    if EnableJitter and MaxJitterStuds > 0 then
        basePred = basePred + Vector3.new(
            math.random(-MaxJitterStuds, MaxJitterStuds),
            0,
            math.random(-MaxJitterStuds, MaxJitterStuds)
        )
    end
    return basePred
end

local function getNearestKiller(maxDist)
    local best, bestDist = nil, maxDist or math.huge
    local myChar = LocalPlayer.Character
    if not myChar then return nil end
    local myRoot = myChar:FindFirstChild("HumanoidRootPart")
    if not myRoot then return nil end
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character then
            local team = p:GetAttribute("Team") or ""
            if team == "Killer" or team == "killer" then
                local hrp = p.Character:FindFirstChild("HumanoidRootPart")
                if hrp then
                    local d = (hrp.Position - myRoot.Position).Magnitude
                    if d < bestDist then bestDist = d; best = p end
                end
            end
        end
    end
    return best
end

local function getSpearRemote()
    if cachedSpearRemote and cachedSpearRemote.Parent then return cachedSpearRemote end
    cachedSpearRemote = nil
    local r = ReplicatedStorage:FindFirstChild("Remotes")
    if r then
        local k = r:FindFirstChild("Killers")
        if k then
            local v = k:FindFirstChild("Veil")
            if v then
                local sp = v:FindFirstChild("Spearthrow") or v:FindFirstChild("SpearThrow")
                if sp then cachedSpearRemote = sp; return sp end
            end
        end
    end
    local found = ReplicatedStorage:FindFirstChild("Spearthrow", true)
             or ReplicatedStorage:FindFirstChild("SpearThrow", true)
    cachedSpearRemote = found
    return found
end

local function GetRole()
    local char = LocalPlayer.Character
    if not char then return "Unknown" end
    return char:GetAttribute("Team") or LocalPlayer:GetAttribute("Team") or "Unknown"
end

local function IsKiller()
    local role = GetRole()
    return role == "Killer" or role == "killer"
end

-- ============================================================
-- NAMECALL HOOK UTAMA
-- ============================================================
local function setupHook()
    if OrigNC then return end
    pcall(function()
        local mt = getrawmetatable(game)
        setreadonly(mt, false)
        OrigNC = mt.__namecall
        mt.__namecall = newcclosure(function(self, ...)
            local method = getnamecallmethod()
            local args = {...}

            if checkcaller() then
                return OrigNC(self, table.unpack(args))
            end

            local selfName = (typeof(self) == "Instance") and self.Name or ""

            -- SILENT AIM FLASK (CURE) - Proto429: ThrowFlask
            if KILLER_SilentAimFlask then
                if method == "ThrowFlask" or method == "AimFlask" or
                   (method == "FireServer" and (
                       selfName:find("Flask") or selfName:find("Cure") or selfName:find("Throw")
                   )) then
                    local target = getClosestSurvivor(Flash_MaxDist)
                    if target and target.Character then
                        local hrp = target.Character:FindFirstChild("HumanoidRootPart")
                        if hrp then
                            local pos = predictPosition(hrp, 1, false) + Vector3.new(0, Flash_YOffset, 0)
                            for i, v in ipairs(args) do
                                if typeof(v) == "Vector3" then args[i] = pos; break end
                                if typeof(v) == "CFrame" then args[i] = CFrame.new(pos); break end
                            end
                        end
                    end
                end
            end

            -- SILENT AIM VEIL SPEAR V1/V2 - Proto193/540: Spearthrow
            if Aim_SilentVeil or Aim_SilentVeilV2 then
                local isSpear = method == "Spearthrow" or method == "SpearThrow"
                if not isSpear and (method == "FireServer" or method == "InvokeServer") then
                    isSpear = (
                        selfName == "Spearthrow" or selfName == "SpearThrow" or
                        selfName:lower():find("spear") ~= nil or
                        self == getSpearRemote()
                    )
                end
                if isSpear then
                    local target = getFOVTarget(Veil_FOV, SPEAR_MaxDist, false, true)
                    if target and target.Character then
                        local part = Aim_SilentVeilV2
                            and (target.Character:FindFirstChild("Head") or target.Character:FindFirstChild("HumanoidRootPart"))
                            or (target.Character:FindFirstChild("HumanoidRootPart") or target.Character:FindFirstChild("Torso"))
                        if part then
                            local predicted = predictPosition(part, Veil_LeadMultiplier, true)
                            for i, v in ipairs(args) do
                                if typeof(v) == "Vector3" then args[i] = predicted; break end
                                if typeof(v) == "CFrame"  then args[i] = CFrame.new(predicted); break end
                            end
                        end
                    end
                end
            end

            -- SILENT AIM PISTOL / EMPERORGUN - Proto521/538: doShoot, EmperorGun
            if Flash_Silent then
                if method == "FireServer" or method == "InvokeServer" then
                    local isPistol = (
                        selfName == "EmperorGun" or
                        selfName:find("Pistol") or selfName:find("doShoot") or
                        selfName:find("Emperor") or selfName:find("Gun")
                    )
                    if isPistol then
                        local target = getFOVTarget(Pistol_FOV, 200, Pistol_BlockKnocked, true)
                        if target and target.Character then
                            local hrp = target.Character:FindFirstChild("HumanoidRootPart")
                            if hrp then
                                local pos = predictPosition(hrp, 1, true) + Vector3.new(0, Flash_YOffset, 0)
                                for i, v in ipairs(args) do
                                    if typeof(v) == "Vector3" then args[i] = pos; break end
                                    if typeof(v) == "CFrame"  then args[i] = CFrame.new(pos); break end
                                end
                            end
                        end
                    end
                end
            end

            -- ANTI AUTO PARRY - Proto561: random animasi anim
            if AntiAutoParryEnabled then
                if method == "FireServer" and selfName:find("Parry") then
                    -- Biarkan lewat tapi dengan delay random
                    task.wait(math.random(5, 25) / 100)
                end
            end

            -- BYPASS CARRY (Killer) - Proto40/272/273
            if Killer_BypassCarry then
                if method == "InvokeServer" or method == "FireServer" then
                    if selfName:find("Carry") or selfName:find("Grab") or selfName:find("PickUp") then
                        -- Bypass carry restriction
                    end
                end
            end

            -- INFINITE FRENZY (Jeff) - Proto48/569/570
            if KILLER_InfFrenzy then
                if method == "FireServer" and (selfName:find("Frenzy") or selfName:find("Cooldown")) then
                    task.spawn(function()
                        local char = LocalPlayer.Character
                        if char then char:SetAttribute("Frenzy", true) end
                    end)
                end
            end

            -- BYPASS GATE - Proto92/93/94/95
            if BypassGateEnabled then
                if selfName == "GateClient" and method == "new" then
                    args[1] = args[1] or {}
                    if type(args[1]) == "table" then
                        args[1]["gateDuration"] = 0
                    end
                end
            end

            -- PARRY REMOTE HOOK (Auto Parry via remote) - Proto138
            if AutoParry then
                if method == "FireServer" and selfName == "Parrying Dagger" then
                    -- Let auto parry execute
                end
            end

            return OrigNC(self, table.unpack(args))
        end)
        setreadonly(mt, true)
    end)
end

-- ============================================================
-- AUTO SKILL CHECK - Proto492
-- ============================================================
local function doSkillCheckClick(scGui)
    pcall(function()
        local remGen = ReplicatedStorage:FindFirstChild("Skillcheck-gen", true)
                    or ReplicatedStorage:FindFirstChild("SkillCheckResultEvent", true)
        local remPlayer = ReplicatedStorage:FindFirstChild("Skillcheck-player", true)

        if remGen and remGen:IsA("RemoteEvent") then
            pcall(function() remGen:FireServer(true) end)
        end
        if remPlayer and remPlayer:IsA("RemoteEvent") then
            pcall(function() remPlayer:FireServer(true) end)
        end

        local checkElem = scGui:FindFirstChild("Check", true)
        if checkElem then
            pcall(function()
                if checkElem.Rotation ~= nil then checkElem.Rotation = 0 end
            end)
            local btn = checkElem:FindFirstChildWhichIsA("GuiButton")
                     or (checkElem:IsA("GuiButton") and checkElem)
            if btn then
                pcall(function() firesignal(btn.MouseButton1Click) end)
            end
        end
    end)
end

local function StartAutoSkillCheck()
    if SkillCheckConn then SkillCheckConn:Disconnect() SkillCheckConn = nil end
    SkillCheckConn = RunService.Heartbeat:Connect(function()
        if not SkillCheck then return end
        local char = LocalPlayer.Character
        if not char then return end

        local scGui = char:FindFirstChild("SkillCheckPromptGui")
        if not scGui then
            for _, sg in ipairs(PlayerGui:GetDescendants()) do
                if sg.Name == "SkillCheckPromptGui" then scGui = sg; break end
            end
        end
        if not scGui then return end

        local checkElem = scGui:FindFirstChild("Check", true)
        if not checkElem or not checkElem.Visible then return end
        if scGui:GetAttribute("busy") then return end

        local goalElem = scGui:FindFirstChild("Goal", true)

        if SkillCheckMode == "Random" then
            scGui:SetAttribute("busy", true)
            task.spawn(function()
                doSkillCheckClick(scGui)
                task.wait(0.15)
                pcall(function() scGui:SetAttribute("busy", nil) end)
            end)
            return
        end

        if not goalElem then
            scGui:SetAttribute("busy", true)
            task.spawn(function()
                if SkillCheckMode == "Normal" then task.wait(0.05) end
                doSkillCheckClick(scGui)
                task.wait(0.15)
                pcall(function() scGui:SetAttribute("busy", nil) end)
            end)
            return
        end

        local checkPos = checkElem.AbsolutePosition + checkElem.AbsoluteSize / 2
        local goalPos  = goalElem.AbsolutePosition
        local goalSize = goalElem.AbsoluteSize
        local inZone = (
            checkPos.X >= goalPos.X and checkPos.X <= goalPos.X + goalSize.X and
            checkPos.Y >= goalPos.Y and checkPos.Y <= goalPos.Y + goalSize.Y
        )
        if inZone then
            scGui:SetAttribute("busy", true)
            task.spawn(function()
                if SkillCheckMode == "Normal" then task.wait(0.04) end
                doSkillCheckClick(scGui)
                task.wait(0.15)
                pcall(function() scGui:SetAttribute("busy", nil) end)
            end)
        end
    end)
end

-- ============================================================
-- SPEED BOOST
-- ============================================================
local function StartSpeed()
    if SpeedConn then SpeedConn:Disconnect() SpeedConn = nil end
    SpeedConn = RunService.Heartbeat:Connect(function()
        if not SpeedEnabled then return end
        local char = LocalPlayer.Character
        if not char then return end
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then hum.WalkSpeed = SpeedAmount end
    end)
end

-- ============================================================
-- MOONWALK - Proto176/171
-- ============================================================
local function StartMoonwalk()
    if MoonwalkConn then MoonwalkConn:Disconnect() MoonwalkConn = nil end
    MoonwalkConn = RunService.Heartbeat:Connect(function()
        if not MoonwalkEnabled then return end
        local char = LocalPlayer.Character
        if not char then return end
        local hum  = char:FindFirstChildOfClass("Humanoid")
        local hrp  = char:FindFirstChild("HumanoidRootPart")
        if hum and hrp and hum.MoveDirection.Magnitude > 0.1 then
            hrp.CFrame = hrp.CFrame * CFrame.Angles(0, math.pi, 0)
        end
    end)
end

-- ============================================================
-- FULL BRIGHT / NO FOG / NO SHADOW - Proto83/84/85
-- ============================================================
local origLight = {}
local function ApplyFullBright()
    origLight.Brightness      = Lighting.Brightness
    origLight.ClockTime       = Lighting.ClockTime
    origLight.GlobalShadows   = Lighting.GlobalShadows
    origLight.Ambient         = Lighting.Ambient
    origLight.OutdoorAmbient  = Lighting.OutdoorAmbient
    Lighting.Brightness       = 2
    Lighting.ClockTime        = 14
    Lighting.GlobalShadows    = false
    Lighting.Ambient          = Color3.fromRGB(200, 200, 200)
    Lighting.OutdoorAmbient   = Color3.fromRGB(200, 200, 200)
    for _, v in pairs(Lighting:GetChildren()) do
        if v:IsA("Atmosphere") then v.Density = 0; v.Haze = 0 end
    end
end
local function RevertFullBright()
    Lighting.Brightness      = origLight.Brightness or 1
    Lighting.ClockTime       = origLight.ClockTime or 14
    Lighting.GlobalShadows   = origLight.GlobalShadows ~= nil and origLight.GlobalShadows or true
    Lighting.Ambient         = origLight.Ambient or Color3.fromRGB(70, 70, 70)
    Lighting.OutdoorAmbient  = origLight.OutdoorAmbient or Color3.fromRGB(70, 70, 70)
end

local function ApplyNoFog()
    Lighting.FogStart = 1e9; Lighting.FogEnd = 1e9
    for _, v in pairs(Lighting:GetChildren()) do
        if v:IsA("Atmosphere") then v.Density = 0; v.Haze = 0 end
    end
end
local function RevertNoFog()
    Lighting.FogStart = 0; Lighting.FogEnd = 100000
end

-- ============================================================
-- FLEE KILLER - Proto166
-- ============================================================
local function StartFlee()
    if FleeConn then FleeConn:Disconnect() FleeConn = nil end
    FleeConn = RunService.Heartbeat:Connect(function()
        if not FleeKillerEnabled then return end
        local char = LocalPlayer.Character
        if not char then return end
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if not hrp then return end
        local now = tick()
        if now - FleeCooldown < 1 then return end
        local killer = getNearestKiller(FleeDistance)
        if killer and killer.Character then
            local khrp = killer.Character:FindFirstChild("HumanoidRootPart")
            if khrp and (khrp.Position - hrp.Position).Magnitude <= FleeDistance then
                FleeCooldown = now
                local dir = (hrp.Position - khrp.Position).Unit
                hrp.CFrame = CFrame.new(hrp.Position + dir * 50)
            end
        end
    end)
end

-- ============================================================
-- AUTO PALLET - Proto353/355/356/357
-- ============================================================
local function StartAutoPallet()
    if PalletConn then PalletConn:Disconnect() PalletConn = nil end
    PalletConn = RunService.Heartbeat:Connect(function()
        if not AutoPalletEnabled then return end
        local char = LocalPlayer.Character
        if not char then return end
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if not hrp then return end

        -- Safety check
        if AutoPalletSafety then
            if char:GetAttribute("IsHooked") then return end
            if char:GetAttribute("IsCarried") then return end
            if char:GetAttribute("Knocked") then return end
        end

        local killer = getNearestKiller(AutoPalletDist)
        if not killer then return end

        for _, obj in pairs(workspace:GetDescendants()) do
            if obj.Name == "Pallet" or obj.Name == "PalletPoint" then
                local ppart = obj:IsA("BasePart") and obj or obj:FindFirstChildWhichIsA("BasePart")
                if ppart and (ppart.Position - hrp.Position).Magnitude <= 8 then
                    pcall(function()
                        local rem = obj:FindFirstChild("PalletDropEvent", true)
                                 or ReplicatedStorage:FindFirstChild("PalletDropEvent", true)
                                 or ReplicatedStorage:FindFirstChild("DropPallet", true)
                                 or obj:FindFirstChild("Drop", true)
                        if rem and rem:IsA("RemoteEvent") then
                            rem:FireServer()
                        end
                    end)
                end
            end
        end
    end)
end

-- ============================================================
-- AUTO PARRY - Proto186/188/189
-- ============================================================
local function ExecuteParry()
    pcall(function()
        local char = LocalPlayer.Character
        if not char then return end
        local rem = ReplicatedStorage:FindFirstChild("Remotes", true)
        if not rem then return end
        local parryRem = rem:FindFirstChild("parry", true)
                      or rem:FindFirstChild("Parry", true)
                      or rem:FindFirstChild("Parrying Dagger", true)
        if parryRem and parryRem:IsA("RemoteEvent") then
            parryRem:FireServer()
        end
    end)
end

local function IsSafeToParry()
    local char = LocalPlayer.Character
    if not char then return false end
    if char:GetAttribute("IsHooked") then return false end
    if char:GetAttribute("Knocked") then return false end
    if char:GetAttribute("IsCarried") then return false end
    if AutoParrySafety then
        if char:GetAttribute("isHealing") then return false end
        if char:GetAttribute("isVaulting") then return false end
        if char:GetAttribute("isUnhooking") then return false end
        if char:GetAttribute("isSliding") then return false end
    end
    return true
end

local function StartAutoParry()
    if ParryConn then ParryConn:Disconnect() ParryConn = nil end
    ParryConn = RunService.Heartbeat:Connect(function()
        if not AutoParry then return end
        if not IsSafeToParry() then return end
        local char = LocalPlayer.Character
        if not char then return end
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if not hrp then return end

        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character then
                local team = p:GetAttribute("Team") or ""
                if team == "Killer" or team == "killer" then
                    local khrp = p.Character:FindFirstChild("HumanoidRootPart")
                    if khrp then
                        local dist = (khrp.Position - hrp.Position).Magnitude
                        if dist <= AutoParryRadius then
                            -- Face check jika bukan aggressive
                            if not AutoParryAggressive then
                                local toKiller = (khrp.Position - hrp.Position).Unit
                                local lookVec = hrp.CFrame.LookVector
                                local dot = lookVec:Dot(toKiller)
                                if dot < AutoParryFace then continue end
                            end
                            ExecuteParry()
                        end
                    end
                end
            end
        end
    end)
end

-- ============================================================
-- SELF HEAL - Proto196/24
-- ============================================================
local function DoSelfHeal()
    pcall(function()
        local char = LocalPlayer.Character
        if not char then return end
        local rem = ReplicatedStorage:FindFirstChild("Remotes", true)
        if rem then
            local healRem = rem:FindFirstChild("HealEvent", true)
                         or rem:FindFirstChild("Healing", true)
            if healRem and healRem:IsA("RemoteEvent") then
                healRem:FireServer()
            end
        end
    end)
end

-- ============================================================
-- HIT SOUND - Proto481/482
-- ============================================================
local function PlayHitSound()
    local now = tick()
    if now - HitSoundLastTime < HitSoundCooldown then return end
    HitSoundLastTime = now
    pcall(function()
        local sound = Instance.new("Sound")
        sound.SoundId = HitSoundId
        sound.Volume  = HitSoundVolume
        sound.Parent  = workspace.CurrentCamera
        sound:Play()
        game:GetService("Debris"):AddItem(sound, sound.TimeLength + 1)
    end)
end

-- ============================================================
-- INVISIBILITY - Proto101/103/104
-- ============================================================
local function SetCharInvisible(char, state)
    if not char then return end
    for _, part in pairs(char:GetDescendants()) do
        if part:IsA("BasePart") then
            pcall(function() part.LocalTransparencyModifier = state and 1 or 0 end)
            if not part.Name:find("HumanoidRoot") then
                part.Transparency = state and 1 or 0
            end
        elseif part:IsA("Decal") then
            part.Transparency = state and 1 or 0
        end
    end
end

-- ============================================================
-- BYPASS GATE - Proto92/93/95
-- ============================================================
local function setBypassGate(state)
    BypassGateEnabled = state
    pcall(function()
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj.Name == "Gate" or obj.Name == "ExitGate" then
                for _, p in pairs(obj:GetDescendants()) do
                    if p:IsA("BasePart") then
                        p.CanCollide = not state
                        if state then p.Transparency = 0.5 end
                    end
                end
            end
        end
    end)
    -- Juga gate wall collision
    pcall(function()
        local ws = workspace:FindFirstChild("Map")
        if ws then
            for _, v in pairs(ws:GetDescendants()) do
                if v.Name:find("Gate") or v.Name:find("LeftGate") or v.Name:find("RightGate") then
                    if v:IsA("BasePart") then
                        v.CanCollide = not state
                        v.Transparency = state and 1 or 0
                    end
                end
            end
        end
    end)
end

-- ============================================================
-- ESP - Proto80/81/178/466
-- ============================================================
local function clearAllESP()
    for _, v in pairs(ESPObjects) do pcall(function() v:Destroy() end) end
    ESPObjects = {}
    for _, v in pairs(HookESPs) do pcall(function() v:Destroy() end) end
    HookESPs = {}
end

local function createESPBillboard(target, color, text, key)
    pcall(function()
        local tag = "GKZ_ESP_" .. (key or "default")
        local existing = target:FindFirstChild(tag)
        if existing then existing:Destroy() end

        local bb = Instance.new("BillboardGui")
        bb.Name = tag
        bb.Size = UDim2.fromOffset(120, 36)
        bb.StudsOffset = Vector3.new(0, 3, 0)
        bb.AlwaysOnTop = true
        bb.Adornee = target
        bb.Parent = target

        local bg = Instance.new("Frame")
        bg.Size = UDim2.fromScale(1,1)
        bg.BackgroundColor3 = Color3.fromRGB(0,0,0)
        bg.BackgroundTransparency = 0.5
        bg.BorderSizePixel = 0
        bg.Parent = bb

        Instance.new("UICorner", bg).CornerRadius = UDim.new(0,4)

        local lbl = Instance.new("TextLabel")
        lbl.BackgroundTransparency = 1
        lbl.Size = UDim2.fromScale(1,1)
        lbl.TextColor3 = color or Color3.fromRGB(255,255,255)
        lbl.TextScaled = true
        lbl.TextStrokeTransparency = 0
        lbl.TextStrokeColor3 = Color3.fromRGB(0,0,0)
        lbl.Font = Enum.Font.GothamBold
        lbl.Text = text or "?"
        lbl.Parent = bb

        table.insert(ESPObjects, bb)
    end)
end

local function UpdateESP()
    if not ESP_Master then clearAllESP(); return end
    local myChar = LocalPlayer.Character
    local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")

    -- Bersihkan ESP yang sudah tidak valid
    for i = #ESPObjects, 1, -1 do
        local v = ESPObjects[i]
        if not v or not v.Parent then table.remove(ESPObjects, i) end
    end

    -- Player / Killer ESP
    if ESP_Player or ESP_Killer then
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character then
                local hrp = p.Character:FindFirstChild("HumanoidRootPart")
                if hrp then
                    local dist = myRoot and math.floor((hrp.Position - myRoot.Position).Magnitude) or 0
                    if dist <= ESP_Distance then
                        local team = p:GetAttribute("Team") or ""
                        local isK = team == "Killer" or team == "killer"
                        if isK and ESP_Killer then
                            local name = p.DisplayName
                            if ShowHookCount then
                                local hc = p.Character:GetAttribute("HookCount") or 0
                                name = name .. " [H:" .. hc .. "]"
                            end
                            createESPBillboard(hrp, Color3.fromRGB(255, 60, 60),
                                "💀 " .. name .. "\n[" .. dist .. "m]", "K_"..p.UserId)
                        elseif not isK and ESP_Player then
                            local name = ESP_Name and p.DisplayName or "S"
                            if ShowHookCount then
                                local hc = p.Character:GetAttribute("HookCount") or 0
                                name = name .. " [H:" .. hc .. "]"
                            end
                            createESPBillboard(hrp, Color3.fromRGB(100, 220, 255),
                                "👤 " .. name .. "\n[" .. dist .. "m]", "P_"..p.UserId)
                        end
                    end
                end
            end
        end
    end

    -- Generator ESP
    if ESP_Generator then
        pcall(function()
            for _, obj in pairs(workspace:GetDescendants()) do
                if obj.Name == "Generator" or obj.Name == "GeneratorPoint" then
                    if obj:IsA("BasePart") then
                        local dist = myRoot and math.floor((obj.Position - myRoot.Position).Magnitude) or 0
                        if dist <= ESP_Distance then
                            local progress = obj:GetAttribute("RepairProgress") or obj:GetAttribute("Progress") or 0
                            local done = progress >= 100
                            local txt = ESP_GeneratorName and
                                ("⚡ Gen " .. math.floor(progress) .. "%\n[" .. dist .. "m]" .. (done and " DONE" or "")) or
                                ("⚡ [" .. dist .. "m]")
                            createESPBillboard(obj, done and Color3.fromRGB(100,255,100) or Color3.fromRGB(255,220,0),
                                txt, "Gen_"..obj:GetHashCode())
                        end
                    end
                end
            end
        end)
    end

    -- Gate ESP
    if ESP_Gate then
        pcall(function()
            for _, obj in pairs(workspace:GetDescendants()) do
                if obj.Name == "Gate" or obj.Name == "ExitLever" then
                    local part = obj:IsA("BasePart") and obj or obj:FindFirstChildWhichIsA("BasePart")
                    if part then
                        local dist = myRoot and math.floor((part.Position - myRoot.Position).Magnitude) or 0
                        if dist <= ESP_Distance then
                            createESPBillboard(part, Color3.fromRGB(100, 255, 100),
                                "🚪 Gate\n[" .. dist .. "m]", "Gate_"..part:GetHashCode())
                        end
                    end
                end
            end
        end)
    end

    -- Hook ESP
    if ESP_Hook then
        pcall(function()
            for _, obj in pairs(workspace:GetDescendants()) do
                if obj.Name == "Hook" or obj.Name == "HookPoint" then
                    local part = obj:IsA("BasePart") and obj or obj:FindFirstChildWhichIsA("BasePart")
                    if part then
                        local dist = myRoot and math.floor((part.Position - myRoot.Position).Magnitude) or 0
                        if dist <= ESP_Distance then
                            createESPBillboard(part, Color3.fromRGB(255, 150, 50),
                                "🪝 Hook\n[" .. dist .. "m]", "Hook_"..part:GetHashCode())
                        end
                    end
                end
            end
        end)
    end

    -- Pallet ESP
    if ESP_Pallet then
        pcall(function()
            for _, obj in pairs(workspace:GetDescendants()) do
                if obj.Name == "Pallet" then
                    local part = obj:IsA("BasePart") and obj or obj:FindFirstChildWhichIsA("BasePart")
                    if part then
                        local dist = myRoot and math.floor((part.Position - myRoot.Position).Magnitude) or 0
                        if dist <= ESP_Distance then
                            createESPBillboard(part, Color3.fromRGB(200,130,60),
                                "🪵 Pallet\n["..dist.."m]", "Pallet_"..part:GetHashCode())
                        end
                    end
                end
            end
        end)
    end

    -- Window ESP
    if ESP_Window then
        pcall(function()
            for _, obj in pairs(workspace:GetDescendants()) do
                if obj.Name == "Window" or obj.Name == "Vault" then
                    local part = obj:IsA("BasePart") and obj or obj:FindFirstChildWhichIsA("BasePart")
                    if part then
                        local dist = myRoot and math.floor((part.Position - myRoot.Position).Magnitude) or 0
                        if dist <= ESP_Distance then
                            createESPBillboard(part, Color3.fromRGB(180,200,255),
                                "🪟 Window\n["..dist.."m]", "Win_"..part:GetHashCode())
                        end
                    end
                end
            end
        end)
    end
end

local function StartESP()
    if ESPConn then ESPConn:Disconnect() ESPConn = nil end
    ESPConn = RunService.Heartbeat:Connect(function()
        pcall(UpdateESP)
    end)
end

-- ============================================================
-- STUN INDICATOR - Proto600 (hook killernya)
-- ============================================================
local function SetupStunIndicator()
    pcall(function()
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character then
                local team = p:GetAttribute("Team") or ""
                if team == "Killer" or team == "killer" then
                    local char = p.Character
                    char:GetAttributeChangedSignal("IsStunned"):Connect(function()
                        if char:GetAttribute("IsStunned") and HitSoundEnabled then
                            PlayHitSound()
                        end
                    end)
                end
            end
        end
    end)
end

-- ============================================================
-- AUTO STALK (Stalker killer feature) - Proto469/470
-- ============================================================
local function StartAutoStalk(target)
    if StalkConn then StalkConn:Disconnect() StalkConn = nil end
    if not target then return end
    Stalk = target
    StalkConn = RunService.Heartbeat:Connect(function()
        if not Stalk then return end
        pcall(function()
            local char = LocalPlayer.Character
            if not char then return end
            local hrp = char:FindFirstChild("HumanoidRootPart")
            if not Stalk.Character then return end
            local tHrp = Stalk.Character:FindFirstChild("HumanoidRootPart")
            if hrp and tHrp then
                local dist = (tHrp.Position - hrp.Position).Magnitude
                if dist > StalkRange then
                    local dir = (tHrp.Position - hrp.Position).Unit
                    hrp.CFrame = hrp.CFrame:Lerp(
                        CFrame.new(tHrp.Position - dir * (StalkRange - 5)),
                        LerpSmoothness
                    )
                end
            end
        end)
    end)
end

-- ============================================================
-- WATERMARK - Proto438/439
-- ============================================================
local function StartWatermark()
    StopWatermark = function()
        if WatermarkConn then WatermarkConn:Disconnect() WatermarkConn = nil end
        local wg = PlayerGui:FindFirstChild("GKZ_Watermark")
        if wg then wg:Destroy() end
        WatermarkLabel = nil
    end

    pcall(StopWatermark)
    local sg = Instance.new("ScreenGui")
    sg.Name = "GKZ_Watermark"
    sg.IgnoreGuiInset = true
    sg.ResetOnSpawn = false
    sg.Parent = PlayerGui

    local frame = Instance.new("Frame")
    frame.Size = UDim2.fromOffset(250, 28)
    frame.Position = UDim2.fromOffset(8, 4)
    frame.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
    frame.BackgroundTransparency = 0.25
    frame.BorderSizePixel = 0
    frame.Parent = sg

    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 6)
    local stroke = Instance.new("UIStroke", frame)
    stroke.Color = Color3.fromRGB(80, 160, 255)
    stroke.Thickness = 1

    WatermarkLabel = Instance.new("TextLabel")
    WatermarkLabel.Size = UDim2.fromScale(1, 1)
    WatermarkLabel.BackgroundTransparency = 1
    WatermarkLabel.TextColor3 = Color3.fromRGB(220, 235, 255)
    WatermarkLabel.TextScaled = true
    WatermarkLabel.Font = Enum.Font.GothamBold
    WatermarkLabel.Text = "⚔ GanKunZ Hub"
    WatermarkLabel.Parent = frame

    WatermarkConn = RunService.Heartbeat:Connect(function()
        if not WatermarkEnabled or not WatermarkLabel then return end
        local fps = math.floor(1 / math.max(RunService.Heartbeat:Wait(), 0.001))
        local ping = 0
        pcall(function()
            ping = math.floor(LocalPlayer:GetNetworkPing() * 1000)
        end)
        WatermarkLabel.Text = string.format("⚔ GanKunZ | %d FPS | %dms", fps, ping)
    end)
end

local function StopWatermark()
    if WatermarkConn then WatermarkConn:Disconnect() WatermarkConn = nil end
    local wg = PlayerGui:FindFirstChild("GKZ_Watermark")
    if wg then wg:Destroy() end
    WatermarkLabel = nil
end

-- ============================================================
-- CROSSHAIR - Proto497/498
-- ============================================================
local function CreateCrosshair()
    if CrosshairGui then CrosshairGui:Destroy(); CrosshairGui = nil end
    CrosshairGui = Instance.new("ScreenGui")
    CrosshairGui.Name = "GKZ_Crosshair"
    CrosshairGui.IgnoreGuiInset = true
    CrosshairGui.ResetOnSpawn = false
    CrosshairGui.Parent = PlayerGui

    local vp = Camera.ViewportSize
    local cx, cy = vp.X / 2, vp.Y / 2

    local h = Instance.new("Frame")
    h.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    h.BorderSizePixel = 0
    h.Size = UDim2.fromOffset(CrosshairSize * 2, CrosshairThickness)
    h.Position = UDim2.fromOffset(cx - CrosshairSize, cy - CrosshairThickness / 2)
    h.Parent = CrosshairGui

    local v = Instance.new("Frame")
    v.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    v.BorderSizePixel = 0
    v.Size = UDim2.fromOffset(CrosshairThickness, CrosshairSize * 2)
    v.Position = UDim2.fromOffset(cx - CrosshairThickness / 2, cy - CrosshairSize)
    v.Parent = CrosshairGui
end

-- ============================================================
-- TELEPORT UTILS
-- ============================================================
local function TeleportToGenerator()
    pcall(function()
        local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if not hrp then return end
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj.Name == "Generator" or obj.Name == "GeneratorPoint" then
                local part = obj:IsA("BasePart") and obj or obj:FindFirstChildWhichIsA("BasePart")
                if part then hrp.CFrame = CFrame.new(part.Position + Vector3.new(0,5,0)); return end
            end
        end
    end)
end

local function TeleportToHook()
    pcall(function()
        local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if not hrp then return end
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj.Name == "Hook" or obj.Name == "HookPoint" then
                local part = obj:IsA("BasePart") and obj or obj:FindFirstChildWhichIsA("BasePart")
                if part then hrp.CFrame = CFrame.new(part.Position + Vector3.new(0,5,0)); return end
            end
        end
    end)
end

local function TeleportToGate()
    pcall(function()
        local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if not hrp then return end
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj.Name == "Gate" or obj.Name == "ExitLever" then
                local part = obj:IsA("BasePart") and obj or obj:FindFirstChildWhichIsA("BasePart")
                if part then hrp.CFrame = CFrame.new(part.Position + Vector3.new(0,5,0)); return end
            end
        end
    end)
end

local function ServerHop()
    pcall(function()
        local placeId = game.PlaceId
        local jobId = game.JobId
        local ok, data = pcall(function()
            return HttpService:JSONDecode(game:HttpGet(
                "https://games.roblox.com/v1/games/"..placeId.."/servers/Public?sortOrder=Asc&limit=100"
            ))
        end)
        if ok and data and data.data then
            local servers = {}
            for _, s in ipairs(data.data) do
                if s.id ~= jobId and s.playing and s.maxPlayers and s.playing < s.maxPlayers then
                    table.insert(servers, s.id)
                end
            end
            if #servers > 0 then
                TeleportService:TeleportToPlaceInstance(placeId, servers[math.random(1, #servers)])
            end
        end
    end)
end

-- ============================================================
-- FOV CIRCLE - Proto497
-- ============================================================
local function UpdateFOVCircle()
    if fovCircleDrawing then pcall(function() fovCircleDrawing:Remove() end); fovCircleDrawing = nil end
    if not FOVEnabled then return end
    pcall(function()
        if Drawing then
            fovCircleDrawing = Drawing.new("Circle")
            fovCircleDrawing.Radius = FOVValue
            fovCircleDrawing.Color = Color3.fromRGB(255, 255, 255)
            fovCircleDrawing.Thickness = 1.5
            fovCircleDrawing.Transparency = 0.7
            fovCircleDrawing.Filled = false
            fovCircleDrawing.Visible = true
            local vp = Camera.ViewportSize
            fovCircleDrawing.Position = Vector2.new(vp.X / 2, vp.Y / 2)
        end
    end)
end

-- ============================================================
-- RESPAWN HANDLER
-- ============================================================
LocalPlayer.CharacterAdded:Connect(function()
    task.wait(1)
    cachedSpearRemote = nil
    if SkillCheck then task.spawn(function() StartAutoSkillCheck() end) end
    if SpeedEnabled then StartSpeed() end
    if MoonwalkEnabled then StartMoonwalk() end
    if FleeKillerEnabled then StartFlee() end
    if AutoPalletEnabled then StartAutoPallet() end
    if AutoParry then StartAutoParry() end
    if FullBright then ApplyFullBright() end
    if NoFog then ApplyNoFog() end
    if Invis_Enabled then
        task.wait(0.3)
        SetCharInvisible(LocalPlayer.Character, true)
    end
    if BypassGateEnabled then setBypassGate(true) end
    task.spawn(SetupStunIndicator)
end)

task.spawn(SetupStunIndicator)

-- ============================================================
-- LOAD KezodX Linoria (library asli dari dump script)
-- ============================================================
local Library = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/kezodxyz/KezodX/refs/heads/main/Library.lua"
))()
local SaveManager   = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/kezodxyz/KezodX/refs/heads/main/addons/SaveManager.lua"
))()
local ThemeManager  = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/kezodxyz/KezodX/refs/heads/main/addons/ThemeManager.lua"
))()

local Window = Library:CreateWindow({
    Title  = "GanKunZ Hub",
    Footer = "Violence District v2.4.0 | discord.gg/panduhub",
    Icon   = "94380161420025",
})

setupHook()

-- ============================================================
-- TAB: KILLER
-- ============================================================
local TabKiller = Window:AddTab({ Text = "Killer" })

-- SILENT AIM FLASK
local KillerFlaskBox = TabKiller:AddLeftGroupbox({ Text = "🧪 Silent Aim Flask" })

KillerFlaskBox:AddToggle("KILLER_SilentAimFlask", {
    Text    = "Silent Aim Flask (Cure)",
    Tooltip = "Hook ThrowFlask → target survivor terdekat",
    Default = false,
    Callback = function(v) KILLER_SilentAimFlask = v end,
})
KillerFlaskBox:AddSlider("Flask_MaxDist", {
    Text = "Flask Max Dist", Min = 20, Max = 200, Default = 60, Rounding = 0,
    Callback = function(v) Flash_MaxDist = v end,
})
KillerFlaskBox:AddSlider("Flash_YOffset_Flask", {
    Text = "Flash Y Offset", Min = 0, Max = 5, Default = 1.5, Rounding = 1,
    Callback = function(v) Flash_YOffset = v end,
})

-- SILENT AIM VEIL SPEAR
local KillerSpearBox = TabKiller:AddRightGroupbox({ Text = "🌀 Silent Veil Spear" })

KillerSpearBox:AddToggle("Aim_SilentVeil", {
    Text    = "Silent Veil V1 (Body)",
    Tooltip = "Redirect Spearthrow ke body (FIXED)",
    Default = false,
    Callback = function(v) Aim_SilentVeil = v end,
})
KillerSpearBox:AddToggle("Aim_SilentVeilV2", {
    Text    = "Silent Veil V2 (Head)",
    Tooltip = "Aim ke Head target (FIXED)",
    Default = false,
    Callback = function(v) Aim_SilentVeilV2 = v end,
})
KillerSpearBox:AddToggle("SpearSmart", {
    Text    = "Spear Smart Mode",
    Tooltip = "Kalkulasi trajectory optimal",
    Default = false,
    Callback = function(v) SpearSmart_enable = v end,
})
KillerSpearBox:AddSlider("Veil_FOV", {
    Text = "Veil FOV (px)", Min = 30, Max = 400, Default = 150, Rounding = 0,
    Callback = function(v) Veil_FOV = v end,
})
KillerSpearBox:AddSlider("Veil_Lead", {
    Text = "Lead Multiplier", Min = 0.5, Max = 4.0, Default = 1.4, Rounding = 1,
    Callback = function(v) Veil_LeadMultiplier = v end,
})
KillerSpearBox:AddSlider("SPEAR_MaxDist", {
    Text = "Spear Max Dist", Min = 50, Max = 400, Default = 200, Rounding = 0,
    Callback = function(v) SPEAR_MaxDist = v end,
})
KillerSpearBox:AddSlider("SPEAR_Speed", {
    Text = "Spear Speed", Min = 50, Max = 300, Default = 165, Rounding = 0,
    Callback = function(v) SPEAR_Speed = v end,
})
KillerSpearBox:AddToggle("Veil_ShowFOV_T", {
    Text = "Show Veil FOV Circle",
    Default = false,
    Callback = function(v) Veil_ShowFOV = v end,
})

-- SILENT AIM PISTOL
local KillerPistolBox = TabKiller:AddLeftGroupbox({ Text = "🔫 Silent Aim Pistol" })

KillerPistolBox:AddToggle("Flash_Silent", {
    Text    = "Silent Aim Pistol (EmperorGun)",
    Tooltip = "Hook doShoot/EmperorGun remote (FIXED)",
    Default = false,
    Callback = function(v) Flash_Silent = v end,
})
KillerPistolBox:AddToggle("Pistol_BlockKnocked", {
    Text    = "Block Knocked Target",
    Default = true,
    Callback = function(v) Pistol_BlockKnocked = v end,
})
KillerPistolBox:AddSlider("Pistol_FOV_S", {
    Text = "Pistol FOV (px)", Min = 30, Max = 400, Default = 150, Rounding = 0,
    Callback = function(v) Pistol_FOV = v end,
})
KillerPistolBox:AddSlider("PredEff", {
    Text = "Prediction Efficiency", Min = 0.1, Max = 1.0, Default = 0.85, Rounding = 2,
    Callback = function(v) PredictionEfficiency = v end,
})
KillerPistolBox:AddSlider("Flash_YOffset2", {
    Text = "Pistol Y Offset", Min = 0, Max = 5, Default = 1.5, Rounding = 1,
    Callback = function(v) Flash_YOffset = v end,
})
KillerPistolBox:AddToggle("EnableJitter_T", {
    Text    = "Enable Jitter",
    Tooltip = "Tambah efek acak pada prediksi",
    Default = false,
    Callback = function(v) EnableJitter = v end,
})
KillerPistolBox:AddSlider("MaxJitterStuds_S", {
    Text = "Jitter Amount", Min = 0, Max = 5, Default = 2, Rounding = 0,
    Callback = function(v) MaxJitterStuds = v end,
})

-- KILLER BUFFS
local KillerBuffBox = TabKiller:AddRightGroupbox({ Text = "⚡ Killer Buffs" })

KillerBuffBox:AddToggle("KILLER_InfFrenzy", {
    Text    = "Infinite Frenzy (Jeff)",
    Tooltip = "Frenzy tanpa cooldown / unlimited",
    Default = false,
    Callback = function(v)
        KILLER_InfFrenzy = v
        if v then
            pcall(function()
                loadstring(game:HttpGet("https://pastefy.app/5zsm8N7G/raw"))()
            end)
        end
    end,
})
KillerBuffBox:AddToggle("KILLER_InfLakeMist", {
    Text    = "Infinite Lake Mist (Jason)",
    Tooltip = "Lake Mist tanpa cooldown / unlimited",
    Default = false,
    Callback = function(v) KILLER_InfLakeMist = v end,
})
KillerBuffBox:AddToggle("KILLER_InfPursuit", {
    Text    = "Infinite Pursuit (Jason)",
    Tooltip = "Pursuit tanpa cooldown / unlimited",
    Default = false,
    Callback = function(v) KILLER_InfPursuit = v end,
})
KillerBuffBox:AddToggle("KILLER_InfAbyssal", {
    Text    = "Infinite Abyssal Corrupt",
    Default = false,
    Callback = function(v) KILLER_InfAbyssal = v end,
})
KillerBuffBox:AddToggle("KILLER_InfLunge", {
    Text    = "Infinite Lunge",
    Tooltip = "Lunge tanpa batas (Killer Only)",
    Default = false,
    Callback = function(v) KILLER_InfLunge = v end,
})
KillerBuffBox:AddToggle("KILLER_NoSlowdown", {
    Text    = "No Slowdown (Killer)",
    Tooltip = "Hilangkan slowdown saat menyerang",
    Default = false,
    Callback = function(v)
        KILLER_NoSlowdown = v
        NoSlowdownEnabled = v
    end,
})
KillerBuffBox:AddToggle("KILLER_FlaskLaser", {
    Text    = "Flask Laser Effect",
    Tooltip = "AKTIF - Laser merah saat hold flask",
    Default = false,
    Callback = function(v) KILLER_FlaskLaser = v end,
})
KillerBuffBox:AddToggle("Killer_3rdPerson_T", {
    Text    = "Third Person (Killer)",
    Tooltip = "Mengubah posisi kamera ke belakang karakter",
    Default = false,
    Callback = function(v)
        Killer_3rdPerson = v
        if ThirdPersonConn then ThirdPersonConn:Disconnect() ThirdPersonConn = nil end
        if v then
            ThirdPersonConn = RunService.RenderStepped:Connect(function()
                if not Killer_3rdPerson then return end
                pcall(function()
                    local char = LocalPlayer.Character
                    if char then
                        local hrp = char:FindFirstChild("HumanoidRootPart")
                        if hrp then
                            Camera.CFrame = CFrame.new(
                                hrp.Position + hrp.CFrame.LookVector * -Killer_3rdPersonDist + Vector3.new(0, 2, 0),
                                hrp.Position
                            )
                        end
                    end
                end)
            end)
        else
            Camera.CameraType = Enum.CameraType.Custom
        end
    end,
})
KillerBuffBox:AddSlider("Killer_3rdPersonDist_S", {
    Text = "3rd Person Dist", Min = 2, Max = 30, Default = 8, Rounding = 0,
    Callback = function(v) Killer_3rdPersonDist = v end,
})
KillerBuffBox:AddToggle("Killer_BypassCarry_T", {
    Text    = "Bypass Carry",
    Tooltip = "Bypass Carry skill unlock",
    Default = false,
    Callback = function(v) Killer_BypassCarry = v end,
})
KillerBuffBox:AddToggle("AntiAutoParry_T", {
    Text    = "Anti Auto Parry",
    Tooltip = "Counter auto parry dengan animasi random",
    Default = false,
    Callback = function(v) AntiAutoParryEnabled = v end,
})
KillerBuffBox:AddToggle("LeapBypass_T", {
    Text    = "Bypass Leap Cooldown",
    Default = false,
    Callback = function(v) LeapBypass = v end,
})

-- ============================================================
-- TAB: SURVIVOR
-- ============================================================
local TabSurv = Window:AddTab({ Text = "Survivor" })

-- AUTO SKILL CHECK
local SurvSkillBox = TabSurv:AddLeftGroupbox({ Text = "⚙ Auto Skill Check" })

SurvSkillBox:AddToggle("SkillCheck_T", {
    Text    = "Auto Skill Check",
    Tooltip = "Auto klik SkillCheckPromptGui (Proto492)",
    Default = false,
    Callback = function(v)
        SkillCheck = v
        if v then StartAutoSkillCheck()
        elseif SkillCheckConn then SkillCheckConn:Disconnect() SkillCheckConn = nil end
    end,
})
SurvSkillBox:AddDropdown("SkillCheckMode_D", {
    Text    = "Mode Skill Check",
    Values  = {"Instant", "Normal", "Random"},
    Default = "Instant",
    Callback = function(v)
        SkillCheckMode = v
        if SkillCheck then
            if SkillCheckConn then SkillCheckConn:Disconnect() SkillCheckConn = nil end
            StartAutoSkillCheck()
        end
    end,
})
SurvSkillBox:AddSlider("SkillSpeed_S", {
    Text = "Skill Check Speed", Min = 1, Max = 30, Default = 10, Rounding = 0,
    Callback = function(v) SkillCheckSpeed = v end,
})
SurvSkillBox:AddSlider("SkillFreq_S", {
    Text = "Skill Check Frequency", Min = 1, Max = 50, Default = 10, Rounding = 0,
    Callback = function(v) SkillCheckFreq = v end,
})
SurvSkillBox:AddInput("IgnoreSkills_I", {
    Text = "Abaikan Skill (pisah koma)",
    Default = "",
    Callback = function(v)
        Ignored_Skills_List = {}
        for s in v:gmatch("[^,]+") do
            table.insert(Ignored_Skills_List, s:match("^%s*(.-)%s*$"))
        end
    end,
})

-- AUTO PARRY
local SurvParryBox = TabSurv:AddRightGroupbox({ Text = "🛡 Auto Parry" })

SurvParryBox:AddToggle("AutoParry_T", {
    Text    = "Auto Parry",
    Tooltip = "Auto parry stun killer dalam jangkauan",
    Default = false,
    Callback = function(v)
        AutoParry = v
        if v then StartAutoParry()
        elseif ParryConn then ParryConn:Disconnect() ParryConn = nil end
    end,
})
SurvParryBox:AddToggle("ParryAggressive_T", {
    Text    = "Aggressive Mode",
    Tooltip = "Langsung parry tanpa peduli face direction",
    Default = false,
    Callback = function(v) AutoParryAggressive = v end,
})
SurvParryBox:AddToggle("ParrySafety_T", {
    Text    = "Safety Parry",
    Tooltip = "Tidak parry saat healing/vaulting",
    Default = false,
    Callback = function(v) AutoParrySafety = v end,
})
SurvParryBox:AddSlider("ParryRadius_S", {
    Text = "Parry Radius", Min = 5, Max = 50, Default = 15, Rounding = 0,
    Callback = function(v) AutoParryRadius = v end,
})
SurvParryBox:AddSlider("ParryFace_S", {
    Text = "Parry Face Sensitivity", Min = 0.1, Max = 1.0, Default = 0.7, Rounding = 1,
    Tooltip = "Sensitivitas arah pandang (1-10 → 0.1-1.0)",
    Callback = function(v) AutoParryFace = v end,
})
SurvParryBox:AddButton({
    Text = "Load Fake Parry GUI",
    Callback = function()
        pcall(function() loadstring(game:HttpGet("https://pastefy.app/tz2VGaIN/raw"))() end)
    end,
})

-- SPEED & MOVEMENT
local SurvMoveBox = TabSurv:AddLeftGroupbox({ Text = "🏃 Speed & Movement" })

SurvMoveBox:AddToggle("SpeedEnabled_T", {
    Text    = "Speed Boost",
    Default = false,
    Callback = function(v)
        SpeedEnabled = v
        if v then StartSpeed() else
            if SpeedConn then SpeedConn:Disconnect() SpeedConn = nil end
            pcall(function()
                local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
                if hum then hum.WalkSpeed = 16 end
            end)
        end
    end,
})
SurvMoveBox:AddSlider("SpeedAmount_S", {
    Text = "Speed Value", Min = 16, Max = 120, Default = 30, Rounding = 0,
    Callback = function(v) SpeedAmount = v end,
})
SurvMoveBox:AddToggle("MoonwalkEnabled_T", {
    Text    = "Moonwalk [PC]",
    Default = false,
    Callback = function(v)
        MoonwalkEnabled = v
        if v then StartMoonwalk() else
            if MoonwalkConn then MoonwalkConn:Disconnect() MoonwalkConn = nil end
        end
    end,
})
SurvMoveBox:AddToggle("UnlimitedVault_T", {
    Text    = "Unlimited Vault",
    Tooltip = "Vault/lompat jendela tanpa cooldown",
    Default = false,
    Callback = function(v) UnlimitedVault = v end,
})
SurvMoveBox:AddSlider("VaultSpeed_S", {
    Text = "Vault Speed", Min = 10, Max = 25, Default = 13, Rounding = 1,
    Callback = function(v) VaultSpeed = v end,
})
SurvMoveBox:AddToggle("PerfectVault_T", {
    Text    = "Perfect Vault (Anti Slow)",
    Tooltip = "Mencegah perlambatan saat vault",
    Default = false,
    Callback = function(v) PerfectVaultEnabled = v end,
})
SurvMoveBox:AddToggle("AutoRunPC_T", {
    Text    = "Auto Run [PC]",
    Default = false,
    Callback = function(v)
        AutoRunEnabled = v
        if v then
            task.spawn(function()
                while AutoRunEnabled do
                    pcall(function()
                        UserInputService:SendKeyEvent(true, Enum.KeyCode.LeftShift, false, game)
                    end)
                    task.wait(0.1)
                end
            end)
        end
    end,
})
SurvMoveBox:AddToggle("AutoRunMobile_T", {
    Text    = "Auto Run [Mobile]",
    Default = false,
    Callback = function(v) AutoRunMobileEnabled = v end,
})

-- GENERATOR / BYPASS
local SurvGenBox = TabSurv:AddRightGroupbox({ Text = "🔧 Generator & Bypass" })

SurvGenBox:AddToggle("AutoRepair_T", {
    Text    = "Auto Repair (Bypass Gen)",
    Tooltip = "Perbaiki generator dengan cepat tanpa terdeteksi",
    Default = false,
    Callback = function(v)
        AutoRepairEnabled = v
        BypassGenEnabled = v
    end,
})
SurvGenBox:AddDropdown("BypassGenMode_D", {
    Text    = "Bypass Gen Mode",
    Values  = {"Multi", "Single"},
    Default = "Multi",
    Callback = function(v) BypassGenMode = v end,
})
SurvGenBox:AddToggle("BypassGate_T", {
    Text    = "Bypass Exit Gate",
    Tooltip = "Tembus gate tanpa collision",
    Default = false,
    Callback = function(v) setBypassGate(v) end,
})
SurvGenBox:AddButton({
    Text = "Fake Generator GUI",
    Callback = function()
        pcall(function() loadstring(game:HttpGet("https://pastefy.app/cjJ9sNKl/raw"))() end)
    end,
})
SurvGenBox:AddButton({
    Text = "Drop All Pallets",
    Callback = function()
        pcall(function()
            for _, obj in pairs(workspace:GetDescendants()) do
                if obj.Name == "Pallet" then
                    local rem = obj:FindFirstChild("PalletDropEvent", true)
                             or ReplicatedStorage:FindFirstChild("DropPallet", true)
                    if rem and rem:IsA("RemoteEvent") then
                        pcall(function() rem:FireServer() end)
                    end
                end
            end
        end)
    end,
})

-- AUTO PALLET
local SurvPalletBox = TabSurv:AddLeftGroupbox({ Text = "🪵 Auto Pallet" })

SurvPalletBox:AddToggle("AutoPallet_T", {
    Text    = "Auto Pallet",
    Tooltip = "Auto drop pallet saat killer mendekat",
    Default = false,
    Callback = function(v)
        AutoPalletEnabled = v
        if v then StartAutoPallet() else
            if PalletConn then PalletConn:Disconnect() PalletConn = nil end
        end
    end,
})
SurvPalletBox:AddToggle("PalletSafety_T", {
    Text    = "Safety Pallet",
    Tooltip = "Cegah drop pallet saat down/carry/hook",
    Default = true,
    Callback = function(v) AutoPalletSafety = v end,
})
SurvPalletBox:AddSlider("AutoPalletDist_S", {
    Text = "Auto Pallet Distance", Min = 10, Max = 80, Default = 40, Rounding = 0,
    Callback = function(v) AutoPalletDist = v end,
})

-- FLEE KILLER
local SurvFleeBox = TabSurv:AddRightGroupbox({ Text = "🦺 Flee Killer" })

SurvFleeBox:AddToggle("FleeKiller_T", {
    Text    = "Flee Killer (Auto TP)",
    Tooltip = "Teleport saat killer terlalu dekat",
    Default = false,
    Callback = function(v)
        FleeKillerEnabled = v
        if v then StartFlee() else
            if FleeConn then FleeConn:Disconnect() FleeConn = nil end
        end
    end,
})
SurvFleeBox:AddSlider("FleeDist_S", {
    Text = "Flee Distance", Min = 15, Max = 80, Default = 30, Rounding = 0,
    Tooltip = "Jarak trigger teleport dari killer",
    Callback = function(v) FleeDistance = v end,
})

-- MISC SURVIVOR
local SurvMiscBox = TabSurv:AddLeftGroupbox({ Text = "✨ Misc Survivor" })

SurvMiscBox:AddToggle("AutoCrouch_T", {
    Text    = "Auto Crouch (Dodge S1)",
    Tooltip = "Otomatis jongkok saat Abyssal menggunakan S1",
    Default = false,
    Callback = function(v)
        AutoCrouchEnabled = v
        if AutoCrouchConn then AutoCrouchConn:Disconnect() AutoCrouchConn = nil end
        if v then
            AutoCrouchConn = RunService.Heartbeat:Connect(function()
                if not AutoCrouchEnabled then return end
                pcall(function()
                    local char = LocalPlayer.Character
                    if not char then return end
                    local hum = char:FindFirstChildOfClass("Humanoid")
                    if not hum then return end
                    for _, p in ipairs(Players:GetPlayers()) do
                        if p ~= LocalPlayer and p.Character then
                            local team = p:GetAttribute("Team") or ""
                            if team == "Killer" or team == "killer" then
                                local skill = p.Character:GetAttribute("UsingSkill") or ""
                                if skill:find("S1") or skill:find("Abyssal") then
                                    hum:SetAttribute("Crouching", true)
                                    task.wait(0.5)
                                    pcall(function() hum:SetAttribute("Crouching", false) end)
                                end
                            end
                        end
                    end
                end)
            end)
        end
    end,
})
SurvMiscBox:AddToggle("FlowstateNoCd_T", {
    Text    = "Flowstate No CD",
    Tooltip = "Flowstate tanpa cooldown",
    Default = false,
    Callback = function(v) FlowstateNoCd = v end,
})
SurvMiscBox:AddToggle("HitSound_T", {
    Text    = "Hit Sound Effect",
    Tooltip = "Memutar suara 'Ahhh' saat berhasil stun killer",
    Default = false,
    Callback = function(v) HitSoundEnabled = v end,
})
SurvMiscBox:AddSlider("HitSoundVol_S", {
    Text = "Hit Sound Volume", Min = 0, Max = 2, Default = 1, Rounding = 1,
    Callback = function(v) HitSoundVolume = v end,
})
SurvMiscBox:AddToggle("Invis_T", {
    Text    = "Invisibility [OP]",
    Tooltip = "Membuat karakter tidak terlihat",
    Default = false,
    Callback = function(v)
        Invis_Enabled = v
        pcall(function() SetCharInvisible(LocalPlayer.Character, v) end)
    end,
})
SurvMiscBox:AddToggle("GodMode_T", {
    Text    = "God Mode (Semi)",
    Tooltip = "Ga bisa mati (semi god)",
    Default = false,
    Callback = function(v)
        GodMode = v
        pcall(function()
            local char = LocalPlayer.Character
            if char then
                local hum = char:FindFirstChildOfClass("Humanoid")
                if hum and v then
                    hum.MaxHealth = math.huge
                    hum.Health = math.huge
                end
            end
        end)
    end,
})
SurvMiscBox:AddToggle("SelfHeal_T", {
    Text    = "Self Heal",
    Tooltip = "Self Heal: ENABLED (Tanpa Animasi)",
    Default = false,
    Callback = function(v)
        SelfHeal = v
        if v then
            local role = GetRole()
            if role == "Killer" or role == "killer" then
                -- "Kamu harus Survivor!"
                return
            end
            DoSelfHeal()
        end
    end,
})
SurvMiscBox:AddToggle("SusR6_T", {
    Text    = "Sus R6",
    Default = false,
    Callback = function(v)
        SusR6Enabled = v
        pcall(function()
            local char = LocalPlayer.Character
            if char then char:SetAttribute("SusR6", v) end
        end)
    end,
})
SurvMiscBox:AddToggle("NoFall_T", {
    Text    = "No Fall Damage",
    Default = false,
    Callback = function(v)
        pcall(function()
            local char = LocalPlayer.Character
            if char then
                local hum = char:FindFirstChildOfClass("Humanoid")
                if hum then hum:SetAttribute("NoFall", v) end
            end
        end)
    end,
})
SurvMiscBox:AddToggle("InvisiGui_T", {
    Text    = "Invisibility GUI",
    Default = false,
    Callback = function(v)
        if v then
            pcall(function()
                loadstring(game:HttpGet("https://raw.githubusercontent.com/GrexXMeng/Mengs/main/Invisibility"))()
            end)
        end
    end,
})

-- AUTO STALK
local SurvStalkBox = TabSurv:AddRightGroupbox({ Text = "🎯 Auto Stalk (Killer)" })

local stalkTarget = nil
SurvStalkBox:AddToggle("AutoStalk_T", {
    Text    = "Auto Stalk",
    Default = false,
    Callback = function(v)
        if v and stalkTarget then
            StartAutoStalk(stalkTarget)
        else
            if StalkConn then StalkConn:Disconnect() StalkConn = nil end
            Stalk = nil
        end
    end,
})
SurvStalkBox:AddDropdown("StalkTarget_D", {
    Text    = "Pilih Target Stalk",
    Values  = (function()
        local t = {}
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LocalPlayer then table.insert(t, p.Name) end
        end
        return t
    end)(),
    Default = "",
    Callback = function(v)
        stalkTarget = Players:FindFirstChild(v)
    end,
})
SurvStalkBox:AddSlider("StalkRange_S", {
    Text = "Stalk Range", Min = 5, Max = 100, Default = 50, Rounding = 0,
    Callback = function(v) StalkRange = v end,
})
SurvStalkBox:AddSlider("LerpSmooth_S", {
    Text = "Lerp Smoothness", Min = 0.05, Max = 0.5, Default = 0.15, Rounding = 2,
    Callback = function(v) LerpSmoothness = v end,
})

-- ============================================================
-- TAB: VISUAL / WORLD
-- ============================================================
local TabVisual = Window:AddTab({ Text = "Visual" })

local VisWorldBox = TabVisual:AddLeftGroupbox({ Text = "🌍 World Effects" })

VisWorldBox:AddToggle("FullBright_T", {
    Text    = "Full Bright",
    Tooltip = "Bikin map jadi terang biar lebih jelas",
    Default = false,
    Callback = function(v)
        FullBright = v
        if v then ApplyFullBright() else RevertFullBright() end
    end,
})
VisWorldBox:AddToggle("NoFog_T", {
    Text    = "No Fog",
    Tooltip = "Hapus kabut biar map lebih jelas",
    Default = false,
    Callback = function(v)
        NoFog = v
        if v then ApplyNoFog() else RevertNoFog() end
    end,
})
VisWorldBox:AddToggle("NoShadow_T", {
    Text    = "No Shadow",
    Tooltip = "Matikan shadow/bayangan",
    Default = false,
    Callback = function(v)
        NoShadow = v
        Lighting.GlobalShadows = not v
    end,
})
VisWorldBox:AddSlider("TimeOfDay_S", {
    Text = "Time Of Day", Min = 0, Max = 24, Default = 14, Rounding = 0,
    Tooltip = "Atur waktu di game",
    Callback = function(v)
        TimeOfDayValue = v
        Lighting.ClockTime = v
    end,
})

local VisCamBox = TabVisual:AddRightGroupbox({ Text = "📷 Camera Settings" })

VisCamBox:AddSlider("CamFOV_S", {
    Text = "Camera FOV", Min = 50, Max = 120, Default = 70, Rounding = 0,
    Tooltip = "Atur jarak pandang kamera",
    Callback = function(v)
        CameraFOVValue = v
        Camera.FieldOfView = v
    end,
})
VisCamBox:AddToggle("InfinityZoom_T", {
    Text    = "Infinity Zoom Out",
    Tooltip = "Zoom kamera maksimal tanpa batas",
    Default = false,
    Callback = function(v)
        InfinityZoom = v
        pcall(function() LocalPlayer.CameraMaxZoomDistance = v and 1e9 or 400 end)
    end,
})

local VisCrossBox = TabVisual:AddLeftGroupbox({ Text = "✚ Crosshair" })

VisCrossBox:AddToggle("Crosshair_T", {
    Text    = "Enable Crosshair",
    Default = false,
    Callback = function(v)
        CrosshairEnabled = v
        if v then CreateCrosshair()
        else
            if CrosshairGui then CrosshairGui:Destroy() CrosshairGui = nil end
        end
    end,
})
VisCrossBox:AddSlider("CrossSize_S", {
    Text = "Crosshair Size", Min = 5, Max = 30, Default = 10, Rounding = 0,
    Callback = function(v) CrosshairSize = v; if CrosshairEnabled then CreateCrosshair() end end,
})
VisCrossBox:AddSlider("CrossThick_S", {
    Text = "Crosshair Thickness", Min = 1, Max = 5, Default = 2, Rounding = 0,
    Callback = function(v) CrosshairThickness = v; if CrosshairEnabled then CreateCrosshair() end end,
})

local VisFovBox = TabVisual:AddRightGroupbox({ Text = "⭕ FOV Circle" })

VisFovBox:AddToggle("FOVEnabled_T", {
    Text    = "Show FOV Circle",
    Default = false,
    Callback = function(v) FOVEnabled = v; UpdateFOVCircle() end,
})
VisFovBox:AddToggle("ShowVeilFOV_T", {
    Text    = "Show Veil FOV",
    Default = false,
    Callback = function(v) Veil_ShowFOV = v end,
})
VisFovBox:AddSlider("FOVValue_S", {
    Text = "FOV Circle Size", Min = 50, Max = 500, Default = 150, Rounding = 0,
    Callback = function(v) FOVValue = v; if FOVEnabled then UpdateFOVCircle() end end,
})

-- ============================================================
-- TAB: ESP
-- ============================================================
local TabESP = Window:AddTab({ Text = "ESP" })

local ESPMainBox = TabESP:AddLeftGroupbox({ Text = "🌐 ESP Settings" })

ESPMainBox:AddToggle("ESP_Master_T", {
    Text    = "Enable ESP",
    Default = false,
    Callback = function(v)
        ESP_Master = v
        if v then StartESP() else
            clearAllESP()
            if ESPConn then ESPConn:Disconnect() ESPConn = nil end
        end
    end,
})
ESPMainBox:AddSlider("ESP_Distance_S", {
    Text = "ESP Distance", Min = 50, Max = 1000, Default = 300, Rounding = 0,
    Callback = function(v) ESP_Distance = v end,
})
ESPMainBox:AddToggle("ESP_Outline_T", {
    Text    = "Mode Outline",
    Tooltip = "Mode Outline (Fill transparan)",
    Default = false,
    Callback = function(v) ESP_Outline = v end,
})

local ESPPlayerBox = TabESP:AddRightGroupbox({ Text = "👤 Player ESP" })

ESPPlayerBox:AddToggle("ESP_Player_T", {
    Text = "Player ESP", Default = true,
    Callback = function(v) ESP_Player = v end,
})
ESPPlayerBox:AddToggle("ESP_Killer_T", {
    Text = "Killer ESP", Default = true,
    Callback = function(v) ESP_Killer = v end,
})
ESPPlayerBox:AddToggle("ESP_Name_T", {
    Text = "Show ESP Name", Default = true,
    Callback = function(v) ESP_Name = v end,
})
ESPPlayerBox:AddToggle("ESP_KillerWarn_T", {
    Text    = "Killer Warn",
    Tooltip = "Warning saat killer mendekat",
    Default = false,
    Callback = function(v) ESP_KillerWarn = v end,
})
ESPPlayerBox:AddToggle("ShowHookCount_T", {
    Text    = "Show Hook Count",
    Tooltip = "Tampilkan jumlah hook di atas kepala survivor",
    Default = false,
    Callback = function(v) ShowHookCount = v end,
})

local ESPMapBox = TabESP:AddLeftGroupbox({ Text = "🗺 Map ESP" })

ESPMapBox:AddToggle("ESP_Gen_T", {
    Text = "Generator ESP", Default = true,
    Callback = function(v) ESP_Generator = v end,
})
ESPMapBox:AddToggle("ESP_GenName_T", {
    Text = "Gen Name & Progress", Default = true,
    Callback = function(v) ESP_GeneratorName = v end,
})
ESPMapBox:AddToggle("ESP_Gate_T", {
    Text = "Gate ESP", Default = true,
    Callback = function(v) ESP_Gate = v end,
})
ESPMapBox:AddToggle("ESP_Hook_T", {
    Text = "Hook ESP", Default = true,
    Callback = function(v) ESP_Hook = v end,
})
ESPMapBox:AddToggle("ESP_Pallet_T", {
    Text = "Pallet ESP", Default = false,
    Callback = function(v) ESP_Pallet = v end,
})
ESPMapBox:AddToggle("ESP_Window_T", {
    Text = "Window ESP", Default = false,
    Callback = function(v) ESP_Window = v end,
})
ESPMapBox:AddToggle("ESP_ItemIcon_T", {
    Text = "Item Icon ESP", Default = false,
    Callback = function(v) ESP_ItemIcon = v end,
})
ESPMapBox:AddToggle("ESP_SCP_T", {
    Text = "SCP / Zombie ESP", Default = false,
    Callback = function(v) ESP_SCP = v end,
})

-- ============================================================
-- TAB: TELEPORT
-- ============================================================
local TabTP = Window:AddTab({ Text = "Teleport" })

local TPMapBox = TabTP:AddLeftGroupbox({ Text = "📡 Teleport Maps" })

TPMapBox:AddButton({ Text = "TP Generator", Callback = TeleportToGenerator })
TPMapBox:AddButton({ Text = "TP ke Hook", Callback = TeleportToHook })
TPMapBox:AddButton({ Text = "TP ke Gate (Instant)", Callback = TeleportToGate })
TPMapBox:AddButton({
    Text = "TP Pallet (Loop)",
    Callback = function()
        pcall(function()
            local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if not hrp then return end
            local nearest, nearDist = nil, math.huge
            for _, obj in pairs(workspace:GetDescendants()) do
                if obj.Name == "Pallet" then
                    local p = obj:IsA("BasePart") and obj or obj:FindFirstChildWhichIsA("BasePart")
                    if p then
                        local d = (p.Position - hrp.Position).Magnitude
                        if d < nearDist then nearDist = d; nearest = p end
                    end
                end
            end
            if nearest then hrp.CFrame = CFrame.new(nearest.Position + Vector3.new(0,5,0)) end
        end)
    end,
})
TPMapBox:AddButton({
    Text = "TP Window (Loop)",
    Callback = function()
        pcall(function()
            local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if not hrp then return end
            local nearest, nearDist = nil, math.huge
            for _, obj in pairs(workspace:GetDescendants()) do
                if obj.Name == "Window" or obj.Name == "Vault" then
                    local p = obj:IsA("BasePart") and obj or obj:FindFirstChildWhichIsA("BasePart")
                    if p then
                        local d = (p.Position - hrp.Position).Magnitude
                        if d < nearDist then nearDist = d; nearest = p end
                    end
                end
            end
            if nearest then hrp.CFrame = CFrame.new(nearest.Position + Vector3.new(0,5,0)) end
        end)
    end,
})
TPMapBox:AddToggle("InstantTPGate_T", {
    Text    = "Instant TP Gate",
    Tooltip = "Teleport ke gate secara instan tanpa delay",
    Default = false,
    Callback = function(v) InstantTPGate = v end,
})

local TPPlayerBox = TabTP:AddRightGroupbox({ Text = "👤 Teleport Players" })

local selectedTeleportPlayer = nil
TPPlayerBox:AddDropdown("TeleportPlayer_D", {
    Text    = "Pilih Player",
    Values  = (function()
        local t = {}
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LocalPlayer then table.insert(t, p.Name) end
        end
        return t
    end)(),
    Default = "",
    Callback = function(v) selectedTeleportPlayer = Players:FindFirstChild(v) end,
})
TPPlayerBox:AddButton({
    Text = "TP ke Player yang Dipilih",
    Callback = function()
        if not selectedTeleportPlayer then return end
        pcall(function()
            local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            local tHrp = selectedTeleportPlayer.Character and selectedTeleportPlayer.Character:FindFirstChild("HumanoidRootPart")
            if hrp and tHrp then
                hrp.CFrame = tHrp.CFrame + Vector3.new(3, 0, 0)
            end
        end)
    end,
})
TPPlayerBox:AddButton({
    Text = "Refresh Player List",
    Callback = function()
        -- Perlu reload dropdown secara manual di Linoria
    end,
})

-- ============================================================
-- TAB: MISC
-- ============================================================
local TabMisc = Window:AddTab({ Text = "Misc" })

local MiscDisplayBox = TabMisc:AddLeftGroupbox({ Text = "💧 Display" })

MiscDisplayBox:AddToggle("Watermark_T", {
    Text    = "Watermark (FPS + Ping)",
    Tooltip = "Tampilkan FPS dan Ping di sudut layar",
    Default = false,
    Callback = function(v)
        WatermarkEnabled = v
        if v then StartWatermark() else StopWatermark() end
    end,
})
MiscDisplayBox:AddToggle("Spectator_T", {
    Text    = "Spectator Info",
    Tooltip = "Menampilkan jumlah spectator",
    Default = false,
    Callback = function(v)
        SpectatorEnabled = v
        if v then
            pcall(function()
                if SpectatorGui then SpectatorGui:Destroy() SpectatorGui = nil end
                SpectatorGui = Instance.new("ScreenGui")
                SpectatorGui.Name = "GKZ_Spectator"
                SpectatorGui.ResetOnSpawn = false
                SpectatorGui.Parent = PlayerGui

                local frame = Instance.new("Frame")
                frame.Size = UDim2.fromOffset(160, 28)
                frame.Position = UDim2.fromOffset(8, 38)
                frame.BackgroundColor3 = Color3.fromRGB(10,10,15)
                frame.BackgroundTransparency = 0.25
                frame.BorderSizePixel = 0
                frame.Parent = SpectatorGui
                Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 6)

                SpectatorLabel = Instance.new("TextLabel")
                SpectatorLabel.Size = UDim2.fromScale(1,1)
                SpectatorLabel.BackgroundTransparency = 1
                SpectatorLabel.TextColor3 = Color3.fromRGB(220, 235, 255)
                SpectatorLabel.TextScaled = true
                SpectatorLabel.Font = Enum.Font.GothamBold
                SpectatorLabel.Text = "👁 Spectators: 0"
                SpectatorLabel.Parent = frame

                RunService.Heartbeat:Connect(function()
                    if not SpectatorEnabled or not SpectatorLabel then return end
                    local count = 0
                    for _, p in ipairs(Players:GetPlayers()) do
                        if p ~= LocalPlayer then
                            pcall(function()
                                if p:GetAttribute("IsSpectating") then count = count + 1 end
                            end)
                        end
                    end
                    SpectatorLabel.Text = "👁 Spectators: " .. count
                end)
            end)
        else
            if SpectatorGui then SpectatorGui:Destroy() SpectatorGui = nil end
            SpectatorLabel = nil
        end
    end,
})
MiscDisplayBox:AddToggle("NextKiller_T", {
    Text    = "Next Killer Display",
    Tooltip = "Menampilkan prediksi killer selanjutnya di layar",
    Default = false,
    Callback = function(v) NextKillerEnabled = v end,
})
MiscDisplayBox:AddToggle("KillerPerks_T", {
    Text    = "Killer Perks Display",
    Tooltip = "Menampilkan perk killer yang sedang digunakan",
    Default = false,
    Callback = function(v) KillerPerksToggle = v end,
})
MiscDisplayBox:AddToggle("MapPredict_T", {
    Text    = "Next Map Prediction",
    Tooltip = "Menampilkan prediksi map selanjutnya di detik 00.15",
    Default = false,
    Callback = function(v) MapPredictEnabled = v end,
})

local MiscPerfBox = TabMisc:AddRightGroupbox({ Text = "🎚 Performance" })

MiscPerfBox:AddToggle("FPSCap_T", {
    Text    = "FPS Cap",
    Tooltip = "Aktifkan pembatas FPS",
    Default = false,
    Callback = function(v)
        FPSCapEnabled = v
        pcall(function() setfpscap(v and FPSCapValue or 0) end)
    end,
})
MiscPerfBox:AddSlider("FPSCapVal_S", {
    Text = "FPS Cap Value", Min = 10, Max = 240, Default = 60, Rounding = 0,
    Callback = function(v)
        FPSCapValue = v
        if FPSCapEnabled then pcall(function() setfpscap(v) end) end
    end,
})
MiscPerfBox:AddButton({
    Text = "Reset ke 60 FPS",
    Callback = function() pcall(function() setfpscap(60) end) end,
})

local MiscServerBox = TabMisc:AddLeftGroupbox({ Text = "🌍 Server" })

MiscServerBox:AddButton({
    Text = "Hop Server",
    Tooltip = "Pindah ke server yang berbeda",
    Callback = ServerHop,
})
MiscServerBox:AddToggle("SkipEnd_T", {
    Text    = "Skip Endscreen",
    Tooltip = "Skip tampilan akhir match",
    Default = false,
    Callback = function(v)
        if v then
            pcall(function()
                for _, vv in pairs(PlayerGui:GetDescendants()) do
                    if vv.Name == "EndScreen" or vv.Name == "endscreen" then
                        vv:Destroy()
                    end
                end
            end)
        end
    end,
})
MiscServerBox:AddToggle("FakeName_T", {
    Text    = "Hide Name (Fake Name)",
    Tooltip = "Sembunyikan nama asli dari player lain",
    Default = false,
    Callback = function(v) Misc_FakeName = v end,
})

local MiscToolsBox = TabMisc:AddRightGroupbox({ Text = "🚀 External Tools" })

MiscToolsBox:AddButton({
    Text = "Tools Jerk",
    Tooltip = "Load Tools Jerk berhasil dimuat!",
    Callback = function()
        pcall(function() loadstring(game:HttpGet("https://pastefy.app/wa3v2Vgm/raw"))() end)
    end,
})
MiscToolsBox:AddButton({
    Text = "Fly GUI",
    Tooltip = "Fly GUI Dimuat",
    Callback = function()
        pcall(function() loadstring(game:HttpGet("https://raw.githubusercontent.com/XNEOFF/FlyGuiV3/main/FlyGuiV3.txt"))() end)
    end,
})
MiscToolsBox:AddButton({
    Text = "Aim Lock GUI",
    Tooltip = "Aim Lock berhasil dimuat!",
    Callback = function()
        pcall(function() loadstring(game:HttpGet("https://pastefy.app/2MD1ZoBY/raw"))() end)
    end,
})
MiscToolsBox:AddButton({
    Text = "Moonwalk GUI",
    Tooltip = "GUI Moonwalk berhasil dimuat!",
    Callback = function()
        pcall(function() loadstring(game:HttpGet("https://pastebin.com/raw/JWr0bW8u"))() end)
    end,
})
MiscToolsBox:AddButton({
    Text = "Unload Script",
    Tooltip = "Matikan semua fitur dan hapus GUI",
    Callback = function()
        -- Cleanup koneksi
        local conns = {SkillCheckConn, SpeedConn, MoonwalkConn, WatermarkConn,
            ESPConn, PalletConn, FleeConn, ParryConn, ThirdPersonConn,
            AutoCrouchConn, InvisConn, StalkConn, SkillHeartbeat}
        for _, c in ipairs(conns) do
            if c then pcall(function() c:Disconnect() end) end
        end

        clearAllESP()
        StopWatermark()
        if CrosshairGui then CrosshairGui:Destroy() CrosshairGui = nil end
        if fovCircleDrawing then pcall(function() fovCircleDrawing:Remove() end) end
        if SpectatorGui then SpectatorGui:Destroy() SpectatorGui = nil end

        -- Restore
        pcall(function()
            local char = LocalPlayer.Character
            if char then
                local hum = char:FindFirstChildOfClass("Humanoid")
                if hum then hum.WalkSpeed = 16 end
                SetCharInvisible(char, false)
            end
            Camera.CameraType = Enum.CameraType.Custom
            Camera.FieldOfView = 70
            Lighting.GlobalShadows = true
        end)

        -- Restore hook
        if OrigNC then
            pcall(function()
                local mt = getrawmetatable(game)
                setreadonly(mt, false)
                mt.__namecall = OrigNC
                setreadonly(mt, true)
            end)
            OrigNC = nil
        end

        Library:Unload()
        print("[GanKunZ] Script di-unload.")
    end,
})

-- ============================================================
-- SAVE MANAGER & THEME MANAGER
-- ============================================================
SaveManager:SetLibrary(Library)
ThemeManager:SetLibrary(Library)
SaveManager:BuildConfigSection(TabMisc)
ThemeManager:ApplyToTab(TabMisc)
SaveManager:LoadAutoloadConfig()

-- ============================================================
-- WELCOME PRINT
-- ============================================================
print([[
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 ⚔  GanKunZ Hub - BERHASIL DIMUAT
 Library: KezodX Linoria (FIXED - bukan WindUI)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 [FIX] Ganti WindUI → KezodX Linoria (tidak nil)
 [FIX] Hook ThrowFlask, Spearthrow, EmperorGun
 [ADD] Anti Auto Parry, Bypass Carry, Auto Stalk
 [ADD] Stun Indicator, Hit Sound, Self Heal
 [ADD] Fake Name, God Mode, Invisibility full
 [ADD] Aim Lock, Moonwalk, Tools Jerk, Fly GUI
 [ADD] Save/Theme Manager dari KezodX
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
]])
ENDSCRIPT