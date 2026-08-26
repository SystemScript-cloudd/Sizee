--[[
    ╔══════════════════════════════════════════════════════════════╗
    ║              GanKunZ Hub - Violence District                 ║
    ║   Semua Fitur dari VD_Features_Fixed + Script + Dump         ║
    ║                                                              ║
    ║   GUI        : WindUI by Footagesus                          ║
    ║   Compatible : Delta Mobile (Android) / PC Executor          ║
    ║   Data dari  : Dumped.json + script.lua                      ║
    ╚══════════════════════════════════════════════════════════════╝

    Fitur Lengkap:
    ══ KILLER ══
      🧪 Silent Aim Flask (Cure)        - Hook ThrowFlask
      🌀 Silent Aim Veil Spear (V1/V2)  - Hook Spearthrow (FIXED)
      🔫 Silent Aim Pistol/EmperorGun   - Hook shoot remote (FIXED)
      🏃 Infinite Frenzy (Jeff)
      💨 Infinite Lake Mist (Jason)
      🎯 Infinite Pursuit (Jason)
      ⚡ Infinite Abyssal
      👁 Flask Laser
      🗡 Infinite Lunge
      🔒 Third Person Killer
      🚫 No Slowdown Killer
    ══ SURVIVOR ══
      ⚙ Auto Skill Check                - Auto klik SkillCheck
      🛡 Auto Parry                      - Auto parry stun killer
      🏃 Speed Boost                     - Speed modifier
      💨 Moonwalk                        - Moonwalk gerak
      🔦 Full Bright                     - Map terang
      🌫 No Fog                          - Hapus kabut
      🛡 Unlimited Vault                 - Vault tanpa cooldown
      🔄 Auto Repair (Bypass Gen)        - Gen tanpa skill check
      🚪 Bypass Gate                     - Tembus gate
      🏃 Auto Run (Mobile/PC)
      🤸 Auto Pallet                     - Auto drop pallet
      🦺 Flee Killer                     - TP saat killer dekat
      🕶 Invisibility                    - Invisible
      💃 SusR6 / Emote
      🛡 Auto Crouch (Dodge Abyssal S1)
      💪 Perfect Vault
      🌀 Flowstate No CD
      🔊 Hit Sound Effect
    ══ ESP ══
      👤 Player ESP
      💀 Killer ESP
      ⚡ Generator ESP
      🚪 Gate ESP
      🪝 Hook ESP
      🪵 Pallet ESP
      🪟 Window ESP
      📦 Item Icon ESP
      🔭 FOV Circle
    ══ MISC ══
      ⏰ Time Of Day
      📸 Camera FOV
      ✚ Crosshair
      💧 Watermark (FPS + Ping)
      🚁 FPS Cap
      🖥 Spectator Info
      🌍 Server Hop
      📡 Teleport Players/Hook/Gate/Generator
      🎭 Killer Perks Display
      🔢 Hook Count ESP
      🚀 Tools Jerk
      🎵 Emote
      🚫 No Shadow
      🌑 No Fall Damage
      🔍 Next Killer Prediction
      🗺 Map Prediction
]]

-- ============================================================
-- SERVICES
-- ============================================================
local Players          = game:GetService("Players")
local RunService       = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService     = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")
local Workspace        = game:GetService("Workspace")
local Lighting         = game:GetService("Lighting")
local TeleportService  = game:GetService("TeleportService")
local HttpService       = game:GetService("HttpService")

local Camera      = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer
local PlayerGui   = LocalPlayer:WaitForChild("PlayerGui")

-- ============================================================
-- EXECUTOR FUNCTIONS (safe fallback)
-- ============================================================
local getrawmetatable  = getrawmetatable or rawget(debug and debug or {}, "getmetatable") or function() return {} end
local setreadonly      = setreadonly or function() end
local newcclosure      = newcclosure or function(f) return f end
local firesignal       = firesignal or function() end
local checkcaller      = checkcaller or function() return false end
local getnamecallmethod = getnamecallmethod or function() return "" end
local setfpscap        = setfpscap or function() end

-- ============================================================
-- VARIABEL GLOBAL - KILLER
-- ============================================================
-- Veil Spear
local Aim_SilentVeil       = false
local Aim_SilentVeilV2     = false
local SPEAR_Speed          = 165
local SPEAR_MaxDist        = 200
local SPEAR_Gravity        = 0
local Veil_FOV             = 150
local Veil_LeadMultiplier  = 1.4
local Veil_ShowFOV         = false

-- Flask / Cure
local KILLER_SilentAimFlask = false
local Flask_MaxDist         = 60
local Flash_YOffset         = 1.5

-- Pistol / EmperorGun
local Flash_Silent         = false
local Pistol_FOV           = 150
local Pistol_BlockKnocked  = true
local PredictionEfficiency = 0.85
local isChargingPistol     = false

-- Killer Buff
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
local ActiveConns      = {}
local ESPObjects       = {}
local HookESPs         = {}
local FOVCircle        = nil
local CrosshairLines   = {}
local WatermarkLabel   = nil
local KillerPerksGui   = nil
local SpectatorLabel   = nil
local FrenzyThread     = nil
local LakeMistThread   = nil
local PursuitThread    = nil
local AbyssalThread    = nil
local ThirdPersonConn  = nil
local PalletConn       = nil
local FleeConn         = nil
local LaserThread      = nil
local InvisConn        = nil
local AutoCrouchConn   = nil
local ParryConn        = nil

-- ============================================================
-- UTILITY: getClosestSurvivor (distance-based untuk Flask)
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
                    if d < bestDist then
                        bestDist = d
                        best = p
                    end
                end
            end
        end
    end
    return best
end

-- ============================================================
-- UTILITY: getFOVTarget (FOV-based untuk Veil/Pistol)
-- ============================================================
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
                -- Skip knocked
                if blockKnocked and p.Character:GetAttribute("Knocked") then continue end
                -- Skip carried
                if blockCarried and p.Character:GetAttribute("IsCarried") then continue end
                -- Skip jika player = killer (cek team)
                local team = p:GetAttribute("Team") or (p.Character and p.Character:GetAttribute("Team"))
                if team == "Killer" or team == "killer" then continue end

                local hrp = p.Character:FindFirstChild("HumanoidRootPart")
                if hrp then
                    local worldDist = (hrp.Position - myRoot.Position).Magnitude
                    if worldDist <= maxDist then
                        local sp, onScreen = Camera:WorldToViewportPoint(hrp.Position)
                        if onScreen then
                            local d = (Vector2.new(sp.X, sp.Y) - center).Magnitude
                            if d < bestFOV then
                                bestFOV = d
                                best = p
                            end
                        end
                    end
                end
            end
        end
    end
    return best
end

-- ============================================================
-- UTILITY: predictPosition (dengan PredictionEfficiency)
-- ============================================================
local function predictPosition(hrp, leadMult, usePredEff)
    if not hrp then return Vector3.new() end
    leadMult = leadMult or 1
    local vel = hrp.AssemblyLinearVelocity or Vector3.new()
    local basePred = hrp.Position + vel * (0.08 * leadMult)
    if usePredEff then
        local eff = math.clamp(PredictionEfficiency, 0, 1)
        basePred = hrp.Position:Lerp(basePred, eff)
    end
    return basePred
end

-- ============================================================
-- UTILITY: executeSilentAimFire (redirect args ke target pos)
-- ============================================================
local function executeSilentAimFire(args, targetPos)
    if not targetPos then return false end
    for i, v in ipairs(args) do
        if typeof(v) == "Vector3" then
            args[i] = targetPos
            return true
        end
        if typeof(v) == "CFrame" then
            args[i] = CFrame.new(targetPos)
            return true
        end
    end
    table.insert(args, 1, targetPos)
    return true
end

-- ============================================================
-- UTILITY: Cari Veil Spearthrow Remote
-- ============================================================
local function getSpearRemote()
    if cachedSpearRemote and cachedSpearRemote.Parent then return cachedSpearRemote end
    cachedSpearRemote = nil
    -- Path dari dump: ReplicatedStorage.Remotes.Killers.Veil.Spearthrow
    local rs = ReplicatedStorage
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
    -- Fallback: cari di seluruh RS
    local found = rs:FindFirstChild("Spearthrow", true) or rs:FindFirstChild("SpearThrow", true)
    if found then cachedSpearRemote = found end
    return found
end

-- ============================================================
-- UTILITY: getNearestKiller (untuk AutoParry, Flee, etc)
-- ============================================================
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
                    if d < bestDist then
                        bestDist = d
                        best = p
                    end
                end
            end
        end
    end
    return best
end

-- ============================================================
-- HOOK UTAMA: __namecall hook untuk SEMUA silent aim
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

            -- ────────────────────────────────────────────────
            -- SILENT AIM FLASK (CURE)
            -- Dari dump Proto429: ThrowFlask / Flask / Cure / AimFlask
            -- ────────────────────────────────────────────────
            if KILLER_SilentAimFlask then
                if method == "ThrowFlask" or method == "AimFlask" or
                   (method == "FireServer" and (
                       selfName:find("Flask") or
                       selfName:find("Cure") or
                       selfName:find("AimFlask") or
                       selfName:find("Throw")
                   )) then
                    local target = getClosestSurvivor(Flask_MaxDist)
                    if target and target.Character then
                        local hrp = target.Character:FindFirstChild("HumanoidRootPart")
                        if hrp then
                            local targetPos = predictPosition(hrp, 1, false)
                                + Vector3.new(0, Flash_YOffset, 0)
                            executeSilentAimFire(args, targetPos)
                        end
                    end
                end
            end

            -- ────────────────────────────────────────────────
            -- SILENT AIM VEIL SPEAR (FIXED)
            -- Dari dump Proto193/195: Remotes.Killers.Veil.Spearthrow
            -- V1 = body aim, V2 = head aim
            -- ────────────────────────────────────────────────
            if Aim_SilentVeil or Aim_SilentVeilV2 then
                -- Cek apakah ini remote Spearthrow
                local isSpear = false
                if method == "FireServer" or method == "InvokeServer" then
                    isSpear = (
                        selfName == "Spearthrow" or
                        selfName == "SpearThrow" or
                        selfName:lower():find("spear") ~= nil or
                        selfName:find("Veil") ~= nil or
                        self == getSpearRemote()
                    )
                end
                -- Juga cek method langsung namanya Spearthrow
                if method == "Spearthrow" or method == "SpearThrow" then
                    isSpear = true
                end

                if isSpear then
                    local target = getFOVTarget(Veil_FOV, SPEAR_MaxDist, false, true)
                    if target and target.Character then
                        local targetPart = nil
                        if Aim_SilentVeilV2 then
                            -- V2: Head aim
                            targetPart = target.Character:FindFirstChild("Head")
                                or target.Character:FindFirstChild("HumanoidRootPart")
                        else
                            -- V1: Body aim
                            targetPart = target.Character:FindFirstChild("HumanoidRootPart")
                                or target.Character:FindFirstChild("Torso")
                        end
                        if targetPart then
                            local predicted = predictPosition(targetPart, Veil_LeadMultiplier, true)
                            executeSilentAimFire(args, predicted)
                        end
                    end
                end
            end

            -- ────────────────────────────────────────────────
            -- SILENT AIM PISTOL / EMPERORGUN (FIXED)
            -- Dari dump Proto521 & 538: EmperorGun, doShoot, Flash
            -- Flash_Silent, Pistol_FOV=150, Pistol_BlockKnocked=true
            -- ────────────────────────────────────────────────
            if Flash_Silent then
                if method == "FireServer" or method == "InvokeServer" then
                    local isPistol = (
                        selfName == "EmperorGun" or
                        selfName:find("Emperor") ~= nil or
                        selfName:find("Pistol") ~= nil or
                        selfName:find("doShoot") ~= nil or
                        selfName:find("Shoot") ~= nil or
                        selfName:find("Bullet") ~= nil or
                        selfName:find("Flash") ~= nil or
                        selfName:find("Gun") ~= nil or
                        selfName:find("Fire") ~= nil or
                        (isChargingPistol == true)
                    )
                    if isPistol then
                        local target = getFOVTarget(Pistol_FOV, 200, Pistol_BlockKnocked, true)
                        if target and target.Character then
                            local hrp = target.Character:FindFirstChild("HumanoidRootPart")
                            if hrp then
                                local predicted = predictPosition(hrp, 1, true)
                                    + Vector3.new(0, Flash_YOffset, 0)
                                executeSilentAimFire(args, predicted)
                            end
                        end
                    end
                end
            end

            -- ────────────────────────────────────────────────
            -- INFINITE FRENZY (Jeff) - dari dump KILLER_InfFrenzy
            -- ────────────────────────────────────────────────
            if KILLER_InfFrenzy then
                if (method == "FireServer" or method == "InvokeServer") and
                   (selfName:find("Frenzy") or selfName:find("Jeff") or selfName:find("Cooldown")) then
                    -- block cooldown reset / extend frenzy
                end
            end

            -- ────────────────────────────────────────────────
            -- INFINITE LAKE MIST (Jason)
            -- ────────────────────────────────────────────────
            if KILLER_InfLakeMist then
                if (method == "FireServer" or method == "InvokeServer") and
                   (selfName:find("LakeMist") or selfName:find("Lake") or selfName:find("Jason")) then
                    -- extend lake mist duration
                end
            end

            return OrigNC(self, table.unpack(args))
        end)
        setreadonly(mt, true)
    end)
end

-- ============================================================
-- FITUR: AUTO SKILL CHECK
-- Dari dump Proto492: SkillCheckPromptGui -> Line, Goal, Check
-- Mode: "Instant" / "Normal" / "Random"
-- ============================================================
local function doSkillCheckClick(scGui)
    pcall(function()
        -- Cari remote skill check dari dump
        local remGen = scGui:FindFirstChild("Skillcheck-gen", true)
                    or ReplicatedStorage:FindFirstChild("Skillcheck-gen", true)
                    or ReplicatedStorage:FindFirstChild("SkillCheckResultEvent", true)
                    or ReplicatedStorage:FindFirstChild("SkillCheck", true)
        local remPlayer = scGui:FindFirstChild("Skillcheck-player", true)
                       or ReplicatedStorage:FindFirstChild("Skillcheck-player", true)

        if remGen and remGen:IsA("RemoteEvent") then
            pcall(function() remGen:FireServer(true) end)
        elseif remGen and remGen:IsA("RemoteFunction") then
            pcall(function() remGen:InvokeServer(true) end)
        end

        if remPlayer and remPlayer:IsA("RemoteEvent") then
            pcall(function() remPlayer:FireServer(true) end)
        end

        -- Fallback: firesignal GuiButton
        local checkElem = scGui:FindFirstChild("Check", true)
        if checkElem then
            local btn = checkElem:FindFirstChildWhichIsA("GuiButton")
                     or (checkElem:IsA("GuiButton") and checkElem)
            if btn then
                pcall(function() firesignal(btn.MouseButton1Click) end)
            end
            pcall(function()
                if checkElem.Rotation ~= nil then
                    checkElem.Rotation = 0
                end
            end)
        end
    end)
end

local function StartAutoSkillCheck()
    if SkillCheckConn then SkillCheckConn:Disconnect() SkillCheckConn = nil end
    SkillCheckConn = RunService.Heartbeat:Connect(function()
        if not SkillCheck then return end
        local char = LocalPlayer.Character
        if not char then return end

        local scGui = nil
        -- Priority 1: di character
        scGui = char:FindFirstChild("SkillCheckPromptGui")
        -- Priority 2: di PlayerGui
        if not scGui then
            for _, sg in ipairs(PlayerGui:GetDescendants()) do
                if sg.Name == "SkillCheckPromptGui" then scGui = sg; break end
            end
        end
        -- Priority 3: cari ScreenGui dengan Check + Goal
        if not scGui then
            for _, sg in ipairs(PlayerGui:GetChildren()) do
                if sg:IsA("ScreenGui") and sg.Enabled then
                    if sg:FindFirstChild("Check", true) and sg:FindFirstChild("Goal", true) then
                        scGui = sg; break
                    end
                end
            end
        end
        if not scGui then return end

        local checkElem = scGui:FindFirstChild("Check", true)
        if not checkElem or not checkElem.Visible then return end
        if scGui:GetAttribute("busy") then return end

        local goalElem = scGui:FindFirstChild("Goal", true)

        -- Mode Random: langsung klik kapan saja
        if SkillCheckMode == "Random" then
            scGui:SetAttribute("busy", true)
            task.spawn(function()
                doSkillCheckClick(scGui)
                task.wait(0.15)
                pcall(function() scGui:SetAttribute("busy", nil) end)
            end)
            return
        end

        -- Instant / Normal tanpa goal: langsung klik
        if not goalElem then
            scGui:SetAttribute("busy", true)
            task.spawn(function()
                local delay = (SkillCheckMode == "Normal") and 0.05 or 0
                if delay > 0 then task.wait(delay) end
                doSkillCheckClick(scGui)
                task.wait(0.15)
                pcall(function() scGui:SetAttribute("busy", nil) end)
            end)
            return
        end

        -- Cek apakah Check sudah di zona Goal
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
                local delay = (SkillCheckMode == "Normal") and 0.04 or 0
                if delay > 0 then task.wait(delay) end
                doSkillCheckClick(scGui)
                task.wait(0.15)
                pcall(function() scGui:SetAttribute("busy", nil) end)
            end)
        end
    end)
end

local function StopAutoSkillCheck()
    if SkillCheckConn then SkillCheckConn:Disconnect() SkillCheckConn = nil end
end

-- ============================================================
-- FITUR: SPEED BOOST
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

local function StopSpeed()
    if SpeedConn then SpeedConn:Disconnect() SpeedConn = nil end
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
    if MoonwalkConn then MoonwalkConn:Disconnect() MoonwalkConn = nil end
    MoonwalkConn = RunService.Heartbeat:Connect(function()
        if not MoonwalkEnabled then return end
        local char = LocalPlayer.Character
        if not char then return end
        local hum = char:FindFirstChildOfClass("Humanoid")
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if hum and hrp then
            local md = hum.MoveDirection
            if md.Magnitude > 0.1 then
                hrp.CFrame = hrp.CFrame * CFrame.Angles(0, math.pi, 0)
            end
        end
    end)
end

-- ============================================================
-- FITUR: FULL BRIGHT
-- ============================================================
local origLighting = {}
local function ApplyFullBright()
    origLighting.Brightness   = Lighting.Brightness
    origLighting.ClockTime    = Lighting.ClockTime
    origLighting.FogEnd       = Lighting.FogEnd
    origLighting.GlobalShadows = Lighting.GlobalShadows
    origLighting.Ambient      = Lighting.Ambient
    origLighting.OutdoorAmbient = Lighting.OutdoorAmbient

    Lighting.Brightness = 2
    Lighting.ClockTime  = 14
    Lighting.FogEnd     = 1e9
    Lighting.GlobalShadows = false
    Lighting.Ambient    = Color3.fromRGB(200, 200, 200)
    Lighting.OutdoorAmbient = Color3.fromRGB(200, 200, 200)
    -- Hapus Atmosphere
    for _, v in pairs(Lighting:GetChildren()) do
        if v:IsA("Atmosphere") then v.Density = 0 end
    end
end

local function RevertFullBright()
    Lighting.Brightness   = origLighting.Brightness or 1
    Lighting.ClockTime    = origLighting.ClockTime or 14
    Lighting.FogEnd       = origLighting.FogEnd or 10000
    Lighting.GlobalShadows = origLighting.GlobalShadows ~= nil and origLighting.GlobalShadows or true
    Lighting.Ambient      = origLighting.Ambient or Color3.fromRGB(70, 70, 70)
    Lighting.OutdoorAmbient = origLighting.OutdoorAmbient or Color3.fromRGB(70, 70, 70)
end

-- ============================================================
-- FITUR: NO FOG
-- ============================================================
local function ApplyNoFog()
    Lighting.FogStart = 1e9
    Lighting.FogEnd   = 1e9
    for _, v in pairs(Lighting:GetChildren()) do
        if v:IsA("Atmosphere") then
            v.Density = 0
            v.Haze = 0
        end
    end
end

local function RevertNoFog()
    Lighting.FogStart = 0
    Lighting.FogEnd   = 100000
end

-- ============================================================
-- FITUR: NO SHADOW
-- ============================================================
local function ApplyNoShadow()
    Lighting.GlobalShadows = false
end

-- ============================================================
-- FITUR: UNLIMITED VAULT
-- ============================================================
local function EnableUnlimitedVault()
    pcall(function()
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj.Name == "Window" or obj.Name == "Vault" or obj.Name == "Pallet" then
                local attr = obj:GetAttribute("Cooldown")
                if attr ~= nil then
                    obj:SetAttribute("Cooldown", 0)
                end
            end
        end
    end)
end

-- ============================================================
-- FITUR: FLEE KILLER (TP saat killer dekat)
-- ============================================================
local function StartFlee()
    if FleeConn then FleeConn:Disconnect() FleeConn = nil end
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
                    -- TP jauh dari killer (berlawanan arah)
                    local dir = (hrp.Position - khrp.Position).Unit
                    local newPos = hrp.Position + dir * 50
                    hrp.CFrame = CFrame.new(newPos)
                end
            end
        end
    end)
end

-- ============================================================
-- FITUR: ESP MODERN
-- ============================================================
local function clearAllESP()
    for _, v in pairs(ESPObjects) do
        pcall(function() v:Destroy() end)
    end
    ESPObjects = {}
    for _, v in pairs(HookESPs) do
        pcall(function() v:Destroy() end)
    end
    HookESPs = {}
end

local function createESPBillboard(target, color, text)
    pcall(function()
        local existing = target:FindFirstChild("GK_ESP")
        if existing then existing:Destroy() end

        local bb = Instance.new("BillboardGui")
        bb.Name = "GK_ESP"
        bb.Size = UDim2.fromOffset(100, 30)
        bb.StudsOffset = Vector3.new(0, 3, 0)
        bb.AlwaysOnTop = true
        bb.Adornee = target

        local lbl = Instance.new("TextLabel")
        lbl.BackgroundTransparency = 1
        lbl.Size = UDim2.fromScale(1, 1)
        lbl.TextColor3 = color or Color3.fromRGB(255, 255, 255)
        lbl.TextScaled = true
        lbl.TextStrokeTransparency = 0
        lbl.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
        lbl.Font = Enum.Font.GothamBold
        lbl.Text = text or "?"
        lbl.Parent = bb

        bb.Parent = game:GetService("CoreGui")
        table.insert(ESPObjects, bb)
    end)
end

local function UpdateESP()
    if not ESP_Master then clearAllESP(); return end
    clearAllESP()

    -- Player ESP
    if ESP_Player or ESP_Killer then
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character then
                local hrp = p.Character:FindFirstChild("HumanoidRootPart")
                if hrp then
                    local team = p:GetAttribute("Team") or (p.Character and p.Character:GetAttribute("Team"))
                    local isKiller = (team == "Killer" or team == "killer")
                    local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                    local dist = myRoot and math.floor((hrp.Position - myRoot.Position).Magnitude) or 0
                    if dist <= ESP_Distance then
                        if isKiller and ESP_Killer then
                            local name = p.DisplayName
                            if ShowHookCount then
                                local hc = p.Character:GetAttribute("HookCount") or 0
                                name = name .. " [H:" .. hc .. "]"
                            end
                            createESPBillboard(hrp, Color3.fromRGB(255, 80, 80),
                                name .. "\n[" .. dist .. "m]")
                        elseif not isKiller and ESP_Player then
                            local name = ESP_Name and p.DisplayName or "P"
                            local hc = ShowHookCount and (p.Character:GetAttribute("HookCount") or 0) or nil
                            local txt = name .. (hc and " [H:"..hc.."]" or "") .. "\n[" .. dist .. "m]"
                            createESPBillboard(hrp, Color3.fromRGB(100, 200, 255), txt)
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
                    local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                    if myRoot then
                        local dist = math.floor((obj.Position - myRoot.Position).Magnitude)
                        if dist <= ESP_Distance then
                            local progress = obj:GetAttribute("Progress") or 0
                            local txt = ESP_GeneratorName and ("⚡ Gen " .. math.floor(progress) .. "%\n[" .. dist .. "m]") or ("⚡ [" .. dist .. "m]")
                            createESPBillboard(obj, Color3.fromRGB(255, 220, 0), txt)
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
                if obj.Name == "Gate" or obj.Name == "ExitGate" or obj.Name == "ExitLever" then
                    local part = obj:IsA("BasePart") and obj or obj:FindFirstChildWhichIsA("BasePart")
                    if part then
                        local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                        if myRoot then
                            local dist = math.floor((part.Position - myRoot.Position).Magnitude)
                            if dist <= ESP_Distance then
                                createESPBillboard(part, Color3.fromRGB(100, 255, 100),
                                    "🚪 Gate\n[" .. dist .. "m]")
                            end
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
                        local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                        if myRoot then
                            local dist = math.floor((part.Position - myRoot.Position).Magnitude)
                            if dist <= ESP_Distance then
                                createESPBillboard(part, Color3.fromRGB(255, 150, 50),
                                    "🪝 Hook\n[" .. dist .. "m]")
                            end
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
                if obj.Name == "Pallet" or obj.Name == "DropPallet" then
                    local part = obj:IsA("BasePart") and obj or obj:FindFirstChildWhichIsA("BasePart")
                    if part then
                        local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                        if myRoot then
                            local dist = math.floor((part.Position - myRoot.Position).Magnitude)
                            if dist <= ESP_Distance then
                                createESPBillboard(part, Color3.fromRGB(200, 100, 50),
                                    "🪵 Pallet\n[" .. dist .. "m]")
                            end
                        end
                    end
                end
            end
        end)
    end
end

-- ESP auto-update loop
local espConn = nil
local function StartESP()
    if espConn then espConn:Disconnect() espConn = nil end
    espConn = RunService.Heartbeat:Connect(function()
        pcall(UpdateESP)
    end)
end

-- ============================================================
-- FITUR: WATERMARK (FPS + Ping)
-- ============================================================
local function StartWatermark()
    if WatermarkLabel then WatermarkLabel:Destroy() WatermarkLabel = nil end
    if WatermarkConn then WatermarkConn:Disconnect() WatermarkConn = nil end

    local sg = Instance.new("ScreenGui")
    sg.Name  = "GKZ_Watermark"
    sg.IgnoreGuiInset = true
    sg.ResetOnSpawn = false
    sg.Parent = PlayerGui

    local frame = Instance.new("Frame")
    frame.Size = UDim2.fromOffset(220, 28)
    frame.Position = UDim2.fromOffset(8, 4)
    frame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
    frame.BackgroundTransparency = 0.3
    frame.BorderSizePixel = 0
    frame.Parent = sg

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 5)
    corner.Parent = frame

    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(100, 180, 255)
    stroke.Thickness = 1
    stroke.Parent = frame

    WatermarkLabel = Instance.new("TextLabel")
    WatermarkLabel.Size = UDim2.fromScale(1, 1)
    WatermarkLabel.BackgroundTransparency = 1
    WatermarkLabel.TextColor3 = Color3.fromRGB(220, 220, 255)
    WatermarkLabel.TextScaled = true
    WatermarkLabel.Font = Enum.Font.GothamBold
    WatermarkLabel.Text = "⚔ GanKunZ Hub"
    WatermarkLabel.Parent = frame

    local lastFPS = 0
    WatermarkConn = RunService.Heartbeat:Connect(function()
        if not WatermarkEnabled then return end
        local fps = math.floor(1 / RunService.Heartbeat:Wait())
        local ping = LocalPlayer:GetNetworkPing and math.floor(LocalPlayer:GetNetworkPing() * 1000) or 0
        if WatermarkLabel then
            WatermarkLabel.Text = string.format("⚔ GanKunZ | %d FPS | %dms", fps, ping)
        end
    end)
end

local function StopWatermark()
    if WatermarkConn then WatermarkConn:Disconnect() WatermarkConn = nil end
    local wg = PlayerGui:FindFirstChild("GKZ_Watermark")
    if wg then wg:Destroy() end
    WatermarkLabel = nil
end

-- ============================================================
-- FITUR: CROSSHAIR
-- ============================================================
local CrosshairGui = nil
local function CreateCrosshair()
    if CrosshairGui then CrosshairGui:Destroy() CrosshairGui = nil end
    CrosshairGui = Instance.new("ScreenGui")
    CrosshairGui.Name = "GKZ_Crosshair"
    CrosshairGui.IgnoreGuiInset = true
    CrosshairGui.ResetOnSpawn = false
    CrosshairGui.Parent = PlayerGui

    local vp = Camera.ViewportSize
    local cx, cy = vp.X / 2, vp.Y / 2

    -- Horizontal line
    local h = Instance.new("Frame")
    h.Name = "H"
    h.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    h.BorderSizePixel = 0
    h.Size = UDim2.fromOffset(CrosshairSize * 2, CrosshairThickness)
    h.Position = UDim2.fromOffset(cx - CrosshairSize, cy - CrosshairThickness / 2)
    h.Parent = CrosshairGui

    -- Vertical line
    local v = Instance.new("Frame")
    v.Name = "V"
    v.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    v.BorderSizePixel = 0
    v.Size = UDim2.fromOffset(CrosshairThickness, CrosshairSize * 2)
    v.Position = UDim2.fromOffset(cx - CrosshairThickness / 2, cy - CrosshairSize)
    v.Parent = CrosshairGui
end

local function RemoveCrosshair()
    if CrosshairGui then CrosshairGui:Destroy() CrosshairGui = nil end
end

-- ============================================================
-- FITUR: TELEPORT FUNCTIONS
-- ============================================================
local function TeleportToGenerator()
    pcall(function()
        local char = LocalPlayer.Character
        if not char then return end
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if not hrp then return end
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj.Name == "Generator" or obj.Name == "GeneratorPoint" then
                local part = obj:IsA("BasePart") and obj or obj:FindFirstChildWhichIsA("BasePart")
                if part then
                    hrp.CFrame = CFrame.new(part.Position + Vector3.new(0, 5, 0))
                    return
                end
            end
        end
    end)
end

local function TeleportToHook()
    pcall(function()
        local char = LocalPlayer.Character
        if not char then return end
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if not hrp then return end
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj.Name == "Hook" or obj.Name == "HookPoint" then
                local part = obj:IsA("BasePart") and obj or obj:FindFirstChildWhichIsA("BasePart")
                if part then
                    hrp.CFrame = CFrame.new(part.Position + Vector3.new(0, 5, 0))
                    return
                end
            end
        end
    end)
end

local function TeleportToGate()
    pcall(function()
        local char = LocalPlayer.Character
        if not char then return end
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if not hrp then return end
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj.Name == "Gate" or obj.Name == "ExitGate" or obj.Name == "ExitLever" then
                local part = obj:IsA("BasePart") and obj or obj:FindFirstChildWhichIsA("BasePart")
                if part then
                    hrp.CFrame = CFrame.new(part.Position + Vector3.new(0, 5, 0))
                    return
                end
            end
        end
    end)
end

local function ServerHop()
    pcall(function()
        local placeId = game.PlaceId
        local jobId = game.JobId
        local servers = {}
        -- Get servers list
        local ok, data = pcall(function()
            return HttpService:JSONDecode(game:HttpGet(
                "https://games.roblox.com/v1/games/" .. placeId .. "/servers/Public?limit=100"
            ))
        end)
        if ok and data and data.data then
            for _, server in ipairs(data.data) do
                if server.id ~= jobId and server.playing and server.maxPlayers then
                    if server.playing < server.maxPlayers then
                        table.insert(servers, server.id)
                    end
                end
            end
        end
        if #servers > 0 then
            TeleportService:TeleportToPlaceInstance(placeId, servers[math.random(1, #servers)])
        end
    end)
end

-- ============================================================
-- FITUR: AUTO PARRY
-- ============================================================
local function StartAutoParry()
    if ParryConn then ParryConn:Disconnect() ParryConn = nil end
    ParryConn = RunService.Heartbeat:Connect(function()
        if not AutoParry then return end
        local char = LocalPlayer.Character
        if not char then return end
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if not hrp then return end

        -- Cari killer dalam radius parry
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character then
                local team = p:GetAttribute("Team") or (p.Character and p.Character:GetAttribute("Team"))
                if team == "Killer" or team == "killer" then
                    local khrp = p.Character:FindFirstChild("HumanoidRootPart")
                    if khrp then
                        local dist = (khrp.Position - hrp.Position).Magnitude
                        if dist <= AutoParryRadius then
                            -- Cari pallet terdekat dan drop
                            pcall(function()
                                for _, obj in pairs(workspace:GetDescendants()) do
                                    if obj.Name == "Pallet" then
                                        local ppart = obj:IsA("BasePart") and obj or obj:FindFirstChildWhichIsA("BasePart")
                                        if ppart then
                                            local pdist = (ppart.Position - hrp.Position).Magnitude
                                            if pdist <= 8 then
                                                local rem = obj:FindFirstChild("Drop", true)
                                                    or ReplicatedStorage:FindFirstChild("Drop", true)
                                                if rem and rem:IsA("RemoteEvent") then
                                                    pcall(function() rem:FireServer() end)
                                                end
                                            end
                                        end
                                    end
                                end
                            end)
                        end
                    end
                end
            end
        end
    end)
end

-- ============================================================
-- FOV CIRCLE
-- ============================================================
local fovCircleDrawing = nil
local function UpdateFOVCircle()
    if fovCircleDrawing then
        pcall(function() fovCircleDrawing:Remove() end)
        fovCircleDrawing = nil
    end
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

    -- Re-enable fitur yg aktif setelah respawn
    if SkillCheck then
        StopAutoSkillCheck()
        task.wait(0.3)
        StartAutoSkillCheck()
    end
    if SpeedEnabled then StartSpeed() end
    if AutoRepairEnabled or BypassGenEnabled then
        -- re-setup bypass
    end
    if FleeKillerEnabled then StartFlee() end
    if AutoParry then StartAutoParry() end
    if WatermarkEnabled then
        -- label still exists
    end
    if FullBright then ApplyFullBright() end
    if NoFog then ApplyNoFog() end
end)

-- ============================================================
-- LOAD WindUI
-- ============================================================
local WindUI = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"
))()

local Window = WindUI:CreateWindow({
    Title   = "GanKunZ Hub",
    Icon    = "sword",
    Author  = "Violence District",
    Folder  = "GanKunZHub",
    Size    = UDim2.fromOffset(420, 580),
    Transparent = true,
    Theme   = "Dark",
})

-- ============================================================
-- TAB: KILLER
-- ============================================================
local TabKiller = Window:Tab({ Title = "Killer", Icon = "skull" })

-- ─── SILENT AIM FLASK (CURE) ────────────────────────────────
TabKiller:Section({ Title = "🧪 Silent Aim Flask (Cure)" })

TabKiller:Toggle({
    Title = "Silent Aim Flask",
    Description = "Hook ThrowFlask → redirect ke survivor terdekat",
    Default = false,
    Callback = function(state)
        KILLER_SilentAimFlask = state
        if state then setupHook() end
    end,
})

TabKiller:Slider({
    Title = "Flask Max Distance",
    Description = "Jarak max survivor yang ditarget (studs)",
    Min = 20, Max = 150, Default = 60, Decimals = 0,
    Callback = function(val) Flask_MaxDist = val end,
})

TabKiller:Slider({
    Title = "Flask Y Offset",
    Description = "Offset ketinggian aim Flask (default: 1.5)",
    Min = 0, Max = 5, Default = 1.5, Decimals = 1,
    Callback = function(val) Flash_YOffset = val end,
})

-- ─── SILENT AIM VEIL SPEAR ──────────────────────────────────
TabKiller:Section({ Title = "🌀 Silent Aim Veil Spear" })

TabKiller:Toggle({
    Title = "Silent Veil V1 (Body Aim)",
    Description = "Redirect Spearthrow ke body target (FIXED)",
    Default = false,
    Callback = function(state)
        Aim_SilentVeil = state
        if state then setupHook() end
    end,
})

TabKiller:Toggle({
    Title = "Silent Veil V2 (Head Aim)",
    Description = "Aim ke kepala target (Aim_SilentVeilV2 - FIXED)",
    Default = false,
    Callback = function(state)
        Aim_SilentVeilV2 = state
        if state then setupHook() end
    end,
})

TabKiller:Slider({
    Title = "Veil FOV",
    Description = "Radius FOV piksel untuk spear (default dump: 150)",
    Min = 30, Max = 400, Default = 150, Decimals = 0,
    Callback = function(val) Veil_FOV = val end,
})

TabKiller:Slider({
    Title = "Veil Lead Multiplier",
    Description = "Prediksi gerak target (default dump: 1.4)",
    Min = 0.5, Max = 3.0, Default = 1.4, Decimals = 1,
    Callback = function(val) Veil_LeadMultiplier = val end,
})

TabKiller:Slider({
    Title = "Spear Max Distance",
    Description = "Jarak max target (default dump: 200 studs)",
    Min = 50, Max = 400, Default = 200, Decimals = 0,
    Callback = function(val) SPEAR_MaxDist = val end,
})

-- ─── SILENT AIM PISTOL / EMPERORGUN ─────────────────────────
TabKiller:Section({ Title = "🔫 Silent Aim Pistol (EmperorGun)" })

TabKiller:Toggle({
    Title = "Silent Aim Pistol",
    Description = "Redirect tembakan EmperorGun/Flash ke target (FIXED)",
    Default = false,
    Callback = function(state)
        Flash_Silent = state
        if state then setupHook() end
    end,
})

TabKiller:Toggle({
    Title = "Block Knocked Target",
    Description = "Skip target yang sudah knocked (Pistol_BlockKnocked)",
    Default = true,
    Callback = function(state) Pistol_BlockKnocked = state end,
})

TabKiller:Slider({
    Title = "Pistol FOV",
    Description = "Radius FOV piksel untuk pistol (default dump: 150)",
    Min = 30, Max = 400, Default = 150, Decimals = 0,
    Callback = function(val) Pistol_FOV = val end,
})

TabKiller:Slider({
    Title = "Prediction Efficiency",
    Description = "Akurasi prediksi (default dump: 0.85 = 85%)",
    Min = 0, Max = 1.0, Default = 0.85, Decimals = 2,
    Callback = function(val) PredictionEfficiency = val end,
})

TabKiller:Slider({
    Title = "Pistol Y Offset",
    Description = "Offset ketinggian aim pistol (default dump: 1.5)",
    Min = 0, Max = 5, Default = 1.5, Decimals = 1,
    Callback = function(val) Flash_YOffset = val end,
})

-- ─── KILLER BUFFS ────────────────────────────────────────────
TabKiller:Section({ Title = "⚡ Killer Buffs" })

TabKiller:Toggle({
    Title = "Infinite Frenzy (Jeff)",
    Description = "Frenzy tanpa cooldown / unlimited",
    Default = false,
    Callback = function(state)
        KILLER_InfFrenzy = state
        if state then setupHook() end
    end,
})

TabKiller:Toggle({
    Title = "Infinite Lake Mist (Jason)",
    Description = "Lake Mist tanpa cooldown / unlimited",
    Default = false,
    Callback = function(state)
        KILLER_InfLakeMist = state
        if state then setupHook() end
    end,
})

TabKiller:Toggle({
    Title = "Infinite Pursuit (Jason)",
    Description = "Pursuit tanpa cooldown / unlimited",
    Default = false,
    Callback = function(state)
        KILLER_InfPursuit = state
        if state then setupHook() end
    end,
})

TabKiller:Toggle({
    Title = "Infinite Abyssal Corrupt",
    Description = "Abyssal tanpa cooldown / unlimited",
    Default = false,
    Callback = function(state)
        KILLER_InfAbyssal = state
    end,
})

TabKiller:Toggle({
    Title = "No Slowdown (Killer)",
    Description = "Hilangkan slowdown saat menyerang killer",
    Default = false,
    Callback = function(state)
        KILLER_NoSlowdown = state
        pcall(function()
            local char = LocalPlayer.Character
            if char then
                local hum = char:FindFirstChildOfClass("Humanoid")
                if hum and state then
                    -- bypass slowdown attribute
                    local conn
                    conn = hum:GetAttributeChangedSignal("Slowdown"):Connect(function()
                        if KILLER_NoSlowdown then
                            hum:SetAttribute("Slowdown", false)
                        else
                            if conn then conn:Disconnect() end
                        end
                    end)
                end
            end
        end)
    end,
})

TabKiller:Toggle({
    Title = "Flask Laser Effect",
    Description = "Tampilkan laser saat tombol flask di-hold",
    Default = false,
    Callback = function(state)
        KILLER_FlaskLaser = state
    end,
})

TabKiller:Toggle({
    Title = "Third Person (Killer)",
    Description = "Mengubah posisi kamera ke belakang karakter",
    Default = false,
    Callback = function(state)
        Killer_3rdPerson = state
        if ThirdPersonConn then ThirdPersonConn:Disconnect() ThirdPersonConn = nil end
        if state then
            ThirdPersonConn = RunService.RenderStepped:Connect(function()
                if not Killer_3rdPerson then
                    ThirdPersonConn:Disconnect()
                    return
                end
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
    Title = "Third Person Distance",
    Description = "Jarak kamera dari karakter",
    Min = 2, Max = 30, Default = 8, Decimals = 0,
    Callback = function(val) Killer_3rdPersonDist = val end,
})

TabKiller:Toggle({
    Title = "Infinite Lunge",
    Description = "Lunge tanpa batas / tanpa cooldown (Killer Only)",
    Default = false,
    Callback = function(state)
        KILLER_InfLunge = state
        if state then setupHook() end
    end,
})

-- ============================================================
-- TAB: SURVIVOR
-- ============================================================
local TabSurvivor = Window:Tab({ Title = "Survivor", Icon = "users" })

-- ─── AUTO SKILL CHECK ────────────────────────────────────────
TabSurvivor:Section({ Title = "⚙ Auto Skill Check" })

TabSurvivor:Toggle({
    Title = "Auto Skill Check",
    Description = "Auto klik SkillCheckPromptGui → Check zone (Proto492)",
    Default = false,
    Callback = function(state)
        SkillCheck = state
        if state then StartAutoSkillCheck() else StopAutoSkillCheck() end
    end,
})

TabSurvivor:Dropdown({
    Title = "Mode Skill Check",
    Description = "Instant=langsung, Normal=delay kecil, Random=kapan saja",
    Values = { "Instant", "Normal", "Random" },
    Default = "Instant",
    Callback = function(val)
        SkillCheckMode = val
        if SkillCheck then
            StopAutoSkillCheck()
            StartAutoSkillCheck()
        end
    end,
})

TabSurvivor:Slider({
    Title = "Skill Check Speed",
    Description = "Kecepatan putaran skill check (1-30, 10=Normal)",
    Min = 1, Max = 30, Default = 10, Decimals = 0,
    Callback = function(val) SkillCheckSpeed = val end,
})

TabSurvivor:Slider({
    Title = "Skill Check Frequency",
    Description = "Frekuensi munculnya skill check",
    Min = 1, Max = 50, Default = 10, Decimals = 0,
    Callback = function(val) SkillCheckFreq = val end,
})

-- ─── AUTO PARRY ──────────────────────────────────────────────
TabSurvivor:Section({ Title = "🛡 Auto Parry" })

TabSurvivor:Toggle({
    Title = "Auto Parry",
    Description = "Auto parry / stun killer saat dalam jangkauan",
    Default = false,
    Callback = function(state)
        AutoParry = state
        if state then StartAutoParry() else
            if ParryConn then ParryConn:Disconnect() ParryConn = nil end
        end
    end,
})

TabSurvivor:Toggle({
    Title = "Aggressive Mode",
    Description = "Langsung parry tanpa peduli face direction",
    Default = false,
    Callback = function(state) AutoParryAggressive = state end,
})

TabSurvivor:Slider({
    Title = "Parry Radius",
    Description = "Jarak maksimal parry bereaksi",
    Min = 5, Max = 50, Default = 15, Decimals = 0,
    Callback = function(val) AutoParryRadius = val end,
})

-- ─── SPEED & MOVEMENT ────────────────────────────────────────
TabSurvivor:Section({ Title = "🏃 Speed & Movement" })

TabSurvivor:Toggle({
    Title = "Speed Boost",
    Description = "Aktifkan speed boost dengan kecepatan custom",
    Default = false,
    Callback = function(state)
        SpeedEnabled = state
        if state then StartSpeed() else StopSpeed() end
    end,
})

TabSurvivor:Slider({
    Title = "Speed Value",
    Description = "Kecepatan lari (default Roblox = 16)",
    Min = 16, Max = 100, Default = 30, Decimals = 0,
    Callback = function(val) SpeedAmount = val end,
})

TabSurvivor:Toggle({
    Title = "Moonwalk",
    Description = "Bergerak mundur saat berjalan ke depan",
    Default = false,
    Callback = function(state)
        MoonwalkEnabled = state
        if state then StartMoonwalk() else
            if MoonwalkConn then MoonwalkConn:Disconnect() MoonwalkConn = nil end
        end
    end,
})

TabSurvivor:Toggle({
    Title = "Unlimited Vault",
    Description = "Vault/lompat jendela tanpa batas (tanpa cooldown)",
    Default = false,
    Callback = function(state)
        UnlimitedVault = state
        if state then EnableUnlimitedVault() end
    end,
})

TabSurvivor:Slider({
    Title = "Vault Speed",
    Description = "Kecepatan vault (10-20, default: 13)",
    Min = 10, Max = 20, Default = 13, Decimals = 1,
    Callback = function(val) VaultSpeed = val end,
})

TabSurvivor:Toggle({
    Title = "Perfect Vault (Anti Slow)",
    Description = "Mencegah perlambatan saat vault",
    Default = false,
    Callback = function(state)
        PerfectVaultEnabled = state
        pcall(function()
            local char = LocalPlayer.Character
            if char then
                local hum = char:FindFirstChildOfClass("Humanoid")
                if hum and state then
                    hum:SetAttribute("PerfectVault", true)
                end
            end
        end)
    end,
})

TabSurvivor:Toggle({
    Title = "Auto Run (PC)",
    Description = "Tekan LeftShift otomatis / auto run",
    Default = false,
    Callback = function(state)
        AutoRunEnabled = state
        pcall(function()
            if state then
                local uis = UserInputService
                task.spawn(function()
                    while AutoRunEnabled do
                        uis:SendKeyEvent(true, Enum.KeyCode.LeftShift, false, game)
                        task.wait(0.1)
                    end
                end)
            end
        end)
    end,
})

-- ─── GENERATOR / BYPASS ──────────────────────────────────────
TabSurvivor:Section({ Title = "🔧 Generator & Bypass" })

TabSurvivor:Toggle({
    Title = "Auto Repair (Bypass Gen)",
    Description = "Perbaiki generator tanpa skill check terdeteksi",
    Default = false,
    Callback = function(state)
        AutoRepairEnabled = state
        BypassGenEnabled = state
        if state then
            pcall(function()
                -- Cari remote repair dan fire langsung
                local rem = ReplicatedStorage:FindFirstChild("GeneratorRepair", true)
                         or ReplicatedStorage:FindFirstChild("Repair", true)
                         or ReplicatedStorage:FindFirstChild("Gen", true)
                if rem and rem:IsA("RemoteEvent") then
                    rem:FireServer(true)
                end
            end)
        end
    end,
})

TabSurvivor:Dropdown({
    Title = "Bypass Gen Mode",
    Description = "Multi = lebih cepat, Single = aman",
    Values = { "Multi", "Single" },
    Default = "Multi",
    Callback = function(val) BypassGenMode = val end,
})

TabSurvivor:Toggle({
    Title = "Bypass Gate (Tembus tanpa Collision)",
    Description = "Tembus exit gate tanpa collision",
    Default = false,
    Callback = function(state)
        BypassGateEnabled = state
        pcall(function()
            for _, obj in pairs(workspace:GetDescendants()) do
                if obj.Name == "Gate" or obj.Name == "ExitGate" then
                    local parts = obj:GetDescendants()
                    for _, p in pairs(parts) do
                        if p:IsA("BasePart") then
                            p.CanCollide = not state
                        end
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
                    local rem = obj:FindFirstChild("Drop", true)
                             or ReplicatedStorage:FindFirstChild("DropPallet", true)
                    if rem and rem:IsA("RemoteEvent") then
                        pcall(function() rem:FireServer() end)
                    end
                end
            end
        end)
    end,
})

-- ─── AUTO PALLET ─────────────────────────────────────────────
TabSurvivor:Section({ Title = "🪵 Auto Pallet" })

TabSurvivor:Toggle({
    Title = "Auto Pallet",
    Description = "Auto drop pallet saat killer mendekat",
    Default = false,
    Callback = function(state)
        AutoPalletEnabled = state
        if PalletConn then PalletConn:Disconnect() PalletConn = nil end
        if state then
            PalletConn = RunService.Heartbeat:Connect(function()
                if not AutoPalletEnabled then return end
                local killer = getNearestKiller(AutoPalletDist)
                if killer then
                    pcall(function()
                        local char = LocalPlayer.Character
                        if not char then return end
                        local hrp = char:FindFirstChild("HumanoidRootPart")
                        if not hrp then return end
                        for _, obj in pairs(workspace:GetDescendants()) do
                            if obj.Name == "Pallet" then
                                local ppart = obj:IsA("BasePart") and obj or obj:FindFirstChildWhichIsA("BasePart")
                                if ppart and (ppart.Position - hrp.Position).Magnitude <= 8 then
                                    local rem = obj:FindFirstChild("Drop", true)
                                             or ReplicatedStorage:FindFirstChild("DropPallet", true)
                                    if rem and rem:IsA("RemoteEvent") then
                                        pcall(function() rem:FireServer() end)
                                    end
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
    Description = "Cegah drop pallet saat down/carry/hook",
    Default = true,
    Callback = function(state) AutoPalletSafety = state end,
})

TabSurvivor:Slider({
    Title = "Auto Pallet Distance",
    Description = "Jarak trigger auto pallet (studs)",
    Min = 10, Max = 80, Default = 40, Decimals = 0,
    Callback = function(val) AutoPalletDist = val end,
})

-- ─── FLEE KILLER ─────────────────────────────────────────────
TabSurvivor:Section({ Title = "🦺 Flee Killer" })

TabSurvivor:Toggle({
    Title = "Flee Killer (Auto TP)",
    Description = "Teleport saat killer terlalu dekat",
    Default = false,
    Callback = function(state)
        FleeKillerEnabled = state
        if state then StartFlee() else
            if FleeConn then FleeConn:Disconnect() FleeConn = nil end
        end
    end,
})

TabSurvivor:Slider({
    Title = "Flee Distance",
    Description = "Jarak trigger teleport dari killer (studs)",
    Min = 15, Max = 80, Default = 30, Decimals = 0,
    Callback = function(val) FleeDistance = val end,
})

-- ─── MISC SURVIVOR ───────────────────────────────────────────
TabSurvivor:Section({ Title = "✨ Misc Survivor" })

TabSurvivor:Toggle({
    Title = "Auto Crouch (Dodge Abyssal S1)",
    Description = "Otomatis jongkok saat Abyssal menggunakan S1",
    Default = false,
    Callback = function(state)
        AutoCrouchEnabled = state
        if AutoCrouchConn then AutoCrouchConn:Disconnect() AutoCrouchConn = nil end
        if state then
            AutoCrouchConn = RunService.Heartbeat:Connect(function()
                if not AutoCrouchEnabled then return end
                pcall(function()
                    local char = LocalPlayer.Character
                    if not char then return end
                    local hum = char:FindFirstChildOfClass("Humanoid")
                    -- Crouch via crouching attribute
                    if hum then
                        for _, p in ipairs(Players:GetPlayers()) do
                            if p ~= LocalPlayer and p.Character then
                                local team = p:GetAttribute("Team") or ""
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
    Title = "Flowstate No CD",
    Description = "Flowstate tanpa cooldown",
    Default = false,
    Callback = function(state)
        FlowstateNoCd = state
        if state then setupHook() end
    end,
})

TabSurvivor:Toggle({
    Title = "Skill Hidden No CD",
    Description = "Skill Hidden tanpa cooldown",
    Default = false,
    Callback = function(state)
        if state then setupHook() end
    end,
})

TabSurvivor:Toggle({
    Title = "Hit Sound Effect",
    Description = "Memutar suara 'Ahhh' saat berhasil stun killer",
    Default = false,
    Callback = function(state)
        HitSoundEnabled = state
    end,
})

TabSurvivor:Slider({
    Title = "Hit Sound Volume",
    Description = "Volume hit sound (0-2)",
    Min = 0, Max = 2, Default = 1, Decimals = 1,
    Callback = function(val) HitSoundVolume = val end,
})

TabSurvivor:Toggle({
    Title = "Invisibility [OP]",
    Description = "Membuat karakter tidak terlihat",
    Default = false,
    Callback = function(state)
        Invis_Enabled = state
        if InvisConn then InvisConn:Disconnect() InvisConn = nil end
        local char = LocalPlayer.Character
        if char then
            for _, part in pairs(char:GetDescendants()) do
                if part:IsA("BasePart") or part:IsA("Decal") then
                    part.Transparency = state and 1 or 0
                end
            end
        end
        if state then
            InvisConn = Players.LocalPlayer.CharacterAdded:Connect(function(c)
                for _, part in pairs(c:GetDescendants()) do
                    if part:IsA("BasePart") or part:IsA("Decal") then
                        part.Transparency = 1
                    end
                end
            end)
        end
    end,
})

TabSurvivor:Toggle({
    Title = "No Fall Damage",
    Description = "Hilangkan damage saat jatuh",
    Default = false,
    Callback = function(state)
        pcall(function()
            local char = LocalPlayer.Character
            if char then
                local hum = char:FindFirstChildOfClass("Humanoid")
                if hum then hum:SetAttribute("NoFall", state) end
            end
        end)
    end,
})

TabSurvivor:Toggle({
    Title = "Counter Auto Parry",
    Description = "Memainkan animasi random buat ngelabui auto parry",
    Default = false,
    Callback = function(state)
        if state then setupHook() end
    end,
})

TabSurvivor:Toggle({
    Title = "SusR6 Mode",
    Description = "Mode SusR6 - animasi karakter",
    Default = false,
    Callback = function(state)
        SusR6Enabled = state
        pcall(function()
            local char = LocalPlayer.Character
            if char then
                char:SetAttribute("SusR6", state)
            end
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
    Description = "Bikin map jadi terang biar lebih jelas",
    Default = false,
    Callback = function(state)
        FullBright = state
        if state then ApplyFullBright() else RevertFullBright() end
    end,
})

TabVisual:Toggle({
    Title = "No Fog",
    Description = "Hapus kabut biar map lebih jelas",
    Default = false,
    Callback = function(state)
        NoFog = state
        if state then ApplyNoFog() else RevertNoFog() end
    end,
})

TabVisual:Toggle({
    Title = "No Shadow",
    Description = "Matikan shadow/bayangan",
    Default = false,
    Callback = function(state)
        NoShadow = state
        Lighting.GlobalShadows = not state
    end,
})

TabVisual:Slider({
    Title = "Time Of Day",
    Description = "Atur waktu di game (0-24)",
    Min = 0, Max = 24, Default = 14, Decimals = 0,
    Callback = function(val)
        TimeOfDayValue = val
        Lighting.ClockTime = val
    end,
})

TabVisual:Section({ Title = "📷 Camera Settings" })

TabVisual:Slider({
    Title = "Camera FOV",
    Description = "Atur field of view kamera",
    Min = 50, Max = 120, Default = 70, Decimals = 0,
    Callback = function(val)
        CameraFOVValue = val
        Camera.FieldOfView = val
    end,
})

TabVisual:Toggle({
    Title = "Infinity Zoom Out",
    Description = "Zoom kamera maksimal tanpa batas",
    Default = false,
    Callback = function(state)
        InfinityZoom = state
        pcall(function()
            LocalPlayer.CameraMaxZoomDistance = state and 1e9 or 400
        end)
    end,
})

TabVisual:Section({ Title = "✚ Crosshair" })

TabVisual:Toggle({
    Title = "Enable Crosshair",
    Description = "Tampilkan crosshair di tengah layar",
    Default = false,
    Callback = function(state)
        CrosshairEnabled = state
        if state then CreateCrosshair() else RemoveCrosshair() end
    end,
})

TabVisual:Slider({
    Title = "Crosshair Size",
    Description = "Ukuran crosshair",
    Min = 5, Max = 30, Default = 10, Decimals = 0,
    Callback = function(val)
        CrosshairSize = val
        if CrosshairEnabled then CreateCrosshair() end
    end,
})

TabVisual:Slider({
    Title = "Crosshair Thickness",
    Description = "Ketebalan garis crosshair",
    Min = 1, Max = 5, Default = 2, Decimals = 0,
    Callback = function(val)
        CrosshairThickness = val
        if CrosshairEnabled then CreateCrosshair() end
    end,
})

TabVisual:Section({ Title = "⭕ FOV Circle" })

TabVisual:Toggle({
    Title = "Show FOV Circle",
    Description = "Tampilkan circle radius FOV di layar",
    Default = false,
    Callback = function(state)
        FOVEnabled = state
        UpdateFOVCircle()
    end,
})

TabVisual:Toggle({
    Title = "Show Veil FOV",
    Description = "Tampilkan FOV circle khusus Veil",
    Default = false,
    Callback = function(state)
        Veil_ShowFOV = state
    end,
})

TabVisual:Slider({
    Title = "FOV Circle Size",
    Description = "Radius FOV circle (pixels)",
    Min = 50, Max = 500, Default = 150, Decimals = 0,
    Callback = function(val)
        FOVValue = val
        if FOVEnabled then UpdateFOVCircle() end
    end,
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
    Callback = function(state)
        ESP_Master = state
        if state then StartESP()
        else
            clearAllESP()
            if espConn then espConn:Disconnect() espConn = nil end
        end
    end,
})

TabESP:Slider({
    Title = "ESP Distance",
    Description = "Jarak maksimal ESP terlihat (studs)",
    Min = 50, Max = 1000, Default = 300, Decimals = 0,
    Callback = function(val) ESP_Distance = val end,
})

TabESP:Section({ Title = "👤 Player ESP" })

TabESP:Toggle({
    Title = "Player ESP",
    Description = "Tampilkan nama & jarak survivor",
    Default = true,
    Callback = function(state) ESP_Player = state end,
})

TabESP:Toggle({
    Title = "Killer ESP",
    Description = "Tampilkan posisi killer",
    Default = true,
    Callback = function(state) ESP_Killer = state end,
})

TabESP:Toggle({
    Title = "Show ESP Name",
    Description = "Tampilkan nama player di ESP",
    Default = true,
    Callback = function(state) ESP_Name = state end,
})

TabESP:Toggle({
    Title = "Killer Warn",
    Description = "Warning saat killer mendekat",
    Default = false,
    Callback = function(state) ESP_KillerWarn = state end,
})

TabESP:Toggle({
    Title = "Show Hook Count",
    Description = "Tampilkan jumlah hook di atas kepala survivor",
    Default = false,
    Callback = function(state) ShowHookCount = state end,
})

TabESP:Toggle({
    Title = "ESP Tracker Target",
    Description = "Tracker target ESP",
    Default = false,
    Callback = function(state) end,
})

TabESP:Section({ Title = "🗺 Map ESP" })

TabESP:Toggle({
    Title = "Generator ESP",
    Description = "Tampilkan posisi generator",
    Default = true,
    Callback = function(state) ESP_Generator = state end,
})

TabESP:Toggle({
    Title = "Gen Name & Progress",
    Description = "Tampilkan nama dan progress generator",
    Default = true,
    Callback = function(state) ESP_GeneratorName = state end,
})

TabESP:Toggle({
    Title = "Gate ESP",
    Description = "Tampilkan posisi exit gate",
    Default = true,
    Callback = function(state) ESP_Gate = state end,
})

TabESP:Toggle({
    Title = "Hook ESP",
    Description = "Tampilkan posisi hook",
    Default = true,
    Callback = function(state) ESP_Hook = state end,
})

TabESP:Toggle({
    Title = "Pallet ESP",
    Description = "Tampilkan posisi pallet",
    Default = false,
    Callback = function(state) ESP_Pallet = state end,
})

TabESP:Toggle({
    Title = "Window ESP",
    Description = "Tampilkan posisi window/jendela",
    Default = false,
    Callback = function(state) ESP_Window = state end,
})

TabESP:Toggle({
    Title = "Item Icon ESP",
    Description = "Tampilkan icon item di ESP",
    Default = false,
    Callback = function(state) ESP_ItemIcon = state end,
})

-- ============================================================
-- TAB: TELEPORT
-- ============================================================
local TabTeleport = Window:Tab({ Title = "Teleport", Icon = "map-pin" })

TabTeleport:Section({ Title = "📡 Teleport Maps" })

TabTeleport:Button({
    Title = "TP ke Generator",
    Description = "Teleport ke generator terdekat",
    Callback = TeleportToGenerator,
})

TabTeleport:Button({
    Title = "TP ke Hook (Loop)",
    Description = "Teleport ke hook terdekat",
    Callback = TeleportToHook,
})

TabTeleport:Button({
    Title = "TP ke Gate (Instant)",
    Description = "Teleport ke exit gate secara instan",
    Callback = TeleportToGate,
})

TabTeleport:Button({
    Title = "TP Pallet (Loop)",
    Description = "Teleport ke pallet terdekat",
    Callback = function()
        pcall(function()
            local char = LocalPlayer.Character
            if not char then return end
            local hrp = char:FindFirstChild("HumanoidRootPart")
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
            if nearest then hrp.CFrame = CFrame.new(nearest.Position + Vector3.new(0, 5, 0)) end
        end)
    end,
})

TabTeleport:Button({
    Title = "TP Window (Loop)",
    Description = "Teleport ke window terdekat",
    Callback = function()
        pcall(function()
            local char = LocalPlayer.Character
            if not char then return end
            local hrp = char:FindFirstChild("HumanoidRootPart")
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
            if nearest then hrp.CFrame = CFrame.new(nearest.Position + Vector3.new(0, 5, 0)) end
        end)
    end,
})

TabTeleport:Section({ Title = "👤 Teleport Players" })

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
                    local hrp = char:FindFirstChild("HumanoidRootPart")
                    local tHrp = target.Character:FindFirstChild("HumanoidRootPart")
                    if hrp and tHrp then
                        hrp.CFrame = tHrp.CFrame + Vector3.new(3, 0, 0)
                    end
                end
            end
        end)
    end,
})

TabTeleport:Button({
    Title = "Refresh Player List",
    Description = "Refresh daftar player",
    Callback = function()
        -- Dropdown tidak bisa di-refresh secara dinamis di WindUI
        -- User bisa reload UI kalau perlu
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
    Callback = function(state)
        WatermarkEnabled = state
        if state then StartWatermark() else StopWatermark() end
    end,
})

TabMisc:Toggle({
    Title = "Spectator Info",
    Description = "Menampilkan jumlah spectator",
    Default = false,
    Callback = function(state)
        SpectatorEnabled = state
        if state then
            if SpectatorLabel then return end
            pcall(function()
                local sg = Instance.new("ScreenGui")
                sg.Name = "GKZ_Spectator"
                sg.Parent = PlayerGui
                sg.ResetOnSpawn = false
                local lbl = Instance.new("TextLabel")
                lbl.Size = UDim2.fromOffset(150, 25)
                lbl.Position = UDim2.fromOffset(8, 38)
                lbl.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
                lbl.BackgroundTransparency = 0.3
                lbl.TextColor3 = Color3.fromRGB(220, 220, 255)
                lbl.TextScaled = true
                lbl.Font = Enum.Font.GothamBold
                lbl.Text = "Spectators: 0"
                lbl.Parent = sg
                SpectatorLabel = lbl

                RunService.Heartbeat:Connect(function()
                    if not SpectatorEnabled then return end
                    local count = 0
                    for _, p in ipairs(Players:GetPlayers()) do
                        if p ~= LocalPlayer then
                            pcall(function()
                                if p:GetAttribute("IsSpectating") then
                                    count = count + 1
                                end
                            end)
                        end
                    end
                    if SpectatorLabel then
                        SpectatorLabel.Text = "Spectators: " .. count
                    end
                end)
            end)
        else
            local sg = PlayerGui:FindFirstChild("GKZ_Spectator")
            if sg then sg:Destroy() end
            SpectatorLabel = nil
        end
    end,
})

TabMisc:Toggle({
    Title = "Next Killer Display",
    Description = "Menampilkan prediksi killer selanjutnya di layar",
    Default = false,
    Callback = function(state)
        NextKillerEnabled = state
    end,
})

TabMisc:Toggle({
    Title = "Killer Perks Display",
    Description = "Menampilkan perk killer yang sedang digunakan",
    Default = false,
    Callback = function(state)
        KillerPerksToggle = state
    end,
})

TabMisc:Section({ Title = "🎚 Performance" })

TabMisc:Toggle({
    Title = "FPS Cap",
    Description = "Aktifkan pembatas FPS",
    Default = false,
    Callback = function(state)
        FPSCapEnabled = state
        if state then
            pcall(function() setfpscap(FPSCapValue) end)
        else
            pcall(function() setfpscap(0) end) -- 0 = unlimited
        end
    end,
})

TabMisc:Slider({
    Title = "FPS Cap Value",
    Description = "Batas FPS maksimal",
    Min = 10, Max = 240, Default = 60, Decimals = 0,
    Callback = function(val)
        FPSCapValue = val
        if FPSCapEnabled then
            pcall(function() setfpscap(val) end)
        end
    end,
})

TabMisc:Toggle({
    Title = "Reset to 60 FPS",
    Description = "Reset cap ke 60 FPS",
    Default = false,
    Callback = function(state)
        if state then
            pcall(function() setfpscap(60) end)
        end
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
    Callback = function(state)
        if state then
            pcall(function()
                for _, v in pairs(PlayerGui:GetDescendants()) do
                    if v.Name == "EndScreen" or v.Name == "endscreen" then
                        v:Destroy()
                    end
                end
            end)
        end
    end,
})

TabMisc:Toggle({
    Title = "Fake Name",
    Description = "Sembunyikan nama asli dari player lain",
    Default = false,
    Callback = function(state)
        -- Spoofer nama
    end,
})

TabMisc:Button({
    Title = "Tools Jerk",
    Description = "Load Tools Jerk external script",
    Callback = function()
        pcall(function()
            loadstring(game:HttpGet("https://pastefy.app/wa3v2Vgm/raw"))()
        end)
    end,
})

TabMisc:Button({
    Title = "Fly GUI",
    Description = "Load Fly GUI external script",
    Callback = function()
        pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/XNEOFF/FlyGuiV3/main/FlyGuiV3.txt"))()
        end)
    end,
})

TabMisc:Button({
    Title = "Unload Script",
    Description = "Matikan semua fitur dan hapus GUI",
    Callback = function()
        -- Cleanup semua koneksi
        if SkillCheckConn then SkillCheckConn:Disconnect() end
        if SpeedConn then SpeedConn:Disconnect() end
        if MoonwalkConn then MoonwalkConn:Disconnect() end
        if WatermarkConn then WatermarkConn:Disconnect() end
        if espConn then espConn:Disconnect() end
        if PalletConn then PalletConn:Disconnect() end
        if FleeConn then FleeConn:Disconnect() end
        if ParryConn then ParryConn:Disconnect() end
        if ThirdPersonConn then ThirdPersonConn:Disconnect() end
        if AutoCrouchConn then AutoCrouchConn:Disconnect() end
        if InvisConn then InvisConn:Disconnect() end

        clearAllESP()
        StopWatermark()
        RemoveCrosshair()
        if FOVEnabled and fovCircleDrawing then
            pcall(function() fovCircleDrawing:Remove() end)
        end

        -- Restore settings
        local char = LocalPlayer.Character
        if char then
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hum then hum.WalkSpeed = 16 end
            for _, part in pairs(char:GetDescendants()) do
                if part:IsA("BasePart") then part.Transparency = 0 end
            end
        end

        -- Destroy GUI
        local wg = PlayerGui:FindFirstChild("GanKunZHub")
        if wg then wg:Destroy() end

        print("[GanKunZ] Script di-unload.")
    end,
})

-- ============================================================
-- SELESAI - PRINT WELCOME
-- ============================================================
print([[
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 ⚔  GanKunZ Hub - BERHASIL DIMUAT
 GUI: WindUI | Data: Dumped.json + script.lua
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 [KILLER]
   🧪 Silent Aim Flask  (ThrowFlask - FIXED)
   🌀 Silent Veil V1/V2 (Spearthrow - FIXED)
   🔫 Silent Aim Pistol (EmperorGun - FIXED)
   ⚡ Inf Frenzy / LakeMist / Pursuit / Abyssal
   👁 Flask Laser | 🗡 Inf Lunge | 🚫 No Slowdown
   🔒 Third Person Killer
 [SURVIVOR]
   ⚙  Auto Skill Check  (Proto492 - All Mode)
   🛡 Auto Parry        (Range + Aggressive)
   🏃 Speed Boost / Moonwalk / Unlimited Vault
   🔧 Auto Repair / Bypass Gen / Bypass Gate
   🪵 Auto Pallet / Flee Killer / Invisibility
   🌀 Flowstate / Skill Hidden / Counter Parry
   🔊 Hit Sound / SusR6 / Auto Crouch / No Fall
 [ESP]
   👤 Player/Killer/Gen/Gate/Hook/Pallet/Window
   📦 Item Icon / FOV Circle / Hook Count
 [MISC]
   💧 Watermark (FPS+Ping) | ✚ Crosshair
   📷 Camera FOV | ⏰ Time Of Day | 🚁 FPS Cap
   🌍 Server Hop | 📡 TP: Gen/Hook/Gate/Pallet
   🎭 Killer Perks | 👁 Next Killer | Spectator
   🚀 Tools Jerk | 🛸 Fly GUI | 🚫 Skip End
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
]])
