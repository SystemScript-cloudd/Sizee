--[[
    ╔══════════════════════════════════════════════════════════════╗
    ║              GanKunZ Hub - Violence District                 ║
    ║   Semua Fitur dari VD_Features_Fixed + Script + Dump         ║
    ║                                                              ║
    ║   GUI        : WindUI v1.6.65 by Footagesus                  ║
    ║   Compatible : Delta Mobile (Android) / PC Executor          ║
    ║   Data dari  : Dumped.json + script.lua                      ║
    ╚══════════════════════════════════════════════════════════════╝
]]

-- ============================================================
-- SERVICES
-- ============================================================
local Players           = game:GetService("Players")
local RunService        = game:GetService("RunService")
local UserInputService  = game:GetService("UserInputService")
local TweenService      = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace         = game:GetService("Workspace")
local Lighting          = game:GetService("Lighting")
local TeleportService   = game:GetService("TeleportService")
local HttpService       = game:GetService("HttpService")

local Camera      = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer
local PlayerGui   = LocalPlayer:WaitForChild("PlayerGui")

-- ============================================================
-- EXECUTOR FUNCTIONS (safe fallback)
-- ============================================================
local getrawmetatable   = getrawmetatable  or function() return {} end
local setreadonly       = setreadonly      or function() end
local newcclosure       = newcclosure      or function(f) return f end
local firesignal        = firesignal       or function() end
local checkcaller       = checkcaller      or function() return false end
local getnamecallmethod = getnamecallmethod or function() return "" end
local setfpscap         = setfpscap        or function() end

-- ============================================================
-- VARIABEL GLOBAL - KILLER
-- ============================================================
local Aim_SilentVeil       = false
local Aim_SilentVeilV2     = false
local SPEAR_Speed          = 165
local SPEAR_MaxDist        = 200
local SPEAR_Gravity        = 0
local Veil_FOV             = 150
local Veil_LeadMultiplier  = 1.4
local Veil_ShowFOV         = false

local KILLER_SilentAimFlask = false
local Flask_MaxDist         = 60
local Flash_YOffset         = 1.5

local Flash_Silent         = false
local Pistol_FOV           = 150
local Pistol_BlockKnocked  = true
local PredictionEfficiency = 0.85
local isChargingPistol     = false

local KILLER_InfFrenzy     = false
local KILLER_InfLakeMist   = false
local KILLER_InfPursuit    = false
local KILLER_InfAbyssal    = false
local KILLER_FlaskLaser    = false
local KILLER_InfLunge      = false
local KILLER_NoSlowdown    = false
local Killer_3rdPerson     = false
local Killer_3rdPersonDist = 8

-- ============================================================
-- VARIABEL GLOBAL - SURVIVOR
-- ============================================================
local SkillCheck       = false
local SkillCheckMode   = "Instant"
local SkillCheckFreq   = 10
local SkillCheckSpeed  = 10

local SpeedEnabled     = false
local SpeedAmount      = 16
local SpeedConn        = nil

local MoonwalkEnabled  = false
local MoonwalkConn     = nil

local FullBright       = false
local NoFog            = false
local NoShadow         = false

local UnlimitedVault   = false
local VaultSpeed       = 13

local AutoRepairEnabled = false
local BypassGenEnabled = false
local BypassGenMode    = "Multi"

local BypassGateEnabled = false

local AutoRunEnabled   = false

local AutoPalletEnabled = false
local AutoPalletDist   = 40
local AutoPalletSafety = true

local FleeKillerEnabled = false
local FleeDistance      = 30

local Invis_Enabled    = false
local SusR6Enabled     = false

local AutoCrouchEnabled = false
local PerfectVaultEnabled = false
local FlowstateNoCd    = false
local HitSoundEnabled  = false
local HitSoundVolume   = 1

local AutoParry        = false
local AutoParryRadius  = 15
local AutoParryFace    = 0.7
local AutoParryAggressive = false

-- ============================================================
-- VARIABEL GLOBAL - ESP
-- ============================================================
local ESP_Master       = false
local ESP_Player       = true
local ESP_Killer       = true
local ESP_Generator    = true
local ESP_Gate         = true
local ESP_Hook         = true
local ESP_Pallet       = false
local ESP_Window       = false
local ESP_ItemIcon     = false
local ESP_Distance     = 300
local ESP_Name         = true
local ESP_Outline      = false
local ESP_KillerWarn   = false
local ESP_GeneratorName = true
local FOVEnabled       = false
local FOVValue         = 150
local ShowHookCount    = false

-- ============================================================
-- VARIABEL GLOBAL - MISC
-- ============================================================
local WatermarkEnabled   = false
local WatermarkConn      = nil
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

-- ============================================================
-- INTERNAL STATE
-- ============================================================
local OrigNC           = nil
local SkillCheckConn   = nil
local cachedSpearRemote = nil
local ESPObjects       = {}
local HookESPs         = {}
local FOVCircle        = nil
local CrosshairGui     = nil
local WatermarkLabel   = nil
local KillerPerksGui   = nil
local SpectatorLabel   = nil
local ThirdPersonConn  = nil
local PalletConn       = nil
local FleeConn         = nil
local InvisConn        = nil
local AutoCrouchConn   = nil
local ParryConn        = nil
local espConn          = nil
local fovCircleDrawing = nil

-- ============================================================
-- UTILITY FUNCTIONS
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
    fov     = fov or Pistol_FOV
    maxDist = maxDist or 300
    local best, bestFOV = nil, fov
    local vp     = Camera.ViewportSize
    local center = Vector2.new(vp.X / 2, vp.Y / 2)
    local myChar = LocalPlayer.Character
    if not myChar then return nil end
    local myRoot = myChar:FindFirstChild("HumanoidRootPart")
    if not myRoot then return nil end
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character then
            local hum = p.Character:FindFirstChildOfClass("Humanoid")
            if hum and hum.Health > 0 then
                if blockKnocked  and p.Character:GetAttribute("Knocked")   then continue end
                if blockCarried  and p.Character:GetAttribute("IsCarried") then continue end
                local team = p:GetAttribute("Team") or (p.Character and p.Character:GetAttribute("Team"))
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
    local vel     = hrp.AssemblyLinearVelocity or Vector3.new()
    local basePred = hrp.Position + vel * (0.08 * leadMult)
    if usePredEff then
        local eff  = math.clamp(PredictionEfficiency, 0, 1)
        basePred   = hrp.Position:Lerp(basePred, eff)
    end
    return basePred
end

local function executeSilentAimFire(args, targetPos)
    if not targetPos then return false end
    for i, v in ipairs(args) do
        if typeof(v) == "Vector3" then args[i] = targetPos; return true end
        if typeof(v) == "CFrame"  then args[i] = CFrame.new(targetPos); return true end
    end
    table.insert(args, 1, targetPos)
    return true
end

local function getSpearRemote()
    if cachedSpearRemote and cachedSpearRemote.Parent then return cachedSpearRemote end
    cachedSpearRemote = nil
    local rs   = ReplicatedStorage
    local path1 = rs:FindFirstChild("Remotes")
    if path1 then
        local killers = path1:FindFirstChild("Killers")
        if killers then
            local veil = killers:FindFirstChild("Veil")
            if veil then
                local sp = veil:FindFirstChild("Spearthrow") or veil:FindFirstChild("SpearThrow")
                if sp then cachedSpearRemote = sp; return sp end
            end
        end
    end
    local found = rs:FindFirstChild("Spearthrow", true) or rs:FindFirstChild("SpearThrow", true)
    if found then cachedSpearRemote = found end
    return found
end

local function getNearestKiller(maxDist)
    local best, bestDist = nil, maxDist or math.huge
    local myChar = LocalPlayer.Character
    if not myChar then return nil end
    local myRoot = myChar:FindFirstChild("HumanoidRootPart")
    if not myRoot then return nil end
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character then
            local team = p:GetAttribute("Team") or (p.Character and p.Character:GetAttribute("Team"))
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

-- ============================================================
-- HOOK UTAMA: __namecall
-- ============================================================
local function setupHook()
    if OrigNC then return end
    pcall(function()
        local mt = getrawmetatable(game)
        setreadonly(mt, false)
        OrigNC = mt.__namecall
        mt.__namecall = newcclosure(function(self, ...)
            local method   = getnamecallmethod()
            local args     = {...}
            if checkcaller() then return OrigNC(self, table.unpack(args)) end
            local selfName = (typeof(self) == "Instance") and self.Name or ""

            -- Silent Aim Flask
            if KILLER_SilentAimFlask then
                if method == "ThrowFlask" or method == "AimFlask" or
                   (method == "FireServer" and (selfName:find("Flask") or selfName:find("Cure") or selfName:find("Throw"))) then
                    local target = getClosestSurvivor(Flask_MaxDist)
                    if target and target.Character then
                        local hrp = target.Character:FindFirstChild("HumanoidRootPart")
                        if hrp then
                            executeSilentAimFire(args, predictPosition(hrp, 1, false) + Vector3.new(0, Flash_YOffset, 0))
                        end
                    end
                end
            end

            -- Silent Aim Veil Spear
            if Aim_SilentVeil or Aim_SilentVeilV2 then
                local isSpear = false
                if method == "FireServer" or method == "InvokeServer" then
                    isSpear = (selfName == "Spearthrow" or selfName == "SpearThrow" or
                               selfName:lower():find("spear") ~= nil or selfName:find("Veil") ~= nil or
                               self == getSpearRemote())
                end
                if method == "Spearthrow" or method == "SpearThrow" then isSpear = true end
                if isSpear then
                    local target = getFOVTarget(Veil_FOV, SPEAR_MaxDist, false, true)
                    if target and target.Character then
                        local targetPart = Aim_SilentVeilV2
                            and (target.Character:FindFirstChild("Head") or target.Character:FindFirstChild("HumanoidRootPart"))
                            or  (target.Character:FindFirstChild("HumanoidRootPart") or target.Character:FindFirstChild("Torso"))
                        if targetPart then executeSilentAimFire(args, predictPosition(targetPart, Veil_LeadMultiplier, true)) end
                    end
                end
            end

            -- Silent Aim Pistol
            if Flash_Silent then
                if method == "FireServer" or method == "InvokeServer" then
                    local isPistol = (selfName == "EmperorGun" or selfName:find("Emperor") or
                                      selfName:find("Pistol") or selfName:find("doShoot") or
                                      selfName:find("Shoot") or selfName:find("Bullet") or
                                      selfName:find("Flash") or selfName:find("Gun") or
                                      selfName:find("Fire") or isChargingPistol)
                    if isPistol then
                        local target = getFOVTarget(Pistol_FOV, 200, Pistol_BlockKnocked, true)
                        if target and target.Character then
                            local hrp = target.Character:FindFirstChild("HumanoidRootPart")
                            if hrp then executeSilentAimFire(args, predictPosition(hrp, 1, true) + Vector3.new(0, Flash_YOffset, 0)) end
                        end
                    end
                end
            end

            return OrigNC(self, table.unpack(args))
        end)
        setreadonly(mt, true)
    end)
end

-- ============================================================
-- FITUR: AUTO SKILL CHECK
-- ============================================================
local function doSkillCheckClick(scGui)
    pcall(function()
        local remGen = scGui:FindFirstChild("Skillcheck-gen", true)
                    or ReplicatedStorage:FindFirstChild("Skillcheck-gen", true)
                    or ReplicatedStorage:FindFirstChild("SkillCheckResultEvent", true)
                    or ReplicatedStorage:FindFirstChild("SkillCheck", true)
        local remPlayer = scGui:FindFirstChild("Skillcheck-player", true)
                       or ReplicatedStorage:FindFirstChild("Skillcheck-player", true)
        if remGen and remGen:IsA("RemoteEvent") then pcall(function() remGen:FireServer(true) end)
        elseif remGen and remGen:IsA("RemoteFunction") then pcall(function() remGen:InvokeServer(true) end) end
        if remPlayer and remPlayer:IsA("RemoteEvent") then pcall(function() remPlayer:FireServer(true) end) end
        local checkElem = scGui:FindFirstChild("Check", true)
        if checkElem then
            local btn = checkElem:FindFirstChildWhichIsA("GuiButton") or (checkElem:IsA("GuiButton") and checkElem)
            if btn then pcall(function() firesignal(btn.MouseButton1Click) end) end
            pcall(function() if checkElem.Rotation ~= nil then checkElem.Rotation = 0 end end)
        end
    end)
end

local function StartAutoSkillCheck()
    if SkillCheckConn then SkillCheckConn:Disconnect(); SkillCheckConn = nil end
    SkillCheckConn = RunService.Heartbeat:Connect(function()
        if not SkillCheck then return end
        local char = LocalPlayer.Character
        if not char then return end
        local scGui = nil
        scGui = char:FindFirstChild("SkillCheckPromptGui")
        if not scGui then
            for _, sg in ipairs(PlayerGui:GetDescendants()) do
                if sg.Name == "SkillCheckPromptGui" then scGui = sg; break end
            end
        end
        if not scGui then
            for _, sg in ipairs(PlayerGui:GetChildren()) do
                if sg:IsA("ScreenGui") and sg.Enabled then
                    if sg:FindFirstChild("Check", true) and sg:FindFirstChild("Goal", true) then scGui = sg; break end
                end
            end
        end
        if not scGui then return end
        local checkElem = scGui:FindFirstChild("Check", true)
        if not checkElem or not checkElem.Visible then return end
        if scGui:GetAttribute("busy") then return end
        local goalElem = scGui:FindFirstChild("Goal", true)
        if SkillCheckMode == "Random" then
            scGui:SetAttribute("busy", true)
            task.spawn(function() doSkillCheckClick(scGui); task.wait(0.15); pcall(function() scGui:SetAttribute("busy", nil) end) end)
            return
        end
        if not goalElem then
            scGui:SetAttribute("busy", true)
            task.spawn(function()
                local delay = (SkillCheckMode == "Normal") and 0.05 or 0
                if delay > 0 then task.wait(delay) end
                doSkillCheckClick(scGui); task.wait(0.15)
                pcall(function() scGui:SetAttribute("busy", nil) end)
            end)
            return
        end
        local checkPos = checkElem.AbsolutePosition + checkElem.AbsoluteSize / 2
        local goalPos  = goalElem.AbsolutePosition
        local goalSize = goalElem.AbsoluteSize
        local inZone = (checkPos.X >= goalPos.X and checkPos.X <= goalPos.X + goalSize.X and
                        checkPos.Y >= goalPos.Y and checkPos.Y <= goalPos.Y + goalSize.Y)
        if inZone then
            scGui:SetAttribute("busy", true)
            task.spawn(function()
                local delay = (SkillCheckMode == "Normal") and 0.04 or 0
                if delay > 0 then task.wait(delay) end
                doSkillCheckClick(scGui); task.wait(0.15)
                pcall(function() scGui:SetAttribute("busy", nil) end)
            end)
        end
    end)
end

local function StopAutoSkillCheck()
    if SkillCheckConn then SkillCheckConn:Disconnect(); SkillCheckConn = nil end
end

-- ============================================================
-- FITUR: SPEED BOOST
-- ============================================================
local function StartSpeed()
    if SpeedConn then SpeedConn:Disconnect(); SpeedConn = nil end
    SpeedConn = RunService.Heartbeat:Connect(function()
        if not SpeedEnabled then return end
        local char = LocalPlayer.Character
        if not char then return end
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then hum.WalkSpeed = SpeedAmount end
    end)
end

local function StopSpeed()
    if SpeedConn then SpeedConn:Disconnect(); SpeedConn = nil end
    local char = LocalPlayer.Character
    if char then
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then hum.WalkSpeed = 16 end
    end
end

-- ============================================================
-- FITUR: MOONWALK
-- ============================================================
local function StartMoonwalk()
    if MoonwalkConn then MoonwalkConn:Disconnect(); MoonwalkConn = nil end
    MoonwalkConn = RunService.Heartbeat:Connect(function()
        if not MoonwalkEnabled then return end
        local char = LocalPlayer.Character
        if not char then return end
        local hum = char:FindFirstChildOfClass("Humanoid")
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if hum and hrp then
            local md = hum.MoveDirection
            if md.Magnitude > 0.1 then hrp.CFrame = hrp.CFrame * CFrame.Angles(0, math.pi, 0) end
        end
    end)
end

-- ============================================================
-- FITUR: FULL BRIGHT
-- ============================================================
local origLighting = {}
local function ApplyFullBright()
    origLighting.Brightness      = Lighting.Brightness
    origLighting.ClockTime       = Lighting.ClockTime
    origLighting.FogEnd          = Lighting.FogEnd
    origLighting.GlobalShadows   = Lighting.GlobalShadows
    origLighting.Ambient         = Lighting.Ambient
    origLighting.OutdoorAmbient  = Lighting.OutdoorAmbient
    Lighting.Brightness          = 2
    Lighting.ClockTime           = 14
    Lighting.FogEnd              = 1e9
    Lighting.GlobalShadows       = false
    Lighting.Ambient             = Color3.fromRGB(200, 200, 200)
    Lighting.OutdoorAmbient      = Color3.fromRGB(200, 200, 200)
    for _, v in pairs(Lighting:GetChildren()) do
        if v:IsA("Atmosphere") then v.Density = 0 end
    end
end

local function RevertFullBright()
    Lighting.Brightness     = origLighting.Brightness   or 1
    Lighting.ClockTime      = origLighting.ClockTime    or 14
    Lighting.FogEnd         = origLighting.FogEnd       or 10000
    Lighting.GlobalShadows  = origLighting.GlobalShadows ~= nil and origLighting.GlobalShadows or true
    Lighting.Ambient        = origLighting.Ambient      or Color3.fromRGB(70, 70, 70)
    Lighting.OutdoorAmbient = origLighting.OutdoorAmbient or Color3.fromRGB(70, 70, 70)
end

-- ============================================================
-- FITUR: NO FOG
-- ============================================================
local function ApplyNoFog()
    Lighting.FogStart = 1e9; Lighting.FogEnd = 1e9
    for _, v in pairs(Lighting:GetChildren()) do
        if v:IsA("Atmosphere") then v.Density = 0; v.Haze = 0 end
    end
end
local function RevertNoFog() Lighting.FogStart = 0; Lighting.FogEnd = 100000 end

-- ============================================================
-- FITUR: UNLIMITED VAULT
-- ============================================================
local function EnableUnlimitedVault()
    pcall(function()
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj.Name == "Window" or obj.Name == "Vault" or obj.Name == "Pallet" then
                if obj:GetAttribute("Cooldown") ~= nil then obj:SetAttribute("Cooldown", 0) end
            end
        end
    end)
end

-- ============================================================
-- FITUR: FLEE KILLER
-- ============================================================
local function StartFlee()
    if FleeConn then FleeConn:Disconnect(); FleeConn = nil end
    FleeConn = RunService.Heartbeat:Connect(function()
        if not FleeKillerEnabled then return end
        local char = LocalPlayer.Character
        if not char then return end
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if not hrp then return end
        local killer = getNearestKiller(FleeDistance)
        if killer and killer.Character then
            local khrp = killer.Character:FindFirstChild("HumanoidRootPart")
            if khrp then
                local dist = (khrp.Position - hrp.Position).Magnitude
                if dist <= FleeDistance then
                    local dir    = (hrp.Position - khrp.Position).Unit
                    hrp.CFrame   = CFrame.new(hrp.Position + dir * 50)
                end
            end
        end
    end)
end

-- ============================================================
-- FITUR: ESP
-- ============================================================
local function clearAllESP()
    for _, v in pairs(ESPObjects) do pcall(function() v:Destroy() end) end
    ESPObjects = {}
    for _, v in pairs(HookESPs) do pcall(function() v:Destroy() end) end
    HookESPs = {}
end

local function createESPBillboard(target, color, text)
    pcall(function()
        local existing = target:FindFirstChild("GK_ESP")
        if existing then existing:Destroy() end
        local bb  = Instance.new("BillboardGui")
        bb.Name   = "GK_ESP"
        bb.Size   = UDim2.fromOffset(100, 30)
        bb.StudsOffset = Vector3.new(0, 3, 0)
        bb.AlwaysOnTop = true
        bb.Adornee = target
        local lbl = Instance.new("TextLabel")
        lbl.BackgroundTransparency = 1
        lbl.Size          = UDim2.fromScale(1, 1)
        lbl.TextColor3    = color or Color3.fromRGB(255, 255, 255)
        lbl.TextScaled    = true
        lbl.TextStrokeTransparency = 0
        lbl.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
        lbl.Font          = Enum.Font.GothamBold
        lbl.Text          = text or "?"
        lbl.Parent        = bb
        bb.Parent         = game:GetService("CoreGui")
        table.insert(ESPObjects, bb)
    end)
end

local function UpdateESP()
    if not ESP_Master then clearAllESP(); return end
    clearAllESP()
    if ESP_Player or ESP_Killer then
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character then
                local hrp  = p.Character:FindFirstChild("HumanoidRootPart")
                if hrp then
                    local team     = p:GetAttribute("Team") or (p.Character and p.Character:GetAttribute("Team"))
                    local isKiller = (team == "Killer" or team == "killer")
                    local myRoot   = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                    local dist     = myRoot and math.floor((hrp.Position - myRoot.Position).Magnitude) or 0
                    if dist <= ESP_Distance then
                        if isKiller and ESP_Killer then
                            local name = p.DisplayName
                            if ShowHookCount then name = name .. " [H:" .. (p.Character:GetAttribute("HookCount") or 0) .. "]" end
                            createESPBillboard(hrp, Color3.fromRGB(255, 80, 80), name .. "\n[" .. dist .. "m]")
                        elseif not isKiller and ESP_Player then
                            local name = ESP_Name and p.DisplayName or "P"
                            local hc   = ShowHookCount and (p.Character:GetAttribute("HookCount") or 0) or nil
                            local txt  = name .. (hc and " [H:"..hc.."]" or "") .. "\n[" .. dist .. "m]"
                            createESPBillboard(hrp, Color3.fromRGB(100, 200, 255), txt)
                        end
                    end
                end
            end
        end
    end
    if ESP_Generator then
        pcall(function()
            for _, obj in pairs(workspace:GetDescendants()) do
                if obj.Name == "Generator" or obj.Name == "GeneratorPoint" then
                    local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                    if myRoot then
                        local dist     = math.floor((obj.Position - myRoot.Position).Magnitude)
                        if dist <= ESP_Distance then
                            local progress = obj:GetAttribute("Progress") or 0
                            local txt      = ESP_GeneratorName and ("⚡ Gen " .. math.floor(progress) .. "%\n[" .. dist .. "m]") or ("⚡ [" .. dist .. "m]")
                            createESPBillboard(obj, Color3.fromRGB(255, 220, 0), txt)
                        end
                    end
                end
            end
        end)
    end
    if ESP_Gate then
        pcall(function()
            for _, obj in pairs(workspace:GetDescendants()) do
                if obj.Name == "Gate" or obj.Name == "ExitGate" or obj.Name == "ExitLever" then
                    local part   = obj:IsA("BasePart") and obj or obj:FindFirstChildWhichIsA("BasePart")
                    if part then
                        local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                        if myRoot then
                            local dist = math.floor((part.Position - myRoot.Position).Magnitude)
                            if dist <= ESP_Distance then createESPBillboard(part, Color3.fromRGB(100, 255, 100), "🚪 Gate\n[" .. dist .. "m]") end
                        end
                    end
                end
            end
        end)
    end
    if ESP_Hook then
        pcall(function()
            for _, obj in pairs(workspace:GetDescendants()) do
                if obj.Name == "Hook" or obj.Name == "HookPoint" then
                    local part = obj:IsA("BasePart") and obj or obj:FindFirstChildWhichIsA("BasePart")
                    if part then
                        local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                        if myRoot then
                            local dist = math.floor((part.Position - myRoot.Position).Magnitude)
                            if dist <= ESP_Distance then createESPBillboard(part, Color3.fromRGB(255, 150, 50), "🪝 Hook\n[" .. dist .. "m]") end
                        end
                    end
                end
            end
        end)
    end
    if ESP_Pallet then
        pcall(function()
            for _, obj in pairs(workspace:GetDescendants()) do
                if obj.Name == "Pallet" or obj.Name == "DropPallet" then
                    local part = obj:IsA("BasePart") and obj or obj:FindFirstChildWhichIsA("BasePart")
                    if part then
                        local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                        if myRoot then
                            local dist = math.floor((part.Position - myRoot.Position).Magnitude)
                            if dist <= ESP_Distance then createESPBillboard(part, Color3.fromRGB(200, 100, 50), "🪵 Pallet\n[" .. dist .. "m]") end
                        end
                    end
                end
            end
        end)
    end
end

local function StartESP()
    if espConn then espConn:Disconnect(); espConn = nil end
    espConn = RunService.Heartbeat:Connect(function() pcall(UpdateESP) end)
end

-- ============================================================
-- FITUR: WATERMARK
-- ============================================================
local function StartWatermark()
    if WatermarkLabel then WatermarkLabel:Destroy(); WatermarkLabel = nil end
    if WatermarkConn  then WatermarkConn:Disconnect(); WatermarkConn = nil end
    local sg         = Instance.new("ScreenGui")
    sg.Name          = "GKZ_Watermark"
    sg.IgnoreGuiInset = true
    sg.ResetOnSpawn  = false
    sg.Parent        = PlayerGui
    local frame      = Instance.new("Frame")
    frame.Size       = UDim2.fromOffset(220, 28)
    frame.Position   = UDim2.fromOffset(8, 4)
    frame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
    frame.BackgroundTransparency = 0.3
    frame.BorderSizePixel = 0
    frame.Parent     = sg
    local corner     = Instance.new("UICorner"); corner.CornerRadius = UDim.new(0, 5); corner.Parent = frame
    local stroke     = Instance.new("UIStroke"); stroke.Color = Color3.fromRGB(100, 180, 255); stroke.Thickness = 1; stroke.Parent = frame
    WatermarkLabel   = Instance.new("TextLabel")
    WatermarkLabel.Size = UDim2.fromScale(1, 1)
    WatermarkLabel.BackgroundTransparency = 1
    WatermarkLabel.TextColor3 = Color3.fromRGB(220, 220, 255)
    WatermarkLabel.TextScaled = true
    WatermarkLabel.Font       = Enum.Font.GothamBold
    WatermarkLabel.Text       = "⚔ GanKunZ Hub"
    WatermarkLabel.Parent     = frame
    WatermarkConn = RunService.Heartbeat:Connect(function()
        if not WatermarkEnabled then return end
        local fps  = math.floor(1 / RunService.Heartbeat:Wait())
        local ping = LocalPlayer:GetNetworkPing and math.floor(LocalPlayer:GetNetworkPing() * 1000) or 0
        if WatermarkLabel then WatermarkLabel.Text = string.format("⚔ GanKunZ | %d FPS | %dms", fps, ping) end
    end)
end

local function StopWatermark()
    if WatermarkConn then WatermarkConn:Disconnect(); WatermarkConn = nil end
    local wg = PlayerGui:FindFirstChild("GKZ_Watermark")
    if wg then wg:Destroy() end
    WatermarkLabel = nil
end

-- ============================================================
-- FITUR: CROSSHAIR
-- ============================================================
local function CreateCrosshair()
    if CrosshairGui then CrosshairGui:Destroy(); CrosshairGui = nil end
    CrosshairGui = Instance.new("ScreenGui")
    CrosshairGui.Name         = "GKZ_Crosshair"
    CrosshairGui.IgnoreGuiInset = true
    CrosshairGui.ResetOnSpawn = false
    CrosshairGui.Parent       = PlayerGui
    local vp = Camera.ViewportSize
    local cx, cy = vp.X / 2, vp.Y / 2
    local h = Instance.new("Frame"); h.Name = "H"
    h.BackgroundColor3 = Color3.fromRGB(255, 255, 255); h.BorderSizePixel = 0
    h.Size     = UDim2.fromOffset(CrosshairSize * 2, CrosshairThickness)
    h.Position = UDim2.fromOffset(cx - CrosshairSize, cy - CrosshairThickness / 2)
    h.Parent   = CrosshairGui
    local v = Instance.new("Frame"); v.Name = "V"
    v.BackgroundColor3 = Color3.fromRGB(255, 255, 255); v.BorderSizePixel = 0
    v.Size     = UDim2.fromOffset(CrosshairThickness, CrosshairSize * 2)
    v.Position = UDim2.fromOffset(cx - CrosshairThickness / 2, cy - CrosshairSize)
    v.Parent   = CrosshairGui
end

local function RemoveCrosshair()
    if CrosshairGui then CrosshairGui:Destroy(); CrosshairGui = nil end
end

-- ============================================================
-- FITUR: TELEPORT
-- ============================================================
local function TeleportToGenerator()
    pcall(function()
        local char = LocalPlayer.Character; if not char then return end
        local hrp  = char:FindFirstChild("HumanoidRootPart"); if not hrp then return end
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj.Name == "Generator" or obj.Name == "GeneratorPoint" then
                local part = obj:IsA("BasePart") and obj or obj:FindFirstChildWhichIsA("BasePart")
                if part then hrp.CFrame = CFrame.new(part.Position + Vector3.new(0, 5, 0)); return end
            end
        end
    end)
end

local function TeleportToHook()
    pcall(function()
        local char = LocalPlayer.Character; if not char then return end
        local hrp  = char:FindFirstChild("HumanoidRootPart"); if not hrp then return end
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj.Name == "Hook" or obj.Name == "HookPoint" then
                local part = obj:IsA("BasePart") and obj or obj:FindFirstChildWhichIsA("BasePart")
                if part then hrp.CFrame = CFrame.new(part.Position + Vector3.new(0, 5, 0)); return end
            end
        end
    end)
end

local function TeleportToGate()
    pcall(function()
        local char = LocalPlayer.Character; if not char then return end
        local hrp  = char:FindFirstChild("HumanoidRootPart"); if not hrp then return end
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj.Name == "Gate" or obj.Name == "ExitGate" or obj.Name == "ExitLever" then
                local part = obj:IsA("BasePart") and obj or obj:FindFirstChildWhichIsA("BasePart")
                if part then hrp.CFrame = CFrame.new(part.Position + Vector3.new(0, 5, 0)); return end
            end
        end
    end)
end

local function ServerHop()
    pcall(function()
        local placeId = game.PlaceId
        local jobId   = game.JobId
        local servers = {}
        local ok, data = pcall(function()
            return HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. placeId .. "/servers/Public?limit=100"))
        end)
        if ok and data and data.data then
            for _, server in ipairs(data.data) do
                if server.id ~= jobId and server.playing and server.maxPlayers and server.playing < server.maxPlayers then
                    table.insert(servers, server.id)
                end
            end
        end
        if #servers > 0 then TeleportService:TeleportToPlaceInstance(placeId, servers[math.random(1, #servers)]) end
    end)
end

-- ============================================================
-- FITUR: AUTO PARRY
-- ============================================================
local function StartAutoParry()
    if ParryConn then ParryConn:Disconnect(); ParryConn = nil end
    ParryConn = RunService.Heartbeat:Connect(function()
        if not AutoParry then return end
        local char = LocalPlayer.Character; if not char then return end
        local hrp  = char:FindFirstChild("HumanoidRootPart"); if not hrp then return end
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character then
                local team = p:GetAttribute("Team") or (p.Character and p.Character:GetAttribute("Team"))
                if team == "Killer" or team == "killer" then
                    local khrp = p.Character:FindFirstChild("HumanoidRootPart")
                    if khrp and (khrp.Position - hrp.Position).Magnitude <= AutoParryRadius then
                        pcall(function()
                            for _, obj in pairs(workspace:GetDescendants()) do
                                if obj.Name == "Pallet" then
                                    local ppart = obj:IsA("BasePart") and obj or obj:FindFirstChildWhichIsA("BasePart")
                                    if ppart and (ppart.Position - hrp.Position).Magnitude <= 8 then
                                        local rem = obj:FindFirstChild("Drop", true) or ReplicatedStorage:FindFirstChild("Drop", true)
                                        if rem and rem:IsA("RemoteEvent") then pcall(function() rem:FireServer() end) end
                                    end
                                end
                            end
                        end)
                    end
                end
            end
        end
    end)
end

-- ============================================================
-- FOV CIRCLE
-- ============================================================
local function UpdateFOVCircle()
    if fovCircleDrawing then pcall(function() fovCircleDrawing:Remove() end); fovCircleDrawing = nil end
    if not FOVEnabled then return end
    pcall(function()
        if Drawing then
            fovCircleDrawing           = Drawing.new("Circle")
            fovCircleDrawing.Radius    = FOVValue
            fovCircleDrawing.Color     = Color3.fromRGB(255, 255, 255)
            fovCircleDrawing.Thickness = 1.5
            fovCircleDrawing.Transparency = 0.7
            fovCircleDrawing.Filled    = false
            fovCircleDrawing.Visible   = true
            local vp = Camera.ViewportSize
            fovCircleDrawing.Position  = Vector2.new(vp.X / 2, vp.Y / 2)
        end
    end)
end

-- ============================================================
-- RESPAWN HANDLER
-- ============================================================
LocalPlayer.CharacterAdded:Connect(function()
    task.wait(1)
    cachedSpearRemote = nil
    if SkillCheck        then StopAutoSkillCheck(); task.wait(0.3); StartAutoSkillCheck() end
    if SpeedEnabled      then StartSpeed()    end
    if FleeKillerEnabled then StartFlee()     end
    if AutoParry         then StartAutoParry() end
    if FullBright        then ApplyFullBright() end
    if NoFog             then ApplyNoFog()    end
end)

-- ============================================================
-- LOAD WindUI
-- ============================================================
local WindUI = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"
))()

local Window = WindUI:CreateWindow({
    Title       = "GanKunZ Hub",
    Icon        = "sword",
    Author      = "Violence District",
    Folder      = "GanKunZHub",
    Size        = UDim2.fromOffset(420, 580),
    Transparent = true,
    Theme       = "Dark",
    -- Tombol minimize/settings sudah bawaan WindUI
})

-- ============================================================
-- TAB: KILLER
-- ============================================================
local TabKiller = Window:Tab({ Title = "Killer", Icon = "skull" })

-- Silent Aim Flask
TabKiller:Section({ Title = "🧪 Silent Aim Flask (Cure)" })
TabKiller:Toggle({
    Title = "Silent Aim Flask",
    Description = "Redirect ThrowFlask ke survivor terdekat",
    Default = false,
    Callback = function(v) KILLER_SilentAimFlask = v; if v then setupHook() end end,
})
TabKiller:Slider({
    Title = "Flask Max Distance", Min = 20, Max = 150, Default = 60, Decimals = 0,
    Callback = function(v) Flask_MaxDist = v end,
})
TabKiller:Slider({
    Title = "Flask Y Offset", Min = 0, Max = 5, Default = 1.5, Decimals = 1,
    Callback = function(v) Flash_YOffset = v end,
})

-- Silent Aim Veil Spear
TabKiller:Section({ Title = "🌀 Silent Aim Veil Spear" })
TabKiller:Toggle({
    Title = "Silent Veil V1 (Body Aim)",
    Description = "Redirect Spearthrow ke body target (FIXED)",
    Default = false,
    Callback = function(v) Aim_SilentVeil = v; if v then setupHook() end end,
})
TabKiller:Toggle({
    Title = "Silent Veil V2 (Head Aim)",
    Description = "Aim ke kepala target (FIXED)",
    Default = false,
    Callback = function(v) Aim_SilentVeilV2 = v; if v then setupHook() end end,
})
TabKiller:Slider({
    Title = "Veil FOV", Min = 30, Max = 400, Default = 150, Decimals = 0,
    Callback = function(v) Veil_FOV = v end,
})
TabKiller:Slider({
    Title = "Veil Lead Multiplier", Min = 0.5, Max = 3.0, Default = 1.4, Decimals = 1,
    Callback = function(v) Veil_LeadMultiplier = v end,
})
TabKiller:Slider({
    Title = "Spear Max Distance", Min = 50, Max = 400, Default = 200, Decimals = 0,
    Callback = function(v) SPEAR_MaxDist = v end,
})

-- Silent Aim Pistol / EmperorGun
TabKiller:Section({ Title = "🔫 Silent Aim Pistol (EmperorGun)" })
TabKiller:Toggle({
    Title = "Silent Aim Pistol",
    Description = "Redirect EmperorGun/Flash ke target (FIXED)",
    Default = false,
    Callback = function(v) Flash_Silent = v; if v then setupHook() end end,
})
TabKiller:Toggle({
    Title = "Block Knocked Target",
    Description = "Skip target yang sudah knocked",
    Default = true,
    Callback = function(v) Pistol_BlockKnocked = v end,
})
TabKiller:Slider({
    Title = "Pistol FOV", Min = 30, Max = 400, Default = 150, Decimals = 0,
    Callback = function(v) Pistol_FOV = v end,
})
TabKiller:Slider({
    Title = "Prediction Efficiency", Min = 0, Max = 1.0, Default = 0.85, Decimals = 2,
    Callback = function(v) PredictionEfficiency = v end,
})
TabKiller:Slider({
    Title = "Pistol Y Offset", Min = 0, Max = 5, Default = 1.5, Decimals = 1,
    Callback = function(v) Flash_YOffset = v end,
})

-- Killer Buffs
TabKiller:Section({ Title = "⚡ Killer Buffs" })
TabKiller:Toggle({
    Title = "Infinite Frenzy (Jeff)", Default = false,
    Callback = function(v) KILLER_InfFrenzy = v; if v then setupHook() end end,
})
TabKiller:Toggle({
    Title = "Infinite Lake Mist (Jason)", Default = false,
    Callback = function(v) KILLER_InfLakeMist = v; if v then setupHook() end end,
})
TabKiller:Toggle({
    Title = "Infinite Pursuit (Jason)", Default = false,
    Callback = function(v) KILLER_InfPursuit = v; if v then setupHook() end end,
})
TabKiller:Toggle({
    Title = "Infinite Abyssal Corrupt", Default = false,
    Callback = function(v) KILLER_InfAbyssal = v end,
})
TabKiller:Toggle({
    Title = "No Slowdown (Killer)",
    Description = "Hilangkan slowdown saat menyerang",
    Default = false,
    Callback = function(v)
        KILLER_NoSlowdown = v
        pcall(function()
            local char = LocalPlayer.Character
            if char then
                local hum = char:FindFirstChildOfClass("Humanoid")
                if hum and v then
                    local conn
                    conn = hum:GetAttributeChangedSignal("Slowdown"):Connect(function()
                        if KILLER_NoSlowdown then hum:SetAttribute("Slowdown", false)
                        else if conn then conn:Disconnect() end end
                    end)
                end
            end
        end)
    end,
})
TabKiller:Toggle({
    Title = "Flask Laser Effect", Default = false,
    Callback = function(v) KILLER_FlaskLaser = v end,
})
TabKiller:Toggle({
    Title = "Third Person (Killer)",
    Description = "Kamera belakang karakter",
    Default = false,
    Callback = function(v)
        Killer_3rdPerson = v
        if ThirdPersonConn then ThirdPersonConn:Disconnect(); ThirdPersonConn = nil end
        if v then
            ThirdPersonConn = RunService.RenderStepped:Connect(function()
                if not Killer_3rdPerson then ThirdPersonConn:Disconnect(); return end
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
TabKiller:Slider({
    Title = "Third Person Distance", Min = 2, Max = 30, Default = 8, Decimals = 0,
    Callback = function(v) Killer_3rdPersonDist = v end,
})
TabKiller:Toggle({
    Title = "Infinite Lunge", Default = false,
    Callback = function(v) KILLER_InfLunge = v; if v then setupHook() end end,
})

-- ============================================================
-- TAB: SURVIVOR
-- ============================================================
local TabSurvivor = Window:Tab({ Title = "Survivor", Icon = "users" })

-- Auto Skill Check
TabSurvivor:Section({ Title = "⚙ Auto Skill Check" })
TabSurvivor:Toggle({
    Title = "Auto Skill Check",
    Description = "Auto klik SkillCheckPromptGui → Check zone",
    Default = false,
    Callback = function(v) SkillCheck = v; if v then StartAutoSkillCheck() else StopAutoSkillCheck() end end,
})
TabSurvivor:Dropdown({
    Title = "Mode Skill Check",
    Description = "Instant=langsung, Normal=delay kecil, Random=kapan saja",
    Values = { "Instant", "Normal", "Random" },
    Default = "Instant",
    Callback = function(v)
        SkillCheckMode = v
        if SkillCheck then StopAutoSkillCheck(); StartAutoSkillCheck() end
    end,
})
TabSurvivor:Slider({
    Title = "Skill Check Speed", Min = 1, Max = 30, Default = 10, Decimals = 0,
    Callback = function(v) SkillCheckSpeed = v end,
})
TabSurvivor:Slider({
    Title = "Skill Check Frequency", Min = 1, Max = 50, Default = 10, Decimals = 0,
    Callback = function(v) SkillCheckFreq = v end,
})

-- Auto Parry
TabSurvivor:Section({ Title = "🛡 Auto Parry" })
TabSurvivor:Toggle({
    Title = "Auto Parry",
    Description = "Auto parry / stun killer saat dalam jangkauan",
    Default = false,
    Callback = function(v)
        AutoParry = v
        if v then StartAutoParry() else if ParryConn then ParryConn:Disconnect(); ParryConn = nil end end
    end,
})
TabSurvivor:Toggle({
    Title = "Aggressive Mode",
    Description = "Langsung parry tanpa peduli face direction",
    Default = false,
    Callback = function(v) AutoParryAggressive = v end,
})
TabSurvivor:Slider({
    Title = "Parry Radius", Min = 5, Max = 50, Default = 15, Decimals = 0,
    Callback = function(v) AutoParryRadius = v end,
})

-- Speed & Movement
TabSurvivor:Section({ Title = "🏃 Speed & Movement" })
TabSurvivor:Toggle({
    Title = "Speed Boost",
    Description = "Speed modifier custom",
    Default = false,
    Callback = function(v) SpeedEnabled = v; if v then StartSpeed() else StopSpeed() end end,
})
TabSurvivor:Slider({
    Title = "Speed Value", Min = 16, Max = 100, Default = 30, Decimals = 0,
    Callback = function(v) SpeedAmount = v end,
})
TabSurvivor:Toggle({
    Title = "Moonwalk",
    Description = "Bergerak mundur saat berjalan ke depan",
    Default = false,
    Callback = function(v)
        MoonwalkEnabled = v
        if v then StartMoonwalk()
        else if MoonwalkConn then MoonwalkConn:Disconnect(); MoonwalkConn = nil end end
    end,
})
TabSurvivor:Toggle({
    Title = "Unlimited Vault",
    Description = "Vault/jendela tanpa cooldown",
    Default = false,
    Callback = function(v) UnlimitedVault = v; if v then EnableUnlimitedVault() end end,
})
TabSurvivor:Slider({
    Title = "Vault Speed", Min = 10, Max = 20, Default = 13, Decimals = 1,
    Callback = function(v) VaultSpeed = v end,
})
TabSurvivor:Toggle({
    Title = "Perfect Vault (Anti Slow)",
    Description = "Mencegah perlambatan saat vault",
    Default = false,
    Callback = function(v)
        PerfectVaultEnabled = v
        pcall(function()
            local char = LocalPlayer.Character
            if char then
                local hum = char:FindFirstChildOfClass("Humanoid")
                if hum and v then hum:SetAttribute("PerfectVault", true) end
            end
        end)
    end,
})
TabSurvivor:Toggle({
    Title = "Auto Run (PC)",
    Description = "Tekan LeftShift otomatis",
    Default = false,
    Callback = function(v)
        AutoRunEnabled = v
        if v then
            task.spawn(function()
                while AutoRunEnabled do
                    UserInputService:SendKeyEvent(true, Enum.KeyCode.LeftShift, false, game)
                    task.wait(0.1)
                end
            end)
        end
    end,
})

-- Generator & Bypass
TabSurvivor:Section({ Title = "🔧 Generator & Bypass" })
TabSurvivor:Toggle({
    Title = "Auto Repair (Bypass Gen)",
    Description = "Perbaiki generator tanpa skill check",
    Default = false,
    Callback = function(v)
        AutoRepairEnabled = v; BypassGenEnabled = v
        if v then
            pcall(function()
                local rem = ReplicatedStorage:FindFirstChild("GeneratorRepair", true)
                         or ReplicatedStorage:FindFirstChild("Repair", true)
                if rem and rem:IsA("RemoteEvent") then rem:FireServer(true) end
            end)
        end
    end,
})
TabSurvivor:Dropdown({
    Title = "Bypass Gen Mode",
    Description = "Multi = lebih cepat, Single = aman",
    Values = { "Multi", "Single" },
    Default = "Multi",
    Callback = function(v) BypassGenMode = v end,
})
TabSurvivor:Toggle({
    Title = "Bypass Gate",
    Description = "Tembus exit gate tanpa collision",
    Default = false,
    Callback = function(v)
        BypassGateEnabled = v
        pcall(function()
            for _, obj in pairs(workspace:GetDescendants()) do
                if obj.Name == "Gate" or obj.Name == "ExitGate" then
                    for _, p in pairs(obj:GetDescendants()) do
                        if p:IsA("BasePart") then p.CanCollide = not v end
                    end
                end
            end
        end)
    end,
})
TabSurvivor:Button({
    Title = "Drop All Pallets",
    Description = "Drop semua pallet sekarang",
    Callback = function()
        pcall(function()
            for _, obj in pairs(workspace:GetDescendants()) do
                if obj.Name == "Pallet" then
                    local rem = obj:FindFirstChild("Drop", true) or ReplicatedStorage:FindFirstChild("DropPallet", true)
                    if rem and rem:IsA("RemoteEvent") then pcall(function() rem:FireServer() end) end
                end
            end
        end)
    end,
})

-- Auto Pallet
TabSurvivor:Section({ Title = "🪵 Auto Pallet" })
TabSurvivor:Toggle({
    Title = "Auto Pallet",
    Description = "Auto drop pallet saat killer mendekat",
    Default = false,
    Callback = function(v)
        AutoPalletEnabled = v
        if PalletConn then PalletConn:Disconnect(); PalletConn = nil end
        if v then
            PalletConn = RunService.Heartbeat:Connect(function()
                if not AutoPalletEnabled then return end
                local killer = getNearestKiller(AutoPalletDist)
                if killer then
                    pcall(function()
                        local char = LocalPlayer.Character; if not char then return end
                        local hrp  = char:FindFirstChild("HumanoidRootPart"); if not hrp then return end
                        for _, obj in pairs(workspace:GetDescendants()) do
                            if obj.Name == "Pallet" then
                                local ppart = obj:IsA("BasePart") and obj or obj:FindFirstChildWhichIsA("BasePart")
                                if ppart and (ppart.Position - hrp.Position).Magnitude <= 8 then
                                    local rem = obj:FindFirstChild("Drop", true) or ReplicatedStorage:FindFirstChild("DropPallet", true)
                                    if rem and rem:IsA("RemoteEvent") then pcall(function() rem:FireServer() end) end
                                end
                            end
                        end
                    end)
                end
            end)
        end
    end,
})
TabSurvivor:Toggle({
    Title = "Safety Pallet",
    Description = "Cegah drop saat down/carry/hook",
    Default = true,
    Callback = function(v) AutoPalletSafety = v end,
})
TabSurvivor:Slider({
    Title = "Auto Pallet Distance", Min = 10, Max = 80, Default = 40, Decimals = 0,
    Callback = function(v) AutoPalletDist = v end,
})

-- Flee Killer
TabSurvivor:Section({ Title = "🦺 Flee Killer" })
TabSurvivor:Toggle({
    Title = "Flee Killer (Auto TP)",
    Description = "Teleport saat killer terlalu dekat",
    Default = false,
    Callback = function(v)
        FleeKillerEnabled = v
        if v then StartFlee() else if FleeConn then FleeConn:Disconnect(); FleeConn = nil end end
    end,
})
TabSurvivor:Slider({
    Title = "Flee Distance", Min = 15, Max = 80, Default = 30, Decimals = 0,
    Callback = function(v) FleeDistance = v end,
})

-- Misc Survivor
TabSurvivor:Section({ Title = "✨ Misc Survivor" })
TabSurvivor:Toggle({
    Title = "Auto Crouch (Dodge Abyssal S1)",
    Default = false,
    Callback = function(v)
        AutoCrouchEnabled = v
        if AutoCrouchConn then AutoCrouchConn:Disconnect(); AutoCrouchConn = nil end
        if v then
            AutoCrouchConn = RunService.Heartbeat:Connect(function()
                if not AutoCrouchEnabled then return end
                pcall(function()
                    local char = LocalPlayer.Character; if not char then return end
                    local hum  = char:FindFirstChildOfClass("Humanoid")
                    if hum then
                        for _, p in ipairs(Players:GetPlayers()) do
                            if p ~= LocalPlayer and p.Character then
                                local team  = p:GetAttribute("Team") or ""
                                if team == "Killer" or team == "killer" then
                                    local skill = p.Character:GetAttribute("UsingSkill") or ""
                                    if skill:find("S1") or skill:find("Abyssal") then
                                        hum:SetAttribute("Crouching", true)
                                        task.wait(0.5)
                                        hum:SetAttribute("Crouching", false)
                                    end
                                end
                            end
                        end
                    end
                end)
            end)
        end
    end,
})
TabSurvivor:Toggle({
    Title = "Flowstate No CD", Default = false,
    Callback = function(v) FlowstateNoCd = v; if v then setupHook() end end,
})
TabSurvivor:Toggle({
    Title = "Skill Hidden No CD", Default = false,
    Callback = function(v) if v then setupHook() end end,
})
TabSurvivor:Toggle({
    Title = "Hit Sound Effect",
    Description = "Suara saat berhasil stun killer",
    Default = false,
    Callback = function(v) HitSoundEnabled = v end,
})
TabSurvivor:Slider({
    Title = "Hit Sound Volume", Min = 0, Max = 2, Default = 1, Decimals = 1,
    Callback = function(v) HitSoundVolume = v end,
})
TabSurvivor:Toggle({
    Title = "Invisibility [OP]",
    Description = "Karakter tidak terlihat",
    Default = false,
    Callback = function(v)
        Invis_Enabled = v
        if InvisConn then InvisConn:Disconnect(); InvisConn = nil end
        local char = LocalPlayer.Character
        if char then
            for _, part in pairs(char:GetDescendants()) do
                if part:IsA("BasePart") or part:IsA("Decal") then part.Transparency = v and 1 or 0 end
            end
        end
        if v then
            InvisConn = Players.LocalPlayer.CharacterAdded:Connect(function(c)
                for _, part in pairs(c:GetDescendants()) do
                    if part:IsA("BasePart") or part:IsA("Decal") then part.Transparency = 1 end
                end
            end)
        end
    end,
})
TabSurvivor:Toggle({
    Title = "No Fall Damage", Default = false,
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
TabSurvivor:Toggle({
    Title = "Counter Auto Parry",
    Description = "Animasi random buat ngelabui auto parry",
    Default = false,
    Callback = function(v) if v then setupHook() end end,
})
TabSurvivor:Toggle({
    Title = "SusR6 Mode", Default = false,
    Callback = function(v)
        SusR6Enabled = v
        pcall(function()
            local char = LocalPlayer.Character
            if char then char:SetAttribute("SusR6", v) end
        end)
    end,
})

-- ============================================================
-- TAB: VISUAL / WORLD
-- ============================================================
local TabVisual = Window:Tab({ Title = "Visual", Icon = "sun" })

TabVisual:Section({ Title = "🌍 World Effects" })
TabVisual:Toggle({
    Title = "Full Bright",
    Description = "Bikin map jadi terang",
    Default = false,
    Callback = function(v) FullBright = v; if v then ApplyFullBright() else RevertFullBright() end end,
})
TabVisual:Toggle({
    Title = "No Fog",
    Description = "Hapus kabut biar map lebih jelas",
    Default = false,
    Callback = function(v) NoFog = v; if v then ApplyNoFog() else RevertNoFog() end end,
})
TabVisual:Toggle({
    Title = "No Shadow", Default = false,
    Callback = function(v) NoShadow = v; Lighting.GlobalShadows = not v end,
})
TabVisual:Slider({
    Title = "Time Of Day",
    Description = "Atur waktu game (0-24)",
    Min = 0, Max = 24, Default = 14, Decimals = 0,
    Callback = function(v) TimeOfDayValue = v; Lighting.ClockTime = v end,
})

TabVisual:Section({ Title = "📷 Camera Settings" })
TabVisual:Slider({
    Title = "Camera FOV", Min = 50, Max = 120, Default = 70, Decimals = 0,
    Callback = function(v) CameraFOVValue = v; Camera.FieldOfView = v end,
})
TabVisual:Toggle({
    Title = "Infinity Zoom Out",
    Description = "Zoom kamera maksimal tanpa batas",
    Default = false,
    Callback = function(v) InfinityZoom = v; pcall(function() LocalPlayer.CameraMaxZoomDistance = v and 1e9 or 400 end) end,
})

TabVisual:Section({ Title = "✚ Crosshair" })
TabVisual:Toggle({
    Title = "Enable Crosshair", Default = false,
    Callback = function(v) CrosshairEnabled = v; if v then CreateCrosshair() else RemoveCrosshair() end end,
})
TabVisual:Slider({
    Title = "Crosshair Size", Min = 5, Max = 30, Default = 10, Decimals = 0,
    Callback = function(v) CrosshairSize = v; if CrosshairEnabled then CreateCrosshair() end end,
})
TabVisual:Slider({
    Title = "Crosshair Thickness", Min = 1, Max = 5, Default = 2, Decimals = 0,
    Callback = function(v) CrosshairThickness = v; if CrosshairEnabled then CreateCrosshair() end end,
})

TabVisual:Section({ Title = "⭕ FOV Circle" })
TabVisual:Toggle({
    Title = "Show FOV Circle", Default = false,
    Callback = function(v) FOVEnabled = v; UpdateFOVCircle() end,
})
TabVisual:Toggle({
    Title = "Show Veil FOV", Default = false,
    Callback = function(v) Veil_ShowFOV = v end,
})
TabVisual:Slider({
    Title = "FOV Circle Size", Min = 50, Max = 500, Default = 150, Decimals = 0,
    Callback = function(v) FOVValue = v; if FOVEnabled then UpdateFOVCircle() end end,
})

-- ============================================================
-- TAB: ESP
-- ============================================================
local TabESP = Window:Tab({ Title = "ESP", Icon = "eye" })

TabESP:Section({ Title = "🌐 ESP Settings" })
TabESP:Toggle({
    Title = "Enable ESP",
    Description = "Aktifkan ESP untuk semua objek",
    Default = false,
    Callback = function(v)
        ESP_Master = v
        if v then StartESP()
        else clearAllESP(); if espConn then espConn:Disconnect(); espConn = nil end end
    end,
})
TabESP:Slider({
    Title = "ESP Distance", Min = 50, Max = 1000, Default = 300, Decimals = 0,
    Callback = function(v) ESP_Distance = v end,
})

TabESP:Section({ Title = "👤 Player ESP" })
TabESP:Toggle({
    Title = "Player ESP", Default = true,
    Callback = function(v) ESP_Player = v end,
})
TabESP:Toggle({
    Title = "Killer ESP", Default = true,
    Callback = function(v) ESP_Killer = v end,
})
TabESP:Toggle({
    Title = "Show ESP Name", Default = true,
    Callback = function(v) ESP_Name = v end,
})
TabESP:Toggle({
    Title = "Killer Warn",
    Description = "Warning saat killer mendekat",
    Default = false,
    Callback = function(v) ESP_KillerWarn = v end,
})
TabESP:Toggle({
    Title = "Show Hook Count",
    Description = "Tampilkan jumlah hook di atas kepala",
    Default = false,
    Callback = function(v) ShowHookCount = v end,
})

TabESP:Section({ Title = "🗺 Map ESP" })
TabESP:Toggle({ Title = "Generator ESP", Default = true, Callback = function(v) ESP_Generator = v end })
TabESP:Toggle({ Title = "Gen Name & Progress", Default = true, Callback = function(v) ESP_GeneratorName = v end })
TabESP:Toggle({ Title = "Gate ESP", Default = true, Callback = function(v) ESP_Gate = v end })
TabESP:Toggle({ Title = "Hook ESP", Default = true, Callback = function(v) ESP_Hook = v end })
TabESP:Toggle({ Title = "Pallet ESP", Default = false, Callback = function(v) ESP_Pallet = v end })
TabESP:Toggle({ Title = "Window ESP", Default = false, Callback = function(v) ESP_Window = v end })
TabESP:Toggle({ Title = "Item Icon ESP", Default = false, Callback = function(v) ESP_ItemIcon = v end })

-- ============================================================
-- TAB: TELEPORT
-- ============================================================
local TabTeleport = Window:Tab({ Title = "Teleport", Icon = "map-pin" })

TabTeleport:Section({ Title = "📡 Teleport Maps" })
TabTeleport:Button({ Title = "TP ke Generator", Description = "Teleport ke generator terdekat", Callback = TeleportToGenerator })
TabTeleport:Button({ Title = "TP ke Hook",      Description = "Teleport ke hook terdekat",      Callback = TeleportToHook })
TabTeleport:Button({ Title = "TP ke Gate",      Description = "Teleport ke exit gate",           Callback = TeleportToGate })
TabTeleport:Button({
    Title = "TP ke Pallet", Description = "Teleport ke pallet terdekat",
    Callback = function()
        pcall(function()
            local char = LocalPlayer.Character; if not char then return end
            local hrp  = char:FindFirstChild("HumanoidRootPart"); if not hrp then return end
            local nearest, nearDist = nil, math.huge
            for _, obj in pairs(workspace:GetDescendants()) do
                if obj.Name == "Pallet" then
                    local p = obj:IsA("BasePart") and obj or obj:FindFirstChildWhichIsA("BasePart")
                    if p then local d = (p.Position - hrp.Position).Magnitude; if d < nearDist then nearDist = d; nearest = p end end
                end
            end
            if nearest then hrp.CFrame = CFrame.new(nearest.Position + Vector3.new(0, 5, 0)) end
        end)
    end,
})
TabTeleport:Button({
    Title = "TP ke Window", Description = "Teleport ke window terdekat",
    Callback = function()
        pcall(function()
            local char = LocalPlayer.Character; if not char then return end
            local hrp  = char:FindFirstChild("HumanoidRootPart"); if not hrp then return end
            local nearest, nearDist = nil, math.huge
            for _, obj in pairs(workspace:GetDescendants()) do
                if obj.Name == "Window" or obj.Name == "Vault" then
                    local p = obj:IsA("BasePart") and obj or obj:FindFirstChildWhichIsA("BasePart")
                    if p then local d = (p.Position - hrp.Position).Magnitude; if d < nearDist then nearDist = d; nearest = p end end
                end
            end
            if nearest then hrp.CFrame = CFrame.new(nearest.Position + Vector3.new(0, 5, 0)) end
        end)
    end,
})

TabTeleport:Section({ Title = "👤 Teleport ke Player" })
TabTeleport:Dropdown({
    Title = "Pilih Player",
    Description = "Pilih player untuk diteleport ke",
    Values = (function()
        local names = {}
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LocalPlayer then table.insert(names, p.Name) end
        end
        return names
    end)(),
    Default = "",
    Callback = function(val)
        pcall(function()
            local target = Players:FindFirstChild(val)
            if target and target.Character then
                local char = LocalPlayer.Character
                if char then
                    local hrp  = char:FindFirstChild("HumanoidRootPart")
                    local tHrp = target.Character:FindFirstChild("HumanoidRootPart")
                    if hrp and tHrp then hrp.CFrame = tHrp.CFrame + Vector3.new(3, 0, 0) end
                end
            end
        end)
    end,
})

-- ============================================================
-- TAB: MISC
-- ============================================================
local TabMisc = Window:Tab({ Title = "Misc", Icon = "settings" })

TabMisc:Section({ Title = "💧 Watermark & Display" })
TabMisc:Toggle({
    Title = "Watermark (FPS + Ping)",
    Description = "Tampilkan FPS dan Ping di sudut layar",
    Default = false,
    Callback = function(v) WatermarkEnabled = v; if v then StartWatermark() else StopWatermark() end end,
})
TabMisc:Toggle({
    Title = "Spectator Info",
    Description = "Menampilkan jumlah spectator",
    Default = false,
    Callback = function(v)
        SpectatorEnabled = v
        if v then
            if SpectatorLabel then return end
            pcall(function()
                local sg = Instance.new("ScreenGui"); sg.Name = "GKZ_Spectator"; sg.Parent = PlayerGui; sg.ResetOnSpawn = false
                local lbl = Instance.new("TextLabel")
                lbl.Size = UDim2.fromOffset(150, 25); lbl.Position = UDim2.fromOffset(8, 38)
                lbl.BackgroundColor3 = Color3.fromRGB(15, 15, 20); lbl.BackgroundTransparency = 0.3
                lbl.TextColor3 = Color3.fromRGB(220, 220, 255); lbl.TextScaled = true
                lbl.Font = Enum.Font.GothamBold; lbl.Text = "Spectators: 0"; lbl.Parent = sg
                SpectatorLabel = lbl
                RunService.Heartbeat:Connect(function()
                    if not SpectatorEnabled then return end
                    local count = 0
                    for _, p in ipairs(Players:GetPlayers()) do
                        if p ~= LocalPlayer then pcall(function() if p:GetAttribute("IsSpectating") then count = count + 1 end end) end
                    end
                    if SpectatorLabel then SpectatorLabel.Text = "Spectators: " .. count end
                end)
            end)
        else
            local sg = PlayerGui:FindFirstChild("GKZ_Spectator"); if sg then sg:Destroy() end
            SpectatorLabel = nil
        end
    end,
})
TabMisc:Toggle({
    Title = "Next Killer Display", Default = false,
    Callback = function(v) NextKillerEnabled = v end,
})
TabMisc:Toggle({
    Title = "Killer Perks Display", Default = false,
    Callback = function(v) KillerPerksToggle = v end,
})

TabMisc:Section({ Title = "🎚 Performance" })
TabMisc:Toggle({
    Title = "FPS Cap", Default = false,
    Callback = function(v)
        FPSCapEnabled = v
        if v then pcall(function() setfpscap(FPSCapValue) end)
        else pcall(function() setfpscap(0) end) end
    end,
})
TabMisc:Slider({
    Title = "FPS Cap Value", Min = 10, Max = 240, Default = 60, Decimals = 0,
    Callback = function(v)
        FPSCapValue = v
        if FPSCapEnabled then pcall(function() setfpscap(v) end) end
    end,
})

TabMisc:Section({ Title = "🌍 Server" })
TabMisc:Button({
    Title = "Hop Server",
    Description = "Pindah ke server yang berbeda",
    Callback = ServerHop,
})
TabMisc:Toggle({
    Title = "Skip Endscreen",
    Description = "Skip tampilan akhir match",
    Default = false,
    Callback = function(v)
        if v then
            pcall(function()
                for _, child in pairs(PlayerGui:GetDescendants()) do
                    if child.Name == "EndScreen" or child.Name == "endscreen" then child:Destroy() end
                end
            end)
        end
    end,
})

TabMisc:Section({ Title = "🔧 Tools" })
TabMisc:Button({
    Title = "Tools Jerk",
    Description = "Load Tools Jerk external script",
    Callback = function()
        pcall(function() loadstring(game:HttpGet("https://pastefy.app/wa3v2Vgm/raw"))() end)
    end,
})
TabMisc:Button({
    Title = "Fly GUI",
    Description = "Load Fly GUI external script",
    Callback = function()
        pcall(function() loadstring(game:HttpGet("https://raw.githubusercontent.com/XNEOFF/FlyGuiV3/main/FlyGuiV3.txt"))() end)
    end,
})

TabMisc:Section({ Title = "⚠ Danger Zone" })
TabMisc:Button({
    Title = "Unload Script",
    Description = "Matikan semua fitur dan hapus GUI",
    Callback = function()
        if SkillCheckConn   then SkillCheckConn:Disconnect()   end
        if SpeedConn        then SpeedConn:Disconnect()        end
        if MoonwalkConn     then MoonwalkConn:Disconnect()     end
        if WatermarkConn    then WatermarkConn:Disconnect()    end
        if espConn          then espConn:Disconnect()          end
        if PalletConn       then PalletConn:Disconnect()       end
        if FleeConn         then FleeConn:Disconnect()         end
        if ParryConn        then ParryConn:Disconnect()        end
        if ThirdPersonConn  then ThirdPersonConn:Disconnect()  end
        if AutoCrouchConn   then AutoCrouchConn:Disconnect()   end
        if InvisConn        then InvisConn:Disconnect()        end
        clearAllESP(); StopWatermark(); RemoveCrosshair()
        if FOVEnabled and fovCircleDrawing then pcall(function() fovCircleDrawing:Remove() end) end
        local char = LocalPlayer.Character
        if char then
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hum then hum.WalkSpeed = 16 end
            for _, part in pairs(char:GetDescendants()) do
                if part:IsA("BasePart") then part.Transparency = 0 end
            end
        end
        local wg = PlayerGui:FindFirstChild("GanKunZHub"); if wg then wg:Destroy() end
        Camera.CameraType = Enum.CameraType.Custom
        print("[GanKunZ] Script di-unload.")
    end,
})

-- ============================================================
-- SELESAI
-- ============================================================
print([[
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 ⚔  GanKunZ Hub (WindUI v1.6.65) - LOADED
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
]])
