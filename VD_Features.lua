--[[
    ╔══════════════════════════════════════════════════════╗
    ║   VIOLENCE DISTRICT - 4 FITUR UTAMA                 ║
    ║   1. Silent Aim Flask (Cure)                         ║
    ║   2. Silent Aim Veil Spear                           ║
    ║   3. Auto Skill Check                                ║
    ║   4. Silent Aim Pistol                               ║
    ║                                                      ║
    ║   Compatible : Delta Mobile (Android)                ║
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
    Flask_TargetPart = "HumanoidRootPart",  -- Part yang dituju lempar flask
    Flask_MaxDist    = 60,                  -- Jarak max lemparan flask (studs)
    Flask_YOffset    = 1.5,                 -- Offset Y ke atas dari HRP target

    -- === SILENT AIM VEIL SPEAR ===
    Veil_Enabled       = false,
    Veil_TargetPart    = "HumanoidRootPart",
    Veil_MaxDist       = 200,               -- Jarak max spear (studs), default dari dump: 200
    Veil_Speed         = 165,               -- Kecepatan spear, dari dump: SPEAR_Speed = 165
    Veil_Gravity       = 0,                 -- Gravity spear, 0 = no gravity
    Veil_LeadMult      = 1.4,               -- Prediction multiplier, dari dump: 1.4
    Veil_FOV           = 150,               -- FOV radius pixel, dari dump: 150

    -- === AUTO SKILL CHECK ===
    SkillCheck_Enabled = false,
    SkillCheck_Mode    = "Instant",         -- "Instant" atau "Legit"
    -- Mode Instant: langsung klik saat skill check muncul
    -- Mode Legit: klik sedikit delay (lebih aman anti-detect)
    SkillCheck_Delay   = 0.05,              -- Delay klik di mode Legit (detik)

    -- === SILENT AIM PISTOL ===
    Pistol_Enabled     = false,
    Pistol_TargetPart  = "HumanoidRootPart",
    Pistol_MaxDist     = 150,
    Pistol_FOV         = 150,               -- dari dump: Pistol_FOV = 150
    Pistol_BlockKnocked = true,             -- dari dump: tidak aim ke yang sudah knocked
}

-- ============================================================
-- STATE
-- ============================================================
local Remotes = {}          -- cache remote events
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
                -- Block knocked check (dari dump: Pistol_BlockKnocked)
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
-- UTILITY: CARI REMOTE EVENT (nama dari dump)
-- ============================================================
local function FindRemote(name)
    if Remotes[name] then return Remotes[name] end
    -- Violence District menyimpan remote di ReplicatedStorage
    local rs = ReplicatedStorage
    -- cari di sub-folder umum
    for _, folder in ipairs({"Remotes", "Events", "RF", "RE"}) do
        local f = rs:FindFirstChild(folder)
        if f then
            local r = f:FindFirstChild(name)
            if r then Remotes[name] = r; return r end
        end
    end
    -- cari langsung
    local r = rs:FindFirstChild(name, true)
    if r then Remotes[name] = r end
    return r
end

-- ============================================================
-- UTILITY: CARI GUI SKILL CHECK
-- ============================================================
local function FindSkillCheckGui()
    local char = LocalPlayer.Character
    if not char then return nil, nil end

    -- Dari dump: nama GUI "SkillCheckPromptGui", child "Check", "Goal", "Line"
    -- Dicari di PlayerGui dan Character
    local function search(parent)
        if not parent then return nil end
        for _, v in ipairs(parent:GetDescendants()) do
            if v.Name == "SkillCheckPromptGui" or
               v.Name == "SkillCheck" or
               (v:IsA("ScreenGui") and v.Name:lower():find("skill")) then
                local check = v:FindFirstChild("Check") or v:FindFirstDescendant and v:FindFirstChild("Check", true)
                local goal  = v:FindFirstChild("Goal")
                if check and goal then
                    return v, check, goal
                end
            end
        end
        return nil
    end

    return search(PlayerGui)
end

-- ============================================================
-- ══════════════════════════════════════════
-- FITUR 1: SILENT AIM FLASK (CURE)
-- ══════════════════════════════════════════
-- Cara kerja dari dump:
-- Saat ThrowFlask FireServer dipanggil, posisi lemparan
-- di-redirect ke target terdekat (survivor).
-- NEX_StartCureFlaskLaser = versi visual laser merah.
-- ============================================================
local OrigNC_Flask
local function EnableFlaskSilentAim()
    if FlaskConn then return end

    -- Hook namecall: intercept ThrowFlask / AimFlask FireServer
    pcall(function()
        if OrigNC_Flask then return end
        OrigNC_Flask = hookmetamethod(game, "__namecall", newcclosure(function(self, ...)
            local method = getnamecallmethod()
            local args = {...}

            if Config.Flask_Enabled then
                -- Dari dump: remote name "ThrowFlask", "AimFlask", "FlaskSilentAimLaser"
                if method == "FireServer" or method == "InvokeServer" then
                    -- Cek apakah self adalah flask/cure remote
                    local selfName = (typeof(self) == "Instance") and self.Name or ""
                    if selfName:find("Flask") or selfName:find("Cure") or
                       selfName:find("Throw") or selfName:find("Heal") then

                        local target = GetNearestSurvivor(Config.Flask_MaxDist)
                        if target and target.Character then
                            local hrp = target.Character:FindFirstChild("HumanoidRootPart")
                            if hrp then
                                local targetPos = PredictPos(hrp, 1) + Vector3.new(0, Config.Flask_YOffset, 0)
                                -- Ganti Vector3 argument pertama ke posisi target
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
-- ══════════════════════════════════════════
-- FITUR 2: SILENT AIM VEIL SPEAR
-- ══════════════════════════════════════════
-- Cara kerja dari dump (PROTO192/193):
-- setupSpearInterceptor pakai hookmetamethod __namecall
-- intercept "Spearthrow" / "spearmode" FireServer
-- Hitung predicted position dengan Veil_LeadMultiplier
-- Override Vector3 argument ke posisi target
-- SPEAR_Speed = 165, SPEAR_MaxDist = 200, Gravity = 0
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

                    -- Dari dump: remote "Spearthrow", "spearmode", nama Veil
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
                                        -- Hitung predicted pos dengan LeadMultiplier
                                        local predicted = PredictPos(hrp, Config.Veil_LeadMult)

                                        -- Dari dump: override Vector3 arg ke target position
                                        local replaced = false
                                        for i, v in ipairs(args) do
                                            if typeof(v) == "Vector3" then
                                                args[i] = predicted
                                                replaced = true
                                                break
                                            end
                                        end
                                        -- Kalau tidak ada Vector3, tambahkan
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
-- ══════════════════════════════════════════
-- FITUR 3: AUTO SKILL CHECK
-- ══════════════════════════════════════════
-- Cara kerja dari dump (PROTO491/492):
-- RunService Heartbeat cek SkillCheckPromptGui Visible
-- Kalau visible, cek posisi "Check" relatif ke "Goal"
-- Kalau Check sudah di zona Goal → klik / fire remote
-- Mode Instant: langsung klik
-- Mode Legit: delay sedikit lalu klik
-- Dari dump: cek "busy" attribute, Skillcheck-gen, Skillcheck-player
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

        -- Cari SkillCheckPromptGui
        local scGui = nil
        local checkElem = nil
        local goalElem = nil

        -- Dari dump: dicari di Character descendants dan PlayerGui
        for _, desc in ipairs(PlayerGui:GetDescendants()) do
            if desc.Name == "SkillCheckPromptGui" and desc:IsA("ScreenGui") then
                scGui = desc
                checkElem = desc:FindFirstChild("Check", true)
                goalElem  = desc:FindFirstChild("Goal", true)
                break
            end
        end

        -- Fallback: cari GUI apapun yang punya "Check" dan "Goal"
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

        -- Cek apakah "busy" (sedang proses klik sebelumnya)
        local busy = scGui:GetAttribute("busy")
        if busy then return end

        -- Dapatkan posisi Check dan Goal dalam screen space
        local checkPos = checkElem.AbsolutePosition + checkElem.AbsoluteSize / 2
        local goalPos  = goalElem.AbsolutePosition
        local goalSize = goalElem.AbsoluteSize

        -- Check apakah Check ada di dalam zona Goal
        local inZone = (
            checkPos.X >= goalPos.X and
            checkPos.X <= goalPos.X + goalSize.X and
            checkPos.Y >= goalPos.Y and
            checkPos.Y <= goalPos.Y + goalSize.Y
        )

        if inZone then
            scGui:SetAttribute("busy", true)

            local function doClick()
                -- Dari dump: klik via firesignal ke SkillCheckResultEvent
                -- atau via remote FireServer
                pcall(function()
                    -- Coba cari remote skill check
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

                    -- Fallback: simulasi klik pada element Check
                    -- Dari dump: obj:Move() dan obj:Click()
                    local clickable = checkElem:FindFirstChildWhichIsA("GuiButton")
                                   or (checkElem:IsA("GuiButton") and checkElem)
                    if clickable then
                        local fireclick = Instance.new("InputObject")
                        fireclick.UserInputType = Enum.UserInputType.MouseButton1
                        -- Simulasi via firesignal kalau tersedia
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
                -- Mode Legit: delay sedikit
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
-- ══════════════════════════════════════════
-- FITUR 4: SILENT AIM PISTOL
-- ══════════════════════════════════════════
-- Cara kerja dari dump (PROTO521):
-- Hook __namecall, intercept FireServer saat pistol dipakai
-- getPistolTarget → cari target dalam Pistol_FOV
-- Override Vector3 arg ke posisi target
-- Pistol_BlockKnocked: skip target yang sudah knocked
-- Flash_Silent / Flash_YOffset: bawaan dari dump config
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

                    -- Dari dump: remote pistol kemungkinan nama "Shoot", "Fire",
                    -- "EmperorGun", "doShoot", "Pistol", atau "AimFlask" (flash)
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
                        -- Cari target dalam FOV
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
                                -- Flash_YOffset dari dump = 1.5
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
-- GUI MOBILE - TOUCH FRIENDLY
-- ============================================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "VD_FeaturesHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = PlayerGui

-- Main Panel
local Panel = Instance.new("Frame")
Panel.Size = UDim2.new(0, 250, 0, 330)
Panel.Position = UDim2.new(0, 8, 0.2, 0)
Panel.BackgroundColor3 = Color3.fromRGB(12, 12, 18)
Panel.BorderSizePixel = 0
Panel.Parent = ScreenGui

Instance.new("UICorner", Panel).CornerRadius = UDim.new(0, 10)
local ps = Instance.new("UIStroke", Panel)
ps.Color = Color3.fromRGB(200, 40, 40)
ps.Thickness = 1.5

-- Header
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 40)
Header.BackgroundColor3 = Color3.fromRGB(200, 40, 40)
Header.BorderSizePixel = 0
Header.Parent = Panel
Instance.new("UICorner", Header).CornerRadius = UDim.new(0, 10)

local HFix = Instance.new("Frame")
HFix.Size = UDim2.new(1, 0, 0.5, 0)
HFix.Position = UDim2.new(0, 0, 0.5, 0)
HFix.BackgroundColor3 = Color3.fromRGB(200, 40, 40)
HFix.BorderSizePixel = 0
HFix.Parent = Header

local HLabel = Instance.new("TextLabel")
HLabel.Size = UDim2.new(1, -50, 1, 0)
HLabel.Position = UDim2.new(0, 10, 0, 0)
HLabel.BackgroundTransparency = 1
HLabel.Text = "⚔ VD Features Hub"
HLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
HLabel.Font = Enum.Font.GothamBold
HLabel.TextSize = 14
HLabel.TextXAlignment = Enum.TextXAlignment.Left
HLabel.Parent = Header

-- Mini/Max button
local MinBtn = Instance.new("TextButton")
MinBtn.Size = UDim2.new(0, 34, 0, 28)
MinBtn.Position = UDim2.new(1, -38, 0, 6)
MinBtn.Text = "–"
MinBtn.Font = Enum.Font.GothamBold
MinBtn.TextSize = 16
MinBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MinBtn.BackgroundTransparency = 0.7
MinBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
MinBtn.BorderSizePixel = 0
MinBtn.Parent = Header
Instance.new("UICorner", MinBtn).CornerRadius = UDim.new(0, 6)

-- Content
local Content = Instance.new("Frame")
Content.Size = UDim2.new(1, 0, 1, -40)
Content.Position = UDim2.new(0, 0, 0, 40)
Content.BackgroundTransparency = 1
Content.Parent = Panel

local CLayout = Instance.new("UIListLayout", Content)
CLayout.Padding = UDim.new(0, 5)
CLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

local CPad = Instance.new("UIPadding", Content)
CPad.PaddingTop = UDim.new(0, 7)
CPad.PaddingLeft = UDim.new(0, 8)
CPad.PaddingRight = UDim.new(0, 8)

-- ============================================================
-- Helper buat toggle button
-- ============================================================
local function MakeToggle(parent, label, configKey, onEnable, onDisable)
    local Row = Instance.new("Frame")
    Row.Size = UDim2.new(1, 0, 0, 50)
    Row.BackgroundColor3 = Color3.fromRGB(22, 22, 30)
    Row.BorderSizePixel = 0
    Row.Parent = parent
    Instance.new("UICorner", Row).CornerRadius = UDim.new(0, 8)
    local RS = Instance.new("UIStroke", Row)
    RS.Color = Color3.fromRGB(45, 45, 58)
    RS.Thickness = 1

    local Lbl = Instance.new("TextLabel")
    Lbl.Size = UDim2.new(1, -65, 0.6, 0)
    Lbl.Position = UDim2.new(0, 10, 0.05, 0)
    Lbl.BackgroundTransparency = 1
    Lbl.Text = label
    Lbl.TextColor3 = Color3.fromRGB(220, 220, 220)
    Lbl.Font = Enum.Font.GothamBold
    Lbl.TextSize = 12
    Lbl.TextXAlignment = Enum.TextXAlignment.Left
    Lbl.TextWrapped = true
    Lbl.Parent = Row

    local Status = Instance.new("TextLabel")
    Status.Size = UDim2.new(1, -10, 0.35, 0)
    Status.Position = UDim2.new(0, 10, 0.62, 0)
    Status.BackgroundTransparency = 1
    Status.Text = "● OFF"
    Status.TextColor3 = Color3.fromRGB(120, 120, 120)
    Status.Font = Enum.Font.Gotham
    Status.TextSize = 10
    Status.TextXAlignment = Enum.TextXAlignment.Left
    Status.Parent = Row

    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(0, 52, 0, 26)
    Btn.Position = UDim2.new(1, -60, 0.5, -13)
    Btn.Text = "OFF"
    Btn.Font = Enum.Font.GothamBold
    Btn.TextSize = 11
    Btn.TextColor3 = Color3.fromRGB(140, 140, 140)
    Btn.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
    Btn.BorderSizePixel = 0
    Btn.Parent = Row
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 13)

    local function Refresh()
        local on = Config[configKey]
        Btn.Text = on and "ON" or "OFF"
        Btn.BackgroundColor3 = on
            and Color3.fromRGB(200, 40, 40)
            or  Color3.fromRGB(50, 50, 60)
        Btn.TextColor3 = on
            and Color3.fromRGB(255, 255, 255)
            or  Color3.fromRGB(140, 140, 140)
        Status.Text = on and "● AKTIF" or "● OFF"
        Status.TextColor3 = on
            and Color3.fromRGB(100, 230, 100)
            or  Color3.fromRGB(120, 120, 120)
        RS.Color = on
            and Color3.fromRGB(200, 40, 40)
            or  Color3.fromRGB(45, 45, 58)
    end

    Btn.TouchTap:Connect(function()
        Config[configKey] = not Config[configKey]
        Refresh()
        if Config[configKey] then
            if onEnable then onEnable() end
        else
            if onDisable then onDisable() end
        end
    end)

    Refresh()
    return Row
end

-- ============================================================
-- Buat semua toggle
-- ============================================================
MakeToggle(Content,
    "🧪 Silent Aim Flask\n(Cure/ThrowFlask)",
    "Flask_Enabled",
    EnableFlaskSilentAim,
    DisableFlaskSilentAim
)

MakeToggle(Content,
    "🌀 Silent Aim\nVeil Spear",
    "Veil_Enabled",
    EnableVeilSilentAim,
    DisableVeilSilentAim
)

MakeToggle(Content,
    "⚙ Auto Skill Check\n(Instant/Legit)",
    "SkillCheck_Enabled",
    StartAutoSkillCheck,
    StopAutoSkillCheck
)

MakeToggle(Content,
    "🔫 Silent Aim Pistol\n(EmperorGun)",
    "Pistol_Enabled",
    EnablePistolSilentAim,
    DisablePistolSilentAim
)

-- Tombol ganti mode skill check
local ModeBtn = Instance.new("TextButton")
ModeBtn.Size = UDim2.new(1, 0, 0, 36)
ModeBtn.Text = "Mode Skill Check: INSTANT  (tap untuk ganti)"
ModeBtn.Font = Enum.Font.Gotham
ModeBtn.TextSize = 11
ModeBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
ModeBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
ModeBtn.BorderSizePixel = 0
ModeBtn.TextWrapped = true
ModeBtn.Parent = Content
Instance.new("UICorner", ModeBtn).CornerRadius = UDim.new(0, 8)

ModeBtn.TouchTap:Connect(function()
    if Config.SkillCheck_Mode == "Instant" then
        Config.SkillCheck_Mode = "Legit"
        ModeBtn.Text = "Mode Skill Check: LEGIT  (tap untuk ganti)"
        ModeBtn.BackgroundColor3 = Color3.fromRGB(40, 60, 30)
    else
        Config.SkillCheck_Mode = "Instant"
        ModeBtn.Text = "Mode Skill Check: INSTANT  (tap untuk ganti)"
        ModeBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    end
    -- Restart skill check dengan mode baru
    if Config.SkillCheck_Enabled then
        StopAutoSkillCheck()
        StartAutoSkillCheck()
    end
end)

-- ============================================================
-- DRAG & MINIMIZE
-- ============================================================
local minimized = false
local dragging, dragStart, startPos = false, nil, nil

Header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch then
        dragging  = true
        dragStart = input.Position
        startPos  = Panel.Position
    end
end)
Header.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.Touch then
        local delta = input.Position - dragStart
        Panel.Position = UDim2.new(
            startPos.X.Scale, startPos.X.Offset + delta.X,
            startPos.Y.Scale, startPos.Y.Offset + delta.Y
        )
    end
end)
Header.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

MinBtn.TouchTap:Connect(function()
    minimized = not minimized
    Panel.Size = minimized
        and UDim2.new(0, 250, 0, 40)
        or  UDim2.new(0, 250, 0, 330)
    MinBtn.Text = minimized and "+" or "–"
end)

-- ============================================================
-- RESPAWN HANDLER
-- ============================================================
LocalPlayer.CharacterAdded:Connect(function()
    task.wait(1)
    Remotes = {}  -- reset remote cache
    -- restart fitur yang aktif
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
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 Fitur tersedia:
   🧪 Silent Aim Flask (Cure)
   🌀 Silent Aim Veil Spear
   ⚙  Auto Skill Check (Instant/Legit)
   🔫 Silent Aim Pistol

 Tap tombol ON/OFF di GUI untuk aktifkan
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
]])
