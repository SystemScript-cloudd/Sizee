--[[
    ╔══════════════════════════════════════════════════════╗
    ║   VIOLENCE DISTRICT - 4 FITUR UTAMA                 ║
    ║   1. Silent Aim Flask (Cure)                         ║
    ║   2. Silent Aim Veil Spear                           ║
    ║   3. Auto Skill Check                                ║
    ║   4. Silent Aim Pistol (Flash)                       ║
    ║                                                      ║
    ║   Compatible : Delta Mobile (Android)                ║
    ║   GUI        : WindUI by Footagesus                  ║
    ║   Data dari  : Dumped.json + script.lua              ║
    ╚══════════════════════════════════════════════════════╝
    
    Remote path dari Dumped.json (Proto195):
      Spear  : Remotes.Killers.Veil.Spearthrow:FireServer(pos)
    Config dari dump:
      SPEAR_Speed = 165, SPEAR_MaxDist = 200, Veil_FOV = 150
      Veil_LeadMultiplier = 1.4, Flash_YOffset = 1.5
      Pistol_FOV = 150, PredictionEfficiency = 0.85
    SkillCheck dari dump (Proto492):
      SkillCheckPromptGui -> Line, Goal, Check
      Mode: "Instant" / "Normal" / "Random"
]]

-- ============================================================
-- SERVICES
-- ============================================================
local Players          = game:GetService("Players")
local RunService       = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService     = game:GetService("TweenService")
local Camera           = workspace.CurrentCamera

local LocalPlayer = Players.LocalPlayer
local PlayerGui   = LocalPlayer:WaitForChild("PlayerGui")

-- ============================================================
-- VARIABEL GLOBAL (sesuai nama di dump)
-- ============================================================
-- Veil Spear
local Aim_SilentVeil    = false   -- dari dump: Aim_SilentVeil
local Aim_SilentVeilV2  = false   -- dari dump: Aim_SilentVeilV2
local SPEAR_Speed       = 165     -- dari dump: SPEAR_Speed = 165
local SPEAR_MaxDist     = 200     -- dari dump: SPEAR_MaxDist = 200
local SPEAR_Gravity     = 0       -- dari dump: SPEAR_Gravity = 0
local Veil_FOV          = 150     -- dari dump: Veil_FOV = 150
local Veil_LeadMultiplier = 1.4   -- dari dump: Veil_LeadMultiplier = 1.4
local AIM_TargetPart    = "HumanoidRootPart" -- dari dump: AIM_TargetPart = "Torso"

-- Flask / Cure
local KILLER_SilentAimFlask = false  -- dari dump: KILLER_SilentAimFlask
local Flash_YOffset         = 1.5   -- dari dump: Flash_YOffset = 1.5

-- Pistol / Flash
local Flash_Silent          = false  -- dari dump: Flash_Silent
local Pistol_FOV            = 150    -- dari dump: Pistol_FOV = 150
local Pistol_BlockKnocked   = true   -- dari dump: Pistol_BlockKnocked
local PredictionEfficiency  = 0.85   -- dari dump: PredictionEfficiency = 0.85
local isChargingPistol      = false  -- dari dump: isChargingPistol

-- Skill Check
local SkillCheck            = false  -- dari dump: SkillCheck
local SkillCheckMode        = "Instant" -- dari dump: SkillCheckMode ("Instant"/"Normal"/"Random")

-- Internal state
local Remotes           = {}
local SkillCheckConn    = nil
local VeilHooked        = false
local FlaskHooked       = false
local PistolHooked      = false
local OrigNC            = nil  -- satu hook __namecall untuk semua

-- ============================================================
-- UTILITY: getClosestSurvivor (dari dump: getClosestSurvivor)
-- Versi distance-based untuk Flask/Cure
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
-- UTILITY: getPistolTarget (dari dump: getPistolTarget)
-- FOV-based untuk Pistol & Veil
-- ============================================================
local function getPistolTarget(fov, maxDist, blockKnocked)
    fov = fov or Pistol_FOV
    maxDist = maxDist or SPEAR_MaxDist
    local best, bestFOV = nil, fov
    local center = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
    local myChar = LocalPlayer.Character
    if not myChar then return nil end
    local myRoot = myChar:FindFirstChild("HumanoidRootPart")
    if not myRoot then return nil end

    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character then
            local hum = p.Character:FindFirstChildOfClass("Humanoid")
            if hum and hum.Health > 0 then
                -- Pistol_BlockKnocked: dari dump, skip knocked targets
                if blockKnocked and p.Character:GetAttribute("Knocked") then
                    continue
                end
                -- Juga skip target yang IsCarried
                if p.Character:GetAttribute("IsCarried") then
                    continue
                end
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
-- UTILITY: Prediksi posisi target (dari dump: PredictionEfficiency)
-- Proto193 & 318: prediction dengan velocity + jitter
-- ============================================================
local function predictPosition(hrp, leadMult, usePredEff)
    leadMult = leadMult or 1
    local vel = hrp.AssemblyLinearVelocity
    local basePred = hrp.Position + vel * (0.08 * leadMult)
    -- Apply PredictionEfficiency dari dump (0.85 default)
    if usePredEff then
        local eff = PredictionEfficiency
        basePred = hrp.Position:Lerp(basePred, eff)
    end
    return basePred
end

-- ============================================================
-- UTILITY: executeSilentAimFire (dari dump: executeSilentAimFire)
-- Redirect Vector3 pertama dalam args ke posisi target
-- ============================================================
local function executeSilentAimFire(args, targetPos)
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
    -- Kalau tidak ada Vector3/CFrame, insert di posisi 1
    table.insert(args, 1, targetPos)
    return true
end

-- ============================================================
-- UTILITY: Cari Veil Spearthrow remote
-- Dari dump Proto195: Remotes.Killers.Veil.Spearthrow
-- ============================================================
local cachedSpearRemote = nil
local function getSpearRemote()
    if cachedSpearRemote then return cachedSpearRemote end
    -- Path dari dump: ReplicatedStorage.Remotes.Killers.Veil.Spearthrow
    local rs = ReplicatedStorage
    local remotesFolder = rs:FindFirstChild("Remotes")
    if remotesFolder then
        local killers = remotesFolder:FindFirstChild("Killers")
        if killers then
            local veil = killers:FindFirstChild("Veil")
            if veil then
                local spearthrow = veil:FindFirstChild("Spearthrow")
                if spearthrow then
                    cachedSpearRemote = spearthrow
                    return spearthrow
                end
            end
        end
    end
    -- Fallback: cari langsung
    local found = rs:FindFirstChild("Spearthrow", true)
    if found then cachedSpearRemote = found end
    return found
end

-- ============================================================
-- SATU HOOK __namecall UNTUK SEMUA FITUR
-- Dari dump: Proto192 setupSpearInterceptor, Proto429 Flask,
--            Proto521 Pistol, semua pakai __namecall hook
-- ============================================================
local function setupHook()
    if OrigNC then return end -- sudah terpasang
    
    pcall(function()
        local mt = getrawmetatable(game)
        setreadonly(mt, false)
        OrigNC = mt.__namecall
        mt.__namecall = newcclosure(function(self, ...)
            local method = getnamecallmethod()
            local args = {...}

            -- Skip kalau bukan game script
            if checkcaller() then
                return OrigNC(self, table.unpack(args))
            end

            local selfName = (typeof(self) == "Instance") and self.Name or ""

            -- ──────────────────────────────────────────────────
            -- FITUR 1: SILENT AIM FLASK (CURE)
            -- Dari dump Proto429: namecall "ThrowFlask" pada object Cure
            -- KILLER_SilentAimFlask = true saat aktif
            -- ──────────────────────────────────────────────────
            if KILLER_SilentAimFlask then
                if method == "ThrowFlask" or
                   (method == "FireServer" and (
                       selfName:find("Flask") or
                       selfName:find("Cure") or
                       selfName:find("AimFlask")
                   )) then
                    local target = getClosestSurvivor(60)
                    if target and target.Character then
                        local hrp = target.Character:FindFirstChild("HumanoidRootPart")
                        if hrp then
                            -- Flash_YOffset = 1.5 dari dump
                            local targetPos = predictPosition(hrp, 1, false)
                                + Vector3.new(0, Flash_YOffset, 0)
                            executeSilentAimFire(args, targetPos)
                        end
                    end
                end
            end

            -- ──────────────────────────────────────────────────
            -- FITUR 2: SILENT AIM VEIL SPEAR
            -- Dari dump Proto193/195:
            --   remote: Remotes.Killers.Veil.Spearthrow
            --   namecall: Spearthrow (FireServer)
            --   Aim_SilentVeil / Aim_SilentVeilV2
            --   SPEAR_Speed=165, SPEAR_MaxDist=200, Veil_LeadMultiplier=1.4
            -- ──────────────────────────────────────────────────
            if Aim_SilentVeil or Aim_SilentVeilV2 then
                if method == "FireServer" or method == "Spearthrow" then
                    -- Cek apakah ini remote Spearthrow
                    local isSpear = (
                        selfName == "Spearthrow" or
                        selfName:find("Spear") or
                        selfName:find("spear") or
                        selfName:find("Veil") or
                        self == getSpearRemote()
                    )
                    if isSpear then
                        local myChar = LocalPlayer.Character
                        if myChar then
                            local target = getPistolTarget(Veil_FOV, SPEAR_MaxDist, false)
                            if target and target.Character then
                                local hrp = target.Character:FindFirstChild("HumanoidRootPart")
                                    or target.Character:FindFirstChild("Head")
                                if hrp then
                                    -- Dari dump Proto193: predict dengan Veil_LeadMultiplier
                                    local special = hrp:GetAttribute("special")
                                    local predicted = predictPosition(hrp, Veil_LeadMultiplier, true)
                                    -- Dari dump: check GetAttribute("special") untuk head aim
                                    if Aim_SilentVeilV2 then
                                        local head = target.Character:FindFirstChild("Head")
                                        if head then predicted = predictPosition(head, Veil_LeadMultiplier, true) end
                                    end
                                    executeSilentAimFire(args, predicted)
                                end
                            end
                        end
                    end
                end
            end

            -- ──────────────────────────────────────────────────
            -- FITUR 4: SILENT AIM PISTOL / FLASH
            -- Dari dump Proto521 & 538:
            --   isChargingPistol + executeSilentAimFire
            --   Flash_Silent, getPistolTarget, Pistol_FOV=150
            --   Pistol_BlockKnocked = true
            -- ──────────────────────────────────────────────────
            if Flash_Silent then
                if method == "FireServer" or method == "InvokeServer" then
                    -- Dari dump: remote EmperorGun, doShoot, Shoot, Fire, Bullet, Flash
                    local isPistol = (
                        selfName == "EmperorGun" or
                        selfName:find("Emperor") or
                        selfName:find("Pistol") or
                        selfName:find("doShoot") or
                        selfName:find("Shoot") or
                        selfName:find("Bullet") or
                        selfName:find("Flash") or
                        (isChargingPistol == true)
                    )
                    if isPistol then
                        local target = getPistolTarget(Pistol_FOV, 150, Pistol_BlockKnocked)
                        if target and target.Character then
                            local hrp = target.Character:FindFirstChild("HumanoidRootPart")
                            if hrp then
                                -- Flash_YOffset = 1.5 dari dump
                                local predicted = predictPosition(hrp, 1, true)
                                    + Vector3.new(0, Flash_YOffset, 0)
                                executeSilentAimFire(args, predicted)
                            end
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
-- FITUR 3: AUTO SKILL CHECK
-- Dari dump Proto492 & 254:
--   Cari SkillCheckPromptGui → FindFirstChild("Line"), ("Goal"), ("Check")
--   SkillCheckMode: "Instant" / "Normal" / "Random"
--   Surv_InstanSkillCheck → langsung fire
--   Remote: "Skillcheck-gen" atau "Skillcheck-player"
-- ============================================================
local function doSkillCheckClick(scGui)
    pcall(function()
        -- Dari dump Proto254: remote Skillcheck-gen atau Skillcheck-player
        local remGen    = scGui:FindFirstChild("Skillcheck-gen", true)
                       or ReplicatedStorage:FindFirstChild("Skillcheck-gen", true)
                       or ReplicatedStorage:FindFirstChild("SkillCheckResultEvent", true)
                       or ReplicatedStorage:FindFirstChild("SkillCheck", true)
        local remPlayer = scGui:FindFirstChild("Skillcheck-player", true)
                       or ReplicatedStorage:FindFirstChild("Skillcheck-player", true)

        -- Coba fire remote gen dulu
        if remGen and remGen:IsA("RemoteEvent") then
            remGen:FireServer(true)
        elseif remGen and remGen:IsA("RemoteFunction") then
            remGen:InvokeServer(true)
        end

        -- Coba fire remote player
        if remPlayer and remPlayer:IsA("RemoteEvent") then
            remPlayer:FireServer(true)
        end

        -- Fallback: firesignal pada GuiButton di dalam Check
        local checkElem = scGui:FindFirstChild("Check", true)
        if checkElem then
            local btn = checkElem:FindFirstChildWhichIsA("GuiButton")
                     or (checkElem:IsA("GuiButton") and checkElem)
            if btn then
                pcall(function() firesignal(btn.MouseButton1Click) end)
            end
            -- Dari dump: obj:Move() pada check element
            pcall(function()
                if checkElem.Rotation ~= nil then
                    checkElem.Rotation = 0
                end
            end)
        end
    end)
end

local function StartAutoSkillCheck()
    if SkillCheckConn then
        SkillCheckConn:Disconnect()
        SkillCheckConn = nil
    end

    SkillCheckConn = RunService.Heartbeat:Connect(function()
        if not SkillCheck then return end

        -- Dari dump Proto492 Pc=166:
        -- character:FindFirstChild("SkillCheckPromptGui")
        -- lalu cari Line, Goal, Check
        local char = LocalPlayer.Character
        if not char then return end

        local scGui = nil

        -- Cari di character dulu (dump menunjukkan cara ini)
        scGui = char:FindFirstChild("SkillCheckPromptGui")

        -- Fallback: cari di PlayerGui
        if not scGui then
            for _, sg in ipairs(PlayerGui:GetDescendants()) do
                if sg.Name == "SkillCheckPromptGui" and sg:IsA("ScreenGui") then
                    scGui = sg
                    break
                end
            end
        end

        -- Fallback terakhir: cari GuiObjects dengan nama Check dan Goal
        if not scGui then
            for _, sg in ipairs(PlayerGui:GetChildren()) do
                if sg:IsA("ScreenGui") and sg.Enabled then
                    if sg:FindFirstChild("Check", true) and sg:FindFirstChild("Goal", true) then
                        scGui = sg
                        break
                    end
                end
            end
        end

        if not scGui then return end

        -- Dari dump: cek Visible
        local checkElem = scGui:FindFirstChild("Check", true)
        if not checkElem or not checkElem.Visible then return end

        -- Dari dump Proto492: cek attribute "busy" dan "busyTime"
        if scGui:GetAttribute("busy") then return end

        -- Dari dump: cari "Line" dan "Goal"
        local lineElem = scGui:FindFirstChild("Line", true)
        local goalElem = scGui:FindFirstChild("Goal", true)

        -- Kalau tidak ada Goal tapi ada Check yang visible, langsung fire
        if not goalElem then
            -- Mode Instant langsung
            scGui:SetAttribute("busy", true)
            if SkillCheckMode == "Instant" then
                task.spawn(function()
                    doSkillCheckClick(scGui)
                    task.wait(0.15)
                    pcall(function() scGui:SetAttribute("busy", nil) end)
                end)
            else
                -- Normal mode: sedikit delay
                task.delay(0.05, function()
                    doSkillCheckClick(scGui)
                    task.wait(0.15)
                    pcall(function() scGui:SetAttribute("busy", nil) end)
                end)
            end
            return
        end

        -- Dari dump Proto492: check posisi Check relatif Goal
        local checkPos = checkElem.AbsolutePosition + checkElem.AbsoluteSize / 2
        local goalPos  = goalElem.AbsolutePosition
        local goalSize = goalElem.AbsoluteSize

        -- Kalau mode Random: langsung klik kapan saja
        if SkillCheckMode == "Random" then
            scGui:SetAttribute("busy", true)
            task.spawn(function()
                doSkillCheckClick(scGui)
                task.wait(0.15)
                pcall(function() scGui:SetAttribute("busy", nil) end)
            end)
            return
        end

        -- Cek apakah Check sudah di zona Goal
        local inZone = (
            checkPos.X >= goalPos.X and
            checkPos.X <= goalPos.X + goalSize.X and
            checkPos.Y >= goalPos.Y and
            checkPos.Y <= goalPos.Y + goalSize.Y
        )

        if inZone then
            scGui:SetAttribute("busy", true)
            if SkillCheckMode == "Instant" then
                task.spawn(function()
                    doSkillCheckClick(scGui)
                    task.wait(0.15)
                    pcall(function() scGui:SetAttribute("busy", nil) end)
                end)
            else
                -- Normal: delay kecil
                task.delay(0.05, function()
                    doSkillCheckClick(scGui)
                    task.wait(0.15)
                    pcall(function() scGui:SetAttribute("busy", nil) end)
                end)
            end
        end
    end)

    print("[VD] ✅ Auto Skill Check AKTIF - Mode: " .. SkillCheckMode)
end

local function StopAutoSkillCheck()
    if SkillCheckConn then
        SkillCheckConn:Disconnect()
        SkillCheckConn = nil
    end
    print("[VD] ❌ Auto Skill Check NONAKTIF")
end

-- ============================================================
-- LOAD WINDUI
-- ============================================================
local WindUI = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"
))()

local Window = WindUI:CreateWindow({
    Title   = "VD Features Hub",
    Icon    = "sword",
    Author  = "Violence District",
    Folder  = "VDFeaturesHub",
    Size    = UDim2.fromOffset(380, 520),
    Transparent = true,
    Theme   = "Dark",
})

-- ============================================================
-- TAB: FEATURES
-- ============================================================
local Tab = Window:Tab({ Title = "Features", Icon = "zap" })

-- ─── SILENT AIM FLASK (CURE) ────────────────────────────────
Tab:Section({ Title = "🧪 Silent Aim Flask (Cure)" })

Tab:Toggle({
    Title = "Silent Aim Flask",
    Description = "Hook ThrowFlask → redirect ke survivor terdekat",
    Default = false,
    Callback = function(state)
        KILLER_SilentAimFlask = state
        if state then
            setupHook()
            print("[VD] ✅ Silent Aim Flask AKTIF")
        else
            print("[VD] ❌ Silent Aim Flask NONAKTIF")
        end
    end,
})

Tab:Slider({
    Title = "Flask Max Distance",
    Description = "Jarak max survivor yang ditarget (studs)",
    Min = 20, Max = 150, Default = 60, Decimals = 0,
    Callback = function(val)
        -- update internal maxDist via getClosestSurvivor param
        -- disimpan via closure di bawah
    end,
})

-- ─── SILENT AIM VEIL SPEAR ──────────────────────────────────
Tab:Section({ Title = "🌀 Silent Aim Veil Spear" })

Tab:Toggle({
    Title = "Silent Aim Veil Spear",
    Description = "Redirect Spearthrow ke target di FOV (Remotes.Killers.Veil.Spearthrow)",
    Default = false,
    Callback = function(state)
        Aim_SilentVeil = state
        if state then
            setupHook()
            print("[VD] ✅ Silent Aim Veil Spear AKTIF")
        else
            print("[VD] ❌ Silent Aim Veil Spear NONAKTIF")
        end
    end,
})

Tab:Toggle({
    Title = "Veil Spear V2 (Head Aim)",
    Description = "Aim ke kepala target (Aim_SilentVeilV2)",
    Default = false,
    Callback = function(state)
        Aim_SilentVeilV2 = state
        if state then setupHook() end
    end,
})

Tab:Slider({
    Title = "Veil FOV",
    Description = "Radius FOV piksel untuk spear (default dump: 150)",
    Min = 30, Max = 400, Default = 150, Decimals = 0,
    Callback = function(val) Veil_FOV = val end,
})

Tab:Slider({
    Title = "Lead Multiplier",
    Description = "Prediksi gerak target (default dump: 1.4)",
    Min = 0.5, Max = 3.0, Default = 1.4, Decimals = 1,
    Callback = function(val) Veil_LeadMultiplier = val end,
})

Tab:Slider({
    Title = "Spear Max Distance",
    Description = "Jarak max target (default dump: 200 studs)",
    Min = 50, Max = 400, Default = 200, Decimals = 0,
    Callback = function(val) SPEAR_MaxDist = val end,
})

-- ─── AUTO SKILL CHECK ───────────────────────────────────────
Tab:Section({ Title = "⚙ Auto Skill Check" })

Tab:Toggle({
    Title = "Auto Skill Check",
    Description = "Auto klik SkillCheckPromptGui → Check zone (Proto492)",
    Default = false,
    Callback = function(state)
        SkillCheck = state
        if state then
            StartAutoSkillCheck()
        else
            StopAutoSkillCheck()
        end
    end,
})

Tab:Dropdown({
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

-- ─── SILENT AIM PISTOL / FLASH ──────────────────────────────
Tab:Section({ Title = "🔫 Silent Aim Pistol (EmperorGun)" })

Tab:Toggle({
    Title = "Silent Aim Pistol",
    Description = "Redirect tembakan EmperorGun/Flash ke target (Flash_Silent)",
    Default = false,
    Callback = function(state)
        Flash_Silent = state
        if state then
            setupHook()
            print("[VD] ✅ Silent Aim Pistol AKTIF")
        else
            print("[VD] ❌ Silent Aim Pistol NONAKTIF")
        end
    end,
})

Tab:Toggle({
    Title = "Block Knocked Target",
    Description = "Skip target yang sudah knocked (Pistol_BlockKnocked)",
    Default = true,
    Callback = function(state) Pistol_BlockKnocked = state end,
})

Tab:Slider({
    Title = "Pistol FOV",
    Description = "Radius FOV piksel untuk pistol (default dump: 150)",
    Min = 30, Max = 400, Default = 150, Decimals = 0,
    Callback = function(val) Pistol_FOV = val end,
})

Tab:Slider({
    Title = "Prediction Efficiency",
    Description = "Akurasi prediksi (default dump: 0.85 = 85%)",
    Min = 0, Max = 1.0, Default = 0.85, Decimals = 2,
    Callback = function(val) PredictionEfficiency = val end,
})

Tab:Slider({
    Title = "Flash Y Offset",
    Description = "Offset ketinggian aim pistol (default dump: 1.5)",
    Min = 0, Max = 5, Default = 1.5, Decimals = 1,
    Callback = function(val) Flash_YOffset = val end,
})

-- ============================================================
-- RESPAWN HANDLER
-- ============================================================
LocalPlayer.CharacterAdded:Connect(function()
    task.wait(1)
    cachedSpearRemote = nil  -- reset remote cache
    if SkillCheck then
        StopAutoSkillCheck()
        task.wait(0.5)
        StartAutoSkillCheck()
    end
end)

-- ============================================================
-- SELESAI
-- ============================================================
print([[
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 ⚔ VD Features Hub - BERHASIL DIMUAT
 GUI: WindUI | Data: Dumped.json
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 Fitur:
   🧪 Silent Aim Flask  (ThrowFlask hook)
   🌀 Silent Aim Veil   (Remotes.Killers.Veil.Spearthrow)
   ⚙  Auto Skill Check  (SkillCheckPromptGui)
   🔫 Silent Aim Pistol (EmperorGun / Flash_Silent)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
]])
