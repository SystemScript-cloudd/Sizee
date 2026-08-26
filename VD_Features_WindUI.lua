--[[
    ╔══════════════════════════════════════════════════════╗
    ║   VIOLENCE DISTRICT - 4 FITUR UTAMA                 ║
    ║   1. Silent Aim Flask (Cure)                         ║
    ║   2. Silent Aim Veil Spear                           ║
    ║   3. Auto Skill Check                                ║
    ║   4. Silent Aim Pistol                               ║
    ║                                                      ║
    ║   Compatible : Delta Mobile (Android)                ║
    ║   GUI        : WindUI by Footagesus                  ║
    ║   Direkonstruksi dari Dumped.json + script.lua       ║
    ╚══════════════════════════════════════════════════════╝

    ⚠ CATATAN PENTING:
    Script ini merekonstruksi logika dari dump bytecode.
    Nama remote (FireServer) dan struktur argument
    diambil dari pola yang terbaca di dump.
    Kalau ada fitur yang tidak jalan, kemungkinan nama
    Remote di game sudah berubah — cek bagian CONFIG.
]]

-- ============================================================
-- SERVICES
-- ============================================================
local Players          = game:GetService("Players")
local RunService       = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local Camera           = workspace.CurrentCamera

local LocalPlayer = Players.LocalPlayer
local PlayerGui   = LocalPlayer:WaitForChild("PlayerGui")

-- ============================================================
-- CONFIG
-- ============================================================
local Config = {
    -- === SILENT AIM FLASK (CURE) ===
    Flask_Enabled    = false,
    Flask_TargetPart = "HumanoidRootPart",
    Flask_MaxDist    = 60,
    Flask_YOffset    = 1.5,

    -- === SILENT AIM VEIL SPEAR ===
    Veil_Enabled       = false,
    Veil_TargetPart    = "HumanoidRootPart",
    Veil_MaxDist       = 200,
    Veil_Speed         = 165,
    Veil_Gravity       = 0,
    Veil_LeadMult      = 1.4,
    Veil_FOV           = 150,

    -- === AUTO SKILL CHECK ===
    SkillCheck_Enabled = false,
    SkillCheck_Mode    = "Instant",
    SkillCheck_Delay   = 0.05,

    -- === SILENT AIM PISTOL ===
    Pistol_Enabled     = false,
    Pistol_TargetPart  = "HumanoidRootPart",
    Pistol_MaxDist     = 150,
    Pistol_FOV         = 150,
    Pistol_BlockKnocked = true,
}

-- ============================================================
-- STATE
-- ============================================================
local Remotes = {}
local SkillCheckConn = nil
local VeilConn = nil
local FlaskConn = nil
local PistolConn = nil

-- ============================================================
-- UTILITY: CARI SURVIVOR TERDEKAT (untuk flask/cure)
-- ============================================================
local function GetNearestSurvivor(maxDist, selfTeam)
    local best, bestDist = nil, maxDist
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
-- UTILITY: CARI TARGET TERDEKAT KE TENGAH LAYAR (FOV)
-- ============================================================
local function GetFOVTarget(maxFOV, maxDist, blockKnocked)
    local best, bestDist = nil, maxFOV
    local vc = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
    local myChar = LocalPlayer.Character
    if not myChar then return nil end
    local myRoot = myChar:FindFirstChild("HumanoidRootPart")
    if not myRoot then return nil end

    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character then
            local hum = p.Character:FindFirstChildOfClass("Humanoid")
            if hum and hum.Health > 0 then
                if blockKnocked then
                    local knocked = p.Character:GetAttribute("Knocked")
                    if knocked then continue end
                end
                local hrp = p.Character:FindFirstChild("HumanoidRootPart")
                if hrp then
                    local worldDist = (hrp.Position - myRoot.Position).Magnitude
                    if worldDist <= maxDist then
                        local sp, onScreen = Camera:WorldToViewportPoint(hrp.Position)
                        if onScreen then
                            local d = (Vector2.new(sp.X, sp.Y) - vc).Magnitude
                            if d < bestDist then
                                bestDist = d
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
-- UTILITY: PREDIKSI POSISI TARGET
-- ============================================================
local function PredictPos(hrp, leadMult)
    leadMult = leadMult or 1
    local vel = hrp.AssemblyLinearVelocity
    return hrp.Position + vel * (0.08 * leadMult)
end

-- ============================================================
-- UTILITY: CARI REMOTE EVENT
-- ============================================================
local function FindRemote(name)
    if Remotes[name] then return Remotes[name] end
    local rs = ReplicatedStorage
    for _, folder in ipairs({"Remotes", "Events", "RF", "RE"}) do
        local f = rs:FindFirstChild(folder)
        if f then
            local r = f:FindFirstChild(name)
            if r then Remotes[name] = r; return r end
        end
    end
    local r = rs:FindFirstChild(name, true)
    if r then Remotes[name] = r end
    return r
end

-- ============================================================
-- FITUR 1: SILENT AIM FLASK (CURE)
-- ============================================================
local OrigNC_Flask
local function EnableFlaskSilentAim()
    if FlaskConn then return end

    pcall(function()
        if OrigNC_Flask then return end
        OrigNC_Flask = hookmetamethod(game, "__namecall", newcclosure(function(self, ...)
            local method = getnamecallmethod()
            local args = {...}

            if Config.Flask_Enabled then
                if method == "FireServer" or method == "InvokeServer" then
                    local selfName = (typeof(self) == "Instance") and self.Name or ""
                    if selfName:find("Flask") or selfName:find("Cure") or
                       selfName:find("Throw") or selfName:find("Heal") then

                        local target = GetNearestSurvivor(Config.Flask_MaxDist)
                        if target and target.Character then
                            local hrp = target.Character:FindFirstChild("HumanoidRootPart")
                            if hrp then
                                local targetPos = PredictPos(hrp, 1) + Vector3.new(0, Config.Flask_YOffset, 0)
                                for i, v in ipairs(args) do
                                    if typeof(v) == "Vector3" then
                                        args[i] = targetPos
                                        break
                                    end
                                    if typeof(v) == "CFrame" then
                                        args[i] = CFrame.new(targetPos)
                                        break
                                    end
                                end
                            end
                        end
                    end
                end
            end

            return OrigNC_Flask(self, table.unpack(args))
        end))
    end)

    FlaskConn = true
    print("[VD] ✅ Silent Aim Flask (Cure) AKTIF")
end

local function DisableFlaskSilentAim()
    Config.Flask_Enabled = false
    print("[VD] ❌ Silent Aim Flask (Cure) NONAKTIF")
end

-- ============================================================
-- FITUR 2: SILENT AIM VEIL SPEAR
-- ============================================================
local OrigNC_Veil
local function EnableVeilSilentAim()
    if VeilConn then return end

    pcall(function()
        if OrigNC_Veil then return end
        OrigNC_Veil = hookmetamethod(game, "__namecall", newcclosure(function(self, ...)
            local method = getnamecallmethod()
            local args = {...}

            if Config.Veil_Enabled then
                if method == "FireServer" or method == "InvokeServer" then
                    local selfName = (typeof(self) == "Instance") and self.Name or ""

                    if selfName:find("Spear") or selfName:find("spear") or
                       selfName:find("Veil") or selfName:find("Throw") then

                        local myChar = LocalPlayer.Character
                        if myChar then
                            local myRoot = myChar:FindFirstChild("HumanoidRootPart")
                            if myRoot then
                                local target = GetFOVTarget(Config.Veil_FOV, Config.Veil_MaxDist, false)
                                if target and target.Character then
                                    local hrp = target.Character:FindFirstChild("HumanoidRootPart")
                                    if hrp then
                                        local predicted = PredictPos(hrp, Config.Veil_LeadMult)
                                        local replaced = false
                                        for i, v in ipairs(args) do
                                            if typeof(v) == "Vector3" then
                                                args[i] = predicted
                                                replaced = true
                                                break
                                            end
                                        end
                                        if not replaced then
                                            table.insert(args, 1, predicted)
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end

            return OrigNC_Veil(self, table.unpack(args))
        end))
    end)

    VeilConn = true
    print("[VD] ✅ Silent Aim Veil Spear AKTIF")
end

local function DisableVeilSilentAim()
    Config.Veil_Enabled = false
    print("[VD] ❌ Silent Aim Veil Spear NONAKTIF")
end

-- ============================================================
-- FITUR 3: AUTO SKILL CHECK
-- ============================================================
local function StartAutoSkillCheck()
    if SkillCheckConn then
        SkillCheckConn:Disconnect()
        SkillCheckConn = nil
    end

    SkillCheckConn = RunService.Heartbeat:Connect(function()
        if not Config.SkillCheck_Enabled then return end

        local char = LocalPlayer.Character
        if not char then return end

        local scGui = nil
        local checkElem = nil
        local goalElem = nil

        for _, desc in ipairs(PlayerGui:GetDescendants()) do
            if desc.Name == "SkillCheckPromptGui" and desc:IsA("ScreenGui") then
                scGui = desc
                checkElem = desc:FindFirstChild("Check", true)
                goalElem  = desc:FindFirstChild("Goal", true)
                break
            end
        end

        if not scGui then
            for _, sg in ipairs(PlayerGui:GetChildren()) do
                if sg:IsA("ScreenGui") and sg.Enabled then
                    local c = sg:FindFirstChild("Check", true)
                    local g = sg:FindFirstChild("Goal", true)
                    if c and g then
                        scGui = sg
                        checkElem = c
                        goalElem = g
                        break
                    end
                end
            end
        end

        if not scGui or not scGui.Enabled then return end
        if not checkElem or not goalElem then return end
        if not checkElem.Visible then return end

        local busy = scGui:GetAttribute("busy")
        if busy then return end

        local checkPos = checkElem.AbsolutePosition + checkElem.AbsoluteSize / 2
        local goalPos  = goalElem.AbsolutePosition
        local goalSize = goalElem.AbsoluteSize

        local inZone = (
            checkPos.X >= goalPos.X and
            checkPos.X <= goalPos.X + goalSize.X and
            checkPos.Y >= goalPos.Y and
            checkPos.Y <= goalPos.Y + goalSize.Y
        )

        if inZone then
            scGui:SetAttribute("busy", true)

            local function doClick()
                pcall(function()
                    local scRemote = ReplicatedStorage:FindFirstChild("SkillCheckResultEvent", true)
                                  or ReplicatedStorage:FindFirstChild("SkillCheck", true)
                                  or ReplicatedStorage:FindFirstChild("CheckSkill", true)
                    if scRemote then
                        if scRemote:IsA("RemoteEvent") then
                            scRemote:FireServer(true)
                        elseif scRemote:IsA("RemoteFunction") then
                            scRemote:InvokeServer(true)
                        end
                    end

                    local clickable = checkElem:FindFirstChildWhichIsA("GuiButton")
                                   or (checkElem:IsA("GuiButton") and checkElem)
                    if clickable then
                        pcall(function()
                            firesignal(clickable.MouseButton1Click)
                        end)
                    end
                end)

                task.wait(0.1)
                pcall(function()
                    scGui:SetAttribute("busy", nil)
                end)
            end

            if Config.SkillCheck_Mode == "Instant" then
                task.spawn(doClick)
            else
                task.delay(Config.SkillCheck_Delay, doClick)
            end
        end
    end)

    print("[VD] ✅ Auto Skill Check AKTIF - Mode: " .. Config.SkillCheck_Mode)
end

local function StopAutoSkillCheck()
    if SkillCheckConn then
        SkillCheckConn:Disconnect()
        SkillCheckConn = nil
    end
    print("[VD] ❌ Auto Skill Check NONAKTIF")
end

-- ============================================================
-- FITUR 4: SILENT AIM PISTOL
-- ============================================================
local OrigNC_Pistol
local function EnablePistolSilentAim()
    if PistolConn then return end

    pcall(function()
        if OrigNC_Pistol then return end
        OrigNC_Pistol = hookmetamethod(game, "__namecall", newcclosure(function(self, ...)
            local method = getnamecallmethod()
            local args = {...}

            if Config.Pistol_Enabled then
                if method == "FireServer" or method == "InvokeServer" then
                    local selfName = (typeof(self) == "Instance") and self.Name or ""

                    local isPistolRemote = (
                        selfName:find("Shoot") or
                        selfName:find("Fire") or
                        selfName:find("Gun") or
                        selfName:find("Pistol") or
                        selfName:find("Emperor") or
                        selfName:find("Flash") or
                        selfName:find("Bullet")
                    )

                    if isPistolRemote then
                        local target = GetFOVTarget(
                            Config.Pistol_FOV,
                            Config.Pistol_MaxDist,
                            Config.Pistol_BlockKnocked
                        )

                        if target and target.Character then
                            local hrp = target.Character:FindFirstChild(Config.Pistol_TargetPart)
                                     or target.Character:FindFirstChild("HumanoidRootPart")
                            if hrp then
                                local predicted = PredictPos(hrp, 1)
                                predicted = predicted + Vector3.new(0, 1.5, 0)

                                for i, v in ipairs(args) do
                                    if typeof(v) == "Vector3" then
                                        args[i] = predicted
                                        break
                                    end
                                    if typeof(v) == "CFrame" then
                                        args[i] = CFrame.new(predicted)
                                        break
                                    end
                                end
                            end
                        end
                    end
                end
            end

            return OrigNC_Pistol(self, table.unpack(args))
        end))
    end)

    PistolConn = true
    print("[VD] ✅ Silent Aim Pistol AKTIF")
end

local function DisablePistolSilentAim()
    Config.Pistol_Enabled = false
    print("[VD] ❌ Silent Aim Pistol NONAKTIF")
end

-- ============================================================
-- GUI PAKAI WINDUI
-- ============================================================
local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"))()

local Window = WindUI:CreateWindow({
    Title = "VD Features Hub",
    Icon = "sword",
    Author = "Violence District",
    Folder = "VDFeaturesHub",
    Size = UDim2.fromOffset(380, 480),
    Transparent = true,
    Theme = "Dark",
})

-- Tab utama
local Tab = Window:Tab({
    Title = "Features",
    Icon = "zap",
})

-- ─── SILENT AIM FLASK ───────────────────────────────────────
Tab:Section({ Title = "Cure / Flask" })

Tab:Toggle({
    Title = "Silent Aim Flask",
    Description = "Redirect lemparan flask ke survivor terdekat",
    Default = false,
    Callback = function(state)
        Config.Flask_Enabled = state
        if state then
            EnableFlaskSilentAim()
        else
            DisableFlaskSilentAim()
        end
    end,
})

-- ─── SILENT AIM VEIL SPEAR ──────────────────────────────────
Tab:Section({ Title = "Veil Spear" })

Tab:Toggle({
    Title = "Silent Aim Veil Spear",
    Description = "Redirect lempar spear ke target di FOV",
    Default = false,
    Callback = function(state)
        Config.Veil_Enabled = state
        if state then
            EnableVeilSilentAim()
        else
            DisableVeilSilentAim()
        end
    end,
})

-- ─── AUTO SKILL CHECK ───────────────────────────────────────
Tab:Section({ Title = "Skill Check" })

Tab:Toggle({
    Title = "Auto Skill Check",
    Description = "Otomatis klik skill check saat muncul",
    Default = false,
    Callback = function(state)
        Config.SkillCheck_Enabled = state
        if state then
            StartAutoSkillCheck()
        else
            StopAutoSkillCheck()
        end
    end,
})

Tab:Dropdown({
    Title = "Mode Skill Check",
    Description = "Instant = langsung, Legit = sedikit delay",
    Values = { "Instant", "Legit" },
    Default = "Instant",
    Callback = function(value)
        Config.SkillCheck_Mode = value
        -- Restart kalau aktif
        if Config.SkillCheck_Enabled then
            StopAutoSkillCheck()
            StartAutoSkillCheck()
        end
    end,
})

-- ─── SILENT AIM PISTOL ──────────────────────────────────────
Tab:Section({ Title = "Pistol / EmperorGun" })

Tab:Toggle({
    Title = "Silent Aim Pistol",
    Description = "Redirect tembakan pistol ke target di FOV",
    Default = false,
    Callback = function(state)
        Config.Pistol_Enabled = state
        if state then
            EnablePistolSilentAim()
        else
            DisablePistolSilentAim()
        end
    end,
})

Tab:Toggle({
    Title = "Block Knocked Target",
    Description = "Tidak aim ke target yang sudah knocked",
    Default = true,
    Callback = function(state)
        Config.Pistol_BlockKnocked = state
    end,
})

-- ─── Tab Config / Slider ────────────────────────────────────
local CfgTab = Window:Tab({
    Title = "Config",
    Icon = "settings",
})

CfgTab:Section({ Title = "Flask Settings" })

CfgTab:Slider({
    Title = "Flask Max Distance",
    Description = "Jarak maksimum lemparan flask (studs)",
    Min = 20,
    Max = 150,
    Default = 60,
    Decimals = 0,
    Callback = function(val)
        Config.Flask_MaxDist = val
    end,
})

CfgTab:Slider({
    Title = "Flask Y Offset",
    Description = "Offset ketinggian target flask",
    Min = 0,
    Max = 5,
    Default = 1.5,
    Decimals = 1,
    Callback = function(val)
        Config.Flask_YOffset = val
    end,
})

CfgTab:Section({ Title = "Veil Spear Settings" })

CfgTab:Slider({
    Title = "Veil FOV Radius",
    Description = "Radius FOV piksel untuk spear (default: 150)",
    Min = 30,
    Max = 400,
    Default = 150,
    Decimals = 0,
    Callback = function(val)
        Config.Veil_FOV = val
    end,
})

CfgTab:Slider({
    Title = "Veil Max Distance",
    Description = "Jarak maksimum spear (studs, default: 200)",
    Min = 50,
    Max = 400,
    Default = 200,
    Decimals = 0,
    Callback = function(val)
        Config.Veil_MaxDist = val
    end,
})

CfgTab:Slider({
    Title = "Veil Lead Multiplier",
    Description = "Multiplier prediksi gerak target (default: 1.4)",
    Min = 0.5,
    Max = 3.0,
    Default = 1.4,
    Decimals = 1,
    Callback = function(val)
        Config.Veil_LeadMult = val
    end,
})

CfgTab:Section({ Title = "Pistol Settings" })

CfgTab:Slider({
    Title = "Pistol FOV Radius",
    Description = "Radius FOV piksel untuk pistol (default: 150)",
    Min = 30,
    Max = 400,
    Default = 150,
    Decimals = 0,
    Callback = function(val)
        Config.Pistol_FOV = val
    end,
})

CfgTab:Slider({
    Title = "Pistol Max Distance",
    Description = "Jarak maksimum tembakan pistol (studs)",
    Min = 50,
    Max = 300,
    Default = 150,
    Decimals = 0,
    Callback = function(val)
        Config.Pistol_MaxDist = val
    end,
})

CfgTab:Section({ Title = "Skill Check Settings" })

CfgTab:Slider({
    Title = "Legit Mode Delay",
    Description = "Delay klik di mode Legit (detik)",
    Min = 0.01,
    Max = 0.3,
    Default = 0.05,
    Decimals = 2,
    Callback = function(val)
        Config.SkillCheck_Delay = val
    end,
})

-- ============================================================
-- RESPAWN HANDLER
-- ============================================================
LocalPlayer.CharacterAdded:Connect(function()
    task.wait(1)
    Remotes = {}
    if Config.SkillCheck_Enabled then
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
 GUI: WindUI by Footagesus
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 Fitur tersedia:
   🧪 Silent Aim Flask (Cure)
   🌀 Silent Aim Veil Spear
   ⚙  Auto Skill Check (Instant/Legit)
   🔫 Silent Aim Pistol

 Tap tombol di WindUI untuk aktifkan
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
]])
