--[[
    ╔══════════════════════════════════════════════════════════════╗
    ║          GanKunZ Hub - Violence District Auto Farm           ║
    ║                   Peaceful Community Edition                 ║
    ║                   Creator: GanKunZ Hub                       ║
    ╚══════════════════════════════════════════════════════════════╝

    FITUR LENGKAP:
    ✔ Auto Farm (Exit Gate Otomatis)
    ✔ Config Manager (Save/Load/Delete/Export)
    ✔ External JSON Config (Paste JSON langsung)
    ✔ Autoload Config (Auto load saat teleport)
    ✔ Server Hop (Cari server dengan player cukup)
    ✔ Auto Execute setelah teleport
    ✔ Webhook Discord (Kirim stats tiap round selesai)
    ✔ Notif UI terintegrasi

    CARA PAKAI:
    1. Aktifkan [Enable Auto Farm]
    2. Aktifkan [Auto Execute]
    3. Aktifkan [Disable Killer Chance] di game (bukan di hub ini)
    4. Save Config lalu klik [Set Autoload]
    5. Enjoy!

    Creator: GanKunZ Hub
--]]

-- ============================================================
-- SERVICES & VARIABLES UTAMA
-- ============================================================
local Players           = game:GetService("Players")
local TweenService      = game:GetService("TweenService")
local HttpService       = game:GetService("HttpService")
local TeleportService   = game:GetService("TeleportService")
local RunService        = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local LocalPlayer = Players.LocalPlayer
local Character   = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local PlayerGui   = LocalPlayer.PlayerGui

-- ============================================================
-- KONSTANTA / KONFIGURASI INTERNAL
-- ============================================================
local CURRENT_VERSION = "1.0.0"
local CREATOR_NAME    = "GanKunZ Hub"
local HUB_NAME        = "GanKunZ Hub"

local mainFolderName  = "GanKunZ Hub_ViolenceAutoFarm"
local ConfigFolder    = mainFolderName .. "/Config/"
local AutoloadConfig  = mainFolderName .. "/autoload.txt"

-- URL auto-execute setelah teleport (ganti sesuai rawfile kamu)
local AUTO_EXEC_URL   = "https://raw.githubusercontent.com/GrexXMeng/Mengs/refs/heads/main/AutoFarmVD.lua"

-- Roblox API
local ROBLOX_GAME_API = "https://games.roblox.com/v1/games/"

-- ============================================================
-- STATE GLOBAL
-- ============================================================
local _G = _G or {}

_G.AutoFarmEnabled   = false
_G.SelectedConfig    = nil
_G.CurrentLoaded     = nil
_G.ConfigData        = {}
_G.AutoloadConfig    = nil
_G.ExternalJSONInput = ""
_G.ConfigFolder      = ConfigFolder

-- Referensi ke elemen GUI
local UIRefs = {
    ConfigDropdown   = nil,
    ConfigParagraph  = nil,
    AutoFarmSection  = nil,
    WebhookSection   = nil,
    ConfigSection    = nil,
    StatusLabel      = nil,
    WebhookURLInput  = nil,
}

-- ============================================================
-- TEMA WARNA GANKÜNZ HUB
-- ============================================================
local THEME = {
    BG          = Color3.fromRGB(13, 14, 22),       -- background utama (lebih gelap)
    BG2         = Color3.fromRGB(20, 22, 35),       -- frame / card
    BG3         = Color3.fromRGB(28, 30, 48),       -- input / toggle BG
    ACCENT      = Color3.fromRGB(120, 80, 220),     -- purple accent
    ACCENT2     = Color3.fromRGB(80, 50, 180),      -- darker accent
    SECTION_BG  = Color3.fromRGB(30, 25, 55),       -- section label BG
    SECTION_TXT = Color3.fromRGB(180, 140, 255),    -- section label text
    TEXT        = Color3.fromRGB(220, 218, 240),    -- teks utama
    TEXT_DIM    = Color3.fromRGB(140, 135, 170),    -- teks sekunder
    TEXT_INFO   = Color3.fromRGB(255, 210, 100),    -- warning/info kuning
    TOGGLE_ON   = Color3.fromRGB(90, 200, 120),     -- toggle aktif
    TOGGLE_OFF  = Color3.fromRGB(60, 58, 90),       -- toggle nonaktif
    BTN         = Color3.fromRGB(75, 50, 160),      -- tombol utama
    BTN_HOVER   = Color3.fromRGB(100, 70, 200),     -- tombol hover
    SCROLLBAR   = Color3.fromRGB(120, 80, 220),     -- scrollbar
    BORDER      = Color3.fromRGB(70, 55, 130),      -- border
    STATUS_OK   = Color3.fromRGB(100, 230, 150),    -- status hijau
}

-- ============================================================
-- UTILITAS DASAR
-- ============================================================

local function SendNotif(title, text, duration)
    duration = duration or 5
    if syn and syn.toast_notification then
        syn.toast_notification({
            Type     = 0,
            Title    = "[" .. HUB_NAME .. "] " .. title,
            Content  = text,
            Duration = duration,
        })
    elseif game.StarterGui then
        pcall(function()
            game.StarterGui:SetCore("SendNotification", {
                Title    = "[" .. HUB_NAME .. "] " .. title,
                Text     = text,
                Duration = duration,
            })
        end)
    else
        print(("[GanKunZ Hub] %s: %s"):format(title, text))
    end
end

local function UpdateStatus(text)
    if UIRefs.StatusLabel then
        pcall(function() UIRefs.StatusLabel:SetContent(text) end)
    end
end

-- ============================================================
-- FILE SYSTEM HELPERS
-- ============================================================

local function SafeMakeFolder(path)
    if not isfolder(path) then
        pcall(makefolder, path)
    end
end

local function SafeReadFile(path)
    if isfile(path) then
        return pcall(readfile, path)
    end
    return false, nil
end

local function SafeWriteFile(path, content)
    return pcall(writefile, path, content)
end

local function SafeDelFile(path)
    if isfile(path) then
        return pcall(delfile, path)
    end
    return false
end

-- ============================================================
-- CONFIG MANAGER
-- ============================================================

local function GetConfigList()
    local list = {}
    if not isfolder(ConfigFolder) then return list end
    local ok, files = pcall(listfiles, ConfigFolder)
    if not ok or type(files) ~= "table" then return list end
    for _, filePath in ipairs(files) do
        local name = tostring(filePath):match("([^/\\]+)$")
        if name then
            name = name:gsub("%.json$", "")
            table.insert(list, name)
        end
    end
    return list
end

local function LoadConfigElements(configData)
    if type(configData) ~= "table" then return end
    _G.ConfigData = configData
    if configData.AutoFarmEnabled ~= nil then
        _G.AutoFarmEnabled = configData.AutoFarmEnabled
    end
    if configData.WebhookURL ~= nil and UIRefs.WebhookURLInput then
        pcall(function() UIRefs.WebhookURLInput:SetValue(configData.WebhookURL) end)
    end
end

local function SaveConfig(configName)
    if not configName or configName == "" then
        SendNotif("Config", "Nama config kosong!", 3)
        return
    end
    SafeMakeFolder(mainFolderName)
    SafeMakeFolder(ConfigFolder)
    local data = {
        AutoFarmEnabled = _G.AutoFarmEnabled,
        WebhookURL      = (UIRefs.WebhookURLInput and UIRefs.WebhookURLInput:GetValue()) or "",
        Version         = CURRENT_VERSION,
        Creator         = CREATOR_NAME,
    }
    local jsonStr = HttpService:JSONEncode(data)
    local path = ConfigFolder .. configName .. ".json"
    SafeWriteFile(path, jsonStr)
    SendNotif("Config", "Config '" .. configName .. "' berhasil disimpan!", 4)
    if UIRefs.ConfigDropdown then
        pcall(function() UIRefs.ConfigDropdown:SetValues(GetConfigList()) end)
    end
end

local function LoadConfigFromFile(configPath)
    local ok, content = SafeReadFile(configPath)
    if not ok or not content then
        SendNotif("Config", "Gagal baca file: " .. tostring(configPath), 3)
        return
    end
    local parseOk, configData = pcall(function()
        return HttpService:JSONDecode(content)
    end)
    if not parseOk or type(configData) ~= "table" then
        SendNotif("Config", "Format config tidak valid!", 3)
        return
    end
    LoadConfigElements(configData)
    _G.CurrentLoaded = configPath
    local currentName = (configPath:match("([^/\\]+)$") or configPath):gsub("%.json$", "")
    local autoloadName = "None"
    if isfile(AutoloadConfig) then
        local aOk, aContent = SafeReadFile(AutoloadConfig)
        if aOk and aContent then
            autoloadName = (aContent:match("([^/\\]+)$") or aContent):gsub("%.json$", "")
        end
    end
    UpdateStatus("Current: " .. currentName .. " | Autoload: " .. autoloadName)
    SendNotif("Config", "Config '" .. currentName .. "' berhasil di-load!", 4)
end

local function DeleteConfig(configName)
    if not configName or configName == "" then
        SendNotif("Config", "Pilih config terlebih dahulu!", 3)
        return
    end
    local path = ConfigFolder .. configName .. ".json"
    SafeDelFile(path)
    SendNotif("Config", "Config '" .. configName .. "' dihapus!", 3)
    _G.SelectedConfig = nil
    if UIRefs.ConfigDropdown then
        pcall(function() UIRefs.ConfigDropdown:SetValues(GetConfigList()) end)
    end
end

local function SetAutoload(configName)
    if not configName or configName == "" then
        SendNotif("Autoload", "Pilih config terlebih dahulu!", 3)
        return
    end
    SafeMakeFolder(mainFolderName)
    local path = ConfigFolder .. configName .. ".json"
    SafeWriteFile(AutoloadConfig, path)
    _G.AutoloadConfig = path
    SendNotif("Autoload", "Berhasil set config menjadi autoload!", 4)
    local currentName = ((_G.CurrentLoaded or ""):match("([^/\\]+)$") or "None"):gsub("%.json$", "")
    UpdateStatus("Current: " .. currentName .. " | Autoload: " .. configName)
end

local function ClearAutoload()
    SafeDelFile(AutoloadConfig)
    _G.AutoloadConfig = nil
    SendNotif("Autoload", "Berhasil menghapus autoload config!", 3)
    local currentName = ((_G.CurrentLoaded or "None"):match("([^/\\]+)$") or "None"):gsub("%.json$", "")
    UpdateStatus("Current: " .. currentName .. " | Autoload: None")
end

local function ExportConfig(configName)
    if not configName or configName == "" then
        SendNotif("Export", "Pilih dan load dulu config yang ingin di-export!", 4)
        return
    end
    local path = ConfigFolder .. configName .. ".json"
    local ok, content = SafeReadFile(path)
    if ok and content then
        if setclipboard then
            setclipboard(content)
            SendNotif("Export", "Config '" .. configName .. "' berhasil di-copy ke clipboard!", 4)
        else
            SendNotif("Export", "Executor tidak support setclipboard!", 3)
        end
    else
        SendNotif("Export", "Gagal baca config!", 3)
    end
end

local function LoadFromExternalJSON()
    local jsonText = _G.ExternalJSONInput or ""
    if jsonText == "" then
        SendNotif("External JSON", "JSON input kosong!", 3)
        return
    end
    local ok, configData = pcall(function()
        return HttpService:JSONDecode(jsonText)
    end)
    if not ok or type(configData) ~= "table" then
        SendNotif("External JSON", "JSON tidak valid! Cek formatnya", 3)
        return
    end
    LoadConfigElements(configData)
    _G.CurrentLoaded = "External JSON"
    SendNotif("External JSON", "Berhasil load config dari external JSON", 4)
    local autoloadName = isfile(AutoloadConfig) and "Active" or "None"
    UpdateStatus("Current: External JSON | Autoload: " .. autoloadName)
end

-- ============================================================
-- AUTO EXECUTE
-- ============================================================

local function SetupAutoExecute(enabled)
    if not enabled then return end
    local execScript = [[
        repeat task.wait() until game:IsLoaded()
        loadstring(game:HttpGet("]] .. AUTO_EXEC_URL .. [["))()
    ]]
    if queue_on_teleport then
        pcall(queue_on_teleport, execScript)
    else
        print("[GanKunZ Hub] Executor ini tidak support queue_on_teleport")
        SendNotif("Auto Execute", "Executor tidak support queue_on_teleport", 5)
    end
end

-- ============================================================
-- SERVER HOP
-- ============================================================

local function GetServerList(placeId)
    local url = ROBLOX_GAME_API .. tostring(placeId) .. "/servers/Public?sortOrder=Asc&limit=100"
    local ok, result = pcall(function()
        local response = game:HttpGet(url)
        return HttpService:JSONDecode(response)
    end)
    if ok and result and result.data then
        return result.data
    end
    return {}
end

local function HopServer()
    local servers = GetServerList(game.PlaceId)
    local currentJobId = game.JobId
    for i = #servers, 2, -1 do
        local j = math.random(i)
        servers[i], servers[j] = servers[j], servers[i]
    end
    for _, server in ipairs(servers) do
        if server.id and server.id ~= currentJobId then
            local ok = pcall(function()
                TeleportService:TeleportToPlaceInstance(game.PlaceId, server.id, LocalPlayer)
            end)
            if ok then return true end
        end
    end
    SendNotif("Server Hop", "Hop gagal, coba lagi...", 4)
    return false
end

-- ============================================================
-- TEAM / PERAN DETEKSI
-- ============================================================

local function GetPlayerTeam(player)
    local char = player.Character
    if not char then return nil end
    local teamTag = char:FindFirstChild("Team")
    if teamTag then
        local tag = teamTag:FindFirstChild("TeamTag")
        if tag then return tag.Value end
        return teamTag.Team and teamTag.Team.Name
    end
    return nil
end

local function IsSpectator(player)
    local team = GetPlayerTeam(player)
    return team == "Spectator"
end

local function CountSurvivors()
    local count = 0
    for _, p in pairs(Players:GetPlayers()) do
        if not IsSpectator(p) then
            count = count + 1
        end
    end
    return count
end

-- ============================================================
-- AUTO FARM LOOP UTAMA
-- ============================================================

local function TweenCharacterTo(targetCFrame, duration)
    local hrp = Character and Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    local tweenInfo = TweenInfo.new(duration or 1.5, Enum.EasingStyle.Linear)
    local tween = TweenService:Create(hrp, tweenInfo, {CFrame = targetCFrame})
    tween:Play()
    return tween
end

local function TryExitGate()
    local hrp = Character and Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    local fromPos = hrp.Position

    local ws = workspace
    local leftGate   = ws:FindFirstChild("LeftGate")
    local rightGate  = ws:FindFirstChild("RightGate")
    local finishLine = ws:FindFirstChild("Finishline") or ws:FindFirstChild("Fininshline")

    local candidates = {}
    if leftGate   then table.insert(candidates, leftGate)   end
    if rightGate  then table.insert(candidates, rightGate)  end
    if finishLine then table.insert(candidates, finishLine) end
    if #candidates == 0 then return end

    local function GetGateExitPos(gate)
        if gate:IsA("Model") then
            local box = gate:FindFirstChild("Box")
            if box then return box.CFrame end
            return gate:GetPivot()
        end
        return gate.CFrame
    end

    local bestGate, bestDist = nil, math.huge
    for _, gate in ipairs(candidates) do
        local gpos = GetGateExitPos(gate).Position
        local dist = (gpos - fromPos).Magnitude
        if dist < bestDist then
            bestDist = dist
            bestGate = gate
        end
    end
    if not bestGate then return end

    local exitCFrame = GetGateExitPos(bestGate)
    local tween = TweenCharacterTo(exitCFrame, 2)
    if tween then
        tween.Completed:Connect(function()
            SendNotif("Auto Farm", "Successfully exit gate!", 3)
        end)
    end
end

local function ServerHopLoop()
    local function IsMidMatch()
        return workspace:FindFirstChild("Map") ~= nil
    end

    if IsMidMatch() then
        SendNotif("Auto Farm", "Server sedang mid-match, hop dalam 5 detik...", 5)
        task.wait(5)
        HopServer()
        return
    end

    local playerCount = #Players:GetPlayers()
    local MIN_PLAYERS = 4
    if playerCount < MIN_PLAYERS then
        SendNotif("Auto Farm", "Player kurang (" .. playerCount .. "), hop...", 4)
        task.wait(3)
        HopServer()
        return
    else
        SendNotif("Auto Farm", "Player cukup, melanjutkan farm...", 3)
    end

    task.wait(2)
    local myTeam = GetPlayerTeam(LocalPlayer)
    if myTeam == "Killer" then
        SendNotif("Auto Farm", "Kamu dapat role Killer, hop...", 4)
        task.wait(2)
        HopServer()
        return
    end

    task.spawn(function()
        while _G.AutoFarmEnabled do
            task.wait(0.5)
            local currentJobId = game.JobId
            TryExitGate()
            task.wait(1)
            if game.JobId ~= currentJobId then break end
            myTeam = GetPlayerTeam(LocalPlayer)
            if myTeam == "Spectator" then
                task.wait(3)
                break
            end
        end
    end)
end

local function StartAutoFarm()
    if not _G.AutoFarmEnabled then return end
    task.spawn(function()
        while _G.AutoFarmEnabled do
            local ok, err = pcall(ServerHopLoop)
            if not ok then
                warn("[GanKunZ Hub AutoFarm Error]", err)
            end
            task.wait(5)
        end
    end)
end

-- ============================================================
-- WEBHOOK DISCORD
-- ============================================================

local function GetPlayerStat(player, statName)
    local ok, val = pcall(function()
        return player:GetAttribute(statName)
    end)
    if ok and val ~= nil then return tostring(val) end
    return "N/A"
end

local function SendWebhook(webhookURL)
    if not webhookURL or webhookURL == "" then return end

    local player   = LocalPlayer
    local name     = player.Name
    local display  = player.DisplayName
    local level    = GetPlayerStat(player, "Level")
    local expTotal = GetPlayerStat(player, "EXP")
    local expRound = GetPlayerStat(player, "ExpinRound")
    local money    = GetPlayerStat(player, "MoneyinRound")
    local gears    = GetPlayerStat(player, "Gears")
    local screws   = GetPlayerStat(player, "Screws")
    local jobId    = game.JobId
    local timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ")

    local content = table.concat({
        "**Server:** `" .. jobId .. "`",
        "\n——————————————\n",
        "• **Player:** " .. name,
        "• **Display Name:** " .. display,
        "• **Level:** " .. level,
        "• **EXP Total:** " .. expTotal,
        "• **EXP Round:** " .. expRound,
        "• **Money Round:** " .. money,
        "• **Gears:** " .. gears,
        "• **Screws:** " .. screws,
    }, "\n")

    local payload = HttpService:JSONEncode({
        username = "GanKunZ Hub • Auto Farm",
        content  = content,
        embeds   = {{
            title       = "[ Violence District Farm ] - Round Completed",
            description = content,
            color       = 7864319,  -- purple #77FFFF → 7864319 (ungu GanKunZ)
            timestamp   = timestamp,
            footer = {
                text = "GanKunZ Hub v" .. CURRENT_VERSION .. " | Creator: GanKunZ Hub"
            }
        }}
    })

    local function doRequest()
        local headers = { ["Content-Type"] = "application/json" }
        if syn and syn.request then
            syn.request({ Url = webhookURL, Method = "POST", Headers = headers, Body = payload })
        elseif http and http.request then
            http.request({ Url = webhookURL, Method = "POST", Headers = headers, Body = payload })
        elseif request then
            request({ Url = webhookURL, Method = "POST", Headers = headers, Body = payload })
        end
    end
    pcall(doRequest)
end

-- ============================================================
-- STATUS LOOP
-- ============================================================

local function StartStatusLoop()
    task.spawn(function()
        while true do
            task.wait(1)
            local currentName = "None"
            if _G.CurrentLoaded then
                currentName = (_G.CurrentLoaded:match("([^/\\]+)$") or _G.CurrentLoaded):gsub("%.json$", "")
            end
            local autoloadName = "None"
            if isfile(AutoloadConfig) then
                local aOk, aContent = SafeReadFile(AutoloadConfig)
                if aOk and aContent then
                    autoloadName = (aContent:match("([^/\\]+)$") or aContent):gsub("%.json$", "")
                end
            end
            UpdateStatus("Current: " .. currentName .. " | Autoload: " .. autoloadName)
        end
    end)
end

-- ============================================================
-- AUTOLOAD ON STARTUP
-- ============================================================

local function CheckAndAutoload()
    task.spawn(function()
        task.wait(2)
        if isfile(AutoloadConfig) then
            local ok, path = SafeReadFile(AutoloadConfig)
            if ok and path and path ~= "" then
                _G.AutoloadConfig = path
                task.wait(1)
                LoadConfigFromFile(path)
                task.wait(0.5)
                if _G.AutoFarmEnabled then
                    StartAutoFarm()
                end
            end
        end
    end)
end

-- ============================================================
-- GUI - GANKÜNZ HUB (FALLBACK VANILLA GUI)
-- Struktur mirip Meng Hub tapi tema GanKunZ
-- ============================================================

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "GanKunZHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.IgnoreGuiInset = true
ScreenGui.Parent = PlayerGui

-- ── SHADOW LAYER ──────────────────────────────────────────
local Shadow = Instance.new("Frame")
Shadow.Name = "Shadow"
Shadow.Size = UDim2.new(0, 434, 0, 574)
Shadow.Position = UDim2.new(0.5, -213, 0.5, -283)
Shadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Shadow.BackgroundTransparency = 0.55
Shadow.BorderSizePixel = 0
Shadow.ZIndex = 0
Shadow.Parent = ScreenGui
Instance.new("UICorner", Shadow).CornerRadius = UDim.new(0, 14)

-- ── MAIN FRAME ────────────────────────────────────────────
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 430, 0, 570)
MainFrame.Position = UDim2.new(0.5, -215, 0.5, -285)
MainFrame.BackgroundColor3 = THEME.BG
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.ZIndex = 1
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = MainFrame

-- Border stroke
local MainStroke = Instance.new("UIStroke")
MainStroke.Color = THEME.BORDER
MainStroke.Thickness = 1.5
MainStroke.Parent = MainFrame

-- ── TITLE BAR ─────────────────────────────────────────────
local TitleBar = Instance.new("Frame")
TitleBar.Name = "TitleBar"
TitleBar.Size = UDim2.new(1, 0, 0, 48)
TitleBar.BackgroundColor3 = THEME.BG2
TitleBar.BorderSizePixel = 0
TitleBar.ZIndex = 2
TitleBar.Parent = MainFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 12)
TitleCorner.Parent = TitleBar

-- Title bar bottom cover (so bottom corners aren't rounded)
local TitleCover = Instance.new("Frame")
TitleCover.Size = UDim2.new(1, 0, 0, 14)
TitleCover.Position = UDim2.new(0, 0, 1, -14)
TitleCover.BackgroundColor3 = THEME.BG2
TitleCover.BorderSizePixel = 0
TitleCover.ZIndex = 2
TitleCover.Parent = TitleBar

-- Icon (unicode diamond/hub symbol)
local IconLabel = Instance.new("TextLabel")
IconLabel.Name = "Icon"
IconLabel.Size = UDim2.new(0, 36, 0, 36)
IconLabel.Position = UDim2.new(0, 10, 0.5, -18)
IconLabel.BackgroundColor3 = THEME.ACCENT
IconLabel.BorderSizePixel = 0
IconLabel.Text = "⚡"
IconLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
IconLabel.TextSize = 18
IconLabel.Font = Enum.Font.GothamBold
IconLabel.TextXAlignment = Enum.TextXAlignment.Center
IconLabel.ZIndex = 3
IconLabel.Parent = TitleBar
Instance.new("UICorner", IconLabel).CornerRadius = UDim.new(0, 8)

-- Title text
local TitleLabel = Instance.new("TextLabel")
TitleLabel.Name = "Title"
TitleLabel.Size = UDim2.new(1, -130, 1, 0)
TitleLabel.Position = UDim2.new(0, 54, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "GanKunZ Hub"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextSize = 16
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.ZIndex = 3
TitleLabel.Parent = TitleBar

local SubTitleLabel = Instance.new("TextLabel")
SubTitleLabel.Name = "SubTitle"
SubTitleLabel.Size = UDim2.new(1, -130, 0, 16)
SubTitleLabel.Position = UDim2.new(0, 54, 0, 26)
SubTitleLabel.BackgroundTransparency = 1
SubTitleLabel.Text = "Violence District Auto Farm  •  v" .. CURRENT_VERSION
SubTitleLabel.TextColor3 = THEME.TEXT_DIM
SubTitleLabel.TextSize = 11
SubTitleLabel.Font = Enum.Font.Gotham
SubTitleLabel.TextXAlignment = Enum.TextXAlignment.Left
SubTitleLabel.ZIndex = 3
SubTitleLabel.Parent = TitleBar

-- Close Button
local CloseBtn = Instance.new("TextButton")
CloseBtn.Name = "CloseBtn"
CloseBtn.Size = UDim2.new(0, 28, 0, 28)
CloseBtn.Position = UDim2.new(1, -38, 0.5, -14)
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
CloseBtn.BorderSizePixel = 0
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextSize = 13
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.ZIndex = 4
CloseBtn.Parent = TitleBar
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 6)

CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Minimize Button
local MinBtn = Instance.new("TextButton")
MinBtn.Name = "MinBtn"
MinBtn.Size = UDim2.new(0, 28, 0, 28)
MinBtn.Position = UDim2.new(1, -70, 0.5, -14)
MinBtn.BackgroundColor3 = Color3.fromRGB(200, 160, 40)
MinBtn.BorderSizePixel = 0
MinBtn.Text = "—"
MinBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MinBtn.TextSize = 13
MinBtn.Font = Enum.Font.GothamBold
MinBtn.ZIndex = 4
MinBtn.Parent = TitleBar
Instance.new("UICorner", MinBtn).CornerRadius = UDim.new(0, 6)

local minimized = false
local ContentHolder -- defined below
MinBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    if ContentHolder then
        ContentHolder.Visible = not minimized
    end
    MainFrame.Size = minimized and UDim2.new(0, 430, 0, 48) or UDim2.new(0, 430, 0, 570)
    Shadow.Size = minimized and UDim2.new(0, 434, 0, 52) or UDim2.new(0, 434, 0, 574)
end)

-- ── TAB BAR ───────────────────────────────────────────────
local TabBar = Instance.new("Frame")
TabBar.Name = "TabBar"
TabBar.Size = UDim2.new(1, 0, 0, 36)
TabBar.Position = UDim2.new(0, 0, 0, 48)
TabBar.BackgroundColor3 = THEME.BG2
TabBar.BorderSizePixel = 0
TabBar.ZIndex = 2
TabBar.Parent = MainFrame

local TabLayout = Instance.new("UIListLayout")
TabLayout.FillDirection = Enum.FillDirection.Horizontal
TabLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
TabLayout.VerticalAlignment = Enum.VerticalAlignment.Center
TabLayout.Padding = UDim.new(0, 2)
TabLayout.Parent = TabBar

local TabPadding = Instance.new("UIPadding")
TabPadding.PaddingLeft = UDim.new(0, 6)
TabPadding.Parent = TabBar

-- ── CONTENT HOLDER ────────────────────────────────────────
ContentHolder = Instance.new("Frame")
ContentHolder.Name = "ContentHolder"
ContentHolder.Size = UDim2.new(1, 0, 1, -84)
ContentHolder.Position = UDim2.new(0, 0, 0, 84)
ContentHolder.BackgroundTransparency = 1
ContentHolder.ClipsDescendants = true
ContentHolder.ZIndex = 2
ContentHolder.Parent = MainFrame

-- ── SCROLL FRAME ─────────────────────────────────────────
local ScrollFrame = Instance.new("ScrollingFrame")
ScrollFrame.Name = "Content"
ScrollFrame.Size = UDim2.new(1, -8, 1, -8)
ScrollFrame.Position = UDim2.new(0, 4, 0, 4)
ScrollFrame.BackgroundTransparency = 1
ScrollFrame.ScrollBarThickness = 3
ScrollFrame.ScrollBarImageColor3 = THEME.SCROLLBAR
ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
ScrollFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
ScrollFrame.BorderSizePixel = 0
ScrollFrame.ZIndex = 2
ScrollFrame.Parent = ContentHolder

local ListLayout = Instance.new("UIListLayout")
ListLayout.Padding = UDim.new(0, 5)
ListLayout.Parent = ScrollFrame

local ScrollPadding = Instance.new("UIPadding")
ScrollPadding.PaddingLeft  = UDim.new(0, 8)
ScrollPadding.PaddingRight = UDim.new(0, 10)
ScrollPadding.PaddingTop   = UDim.new(0, 6)
ScrollPadding.PaddingBottom = UDim.new(0, 6)
ScrollPadding.Parent = ScrollFrame

-- ── TAB SYSTEM ────────────────────────────────────────────
local tabs = {}
local activeTab = nil

local tabPages = {} -- { [tabName] = Frame page }

local function CreateTabPage()
    local page = Instance.new("ScrollingFrame")
    page.Name = "Page"
    page.Size = UDim2.new(1, -8, 1, -8)
    page.Position = UDim2.new(0, 4, 0, 4)
    page.BackgroundTransparency = 1
    page.ScrollBarThickness = 3
    page.ScrollBarImageColor3 = THEME.SCROLLBAR
    page.CanvasSize = UDim2.new(0, 0, 0, 0)
    page.AutomaticCanvasSize = Enum.AutomaticSize.Y
    page.BorderSizePixel = 0
    page.Visible = false
    page.ZIndex = 2
    page.Parent = ContentHolder

    local pl = Instance.new("UIListLayout")
    pl.Padding = UDim.new(0, 5)
    pl.Parent = page

    local pp = Instance.new("UIPadding")
    pp.PaddingLeft   = UDim.new(0, 8)
    pp.PaddingRight  = UDim.new(0, 10)
    pp.PaddingTop    = UDim.new(0, 6)
    pp.PaddingBottom = UDim.new(0, 6)
    pp.Parent = page

    return page
end

local function AddTab(name, icon)
    local page = CreateTabPage()
    tabPages[name] = page

    local btn = Instance.new("TextButton")
    btn.Name = name
    btn.Size = UDim2.new(0, 0, 1, -8)
    btn.AutomaticSize = Enum.AutomaticSize.X
    btn.BackgroundColor3 = THEME.BG2
    btn.BorderSizePixel = 0
    btn.Text = (icon or "") .. " " .. name
    btn.TextColor3 = THEME.TEXT_DIM
    btn.TextSize = 12
    btn.Font = Enum.Font.GothamBold
    btn.ZIndex = 3
    btn.Parent = TabBar

    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 6)
    btnCorner.Parent = btn

    local btnPad = Instance.new("UIPadding")
    btnPad.PaddingLeft  = UDim.new(0, 10)
    btnPad.PaddingRight = UDim.new(0, 10)
    btnPad.Parent = btn

    -- Active indicator bar
    local indicator = Instance.new("Frame")
    indicator.Name = "Indicator"
    indicator.Size = UDim2.new(1, -16, 0, 2)
    indicator.Position = UDim2.new(0, 8, 1, -4)
    indicator.BackgroundColor3 = THEME.ACCENT
    indicator.BorderSizePixel = 0
    indicator.Visible = false
    indicator.ZIndex = 4
    indicator.Parent = btn
    Instance.new("UICorner", indicator).CornerRadius = UDim.new(1, 0)

    btn.MouseButton1Click:Connect(function()
        -- Deactivate all
        for tName, tPage in pairs(tabPages) do
            tPage.Visible = false
            local tBtn = TabBar:FindFirstChild(tName)
            if tBtn then
                tBtn.TextColor3 = THEME.TEXT_DIM
                tBtn.BackgroundColor3 = THEME.BG2
                local ind = tBtn:FindFirstChild("Indicator")
                if ind then ind.Visible = false end
            end
        end
        -- Activate this tab
        page.Visible = true
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.BackgroundColor3 = THEME.ACCENT2
        indicator.Visible = true
        activeTab = name
    end)

    tabs[name] = { btn = btn, page = page }
    return page
end

-- Helper to get parent (tab page or main scroll)
local currentPage = ScrollFrame  -- fallback

local function SetCurrentPage(page)
    currentPage = page
end

-- ── GUI ELEMENT HELPERS ───────────────────────────────────

local function MakeSectionLabel(text, parent)
    local p = parent or currentPage
    local outer = Instance.new("Frame")
    outer.Name = "Section_" .. text
    outer.Size = UDim2.new(1, 0, 0, 30)
    outer.BackgroundColor3 = THEME.SECTION_BG
    outer.BorderSizePixel = 0
    outer.ZIndex = 2
    outer.Parent = p
    Instance.new("UICorner", outer).CornerRadius = UDim.new(0, 7)

    local stroke = Instance.new("UIStroke")
    stroke.Color = THEME.ACCENT
    stroke.Thickness = 1
    stroke.Parent = outer

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, -12, 1, 0)
    lbl.Position = UDim2.new(0, 10, 0, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = "◈  " .. text
    lbl.TextColor3 = THEME.SECTION_TXT
    lbl.TextSize = 12
    lbl.Font = Enum.Font.GothamBold
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.ZIndex = 3
    lbl.Parent = outer
    return outer
end

local function MakeLabel(text, color, parent)
    local p = parent or currentPage
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, 0, 0, 0)
    lbl.AutomaticSize = Enum.AutomaticSize.Y
    lbl.BackgroundTransparency = 1
    lbl.Text = text
    lbl.TextColor3 = color or THEME.TEXT
    lbl.TextSize = 12
    lbl.Font = Enum.Font.Gotham
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.TextWrapped = true
    lbl.ZIndex = 2
    lbl.Parent = p
    return lbl
end

local function MakeToggle(text, default, callback, parent)
    local p = parent or currentPage
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 0, 38)
    frame.BackgroundColor3 = THEME.BG2
    frame.BorderSizePixel = 0
    frame.ZIndex = 2
    frame.Parent = p
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 7)

    local stroke = Instance.new("UIStroke")
    stroke.Color = THEME.BORDER
    stroke.Thickness = 1
    stroke.Parent = frame

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.75, 0, 1, 0)
    label.Position = UDim2.new(0, 12, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = THEME.TEXT
    label.TextSize = 12
    label.Font = Enum.Font.Gotham
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.ZIndex = 3
    label.Parent = frame

    local state = default or false

    -- Toggle track
    local track = Instance.new("Frame")
    track.Size = UDim2.new(0, 44, 0, 22)
    track.Position = UDim2.new(1, -54, 0.5, -11)
    track.BackgroundColor3 = state and THEME.TOGGLE_ON or THEME.TOGGLE_OFF
    track.BorderSizePixel = 0
    track.ZIndex = 3
    track.Parent = frame
    Instance.new("UICorner", track).CornerRadius = UDim.new(1, 0)

    -- Knob
    local knob = Instance.new("Frame")
    knob.Size = UDim2.new(0, 16, 0, 16)
    knob.Position = state and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)
    knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    knob.BorderSizePixel = 0
    knob.ZIndex = 4
    knob.Parent = track
    Instance.new("UICorner", knob).CornerRadius = UDim.new(1, 0)

    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 1, 0)
    btn.BackgroundTransparency = 1
    btn.Text = ""
    btn.ZIndex = 5
    btn.Parent = frame

    local function UpdateVisual()
        local ti = TweenInfo.new(0.15, Enum.EasingStyle.Quad)
        TweenService:Create(track, ti, {BackgroundColor3 = state and THEME.TOGGLE_ON or THEME.TOGGLE_OFF}):Play()
        TweenService:Create(knob, ti, {Position = state and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)}):Play()
    end

    btn.MouseButton1Click:Connect(function()
        state = not state
        UpdateVisual()
        if callback then callback(state) end
    end)

    return frame, function() return state end
end

local function MakeButton(text, callback, parent)
    local p = parent or currentPage
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 34)
    btn.BackgroundColor3 = THEME.BTN
    btn.BorderSizePixel = 0
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 12
    btn.Font = Enum.Font.GothamBold
    btn.ZIndex = 2
    btn.Parent = p
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 7)

    -- Hover effect
    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.1), {BackgroundColor3 = THEME.BTN_HOVER}):Play()
    end)
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.1), {BackgroundColor3 = THEME.BTN}):Play()
    end)

    btn.MouseButton1Click:Connect(function()
        if callback then
            -- Quick flash
            btn.BackgroundColor3 = THEME.ACCENT
            task.delay(0.12, function()
                btn.BackgroundColor3 = THEME.BTN
            end)
            callback()
        end
    end)
    return btn
end

local function MakeInput(labelText, placeholder, callback, parent)
    local p = parent or currentPage
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 0, 62)
    frame.BackgroundColor3 = THEME.BG2
    frame.BorderSizePixel = 0
    frame.ZIndex = 2
    frame.Parent = p
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 7)

    local stroke = Instance.new("UIStroke")
    stroke.Color = THEME.BORDER
    stroke.Thickness = 1
    stroke.Parent = frame

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, -12, 0, 20)
    lbl.Position = UDim2.new(0, 10, 0, 3)
    lbl.BackgroundTransparency = 1
    lbl.Text = labelText
    lbl.TextColor3 = THEME.SECTION_TXT
    lbl.TextSize = 11
    lbl.Font = Enum.Font.GothamBold
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.ZIndex = 3
    lbl.Parent = frame

    local box = Instance.new("TextBox")
    box.Size = UDim2.new(1, -16, 0, 28)
    box.Position = UDim2.new(0, 8, 0, 28)
    box.BackgroundColor3 = THEME.BG3
    box.BorderSizePixel = 0
    box.PlaceholderText = placeholder or ""
    box.PlaceholderColor3 = THEME.TEXT_DIM
    box.Text = ""
    box.TextColor3 = THEME.TEXT
    box.TextSize = 12
    box.Font = Enum.Font.Gotham
    box.ClearTextOnFocus = false
    box.ZIndex = 3
    box.Parent = frame
    Instance.new("UICorner", box).CornerRadius = UDim.new(0, 5)

    -- Focus stroke highlight
    box.Focused:Connect(function()
        stroke.Color = THEME.ACCENT
    end)
    box.FocusLost:Connect(function()
        stroke.Color = THEME.BORDER
        if callback then callback(box.Text) end
    end)

    return frame, box
end

-- ── STATUS INFO CARD ─────────────────────────────────────
local function MakeInfoCard(text, parent)
    local p = parent or currentPage
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 0, 38)
    frame.BackgroundColor3 = Color3.fromRGB(18, 22, 38)
    frame.BorderSizePixel = 0
    frame.ZIndex = 2
    frame.Parent = p
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 7)

    local stroke = Instance.new("UIStroke")
    stroke.Color = THEME.ACCENT
    stroke.Thickness = 1
    stroke.Parent = frame

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, -12, 1, 0)
    lbl.Position = UDim2.new(0, 10, 0, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = text
    lbl.TextColor3 = THEME.STATUS_OK
    lbl.TextSize = 11
    lbl.Font = Enum.Font.Gotham
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.TextWrapped = true
    lbl.ZIndex = 3
    lbl.Parent = frame

    -- Expose update
    local ref = {}
    ref.SetContent = function(_, t)
        lbl.Text = t
    end
    UIRefs.StatusLabel = ref
    return frame
end

-- ============================================================
-- BUILD GUI TABS
-- ============================================================

-- ── TAB: AUTO FARM ────────────────────────────────────────
local AutoFarmPage = AddTab("Auto Farm", "⚡")
SetCurrentPage(AutoFarmPage)

MakeSectionLabel("Auto Farm Features", AutoFarmPage)

MakeLabel(
    "📌 README:\n1. Aktifkan Auto Farm\n2. Aktifkan Auto Execute\n3. Aktifkan Disable Killer Chance di game\n4. Save Config lalu Set Autoload\n5. Enjoy!",
    THEME.TEXT_INFO,
    AutoFarmPage
)

MakeToggle("Enable Auto Farm", false, function(state)
    _G.AutoFarmEnabled = state
    if _G.ConfigData then _G.ConfigData.AutoFarmEnabled = state end
    if state then
        StartAutoFarm()
        SendNotif("Auto Farm", "Auto Farm diaktifkan!", 3)
    else
        SendNotif("Auto Farm", "Auto Farm dinonaktifkan.", 3)
    end
end, AutoFarmPage)

MakeToggle("Auto Execute (Queue on Teleport)", false, function(state)
    SetupAutoExecute(state)
    if state then
        SendNotif("Auto Execute", "Auto Execute aktif!", 3)
    end
end, AutoFarmPage)

MakeButton("🌐 Manual Server Hop", function()
    SendNotif("Server Hop", "Mencari server lain...", 3)
    HopServer()
end, AutoFarmPage)

-- ── TAB: WEBHOOK ──────────────────────────────────────────
local WebhookPage = AddTab("Webhook", "🔗")
SetCurrentPage(WebhookPage)

MakeSectionLabel("Webhook Discord", WebhookPage)

MakeLabel("Kirim stats otomatis ke Discord setiap round selesai.", THEME.TEXT_DIM, WebhookPage)

local _, webhookBox = MakeInput("Discord Webhook URL", "https://discord.com/api/webhooks/...", function(val)
    if _G.ConfigData then _G.ConfigData.WebhookURL = val end
end, WebhookPage)

UIRefs.WebhookURLInput = {
    GetValue = function() return webhookBox.Text end,
    SetValue = function(_, v) webhookBox.Text = v or "" end,
}

local webhookEnabled = false
MakeToggle("Enable Webhook", false, function(state)
    webhookEnabled = state
    if state then
        SendNotif("Webhook", "Webhook aktif!", 3)
    end
end, WebhookPage)

MakeButton("📤 Test Webhook Sekarang", function()
    if webhookEnabled then
        SendWebhook(webhookBox.Text)
        SendNotif("Webhook", "Test webhook dikirim!", 3)
    else
        SendNotif("Webhook", "Aktifkan Enable Webhook dulu!", 3)
    end
end, WebhookPage)

-- ── TAB: CONFIGURATION ────────────────────────────────────
local ConfigPage = AddTab("Config", "⚙️")
SetCurrentPage(ConfigPage)

MakeSectionLabel("Config Manager", ConfigPage)

-- Status info card
MakeInfoCard("Current: None  |  Autoload: None", ConfigPage)

local _, configNameBox = MakeInput("Nama Config", "Masukkan nama config...", function(val)
    _G._configNameInput = val
end, ConfigPage)

local _, externalJSONBox = MakeInput("External Config JSON", "Paste raw JSON config disini...", function(val)
    _G.ExternalJSONInput = val
end, ConfigPage)

MakeButton("💾 Save Config", function()
    local name = (_G._configNameInput or ""):gsub("^%s+", ""):gsub("%s+$", "")
    if name == "" and _G.SelectedConfig then name = _G.SelectedConfig end
    if _G.ConfigData then _G.ConfigData.WebhookURL = webhookBox.Text end
    SaveConfig(name)
end, ConfigPage)

MakeButton("📂 Load Config", function()
    local name = _G.SelectedConfig or (_G._configNameInput or ""):gsub("^%s+",""):gsub("%s+$","")
    if name == "" then SendNotif("Config", "Isi nama config dulu!", 3) return end
    LoadConfigFromFile(ConfigFolder .. name .. ".json")
end, ConfigPage)

MakeButton("📋 Load External JSON", function()
    _G.ExternalJSONInput = externalJSONBox.Text
    LoadFromExternalJSON()
end, ConfigPage)

MakeButton("📤 Export Config (Copy ke Clipboard)", function()
    local name = (_G._configNameInput or ""):gsub("^%s+",""):gsub("%s+$","")
    if name ~= "" then _G.SelectedConfig = name end
    ExportConfig(_G.SelectedConfig)
end, ConfigPage)

MakeButton("⭐ Set Autoload", function()
    local name = (_G._configNameInput or ""):gsub("^%s+",""):gsub("%s+$","")
    if name ~= "" then _G.SelectedConfig = name end
    SetAutoload(_G.SelectedConfig)
end, ConfigPage)

MakeButton("🧹 Clear Autoload", function()
    ClearAutoload()
end, ConfigPage)

MakeButton("❌ Delete Config", function()
    local name = (_G._configNameInput or ""):gsub("^%s+",""):gsub("%s+$","")
    if name ~= "" then _G.SelectedConfig = name end
    DeleteConfig(_G.SelectedConfig)
end, ConfigPage)

MakeButton("🔄 Refresh Config List", function()
    local list = GetConfigList()
    if #list == 0 then
        SendNotif("Config", "Tidak ada config tersimpan.", 3)
    else
        SendNotif("Config", "Config: " .. table.concat(list, ", "), 5)
    end
end, ConfigPage)

MakeButton("🔁 Reset All ke Default", function()
    _G.ConfigData = {}
    _G.AutoFarmEnabled = false
    webhookBox.Text = ""
    configNameBox.Text = ""
    SendNotif("Config", "Semua direset ke default!", 3)
end, ConfigPage)

-- ── TAB: INFO ─────────────────────────────────────────────
local InfoPage = AddTab("Info", "📋")
SetCurrentPage(InfoPage)

MakeSectionLabel("About GanKunZ Hub", InfoPage)

MakeLabel(
    "🔷 Hub Name : GanKunZ Hub\n👤 Creator  : GanKunZ Hub\n📦 Version  : v" .. CURRENT_VERSION .. "\n🎮 Game     : Violence District\n\n⚡ Fitur:\n• Auto Farm Exit Gate\n• Config Manager (Save/Load/Export)\n• Autoload Config\n• Server Hop Otomatis\n• Auto Execute via queue_on_teleport\n• Discord Webhook Stats",
    THEME.TEXT,
    InfoPage
)

MakeSectionLabel("Server Info", InfoPage)

MakeLabel(
    "🌐 Job ID: " .. (game.JobId:sub(1, 16) .. "...") .. "\n👥 Players: " .. #Players:GetPlayers() .. "/" .. Players.MaxPlayers,
    THEME.TEXT_DIM,
    InfoPage
)

-- ── ACTIVATE FIRST TAB ────────────────────────────────────
-- Simulate click on first tab
do
    local firstTab = TabBar:FindFirstChildWhichIsA("TextButton")
    if firstTab then firstTab:Activate() end
    -- Manual activate Auto Farm tab
    tabPages["Auto Farm"].Visible = true
    local afBtn = TabBar:FindFirstChild("Auto Farm")
    if afBtn then
        afBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        afBtn.BackgroundColor3 = THEME.ACCENT2
        local ind = afBtn:FindFirstChild("Indicator")
        if ind then ind.Visible = true end
    end
end

-- ============================================================
-- STARTUP
-- ============================================================
SafeMakeFolder(mainFolderName)
SafeMakeFolder(ConfigFolder)

StartStatusLoop()
CheckAndAutoload()

task.delay(1, function()
    SendNotif("GanKunZ Hub", "Script berhasil diload! Violence District Auto Farm v" .. CURRENT_VERSION .. " | Creator: GanKunZ Hub", 6)
end)

print("[GanKunZ Hub] Violence District Auto Farm loaded! Version:", CURRENT_VERSION, "| Creator: GanKunZ Hub")
