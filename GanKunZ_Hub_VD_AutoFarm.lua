--[[
    GanKunZ Hub - Violence District Auto Farm
    Peaceful Community Edition
    Creator: GanKunZ Hub
    
    FITUR:
    Auto Farm (Exit Gate Otomatis)
    Config Manager (Save/Load/Delete/Export)
    External JSON Config
    Autoload Config
    Server Hop
    Auto Execute setelah teleport

    CARA PAKAI:
    1. Aktifkan Enable Auto Farm
    2. Aktifkan Auto Execute
    3. Aktifkan Disable Killer Chance di game
    4. Save Config lalu klik Set Autoload
    5. Enjoy!
--]]

-- Services
local Players           = game:GetService("Players")
local TweenService      = game:GetService("TweenService")
local HttpService       = game:GetService("HttpService")
local TeleportService   = game:GetService("TeleportService")
local UserInputService  = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer
local Character   = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local PlayerGui   = LocalPlayer.PlayerGui

-- Konstanta
local CURRENT_VERSION = "1.0.0"
local CREATOR_NAME    = "GanKunZ Hub"
local HUB_NAME        = "GanKunZ Hub"
local mainFolderName  = "GanKunZ Hub_ViolenceAutoFarm"
local ConfigFolder    = mainFolderName .. "/Config/"
local AutoloadConfig  = mainFolderName .. "/autoload.txt"
local AUTO_EXEC_URL   = "https://raw.githubusercontent.com/GrexXMeng/Mengs/refs/heads/main/AutoFarmVD.lua"
local ROBLOX_GAME_API = "https://games.roblox.com/v1/games/"

-- State global (pakai _G langsung tanpa local override)
_G.AutoFarmEnabled   = _G.AutoFarmEnabled   or false
_G.SelectedConfig    = _G.SelectedConfig    or nil
_G.CurrentLoaded     = _G.CurrentLoaded     or nil
_G.ConfigData        = _G.ConfigData        or {}
_G.AutoloadConfig    = _G.AutoloadConfig    or nil
_G.ExternalJSONInput = _G.ExternalJSONInput or ""
_G.ConfigFolder      = ConfigFolder

-- Referensi UI
local UIRefs = {
    StatusLabel    = nil,
}

-- Tema
local THEME = {
    BG         = Color3.fromRGB(13, 14, 22),
    BG2        = Color3.fromRGB(20, 22, 35),
    BG3        = Color3.fromRGB(28, 30, 48),
    ACCENT     = Color3.fromRGB(120, 80, 220),
    ACCENT2    = Color3.fromRGB(80, 50, 180),
    SECTION_BG = Color3.fromRGB(30, 25, 55),
    SECTION_TXT = Color3.fromRGB(180, 140, 255),
    TEXT       = Color3.fromRGB(220, 218, 240),
    TEXT_DIM   = Color3.fromRGB(140, 135, 170),
    TEXT_INFO  = Color3.fromRGB(255, 210, 100),
    TOGGLE_ON  = Color3.fromRGB(90, 200, 120),
    TOGGLE_OFF = Color3.fromRGB(60, 58, 90),
    BTN        = Color3.fromRGB(75, 50, 160),
    BTN_HOVER  = Color3.fromRGB(100, 70, 200),
    SCROLLBAR  = Color3.fromRGB(120, 80, 220),
    BORDER     = Color3.fromRGB(70, 55, 130),
    STATUS_OK  = Color3.fromRGB(100, 230, 150),
}

-- ============================================================
-- UTILITAS
-- ============================================================

local function SendNotif(title, text, duration)
    duration = duration or 5
    if syn and syn.toast_notification then
        syn.toast_notification({ Type = 0, Title = "[" .. HUB_NAME .. "] " .. title, Content = text, Duration = duration })
    elseif game.StarterGui then
        pcall(function()
            game.StarterGui:SetCore("SendNotification", { Title = "[" .. HUB_NAME .. "] " .. title, Text = text, Duration = duration })
        end)
    end
end

local function UpdateStatus(text)
    if UIRefs.StatusLabel then
        pcall(function() UIRefs.StatusLabel(text) end)
    end
end

-- ============================================================
-- FILE SYSTEM
-- ============================================================

local function SafeMakeFolder(path)
    if not isfolder(path) then pcall(makefolder, path) end
end

local function SafeReadFile(path)
    if isfile(path) then return pcall(readfile, path) end
    return false, nil
end

local function SafeWriteFile(path, content)
    return pcall(writefile, path, content)
end

local function SafeDelFile(path)
    if isfile(path) then return pcall(delfile, path) end
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
            table.insert(list, name:gsub("%.json$", ""))
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
        Version         = CURRENT_VERSION,
        Creator         = CREATOR_NAME,
    }
    SafeWriteFile(ConfigFolder .. configName .. ".json", HttpService:JSONEncode(data))
    SendNotif("Config", "Config '" .. configName .. "' disimpan!", 4)
end

local function LoadConfigFromFile(configPath)
    local ok, content = SafeReadFile(configPath)
    if not ok or not content then
        SendNotif("Config", "Gagal baca file!", 3)
        return
    end
    local parseOk, configData = pcall(function() return HttpService:JSONDecode(content) end)
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
    SendNotif("Config", "Config '" .. currentName .. "' di-load!", 4)
end

local function DeleteConfig(configName)
    if not configName or configName == "" then
        SendNotif("Config", "Pilih config dulu!", 3)
        return
    end
    SafeDelFile(ConfigFolder .. configName .. ".json")
    _G.SelectedConfig = nil
    SendNotif("Config", "Config '" .. configName .. "' dihapus!", 3)
end

local function SetAutoload(configName)
    if not configName or configName == "" then
        SendNotif("Autoload", "Pilih config dulu!", 3)
        return
    end
    SafeMakeFolder(mainFolderName)
    SafeWriteFile(AutoloadConfig, ConfigFolder .. configName .. ".json")
    _G.AutoloadConfig = ConfigFolder .. configName .. ".json"
    local currentName = ((_G.CurrentLoaded or ""):match("([^/\\]+)$") or "None"):gsub("%.json$", "")
    UpdateStatus("Current: " .. currentName .. " | Autoload: " .. configName)
    SendNotif("Autoload", "Set autoload ke '" .. configName .. "'!", 4)
end

local function ClearAutoload()
    SafeDelFile(AutoloadConfig)
    _G.AutoloadConfig = nil
    local currentName = ((_G.CurrentLoaded or "None"):match("([^/\\]+)$") or "None"):gsub("%.json$", "")
    UpdateStatus("Current: " .. currentName .. " | Autoload: None")
    SendNotif("Autoload", "Autoload dihapus!", 3)
end

local function ExportConfig(configName)
    if not configName or configName == "" then
        SendNotif("Export", "Load config dulu!", 4)
        return
    end
    local ok, content = SafeReadFile(ConfigFolder .. configName .. ".json")
    if ok and content then
        if setclipboard then
            setclipboard(content)
            SendNotif("Export", "Config di-copy ke clipboard!", 4)
        else
            SendNotif("Export", "Executor tidak support clipboard!", 3)
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
    local ok, configData = pcall(function() return HttpService:JSONDecode(jsonText) end)
    if not ok or type(configData) ~= "table" then
        SendNotif("External JSON", "JSON tidak valid!", 3)
        return
    end
    LoadConfigElements(configData)
    _G.CurrentLoaded = "External JSON"
    UpdateStatus("Current: External JSON | Autoload: " .. (isfile(AutoloadConfig) and "Active" or "None"))
    SendNotif("External JSON", "Config dari JSON berhasil di-load!", 4)
end

-- ============================================================
-- AUTO EXECUTE
-- ============================================================

local function SetupAutoExecute(enabled)
    if not enabled then return end
    local execScript = 'repeat task.wait() until game:IsLoaded() loadstring(game:HttpGet("' .. AUTO_EXEC_URL .. '"))()'
    if queue_on_teleport then
        pcall(queue_on_teleport, execScript)
    else
        SendNotif("Auto Execute", "Executor tidak support queue_on_teleport", 5)
    end
end

-- ============================================================
-- SERVER HOP
-- ============================================================

local function HopServer()
    local url = ROBLOX_GAME_API .. tostring(game.PlaceId) .. "/servers/Public?sortOrder=Asc&limit=100"
    local ok, result = pcall(function()
        return HttpService:JSONDecode(game:HttpGet(url))
    end)
    if not ok or not result or not result.data then
        SendNotif("Server Hop", "Gagal ambil list server!", 3)
        return false
    end
    local servers = result.data
    local currentJobId = game.JobId
    -- Shuffle
    for i = #servers, 2, -1 do
        local j = math.random(i)
        servers[i], servers[j] = servers[j], servers[i]
    end
    for _, server in ipairs(servers) do
        if server.id and server.id ~= currentJobId then
            local hopped = pcall(function()
                TeleportService:TeleportToPlaceInstance(game.PlaceId, server.id, LocalPlayer)
            end)
            if hopped then return true end
        end
    end
    SendNotif("Server Hop", "Hop gagal, coba lagi!", 4)
    return false
end

-- ============================================================
-- AUTO FARM
-- ============================================================

local function GetPlayerTeam(player)
    local char = player.Character
    if not char then return nil end
    local teamTag = char:FindFirstChild("Team")
    if not teamTag then return nil end
    local tag = teamTag:FindFirstChild("TeamTag")
    if tag then return tag.Value end
    return teamTag.Team and teamTag.Team.Name
end

local function TryExitGate()
    Character = LocalPlayer.Character
    local hrp = Character and Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    local ws = workspace
    local candidates = {}
    local names = {"LeftGate", "RightGate", "Finishline", "Fininshline"}
    for _, n in ipairs(names) do
        local g = ws:FindFirstChild(n)
        if g then table.insert(candidates, g) end
    end
    if #candidates == 0 then return end
    local function GetPos(gate)
        if gate:IsA("Model") then
            local box = gate:FindFirstChild("Box")
            return box and box.CFrame or gate:GetPivot()
        end
        return gate.CFrame
    end
    local best, bestDist = nil, math.huge
    for _, gate in ipairs(candidates) do
        local dist = (GetPos(gate).Position - hrp.Position).Magnitude
        if dist < bestDist then bestDist = dist; best = gate end
    end
    if not best then return end
    local tween = TweenService:Create(hrp, TweenInfo.new(2, Enum.EasingStyle.Linear), {CFrame = GetPos(best)})
    tween:Play()
    tween.Completed:Connect(function()
        SendNotif("Auto Farm", "Exit gate berhasil!", 3)
    end)
end

local function StartAutoFarm()
    if not _G.AutoFarmEnabled then return end
    task.spawn(function()
        while _G.AutoFarmEnabled do
            local ok, err = pcall(function()
                -- Cek player count
                local playerCount = #Players:GetPlayers()
                if playerCount < 4 then
                    SendNotif("Auto Farm", "Player kurang (" .. playerCount .. "), hop...", 4)
                    task.wait(3)
                    HopServer()
                    return
                end
                -- Cek mid-match
                if workspace:FindFirstChild("Map") then
                    task.wait(5)
                    HopServer()
                    return
                end
                task.wait(2)
                -- Cek role killer
                local myTeam = GetPlayerTeam(LocalPlayer)
                if myTeam == "Killer" then
                    SendNotif("Auto Farm", "Dapat role Killer, hop...", 4)
                    task.wait(2)
                    HopServer()
                    return
                end
                -- Farm loop
                while _G.AutoFarmEnabled do
                    task.wait(0.5)
                    TryExitGate()
                    task.wait(1)
                    myTeam = GetPlayerTeam(LocalPlayer)
                    if myTeam == "Spectator" then
                        task.wait(3)
                        break
                    end
                end
            end)
            if not ok then warn("[GanKunZ Hub] AutoFarm error:", err) end
            task.wait(5)
        end
    end)
end

-- ============================================================
-- STATUS LOOP
-- ============================================================

local function StartStatusLoop()
    task.spawn(function()
        while true do
            task.wait(2)
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
-- AUTOLOAD
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
                if _G.AutoFarmEnabled then StartAutoFarm() end
            end
        end
    end)
end

-- ============================================================
-- GUI BUILD
-- ============================================================

-- Hapus instance lama
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

-- Shadow
local Shadow = Instance.new("Frame")
Shadow.Name = "Shadow"
Shadow.Size = UDim2.new(0, 438, 0, 578)
Shadow.Position = UDim2.new(0.5, -221, 0.5, -291)
Shadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Shadow.BackgroundTransparency = 0.5
Shadow.BorderSizePixel = 0
Shadow.ZIndex = 0
Shadow.Parent = ScreenGui
Instance.new("UICorner", Shadow).CornerRadius = UDim.new(0, 20)

-- Main Frame
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 430, 0, 570)
MainFrame.Position = UDim2.new(0.5, -215, 0.5, -285)
MainFrame.BackgroundColor3 = THEME.BG
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.ZIndex = 1
MainFrame.Parent = ScreenGui
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 20)
local MainStroke = Instance.new("UIStroke")
MainStroke.Color = THEME.BORDER
MainStroke.Thickness = 1.5
MainStroke.Parent = MainFrame

-- ============================================================
-- DRAG SYSTEM (UIS - bukan .Draggable deprecated)
-- ============================================================
do
    local dragging  = false
    local dragStart = nil
    local startPos  = nil

    local function SyncShadow()
        local ap = MainFrame.AbsolutePosition
        Shadow.Position = UDim2.new(0, ap.X - 4, 0, ap.Y - 4)
    end

    task.defer(SyncShadow)

    MainFrame.InputBegan:Connect(function(input)
        local t = input.UserInputType
        if t == Enum.UserInputType.MouseButton1 or t == Enum.UserInputType.Touch then
            local relY = input.Position.Y - MainFrame.AbsolutePosition.Y
            if relY <= 54 then
                dragging  = true
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
        local t = input.UserInputType
        if dragging and (t == Enum.UserInputType.MouseMovement or t == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            MainFrame.Position = UDim2.new(
                startPos.X.Scale, startPos.X.Offset + delta.X,
                startPos.Y.Scale, startPos.Y.Offset + delta.Y
            )
            SyncShadow()
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        local t = input.UserInputType
        if t == Enum.UserInputType.MouseButton1 or t == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
end

-- ============================================================
-- TITLE BAR
-- ============================================================
local TitleBar = Instance.new("Frame")
TitleBar.Name = "TitleBar"
TitleBar.Size = UDim2.new(1, 0, 0, 54)
TitleBar.BackgroundColor3 = THEME.BG2
TitleBar.BorderSizePixel = 0
TitleBar.ZIndex = 2
TitleBar.Parent = MainFrame
Instance.new("UICorner", TitleBar).CornerRadius = UDim.new(0, 20)

-- Potong corner bawah title bar
local TitleCover = Instance.new("Frame")
TitleCover.Size = UDim2.new(1, 0, 0, 20)
TitleCover.Position = UDim2.new(0, 0, 1, -20)
TitleCover.BackgroundColor3 = THEME.BG2
TitleCover.BorderSizePixel = 0
TitleCover.ZIndex = 2
TitleCover.Parent = TitleBar

-- Accent line separator
local TitleLine = Instance.new("Frame")
TitleLine.Size = UDim2.new(1, -40, 0, 1)
TitleLine.Position = UDim2.new(0, 20, 1, -1)
TitleLine.BackgroundColor3 = THEME.ACCENT
TitleLine.BackgroundTransparency = 0.6
TitleLine.BorderSizePixel = 0
TitleLine.ZIndex = 3
TitleLine.Parent = TitleBar

-- Icon badge (lingkaran)
local IconBadge = Instance.new("Frame")
IconBadge.Size = UDim2.new(0, 36, 0, 36)
IconBadge.Position = UDim2.new(0, 12, 0.5, -18)
IconBadge.BackgroundColor3 = THEME.ACCENT
IconBadge.BorderSizePixel = 0
IconBadge.ZIndex = 3
IconBadge.Parent = TitleBar
Instance.new("UICorner", IconBadge).CornerRadius = UDim.new(1, 0)
local IconText = Instance.new("TextLabel")
IconText.Size = UDim2.new(1, 0, 1, 0)
IconText.BackgroundTransparency = 1
IconText.Text = "G"
IconText.TextColor3 = Color3.fromRGB(255, 255, 255)
IconText.TextSize = 18
IconText.Font = Enum.Font.GothamBold
IconText.ZIndex = 4
IconText.Parent = IconBadge

-- Title
local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1, -160, 0, 20)
TitleLabel.Position = UDim2.new(0, 58, 0, 8)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "GanKunZ Hub"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextSize = 15
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.ZIndex = 3
TitleLabel.Parent = TitleBar

-- Subtitle
local SubTitle = Instance.new("TextLabel")
SubTitle.Size = UDim2.new(1, -160, 0, 14)
SubTitle.Position = UDim2.new(0, 58, 0, 30)
SubTitle.BackgroundTransparency = 1
SubTitle.Text = "Peacefull Community  v" .. CURRENT_VERSION
SubTitle.TextColor3 = THEME.TEXT_DIM
SubTitle.TextSize = 11
SubTitle.Font = Enum.Font.Gotham
SubTitle.TextXAlignment = Enum.TextXAlignment.Left
SubTitle.ZIndex = 3
SubTitle.Parent = TitleBar

-- Game tag badge
local GameTagFrame = Instance.new("Frame")
GameTagFrame.Size = UDim2.new(0, 110, 0, 24)
GameTagFrame.Position = UDim2.new(1, -156, 0.5, -12)
GameTagFrame.BackgroundColor3 = THEME.ACCENT2
GameTagFrame.BorderSizePixel = 0
GameTagFrame.ZIndex = 4
GameTagFrame.Parent = TitleBar
Instance.new("UICorner", GameTagFrame).CornerRadius = UDim.new(0, 6)
local GameTagLabel = Instance.new("TextLabel")
GameTagLabel.Size = UDim2.new(1, 0, 1, 0)
GameTagLabel.BackgroundTransparency = 1
GameTagLabel.Text = "VD | Auto Farm"
GameTagLabel.TextColor3 = Color3.fromRGB(220, 210, 255)
GameTagLabel.TextSize = 11
GameTagLabel.Font = Enum.Font.GothamBold
GameTagLabel.ZIndex = 5
GameTagLabel.Parent = GameTagFrame

-- Minimize button
local MinBtn = Instance.new("TextButton")
MinBtn.Size = UDim2.new(0, 26, 0, 26)
MinBtn.Position = UDim2.new(1, -70, 0.5, -13)
MinBtn.BackgroundColor3 = Color3.fromRGB(200, 160, 40)
MinBtn.BorderSizePixel = 0
MinBtn.Text = "-"
MinBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MinBtn.TextSize = 14
MinBtn.Font = Enum.Font.GothamBold
MinBtn.ZIndex = 5
MinBtn.Parent = TitleBar
Instance.new("UICorner", MinBtn).CornerRadius = UDim.new(1, 0)

-- Close button
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 26, 0, 26)
CloseBtn.Position = UDim2.new(1, -40, 0.5, -13)
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
CloseBtn.BorderSizePixel = 0
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextSize = 12
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.ZIndex = 5
CloseBtn.Parent = TitleBar
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(1, 0)

CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- ============================================================
-- TAB BAR
-- ============================================================
local TabBar = Instance.new("Frame")
TabBar.Name = "TabBar"
TabBar.Size = UDim2.new(1, -24, 0, 32)
TabBar.Position = UDim2.new(0, 12, 0, 58)
TabBar.BackgroundTransparency = 1
TabBar.BorderSizePixel = 0
TabBar.ZIndex = 2
TabBar.Parent = MainFrame

local TabLayout = Instance.new("UIListLayout")
TabLayout.FillDirection = Enum.FillDirection.Horizontal
TabLayout.VerticalAlignment = Enum.VerticalAlignment.Center
TabLayout.Padding = UDim.new(0, 4)
TabLayout.Parent = TabBar

-- ============================================================
-- CONTENT HOLDER
-- ============================================================
local ContentHolder = Instance.new("Frame")
ContentHolder.Name = "ContentHolder"
ContentHolder.Size = UDim2.new(1, 0, 1, -98)
ContentHolder.Position = UDim2.new(0, 0, 0, 94)
ContentHolder.BackgroundTransparency = 1
ContentHolder.ClipsDescendants = true
ContentHolder.ZIndex = 2
ContentHolder.Parent = MainFrame

-- ============================================================
-- USER BADGE (bawah kiri)
-- ============================================================
local UserBadge = Instance.new("Frame")
UserBadge.Size = UDim2.new(0, 160, 0, 32)
UserBadge.Position = UDim2.new(0, 10, 1, -40)
UserBadge.BackgroundColor3 = THEME.BG2
UserBadge.BorderSizePixel = 0
UserBadge.ZIndex = 10
UserBadge.Parent = MainFrame
Instance.new("UICorner", UserBadge).CornerRadius = UDim.new(0, 10)
local UBStroke = Instance.new("UIStroke")
UBStroke.Color = THEME.BORDER
UBStroke.Thickness = 1
UBStroke.Parent = UserBadge

local AvatarCircle = Instance.new("Frame")
AvatarCircle.Size = UDim2.new(0, 20, 0, 20)
AvatarCircle.Position = UDim2.new(0, 6, 0.5, -10)
AvatarCircle.BackgroundColor3 = THEME.ACCENT
AvatarCircle.BorderSizePixel = 0
AvatarCircle.ZIndex = 11
AvatarCircle.Parent = UserBadge
Instance.new("UICorner", AvatarCircle).CornerRadius = UDim.new(1, 0)
local AvatarText = Instance.new("TextLabel")
AvatarText.Size = UDim2.new(1, 0, 1, 0)
AvatarText.BackgroundTransparency = 1
AvatarText.Text = LocalPlayer.Name:sub(1, 1):upper()
AvatarText.TextColor3 = Color3.fromRGB(255, 255, 255)
AvatarText.TextSize = 11
AvatarText.Font = Enum.Font.GothamBold
AvatarText.ZIndex = 12
AvatarText.Parent = AvatarCircle

local WelcomeText = Instance.new("TextLabel")
WelcomeText.Size = UDim2.new(1, -34, 1, 0)
WelcomeText.Position = UDim2.new(0, 30, 0, 0)
WelcomeText.BackgroundTransparency = 1
local pName = LocalPlayer.Name
local displayName = (#pName > 3) and (pName:sub(1, #pName - 3) .. "***") or pName
WelcomeText.Text = "Welcome, " .. displayName
WelcomeText.TextColor3 = THEME.TEXT
WelcomeText.TextSize = 11
WelcomeText.Font = Enum.Font.Gotham
WelcomeText.TextXAlignment = Enum.TextXAlignment.Left
WelcomeText.TextTruncate = Enum.TextTruncate.AtEnd
WelcomeText.ZIndex = 11
WelcomeText.Parent = UserBadge

-- Minimize logic
local minimized = false
MinBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    ContentHolder.Visible = not minimized
    UserBadge.Visible = not minimized
    local targetH = minimized and 54 or 570
    TweenService:Create(MainFrame, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
        Size = UDim2.new(0, 430, 0, targetH)
    }):Play()
    task.delay(0.05, function()
        local ap = MainFrame.AbsolutePosition
        local sh = minimized and 58 or 578
        Shadow.Size = UDim2.new(0, 438, 0, sh)
        Shadow.Position = UDim2.new(0, ap.X - 4, 0, ap.Y - 4)
    end)
end)

-- ============================================================
-- TAB SYSTEM
-- ============================================================
local tabPages = {}
local activeTab = nil

local function CreateTabPage()
    local page = Instance.new("ScrollingFrame")
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
    pp.PaddingBottom = UDim.new(0, 48)
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
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
    local pad = Instance.new("UIPadding")
    pad.PaddingLeft  = UDim.new(0, 10)
    pad.PaddingRight = UDim.new(0, 10)
    pad.Parent = btn

    local ind = Instance.new("Frame")
    ind.Name = "Indicator"
    ind.Size = UDim2.new(1, -16, 0, 2)
    ind.Position = UDim2.new(0, 8, 1, -3)
    ind.BackgroundColor3 = THEME.ACCENT
    ind.BorderSizePixel = 0
    ind.Visible = false
    ind.ZIndex = 4
    ind.Parent = btn
    Instance.new("UICorner", ind).CornerRadius = UDim.new(1, 0)

    btn.MouseButton1Click:Connect(function()
        for tName, tPage in pairs(tabPages) do
            tPage.Visible = false
            local tBtn = TabBar:FindFirstChild(tName)
            if tBtn then
                tBtn.TextColor3 = THEME.TEXT_DIM
                tBtn.BackgroundColor3 = THEME.BG2
                local tInd = tBtn:FindFirstChild("Indicator")
                if tInd then tInd.Visible = false end
            end
        end
        page.Visible = true
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.BackgroundColor3 = THEME.ACCENT2
        ind.Visible = true
        activeTab = name
    end)

    return page, btn
end

-- ============================================================
-- GUI ELEMENT BUILDERS
-- ============================================================

local function MakeSectionLabel(text, parent)
    local f = Instance.new("Frame")
    f.Size = UDim2.new(1, 0, 0, 30)
    f.BackgroundColor3 = THEME.SECTION_BG
    f.BorderSizePixel = 0
    f.ZIndex = 2
    f.Parent = parent
    Instance.new("UICorner", f).CornerRadius = UDim.new(0, 8)
    local stroke = Instance.new("UIStroke")
    stroke.Color = THEME.ACCENT
    stroke.Thickness = 1
    stroke.Parent = f
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, -12, 1, 0)
    lbl.Position = UDim2.new(0, 10, 0, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = "  " .. text
    lbl.TextColor3 = THEME.SECTION_TXT
    lbl.TextSize = 12
    lbl.Font = Enum.Font.GothamBold
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.ZIndex = 3
    lbl.Parent = f
    return f
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
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 8)
    local stroke = Instance.new("UIStroke")
    stroke.Color = THEME.BORDER
    stroke.Thickness = 1
    stroke.Parent = frame

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(0.75, -12, 1, 0)
    lbl.Position = UDim2.new(0, 12, 0, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = text
    lbl.TextColor3 = THEME.TEXT
    lbl.TextSize = 12
    lbl.Font = Enum.Font.Gotham
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.ZIndex = 3
    lbl.Parent = frame

    local state = default or false

    local track = Instance.new("Frame")
    track.Size = UDim2.new(0, 44, 0, 22)
    track.Position = UDim2.new(1, -56, 0.5, -11)
    track.BackgroundColor3 = state and THEME.TOGGLE_ON or THEME.TOGGLE_OFF
    track.BorderSizePixel = 0
    track.ZIndex = 3
    track.Parent = frame
    Instance.new("UICorner", track).CornerRadius = UDim.new(1, 0)

    local knob = Instance.new("Frame")
    knob.Size = UDim2.new(0, 16, 0, 16)
    knob.Position = state and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)
    knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    knob.BorderSizePixel = 0
    knob.ZIndex = 4
    knob.Parent = track
    Instance.new("UICorner", knob).CornerRadius = UDim.new(1, 0)

    local hitbox = Instance.new("TextButton")
    hitbox.Size = UDim2.new(1, 0, 1, 0)
    hitbox.BackgroundTransparency = 1
    hitbox.Text = ""
    hitbox.ZIndex = 5
    hitbox.Parent = frame

    local function Refresh()
        TweenService:Create(track, TweenInfo.new(0.15, Enum.EasingStyle.Quad),
            {BackgroundColor3 = state and THEME.TOGGLE_ON or THEME.TOGGLE_OFF}):Play()
        TweenService:Create(knob, TweenInfo.new(0.15, Enum.EasingStyle.Quad),
            {Position = state and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)}):Play()
    end

    hitbox.MouseButton1Click:Connect(function()
        state = not state
        Refresh()
        if callback then callback(state) end
    end)

    return frame
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
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)

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
                if btn and btn.Parent then btn.BackgroundColor3 = THEME.BTN end
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
    local function Half(t, cb)
        local b = Instance.new("TextButton")
        b.Size = UDim2.new(0.5, -3, 1, 0)
        b.BackgroundColor3 = THEME.BTN
        b.BorderSizePixel = 0
        b.Text = t
        b.TextColor3 = Color3.fromRGB(255, 255, 255)
        b.TextSize = 11
        b.Font = Enum.Font.GothamBold
        b.ZIndex = 3
        b.Parent = row
        Instance.new("UICorner", b).CornerRadius = UDim.new(0, 8)
        b.MouseButton1Click:Connect(function()
            if cb then
                b.BackgroundColor3 = THEME.ACCENT
                task.delay(0.12, function()
                    if b and b.Parent then b.BackgroundColor3 = THEME.BTN end
                end)
                cb()
            end
        end)
    end
    Half(textA, cbA)
    Half(textB, cbB)
    return row
end

local function MakeInput(labelText, placeholder, callback, parent)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 0, 64)
    frame.BackgroundColor3 = THEME.BG2
    frame.BorderSizePixel = 0
    frame.ZIndex = 2
    frame.Parent = parent
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 8)
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
    Instance.new("UICorner", box).CornerRadius = UDim.new(0, 6)

    box.Focused:Connect(function() stroke.Color = THEME.ACCENT end)
    box.FocusLost:Connect(function()
        stroke.Color = THEME.BORDER
        if callback then callback(box.Text) end
    end)

    return frame, box
end

local function MakeInfoCard(parent)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 0, 38)
    frame.BackgroundColor3 = Color3.fromRGB(18, 22, 38)
    frame.BorderSizePixel = 0
    frame.ZIndex = 2
    frame.Parent = parent
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 8)
    local stroke = Instance.new("UIStroke")
    stroke.Color = THEME.ACCENT
    stroke.Thickness = 1
    stroke.Parent = frame
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, -12, 1, 0)
    lbl.Position = UDim2.new(0, 10, 0, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = "Current: None | Autoload: None"
    lbl.TextColor3 = THEME.STATUS_OK
    lbl.TextSize = 11
    lbl.Font = Enum.Font.Gotham
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.TextWrapped = true
    lbl.ZIndex = 3
    lbl.Parent = frame
    -- Expose setter sebagai closure (bukan method table supaya tidak nil)
    UIRefs.StatusLabel = function(text) lbl.Text = text end
    return frame
end

-- ============================================================
-- BUILD TABS
-- ============================================================

-- Auto Farm Tab
local AutoFarmPage, AutoFarmBtn = AddTab("Auto Farm", "")

MakeSectionLabel("Auto Farm Features", AutoFarmPage)
MakeLabel("README:\n1. Aktifkan Auto Farm\n2. Aktifkan Auto Execute\n3. Aktifkan Disable Killer Chance di game\n4. Save Config lalu Set Autoload\n5. Enjoy!", THEME.TEXT_INFO, AutoFarmPage)

MakeToggle("Enable Auto Farm", false, function(state)
    _G.AutoFarmEnabled = state
    if _G.ConfigData then _G.ConfigData.AutoFarmEnabled = state end
    if state then
        StartAutoFarm()
        SendNotif("Auto Farm", "Auto Farm aktif!", 3)
    else
        SendNotif("Auto Farm", "Auto Farm nonaktif.", 3)
    end
end, AutoFarmPage)

MakeToggle("Auto Execute (Queue on Teleport)", false, function(state)
    SetupAutoExecute(state)
    if state then SendNotif("Auto Execute", "Auto Execute aktif!", 3) end
end, AutoFarmPage)

MakeButton("Manual Server Hop", function()
    SendNotif("Server Hop", "Mencari server lain...", 3)
    HopServer()
end, AutoFarmPage)

-- Config Tab
local ConfigPage, ConfigBtn = AddTab("Config", "")

MakeSectionLabel("Configuration", ConfigPage)
MakeInfoCard(ConfigPage)

local _, configNameBox = MakeInput("Config Name", "Enter the name for u config", function(val)
    _G._configNameInput = val
end, ConfigPage)

local _, externalJSONBox = MakeInput("External Config JSON", "Paste ur raw JSON config here", function(val)
    _G.ExternalJSONInput = val
end, ConfigPage)

MakeTwoButtons("Save Config", function()
    local name = (_G._configNameInput or ""):gsub("^%s+",""):gsub("%s+$","")
    if name == "" and _G.SelectedConfig then name = _G.SelectedConfig end
    SaveConfig(name)
end, "Load Config", function()
    local name = _G.SelectedConfig or (_G._configNameInput or ""):gsub("^%s+",""):gsub("%s+$","")
    if name == "" then SendNotif("Config", "Isi nama config dulu!", 3) return end
    LoadConfigFromFile(ConfigFolder .. name .. ".json")
end, ConfigPage)

MakeTwoButtons("Delete Config", function()
    local name = (_G._configNameInput or ""):gsub("^%s+",""):gsub("%s+$","")
    if name ~= "" then _G.SelectedConfig = name end
    DeleteConfig(_G.SelectedConfig)
end, "Set Autoload", function()
    local name = (_G._configNameInput or ""):gsub("^%s+",""):gsub("%s+$","")
    if name ~= "" then _G.SelectedConfig = name end
    SetAutoload(_G.SelectedConfig)
end, ConfigPage)

MakeTwoButtons("Refresh List", function()
    local list = GetConfigList()
    SendNotif("Config", #list == 0 and "Tidak ada config." or table.concat(list, ", "), 5)
end, "Clear Autoload", function()
    ClearAutoload()
end, ConfigPage)

MakeTwoButtons("Load External JSON", function()
    _G.ExternalJSONInput = externalJSONBox.Text
    LoadFromExternalJSON()
end, "Export Config", function()
    local name = (_G._configNameInput or ""):gsub("^%s+",""):gsub("%s+$","")
    if name ~= "" then _G.SelectedConfig = name end
    ExportConfig(_G.SelectedConfig)
end, ConfigPage)

MakeSectionLabel("Server Configuration", ConfigPage)

MakeToggle("Auto Execute", false, function(state)
    SetupAutoExecute(state)
end, ConfigPage)

MakeButton("Reset All ke Default", function()
    _G.ConfigData = {}
    _G.AutoFarmEnabled = false
    configNameBox.Text = ""
    SendNotif("Config", "Semua direset ke default!", 3)
end, ConfigPage)

-- Info Tab
local InfoPage, InfoBtn = AddTab("Info", "")

MakeSectionLabel("About GanKunZ Hub", InfoPage)
MakeLabel(
    "Hub Name : GanKunZ Hub\nCreator  : GanKunZ Hub\nVersion  : v" .. CURRENT_VERSION .. "\nGame     : Violence District\n\nFitur:\n- Auto Farm Exit Gate\n- Config Manager (Save/Load/Export)\n- Autoload Config\n- Server Hop Otomatis\n- Auto Execute via queue_on_teleport",
    THEME.TEXT, InfoPage
)

MakeSectionLabel("Server Info", InfoPage)
MakeLabel(
    "Job ID: " .. game.JobId:sub(1, 16) .. "...\nPlayers: " .. #Players:GetPlayers() .. "/" .. Players.MaxPlayers,
    THEME.TEXT_DIM, InfoPage
)

-- ============================================================
-- ACTIVATE FIRST TAB (Auto Farm)
-- ============================================================
do
    local firstPage = tabPages["Auto Farm"]
    local firstBtn  = TabBar:FindFirstChild("Auto Farm")
    if firstPage then firstPage.Visible = true end
    if firstBtn then
        firstBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        firstBtn.BackgroundColor3 = THEME.ACCENT2
        local ind = firstBtn:FindFirstChild("Indicator")
        if ind then ind.Visible = true end
    end
    activeTab = "Auto Farm"
end

-- ============================================================
-- STARTUP
-- ============================================================
SafeMakeFolder(mainFolderName)
SafeMakeFolder(ConfigFolder)

StartStatusLoop()
CheckAndAutoload()

task.delay(1, function()
    SendNotif("GanKunZ Hub", "Script loaded! VD Auto Farm v" .. CURRENT_VERSION, 5)
end)

print("[GanKunZ Hub] Violence District Auto Farm v" .. CURRENT_VERSION .. " loaded | Creator: GanKunZ Hub")
