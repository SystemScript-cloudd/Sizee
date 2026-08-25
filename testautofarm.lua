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
local UserInputService  = game:GetService("UserInputService")

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

local AUTO_EXEC_URL   = "https://raw.githubusercontent.com/GrexXMeng/Mengs/refs/heads/main/AutoFarmVD.lua"
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
    BG          = Color3.fromRGB(13, 14, 22),
    BG2         = Color3.fromRGB(20, 22, 35),
    BG3         = Color3.fromRGB(28, 30, 48),
    ACCENT      = Color3.fromRGB(120, 80, 220),
    ACCENT2     = Color3.fromRGB(80, 50, 180),
    SECTION_BG  = Color3.fromRGB(30, 25, 55),
    SECTION_TXT = Color3.fromRGB(180, 140, 255),
    TEXT        = Color3.fromRGB(220, 218, 240),
    TEXT_DIM    = Color3.fromRGB(140, 135, 170),
    TEXT_INFO   = Color3.fromRGB(255, 210, 100),
    TOGGLE_ON   = Color3.fromRGB(90, 200, 120),
    TOGGLE_OFF  = Color3.fromRGB(60, 58, 90),
    BTN         = Color3.fromRGB(75, 50, 160),
    BTN_HOVER   = Color3.fromRGB(100, 70, 200),
    SCROLLBAR   = Color3.fromRGB(120, 80, 220),
    BORDER      = Color3.fromRGB(70, 55, 130),
    STATUS_OK   = Color3.fromRGB(100, 230, 150),
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
            color       = 7864319,
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
-- GUI - GANKÜNZ HUB
-- REBUILD: Rounded corners + UIS drag (bisa digeser smooth)
-- ============================================================

-- Hapus instance lama jika ada (re-execute safety)
if PlayerGui:FindFirstChild("GanKunZHub") then
    PlayerGui:FindFirstChild("GanKunZHub"):Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "GanKunZHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.IgnoreGuiInset = true
ScreenGui.DisplayOrder = 999
ScreenGui.Parent = PlayerGui

-- ── SHADOW (mengikuti MainFrame via update loop) ──────────
local Shadow = Instance.new("Frame")
Shadow.Name = "Shadow"
Shadow.Size = UDim2.new(0, 438, 0, 578)
Shadow.Position = UDim2.new(0, 0, 0, 0)  -- akan diupdate oleh drag
Shadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Shadow.BackgroundTransparency = 0.5
Shadow.BorderSizePixel = 0
Shadow.ZIndex = 0
Shadow.Parent = ScreenGui
-- Shadow corner harus sama dengan MainFrame
local ShadowCorner = Instance.new("UICorner")
ShadowCorner.CornerRadius = UDim.new(0, 20)
ShadowCorner.Parent = Shadow

-- ── MAIN FRAME ────────────────────────────────────────────
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 430, 0, 570)
-- Posisi awal tengah layar
MainFrame.Position = UDim2.new(0.5, -215, 0.5, -285)
MainFrame.BackgroundColor3 = THEME.BG
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
-- Draggable = false, kita pakai UIS manual
MainFrame.ZIndex = 1
MainFrame.Parent = ScreenGui

-- Corner radius besar = tampilan lebih "bulat" seperti Meng Hub
local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 20)
MainCorner.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = THEME.BORDER
MainStroke.Thickness = 1.5
MainStroke.Parent = MainFrame

-- ── DRAG SYSTEM via UserInputService ──────────────────────
-- Ini yang buat GUI bisa digeser kemana aja, smooth, tidak deprecated
do
    local dragging = false
    local dragStart = nil
    local startPos = nil

    -- Fungsi update posisi shadow mengikuti MainFrame
    local function UpdateShadowPos()
        local absPos = MainFrame.AbsolutePosition
        Shadow.Position = UDim2.new(
            0, absPos.X - 4,
            0, absPos.Y - 4
        )
    end

    -- Inisialisasi posisi shadow sekali
    task.defer(UpdateShadowPos)

    MainFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
            -- Hanya drag jika klik di area non-interaktif (title bar area atas)
            local relY = input.Position.Y - MainFrame.AbsolutePosition.Y
            if relY <= 50 then  -- 50px = area title bar
                dragging = true
                dragStart = input.Position
                startPos  = MainFrame.Position
                input.Changed:Connect(function()
                    if input.UserInputState == Enum.UserInputState.End then
                        dragging = false
                    end
                end)
            end
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if dragging and (
            input.UserInputType == Enum.UserInputType.MouseMovement or
            input.UserInputType == Enum.UserInputType.Touch
        ) then
            local delta = input.Position - dragStart
            local newPos = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )
            MainFrame.Position = newPos
            -- Shadow ikut bergerak
            UpdateShadowPos()
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
end

-- ── TITLE BAR ─────────────────────────────────────────────
local TitleBar = Instance.new("Frame")
TitleBar.Name = "TitleBar"
TitleBar.Size = UDim2.new(1, 0, 0, 52)
TitleBar.BackgroundColor3 = THEME.BG2
TitleBar.BorderSizePixel = 0
TitleBar.ZIndex = 2
TitleBar.Parent = MainFrame

-- Corner untuk title bar atas saja
local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 20)
TitleCorner.Parent = TitleBar

-- Cover bawah title bar (potong corner bawah)
local TitleCover = Instance.new("Frame")
TitleCover.Size = UDim2.new(1, 0, 0, 20)
TitleCover.Position = UDim2.new(0, 0, 1, -20)
TitleCover.BackgroundColor3 = THEME.BG2
TitleCover.BorderSizePixel = 0
TitleCover.ZIndex = 2
TitleCover.Parent = TitleBar

-- Accent line bawah title bar
local TitleAccentLine = Instance.new("Frame")
TitleAccentLine.Size = UDim2.new(1, -40, 0, 1)
TitleAccentLine.Position = UDim2.new(0, 20, 1, -1)
TitleAccentLine.BackgroundColor3 = THEME.ACCENT
TitleAccentLine.BackgroundTransparency = 0.6
TitleAccentLine.BorderSizePixel = 0
TitleAccentLine.ZIndex = 3
TitleAccentLine.Parent = TitleBar

-- Icon badge (bulat)
local IconBadge = Instance.new("Frame")
IconBadge.Name = "IconBadge"
IconBadge.Size = UDim2.new(0, 36, 0, 36)
IconBadge.Position = UDim2.new(0, 12, 0.5, -18)
IconBadge.BackgroundColor3 = THEME.ACCENT
IconBadge.BorderSizePixel = 0
IconBadge.ZIndex = 3
IconBadge.Parent = TitleBar
local IconBadgeCorner = Instance.new("UICorner")
IconBadgeCorner.CornerRadius = UDim.new(1, 0)  -- bulat sempurna
IconBadgeCorner.Parent = IconBadge

local IconLabel = Instance.new("TextLabel")
IconLabel.Size = UDim2.new(1, 0, 1, 0)
IconLabel.BackgroundTransparency = 1
IconLabel.Text = "⚡"
IconLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
IconLabel.TextSize = 18
IconLabel.Font = Enum.Font.GothamBold
IconLabel.ZIndex = 4
IconLabel.Parent = IconBadge

-- Hub name
local TitleLabel = Instance.new("TextLabel")
TitleLabel.Name = "Title"
TitleLabel.Size = UDim2.new(1, -140, 0, 22)
TitleLabel.Position = UDim2.new(0, 58, 0, 8)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "GanKunZ Hub"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextSize = 15
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.ZIndex = 3
TitleLabel.Parent = TitleBar

-- Sub title: game tag (kanan atas, mirip Meng Hub)
local GameTagFrame = Instance.new("Frame")
GameTagFrame.Size = UDim2.new(0, 0, 0, 24)
GameTagFrame.Position = UDim2.new(1, -74, 0, 14)
GameTagFrame.AutomaticSize = Enum.AutomaticSize.X
GameTagFrame.BackgroundColor3 = THEME.ACCENT2
GameTagFrame.BorderSizePixel = 0
GameTagFrame.ZIndex = 4
GameTagFrame.Parent = TitleBar
local GameTagCorner = Instance.new("UICorner")
GameTagCorner.CornerRadius = UDim.new(0, 6)
GameTagCorner.Parent = GameTagFrame
local GameTagPad = Instance.new("UIPadding")
GameTagPad.PaddingLeft  = UDim.new(0, 8)
GameTagPad.PaddingRight = UDim.new(0, 8)
GameTagPad.Parent = GameTagFrame
local GameTagLabel = Instance.new("TextLabel")
GameTagLabel.Size = UDim2.new(0, 0, 1, 0)
GameTagLabel.AutomaticSize = Enum.AutomaticSize.X
GameTagLabel.BackgroundTransparency = 1
GameTagLabel.Text = "VD | Auto Farm"
GameTagLabel.TextColor3 = Color3.fromRGB(220, 210, 255)
GameTagLabel.TextSize = 11
GameTagLabel.Font = Enum.Font.GothamBold
GameTagLabel.ZIndex = 5
GameTagLabel.Parent = GameTagFrame

-- Subtitle di bawah hub name
local SubTitleLabel = Instance.new("TextLabel")
SubTitleLabel.Name = "SubTitle"
SubTitleLabel.Size = UDim2.new(1, -140, 0, 14)
SubTitleLabel.Position = UDim2.new(0, 58, 0, 30)
SubTitleLabel.BackgroundTransparency = 1
SubTitleLabel.Text = "Peacefull Community  •  v" .. CURRENT_VERSION
SubTitleLabel.TextColor3 = THEME.TEXT_DIM
SubTitleLabel.TextSize = 11
SubTitleLabel.Font = Enum.Font.Gotham
SubTitleLabel.TextXAlignment = Enum.TextXAlignment.Left
SubTitleLabel.ZIndex = 3
SubTitleLabel.Parent = TitleBar

-- Close Button (bulat)
local CloseBtn = Instance.new("TextButton")
CloseBtn.Name = "CloseBtn"
CloseBtn.Size = UDim2.new(0, 26, 0, 26)
CloseBtn.Position = UDim2.new(1, -40, 0, 13)
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
CloseBtn.BorderSizePixel = 0
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextSize = 12
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.ZIndex = 5
CloseBtn.Parent = TitleBar
local CloseBtnCorner = Instance.new("UICorner")
CloseBtnCorner.CornerRadius = UDim.new(1, 0)
CloseBtnCorner.Parent = CloseBtn

CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Minimize Button (bulat)
local MinBtn = Instance.new("TextButton")
MinBtn.Name = "MinBtn"
MinBtn.Size = UDim2.new(0, 26, 0, 26)
MinBtn.Position = UDim2.new(1, -70, 0, 13)
MinBtn.BackgroundColor3 = Color3.fromRGB(200, 160, 40)
MinBtn.BorderSizePixel = 0
MinBtn.Text = "—"
MinBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MinBtn.TextSize = 12
MinBtn.Font = Enum.Font.GothamBold
MinBtn.ZIndex = 5
MinBtn.Parent = TitleBar
local MinBtnCorner = Instance.new("UICorner")
MinBtnCorner.CornerRadius = UDim.new(1, 0)
MinBtnCorner.Parent = MinBtn

local minimized = false
local ContentHolder  -- defined below

MinBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    if ContentHolder then
        ContentHolder.Visible = not minimized
    end
    local targetH = minimized and 52 or 570
    TweenService:Create(MainFrame, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
        Size = UDim2.new(0, 430, 0, targetH)
    }):Play()
    Shadow.Size = minimized and UDim2.new(0, 438, 0, 56) or UDim2.new(0, 438, 0, 578)
end)

-- ── USER BADGE (bawah kiri, seperti Meng Hub "Welcome, Gan***") ──
local UserBadge = Instance.new("Frame")
UserBadge.Name = "UserBadge"
UserBadge.Size = UDim2.new(0, 0, 0, 36)
UserBadge.Position = UDim2.new(0, 10, 1, -44)
UserBadge.AutomaticSize = Enum.AutomaticSize.X
UserBadge.BackgroundColor3 = THEME.BG2
UserBadge.BorderSizePixel = 0
UserBadge.ZIndex = 3
UserBadge.Parent = MainFrame
local UserBadgeCorner = Instance.new("UICorner")
UserBadgeCorner.CornerRadius = UDim.new(0, 10)
UserBadgeCorner.Parent = UserBadge
local UserBadgePad = Instance.new("UIPadding")
UserBadgePad.PaddingLeft  = UDim.new(0, 8)
UserBadgePad.PaddingRight = UDim.new(0, 10)
UserBadgePad.Parent = UserBadge
local UserBadgeStroke = Instance.new("UIStroke")
UserBadgeStroke.Color = THEME.BORDER
UserBadgeStroke.Thickness = 1
UserBadgeStroke.Parent = UserBadge

-- Avatar icon (lingkaran kecil)
local AvatarCircle = Instance.new("Frame")
AvatarCircle.Size = UDim2.new(0, 22, 0, 22)
AvatarCircle.Position = UDim2.new(0, 0, 0.5, -11)
AvatarCircle.BackgroundColor3 = THEME.ACCENT
AvatarCircle.BorderSizePixel = 0
AvatarCircle.ZIndex = 4
AvatarCircle.Parent = UserBadge
local AvatarCircleCorner = Instance.new("UICorner")
AvatarCircleCorner.CornerRadius = UDim.new(1, 0)
AvatarCircleCorner.Parent = AvatarCircle
local AvatarIcon = Instance.new("TextLabel")
AvatarIcon.Size = UDim2.new(1, 0, 1, 0)
AvatarIcon.BackgroundTransparency = 1
AvatarIcon.Text = "G"
AvatarIcon.TextColor3 = Color3.fromRGB(255, 255, 255)
AvatarIcon.TextSize = 12
AvatarIcon.Font = Enum.Font.GothamBold
AvatarIcon.ZIndex = 5
AvatarIcon.Parent = AvatarCircle

-- Welcome text
local WelcomeLabel = Instance.new("TextLabel")
WelcomeLabel.Size = UDim2.new(0, 0, 1, 0)
WelcomeLabel.Position = UDim2.new(0, 28, 0, 0)
WelcomeLabel.AutomaticSize = Enum.AutomaticSize.X
WelcomeLabel.BackgroundTransparency = 1
WelcomeLabel.TextColor3 = THEME.TEXT
WelcomeLabel.TextSize = 11
WelcomeLabel.Font = Enum.Font.Gotham
WelcomeLabel.ZIndex = 4
WelcomeLabel.Parent = UserBadge

-- Set welcome text dengan nama player (sensor 3 karakter terakhir)
local pName = LocalPlayer.Name
local displayName = pName:len() > 3
    and pName:sub(1, pName:len() - 3) .. "***"
    or pName
WelcomeLabel.Text = "Welcome, " .. displayName

-- ── TAB BAR ───────────────────────────────────────────────
local TabBar = Instance.new("Frame")
TabBar.Name = "TabBar"
TabBar.Size = UDim2.new(1, -24, 0, 34)
TabBar.Position = UDim2.new(0, 12, 0, 56)
TabBar.BackgroundTransparency = 1
TabBar.BorderSizePixel = 0
TabBar.ZIndex = 2
TabBar.Parent = MainFrame

local TabLayout = Instance.new("UIListLayout")
TabLayout.FillDirection = Enum.FillDirection.Horizontal
TabLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
TabLayout.VerticalAlignment = Enum.VerticalAlignment.Center
TabLayout.Padding = UDim.new(0, 4)
TabLayout.Parent = TabBar

-- ── CONTENT HOLDER ────────────────────────────────────────
ContentHolder = Instance.new("Frame")
ContentHolder.Name = "ContentHolder"
ContentHolder.Size = UDim2.new(1, 0, 1, -100)
ContentHolder.Position = UDim2.new(0, 0, 0, 94)
ContentHolder.BackgroundTransparency = 1
ContentHolder.ClipsDescendants = true
ContentHolder.ZIndex = 2
ContentHolder.Parent = MainFrame

-- ── TAB SYSTEM ────────────────────────────────────────────
local tabPages = {}
local activeTab = nil

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
    pp.PaddingBottom = UDim.new(0, 50)  -- kasih ruang untuk user badge
    pp.Parent = page

    return page
end

local function AddTab(name, icon)
    local page = CreateTabPage()
    tabPages[name] = page

    local btn = Instance.new("TextButton")
    btn.Name = name
    btn.Size = UDim2.new(0, 0, 1, 0)
    btn.AutomaticSize = Enum.AutomaticSize.X
    btn.BackgroundColor3 = THEME.BG2
    btn.BorderSizePixel = 0
    btn.Text = (icon and (icon .. " ") or "") .. name
    btn.TextColor3 = THEME.TEXT_DIM
    btn.TextSize = 12
    btn.Font = Enum.Font.GothamBold
    btn.ZIndex = 3
    btn.Parent = TabBar

    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 8)
    btnCorner.Parent = btn

    local btnPad = Instance.new("UIPadding")
    btnPad.PaddingLeft  = UDim.new(0, 10)
    btnPad.PaddingRight = UDim.new(0, 10)
    btnPad.Parent = btn

    -- Active indicator bar (bawah tab button)
    local indicator = Instance.new("Frame")
    indicator.Name = "Indicator"
    indicator.Size = UDim2.new(1, -16, 0, 2)
    indicator.Position = UDim2.new(0, 8, 1, -3)
    indicator.BackgroundColor3 = THEME.ACCENT
    indicator.BorderSizePixel = 0
    indicator.Visible = false
    indicator.ZIndex = 4
    indicator.Parent = btn
    local indCorner = Instance.new("UICorner")
    indCorner.CornerRadius = UDim.new(1, 0)
    indCorner.Parent = indicator

    btn.MouseButton1Click:Connect(function()
        for tName, tPage in pairs(tabPages) do
            tPage.Visible = false
            local tBtn = TabBar:FindFirstChild(tName)
            if tBtn then
                TweenService:Create(tBtn, TweenInfo.new(0.12), {
                    TextColor3 = THEME.TEXT_DIM,
                    BackgroundColor3 = THEME.BG2
                }):Play()
                local ind = tBtn:FindFirstChild("Indicator")
                if ind then ind.Visible = false end
            end
        end
        page.Visible = true
        TweenService:Create(btn, TweenInfo.new(0.12), {
            TextColor3 = Color3.fromRGB(255, 255, 255),
            BackgroundColor3 = THEME.ACCENT2
        }):Play()
        indicator.Visible = true
        activeTab = name
    end)

    tabPages[name] = page
    return page
end

-- ── GUI ELEMENT HELPERS ───────────────────────────────────

local function MakeSectionLabel(text, parent)
    local outer = Instance.new("Frame")
    outer.Name = "Section_" .. text
    outer.Size = UDim2.new(1, 0, 0, 30)
    outer.BackgroundColor3 = THEME.SECTION_BG
    outer.BorderSizePixel = 0
    outer.ZIndex = 2
    outer.Parent = parent
    local oc = Instance.new("UICorner")
    oc.CornerRadius = UDim.new(0, 8)
    oc.Parent = outer
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
    lbl.Parent = parent
    return lbl
end

local function MakeToggle(text, default, callback, parent)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 0, 40)
    frame.BackgroundColor3 = THEME.BG2
    frame.BorderSizePixel = 0
    frame.ZIndex = 2
    frame.Parent = parent
    local fc = Instance.new("UICorner")
    fc.CornerRadius = UDim.new(0, 8)
    fc.Parent = frame
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

    local track = Instance.new("Frame")
    track.Size = UDim2.new(0, 44, 0, 22)
    track.Position = UDim2.new(1, -56, 0.5, -11)
    track.BackgroundColor3 = state and THEME.TOGGLE_ON or THEME.TOGGLE_OFF
    track.BorderSizePixel = 0
    track.ZIndex = 3
    track.Parent = frame
    local tc = Instance.new("UICorner")
    tc.CornerRadius = UDim.new(1, 0)
    tc.Parent = track

    local knob = Instance.new("Frame")
    knob.Size = UDim2.new(0, 16, 0, 16)
    knob.Position = state and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)
    knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    knob.BorderSizePixel = 0
    knob.ZIndex = 4
    knob.Parent = track
    local kc = Instance.new("UICorner")
    kc.CornerRadius = UDim.new(1, 0)
    kc.Parent = knob

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
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 34)
    btn.BackgroundColor3 = THEME.BTN
    btn.BorderSizePixel = 0
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 12
    btn.Font = Enum.Font.GothamBold
    btn.ZIndex = 2
    btn.Parent = parent
    local bc = Instance.new("UICorner")
    bc.CornerRadius = UDim.new(0, 8)
    bc.Parent = btn

    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.1), {BackgroundColor3 = THEME.BTN_HOVER}):Play()
    end)
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.1), {BackgroundColor3 = THEME.BTN}):Play()
    end)
    btn.MouseButton1Click:Connect(function()
        if callback then
            btn.BackgroundColor3 = THEME.ACCENT
            task.delay(0.12, function()
                if btn and btn.Parent then
                    btn.BackgroundColor3 = THEME.BTN
                end
            end)
            callback()
        end
    end)
    return btn
end

local function MakeTwoButtons(textA, cbA, textB, cbB, parent)
    local row = Instance.new("Frame")
    row.Size = UDim2.new(1, 0, 0, 34)
    row.BackgroundTransparency = 1
    row.ZIndex = 2
    row.Parent = parent
    local rl = Instance.new("UIListLayout")
    rl.FillDirection = Enum.FillDirection.Horizontal
    rl.Padding = UDim.new(0, 6)
    rl.Parent = row

    local function MakeHalfBtn(text, cb)
        local b = Instance.new("TextButton")
        b.Size = UDim2.new(0.5, -3, 1, 0)
        b.BackgroundColor3 = THEME.BTN
        b.BorderSizePixel = 0
        b.Text = text
        b.TextColor3 = Color3.fromRGB(255, 255, 255)
        b.TextSize = 11
        b.Font = Enum.Font.GothamBold
        b.ZIndex = 3
        b.Parent = row
        local bc = Instance.new("UICorner")
        bc.CornerRadius = UDim.new(0, 8)
        bc.Parent = b
        b.MouseButton1Click:Connect(function()
            if cb then
                b.BackgroundColor3 = THEME.ACCENT
                task.delay(0.12, function()
                    if b and b.Parent then b.BackgroundColor3 = THEME.BTN end
                end)
                cb()
            end
        end)
        return b
    end

    MakeHalfBtn(textA, cbA)
    MakeHalfBtn(textB, cbB)
    return row
end

local function MakeInput(labelText, placeholder, callback, parent)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 0, 64)
    frame.BackgroundColor3 = THEME.BG2
    frame.BorderSizePixel = 0
    frame.ZIndex = 2
    frame.Parent = parent
    local fc = Instance.new("UICorner")
    fc.CornerRadius = UDim.new(0, 8)
    fc.Parent = frame
    local stroke = Instance.new("UIStroke")
    stroke.Color = THEME.BORDER
    stroke.Thickness = 1
    stroke.Parent = frame

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, -12, 0, 22)
    lbl.Position = UDim2.new(0, 10, 0, 4)
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
    box.Position = UDim2.new(0, 8, 0, 30)
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
    local bc = Instance.new("UICorner")
    bc.CornerRadius = UDim.new(0, 6)
    bc.Parent = box

    box.Focused:Connect(function()
        stroke.Color = THEME.ACCENT
    end)
    box.FocusLost:Connect(function()
        stroke.Color = THEME.BORDER
        if callback then callback(box.Text) end
    end)

    return frame, box
end

local function MakeInfoCard(text, parent)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 0, 38)
    frame.BackgroundColor3 = Color3.fromRGB(18, 22, 38)
    frame.BorderSizePixel = 0
    frame.ZIndex = 2
    frame.Parent = parent
    local fc = Instance.new("UICorner")
    fc.CornerRadius = UDim.new(0, 8)
    fc.Parent = frame
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

    local ref = {}
    ref.SetContent = function(_, t) lbl.Text = t end
    UIRefs.StatusLabel = ref
    return frame
end

-- ============================================================
-- BUILD GUI TABS
-- ============================================================

-- ── TAB: AUTO FARM ────────────────────────────────────────
local AutoFarmPage = AddTab("Auto Farm", "⚡")

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

MakeSectionLabel("Webhook Features", WebhookPage)

local webhookEnabled = false
MakeToggle("Enable Webhook", false, function(state)
    webhookEnabled = state
    if state then
        SendNotif("Webhook", "Webhook aktif!", 3)
    end
end, WebhookPage)

local _, webhookBox = MakeInput("Input Discord URL", "Write ur input here...", function(val)
    if _G.ConfigData then _G.ConfigData.WebhookURL = val end
end, WebhookPage)

UIRefs.WebhookURLInput = {
    GetValue = function() return webhookBox.Text end,
    SetValue = function(_, v) webhookBox.Text = v or "" end,
}

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

MakeSectionLabel("Configuration", ConfigPage)
MakeInfoCard("Current: None  |  Autoload: None", ConfigPage)

local _, configNameBox = MakeInput("Config Name", "Enter the name for u config", function(val)
    _G._configNameInput = val
end, ConfigPage)

-- Dropdown select config (visual manual)
-- Select Config label
MakeLabel("Select Config — ketik nama atau pilih dari list", THEME.TEXT_DIM, ConfigPage)

-- External JSON
local _, externalJSONBox = MakeInput("External Config JSON", "Paste ur raw JSON config here", function(val)
    _G.ExternalJSONInput = val
end, ConfigPage)

-- Tombol config 2x2 grid
MakeTwoButtons("💾 Save Config", function()
    local name = (_G._configNameInput or ""):gsub("^%s+",""):gsub("%s+$","")
    if name == "" and _G.SelectedConfig then name = _G.SelectedConfig end
    if _G.ConfigData then _G.ConfigData.WebhookURL = webhookBox.Text end
    SaveConfig(name)
end, "📂 Load Config", function()
    local name = _G.SelectedConfig or (_G._configNameInput or ""):gsub("^%s+",""):gsub("%s+$","")
    if name == "" then SendNotif("Config", "Isi nama config dulu!", 3) return end
    LoadConfigFromFile(ConfigFolder .. name .. ".json")
end, ConfigPage)

MakeTwoButtons("❌ Delete Config", function()
    local name = (_G._configNameInput or ""):gsub("^%s+",""):gsub("%s+$","")
    if name ~= "" then _G.SelectedConfig = name end
    DeleteConfig(_G.SelectedConfig)
end, "⭐ Set Autoload", function()
    local name = (_G._configNameInput or ""):gsub("^%s+",""):gsub("%s+$","")
    if name ~= "" then _G.SelectedConfig = name end
    SetAutoload(_G.SelectedConfig)
end, ConfigPage)

MakeTwoButtons("🔄 Refresh List", function()
    local list = GetConfigList()
    if #list == 0 then
        SendNotif("Config", "Tidak ada config tersimpan.", 3)
    else
        SendNotif("Config", "Config: " .. table.concat(list, ", "), 5)
    end
end, "🧹 Clear Autoload", function()
    ClearAutoload()
end, ConfigPage)

MakeSectionLabel("Load From External", ConfigPage)

MakeTwoButtons("📋 Load External JSON", function()
    _G.ExternalJSONInput = externalJSONBox.Text
    LoadFromExternalJSON()
end, "📤 Export Config", function()
    local name = (_G._configNameInput or ""):gsub("^%s+",""):gsub("%s+$","")
    if name ~= "" then _G.SelectedConfig = name end
    ExportConfig(_G.SelectedConfig)
end, ConfigPage)

MakeSectionLabel("Server Configuration", ConfigPage)

MakeToggle("Auto Execute", false, function(state)
    SetupAutoExecute(state)
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
do
    local firstBtn = TabBar:FindFirstChildWhichIsA("TextButton")
    if firstBtn then
        firstBtn:Activate()
        -- Manual activate kalau Activate() tidak fire Click
        local firstName = firstBtn.Name
        if tabPages[firstName] then
            tabPages[firstName].Visible = true
            firstBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
            firstBtn.BackgroundColor3 = THEME.ACCENT2
            local ind = firstBtn:FindFirstChild("Indicator")
            if ind then ind.Visible = true end
            activeTab = firstName
        end
    end
end

-- ============================================================
-- FOLDER SETUP & STARTUP
-- ============================================================
SafeMakeFolder(mainFolderName)
SafeMakeFolder(ConfigFolder)

StartStatusLoop()
CheckAndAutoload()

task.delay(1, function()
    SendNotif("GanKunZ Hub", "Script berhasil diload! Violence District Auto Farm v" .. CURRENT_VERSION .. " | Creator: GanKunZ Hub", 6)
end)

print("[GanKunZ Hub] Violence District Auto Farm loaded! Version:", CURRENT_VERSION, "| Creator: GanKunZ Hub")