--[[
    GanKunZ Hub - Violence District Auto Farm
    Peaceful Community Edition
    Creator: GanKunZ Hub

    CARA PAKAI:
    1. Aktifkan Enable Auto Farm
    2. Aktifkan Auto Execute
    3. Aktifkan Disable Killer Chance di game
    4. Save Config lalu klik Set Autoload
    5. Enjoy!
--]]

local Players          = game:GetService("Players")
local TweenService     = game:GetService("TweenService")
local HttpService      = game:GetService("HttpService")
local TeleportService  = game:GetService("TeleportService")
local UserInputService = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui   = LocalPlayer.PlayerGui

local CURRENT_VERSION = "1.0.0"
local CREATOR_NAME    = "GanKunZ Hub"
local HUB_NAME        = "GanKunZ Hub"
local mainFolderName  = "GanKunZ Hub_ViolenceAutoFarm"
local ConfigFolder    = mainFolderName .. "/Config/"
local AutoloadConfig  = mainFolderName .. "/autoload.txt"
local AUTO_EXEC_URL   = "https://raw.githubusercontent.com/GrexXMeng/Mengs/refs/heads/main/AutoFarmVD.lua"
local ROBLOX_GAME_API = "https://games.roblox.com/v1/games/"

-- State pakai _G langsung (tidak local override)
_G.AutoFarmEnabled   = _G.AutoFarmEnabled   or false
_G.SelectedConfig    = _G.SelectedConfig    or nil
_G.CurrentLoaded     = _G.CurrentLoaded     or nil
_G.ConfigData        = _G.ConfigData        or {}
_G.AutoloadConfig    = _G.AutoloadConfig    or nil
_G.ExternalJSONInput = _G.ExternalJSONInput or ""
_G.ConfigFolder      = ConfigFolder
_G._configNameInput  = _G._configNameInput  or ""

local StatusLabelSetter = nil  -- closure, diisi saat GUI dibangun

local THEME = {
    BG          = Color3.fromRGB(18, 18, 28),
    SIDEBAR     = Color3.fromRGB(24, 24, 38),
    CONTENT     = Color3.fromRGB(22, 22, 34),
    CARD        = Color3.fromRGB(30, 30, 46),
    CARD2       = Color3.fromRGB(26, 26, 40),
    ACCENT      = Color3.fromRGB(120, 80, 220),
    ACCENT2     = Color3.fromRGB(80, 50, 180),
    ACCENT_DIM  = Color3.fromRGB(50, 35, 110),
    SECTION_TXT = Color3.fromRGB(160, 120, 255),
    TEXT        = Color3.fromRGB(215, 212, 235),
    TEXT_DIM    = Color3.fromRGB(130, 125, 160),
    TEXT_INFO   = Color3.fromRGB(255, 210, 90),
    TOGGLE_ON   = Color3.fromRGB(85, 195, 115),
    TOGGLE_OFF  = Color3.fromRGB(55, 53, 82),
    BTN         = Color3.fromRGB(60, 42, 140),
    BTN_HOVER   = Color3.fromRGB(90, 65, 185),
    SCROLLBAR   = Color3.fromRGB(100, 65, 200),
    BORDER      = Color3.fromRGB(55, 45, 105),
    STATUS_OK   = Color3.fromRGB(95, 220, 140),
    TITLEBAR    = Color3.fromRGB(20, 20, 32),
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
            game.StarterGui:SetCore("SendNotification", {
                Title = "[" .. HUB_NAME .. "] " .. title,
                Text  = text,
                Duration = duration,
            })
        end)
    end
end

local function UpdateStatus(text)
    if StatusLabelSetter then
        pcall(StatusLabelSetter, text)
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
    for _, fp in ipairs(files) do
        local name = tostring(fp):match("([^/\\]+)$")
        if name then table.insert(list, name:gsub("%.json$", "")) end
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
        SendNotif("Config", "Nama config kosong!", 3) return
    end
    SafeMakeFolder(mainFolderName)
    SafeMakeFolder(ConfigFolder)
    local data = { AutoFarmEnabled = _G.AutoFarmEnabled, Version = CURRENT_VERSION, Creator = CREATOR_NAME }
    SafeWriteFile(ConfigFolder .. configName .. ".json", HttpService:JSONEncode(data))
    SendNotif("Config", "Config '" .. configName .. "' disimpan!", 4)
end

local function LoadConfigFromFile(configPath)
    local ok, content = SafeReadFile(configPath)
    if not ok or not content then SendNotif("Config", "Gagal baca file!", 3) return end
    local parseOk, configData = pcall(function() return HttpService:JSONDecode(content) end)
    if not parseOk or type(configData) ~= "table" then SendNotif("Config", "Format tidak valid!", 3) return end
    LoadConfigElements(configData)
    _G.CurrentLoaded = configPath
    local cname = (configPath:match("([^/\\]+)$") or configPath):gsub("%.json$", "")
    local aname = "None"
    if isfile(AutoloadConfig) then
        local aok, ac = SafeReadFile(AutoloadConfig)
        if aok and ac then aname = (ac:match("([^/\\]+)$") or ac):gsub("%.json$", "") end
    end
    UpdateStatus("Current: " .. cname .. " | Autoload: " .. aname)
    SendNotif("Config", "Config '" .. cname .. "' di-load!", 4)
end

local function DeleteConfig(configName)
    if not configName or configName == "" then SendNotif("Config", "Pilih config dulu!", 3) return end
    SafeDelFile(ConfigFolder .. configName .. ".json")
    _G.SelectedConfig = nil
    SendNotif("Config", "Config '" .. configName .. "' dihapus!", 3)
end

local function SetAutoload(configName)
    if not configName or configName == "" then SendNotif("Autoload", "Pilih config dulu!", 3) return end
    SafeMakeFolder(mainFolderName)
    SafeWriteFile(AutoloadConfig, ConfigFolder .. configName .. ".json")
    _G.AutoloadConfig = ConfigFolder .. configName .. ".json"
    local cname = ((_G.CurrentLoaded or ""):match("([^/\\]+)$") or "None"):gsub("%.json$", "")
    UpdateStatus("Current: " .. cname .. " | Autoload: " .. configName)
    SendNotif("Autoload", "Autoload ke '" .. configName .. "' diset!", 4)
end

local function ClearAutoload()
    SafeDelFile(AutoloadConfig)
    _G.AutoloadConfig = nil
    local cname = ((_G.CurrentLoaded or "None"):match("([^/\\]+)$") or "None"):gsub("%.json$", "")
    UpdateStatus("Current: " .. cname .. " | Autoload: None")
    SendNotif("Autoload", "Autoload dihapus!", 3)
end

local function ExportConfig(configName)
    if not configName or configName == "" then SendNotif("Export", "Load config dulu!", 4) return end
    local ok, content = SafeReadFile(ConfigFolder .. configName .. ".json")
    if ok and content then
        if setclipboard then setclipboard(content) SendNotif("Export", "Di-copy ke clipboard!", 4)
        else SendNotif("Export", "Executor tidak support clipboard!", 3) end
    else SendNotif("Export", "Gagal baca config!", 3) end
end

local function LoadFromExternalJSON()
    local jsonText = _G.ExternalJSONInput or ""
    if jsonText == "" then SendNotif("External JSON", "Input kosong!", 3) return end
    local ok, configData = pcall(function() return HttpService:JSONDecode(jsonText) end)
    if not ok or type(configData) ~= "table" then SendNotif("External JSON", "JSON tidak valid!", 3) return end
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
    if queue_on_teleport then pcall(queue_on_teleport, execScript)
    else SendNotif("Auto Execute", "Executor tidak support queue_on_teleport", 5) end
end

-- ============================================================
-- SERVER HOP
-- ============================================================

local function HopServer()
    local url = ROBLOX_GAME_API .. tostring(game.PlaceId) .. "/servers/Public?sortOrder=Asc&limit=100"
    local ok, result = pcall(function() return HttpService:JSONDecode(game:HttpGet(url)) end)
    if not ok or not result or not result.data then
        SendNotif("Server Hop", "Gagal ambil server list!", 3) return false
    end
    local servers = result.data
    for i = #servers, 2, -1 do
        local j = math.random(i)
        servers[i], servers[j] = servers[j], servers[i]
    end
    for _, server in ipairs(servers) do
        if server.id and server.id ~= game.JobId then
            local hopped = pcall(function()
                TeleportService:TeleportToPlaceInstance(game.PlaceId, server.id, LocalPlayer)
            end)
            if hopped then return true end
        end
    end
    SendNotif("Server Hop", "Hop gagal!", 4) return false
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
    local char = LocalPlayer.Character
    local hrp  = char and char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    local candidates = {}
    for _, n in ipairs({"LeftGate","RightGate","Finishline","Fininshline"}) do
        local g = workspace:FindFirstChild(n)
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
        local d = (GetPos(gate).Position - hrp.Position).Magnitude
        if d < bestDist then bestDist = d; best = gate end
    end
    if not best then return end
    local tween = TweenService:Create(hrp, TweenInfo.new(2, Enum.EasingStyle.Linear), {CFrame = GetPos(best)})
    tween:Play()
    tween.Completed:Connect(function() SendNotif("Auto Farm", "Exit gate berhasil!", 3) end)
end

local function StartAutoFarm()
    if not _G.AutoFarmEnabled then return end
    task.spawn(function()
        while _G.AutoFarmEnabled do
            pcall(function()
                if workspace:FindFirstChild("Map") then task.wait(5) HopServer() return end
                local pc = #Players:GetPlayers()
                if pc < 4 then
                    SendNotif("Auto Farm", "Player kurang (" .. pc .. "), hop...", 4)
                    task.wait(3) HopServer() return
                end
                task.wait(2)
                if GetPlayerTeam(LocalPlayer) == "Killer" then
                    SendNotif("Auto Farm", "Dapat Killer, hop...", 4)
                    task.wait(2) HopServer() return
                end
                while _G.AutoFarmEnabled do
                    task.wait(0.5) TryExitGate() task.wait(1)
                    if GetPlayerTeam(LocalPlayer) == "Spectator" then task.wait(3) break end
                end
            end)
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
            local cname = "None"
            if _G.CurrentLoaded then
                cname = (_G.CurrentLoaded:match("([^/\\]+)$") or _G.CurrentLoaded):gsub("%.json$","")
            end
            local aname = "None"
            if isfile(AutoloadConfig) then
                local aok, ac = SafeReadFile(AutoloadConfig)
                if aok and ac then aname = (ac:match("([^/\\]+)$") or ac):gsub("%.json$","") end
            end
            UpdateStatus("Current: " .. cname .. " | Autoload: " .. aname)
        end
    end)
end

local function CheckAndAutoload()
    task.spawn(function()
        task.wait(2)
        if isfile(AutoloadConfig) then
            local ok, path = SafeReadFile(AutoloadConfig)
            if ok and path and path ~= "" then
                _G.AutoloadConfig = path
                task.wait(1) LoadConfigFromFile(path)
                task.wait(0.5) if _G.AutoFarmEnabled then StartAutoFarm() end
            end
        end
    end)
end

-- ============================================================
-- GUI - SIDEBAR LAYOUT (mirip Meng Hub)
-- ============================================================

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

-- Shadow drop
local Shadow = Instance.new("Frame")
Shadow.Name = "Shadow"
Shadow.Size = UDim2.new(0, 724, 0, 424)
Shadow.Position = UDim2.new(0.5, -366, 0.5, -216)
Shadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Shadow.BackgroundTransparency = 0.45
Shadow.BorderSizePixel = 0
Shadow.ZIndex = 0
Shadow.Parent = ScreenGui
Instance.new("UICorner", Shadow).CornerRadius = UDim.new(0, 18)

-- Main container (720x420 - landscape, mirip Meng Hub)
local Main = Instance.new("Frame")
Main.Name = "Main"
Main.Size = UDim2.new(0, 720, 0, 420)
Main.Position = UDim2.new(0.5, -360, 0.5, -210)
Main.BackgroundColor3 = THEME.BG
Main.BorderSizePixel = 0
Main.Active = true
Main.ZIndex = 1
Main.Parent = ScreenGui
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 16)
local MainStroke = Instance.new("UIStroke")
MainStroke.Color = THEME.BORDER
MainStroke.Thickness = 1
MainStroke.Parent = Main

-- ============================================================
-- DRAG SYSTEM (UIS manual, shadow ikut)
-- ============================================================
do
    local dragging  = false
    local dragStart = nil
    local startPos  = nil

    local function SyncShadow()
        local ap = Main.AbsolutePosition
        Shadow.Position = UDim2.new(0, ap.X - 2, 0, ap.Y - 2)
    end
    task.defer(SyncShadow)

    Main.InputBegan:Connect(function(input)
        local t = input.UserInputType
        if t == Enum.UserInputType.MouseButton1 or t == Enum.UserInputType.Touch then
            local relY = input.Position.Y - Main.AbsolutePosition.Y
            if relY <= 46 then
                dragging  = true
                dragStart = input.Position
                startPos  = Main.Position
                input.Changed:Connect(function()
                    if input.UserInputState == Enum.UserInputState.End then dragging = false end
                end)
            end
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        local t = input.UserInputType
        if dragging and (t == Enum.UserInputType.MouseMovement or t == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            Main.Position = UDim2.new(
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
-- TITLE BAR (top strip, full width)
-- ============================================================
local TitleBar = Instance.new("Frame")
TitleBar.Name = "TitleBar"
TitleBar.Size = UDim2.new(1, 0, 0, 46)
TitleBar.BackgroundColor3 = THEME.TITLEBAR
TitleBar.BorderSizePixel = 0
TitleBar.ZIndex = 3
TitleBar.Parent = Main
Instance.new("UICorner", TitleBar).CornerRadius = UDim.new(0, 16)

-- Cover bawah title bar (flatten bottom corners)
local TitleCover = Instance.new("Frame")
TitleCover.Size = UDim2.new(1, 0, 0, 16)
TitleCover.Position = UDim2.new(0, 0, 1, -16)
TitleCover.BackgroundColor3 = THEME.TITLEBAR
TitleCover.BorderSizePixel = 0
TitleCover.ZIndex = 3
TitleCover.Parent = TitleBar

-- Separator line bawah title bar
local TitleSep = Instance.new("Frame")
TitleSep.Size = UDim2.new(1, 0, 0, 1)
TitleSep.Position = UDim2.new(0, 0, 1, -1)
TitleSep.BackgroundColor3 = THEME.BORDER
TitleSep.BorderSizePixel = 0
TitleSep.ZIndex = 4
TitleSep.Parent = TitleBar

-- Icon lingkaran kecil
local IconCircle = Instance.new("Frame")
IconCircle.Size = UDim2.new(0, 28, 0, 28)
IconCircle.Position = UDim2.new(0, 10, 0.5, -14)
IconCircle.BackgroundColor3 = THEME.ACCENT
IconCircle.BorderSizePixel = 0
IconCircle.ZIndex = 4
IconCircle.Parent = TitleBar
Instance.new("UICorner", IconCircle).CornerRadius = UDim.new(1, 0)
local IconLetter = Instance.new("TextLabel")
IconLetter.Size = UDim2.new(1, 0, 1, 0)
IconLetter.BackgroundTransparency = 1
IconLetter.Text = "G"
IconLetter.TextColor3 = Color3.fromRGB(255,255,255)
IconLetter.TextSize = 14
IconLetter.Font = Enum.Font.GothamBold
IconLetter.ZIndex = 5
IconLetter.Parent = IconCircle

-- Hub name
local HubNameLabel = Instance.new("TextLabel")
HubNameLabel.Size = UDim2.new(0, 180, 1, 0)
HubNameLabel.Position = UDim2.new(0, 46, 0, 0)
HubNameLabel.BackgroundTransparency = 1
HubNameLabel.Text = "GanKunZ Hub"
HubNameLabel.TextColor3 = Color3.fromRGB(255,255,255)
HubNameLabel.TextSize = 14
HubNameLabel.Font = Enum.Font.GothamBold
HubNameLabel.TextXAlignment = Enum.TextXAlignment.Left
HubNameLabel.ZIndex = 4
HubNameLabel.Parent = TitleBar

-- Separator vertikal
local TitleVSep = Instance.new("Frame")
TitleVSep.Size = UDim2.new(0, 1, 0, 22)
TitleVSep.Position = UDim2.new(0, 228, 0.5, -11)
TitleVSep.BackgroundColor3 = THEME.BORDER
TitleVSep.BorderSizePixel = 0
TitleVSep.ZIndex = 4
TitleVSep.Parent = TitleBar

-- Subtitle (community)
local CommLabel = Instance.new("TextLabel")
CommLabel.Size = UDim2.new(0, 180, 1, 0)
CommLabel.Position = UDim2.new(0, 236, 0, 0)
CommLabel.BackgroundTransparency = 1
CommLabel.Text = "Peacefull Community"
CommLabel.TextColor3 = THEME.TEXT_DIM
CommLabel.TextSize = 12
CommLabel.Font = Enum.Font.Gotham
CommLabel.TextXAlignment = Enum.TextXAlignment.Left
CommLabel.ZIndex = 4
CommLabel.Parent = TitleBar

-- Game tag badge (kanan, sebelum close/min)
local GameTag = Instance.new("Frame")
GameTag.Size = UDim2.new(0, 110, 0, 24)
GameTag.Position = UDim2.new(1, -194, 0.5, -12)
GameTag.BackgroundColor3 = THEME.ACCENT_DIM
GameTag.BorderSizePixel = 0
GameTag.ZIndex = 4
GameTag.Parent = TitleBar
Instance.new("UICorner", GameTag).CornerRadius = UDim.new(0, 6)
local GameTagStroke = Instance.new("UIStroke")
GameTagStroke.Color = THEME.ACCENT
GameTagStroke.Thickness = 1
GameTagStroke.Parent = GameTag
local GameTagLbl = Instance.new("TextLabel")
GameTagLbl.Size = UDim2.new(1, 0, 1, 0)
GameTagLbl.BackgroundTransparency = 1
GameTagLbl.Text = "VD | Auto Farming"
GameTagLbl.TextColor3 = THEME.SECTION_TXT
GameTagLbl.TextSize = 11
GameTagLbl.Font = Enum.Font.GothamBold
GameTagLbl.ZIndex = 5
GameTagLbl.Parent = GameTag

-- Minimize button
local MinBtn = Instance.new("TextButton")
MinBtn.Size = UDim2.new(0, 24, 0, 24)
MinBtn.Position = UDim2.new(1, -74, 0.5, -12)
MinBtn.BackgroundColor3 = Color3.fromRGB(180,140,30)
MinBtn.BorderSizePixel = 0
MinBtn.Text = "-"
MinBtn.TextColor3 = Color3.fromRGB(255,255,255)
MinBtn.TextSize = 14
MinBtn.Font = Enum.Font.GothamBold
MinBtn.ZIndex = 5
MinBtn.Parent = TitleBar
Instance.new("UICorner", MinBtn).CornerRadius = UDim.new(1, 0)

-- Close button
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 24, 0, 24)
CloseBtn.Position = UDim2.new(1, -42, 0.5, -12)
CloseBtn.BackgroundColor3 = Color3.fromRGB(190, 55, 55)
CloseBtn.BorderSizePixel = 0
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255,255,255)
CloseBtn.TextSize = 12
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.ZIndex = 5
CloseBtn.Parent = TitleBar
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(1, 0)

CloseBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

-- ============================================================
-- BODY (di bawah title bar)
-- ============================================================
local Body = Instance.new("Frame")
Body.Name = "Body"
Body.Size = UDim2.new(1, 0, 1, -46)
Body.Position = UDim2.new(0, 0, 0, 46)
Body.BackgroundTransparency = 1
Body.ZIndex = 2
Body.Parent = Main

-- ============================================================
-- SIDEBAR KIRI (lebar 160px, seperti Meng Hub)
-- ============================================================
local Sidebar = Instance.new("Frame")
Sidebar.Name = "Sidebar"
Sidebar.Size = UDim2.new(0, 158, 1, 0)
Sidebar.BackgroundColor3 = THEME.SIDEBAR
Sidebar.BorderSizePixel = 0
Sidebar.ZIndex = 3
Sidebar.Parent = Body

-- Sidebar rounded hanya kiri bawah
local SidebarCorner = Instance.new("UICorner")
SidebarCorner.CornerRadius = UDim.new(0, 16)
SidebarCorner.Parent = Sidebar

-- Cover kanan atas sidebar (flatten top-right corner)
local SidebarCoverTR = Instance.new("Frame")
SidebarCoverTR.Size = UDim2.new(0, 16, 0, 16)
SidebarCoverTR.Position = UDim2.new(1, -16, 0, 0)
SidebarCoverTR.BackgroundColor3 = THEME.SIDEBAR
SidebarCoverTR.BorderSizePixel = 0
SidebarCoverTR.ZIndex = 3
SidebarCoverTR.Parent = Sidebar

-- Cover kanan atas di MAIN (buat separasi sidebar dan content)
local SidebarSep = Instance.new("Frame")
SidebarSep.Size = UDim2.new(0, 1, 1, 0)
SidebarSep.Position = UDim2.new(0, 158, 0, 0)
SidebarSep.BackgroundColor3 = THEME.BORDER
SidebarSep.BorderSizePixel = 0
SidebarSep.ZIndex = 2
SidebarSep.Parent = Body

-- Search bar di sidebar atas
local SearchFrame = Instance.new("Frame")
SearchFrame.Size = UDim2.new(1, -16, 0, 30)
SearchFrame.Position = UDim2.new(0, 8, 0, 8)
SearchFrame.BackgroundColor3 = THEME.CARD2
SearchFrame.BorderSizePixel = 0
SearchFrame.ZIndex = 4
SearchFrame.Parent = Sidebar
Instance.new("UICorner", SearchFrame).CornerRadius = UDim.new(0, 8)
local SearchStroke = Instance.new("UIStroke")
SearchStroke.Color = THEME.BORDER
SearchStroke.Thickness = 1
SearchStroke.Parent = SearchFrame
local SearchIcon = Instance.new("TextLabel")
SearchIcon.Size = UDim2.new(0, 20, 1, 0)
SearchIcon.Position = UDim2.new(0, 6, 0, 0)
SearchIcon.BackgroundTransparency = 1
SearchIcon.Text = "S"
SearchIcon.TextColor3 = THEME.TEXT_DIM
SearchIcon.TextSize = 12
SearchIcon.Font = Enum.Font.GothamBold
SearchIcon.ZIndex = 5
SearchIcon.Parent = SearchFrame
local SearchLabel = Instance.new("TextLabel")
SearchLabel.Size = UDim2.new(1, -28, 1, 0)
SearchLabel.Position = UDim2.new(0, 24, 0, 0)
SearchLabel.BackgroundTransparency = 1
SearchLabel.Text = "Search..."
SearchLabel.TextColor3 = THEME.TEXT_DIM
SearchLabel.TextSize = 12
SearchLabel.Font = Enum.Font.Gotham
SearchLabel.TextXAlignment = Enum.TextXAlignment.Left
SearchLabel.ZIndex = 5
SearchLabel.Parent = SearchFrame

-- Nav list di sidebar
local NavList = Instance.new("Frame")
NavList.Size = UDim2.new(1, 0, 1, -56)
NavList.Position = UDim2.new(0, 0, 0, 46)
NavList.BackgroundTransparency = 1
NavList.ZIndex = 3
NavList.Parent = Sidebar
local NavLayout = Instance.new("UIListLayout")
NavLayout.Padding = UDim.new(0, 2)
NavLayout.Parent = NavList
local NavPad = Instance.new("UIPadding")
NavPad.PaddingLeft  = UDim.new(0, 6)
NavPad.PaddingRight = UDim.new(0, 6)
NavPad.PaddingTop   = UDim.new(0, 4)
NavPad.Parent = NavList

-- User badge di bawah sidebar
local UserBadge = Instance.new("Frame")
UserBadge.Size = UDim2.new(1, -12, 0, 36)
UserBadge.Position = UDim2.new(0, 6, 1, -44)
UserBadge.BackgroundColor3 = THEME.CARD2
UserBadge.BorderSizePixel = 0
UserBadge.ZIndex = 4
UserBadge.Parent = Sidebar
Instance.new("UICorner", UserBadge).CornerRadius = UDim.new(0, 10)
local UBStroke = Instance.new("UIStroke")
UBStroke.Color = THEME.BORDER
UBStroke.Thickness = 1
UBStroke.Parent = UserBadge

-- Avatar circle
local AvatarCircle = Instance.new("Frame")
AvatarCircle.Size = UDim2.new(0, 24, 0, 24)
AvatarCircle.Position = UDim2.new(0, 6, 0.5, -12)
AvatarCircle.BackgroundColor3 = THEME.ACCENT
AvatarCircle.BorderSizePixel = 0
AvatarCircle.ZIndex = 5
AvatarCircle.Parent = UserBadge
Instance.new("UICorner", AvatarCircle).CornerRadius = UDim.new(1, 0)
local AvatarLetter = Instance.new("TextLabel")
AvatarLetter.Size = UDim2.new(1, 0, 1, 0)
AvatarLetter.BackgroundTransparency = 1
AvatarLetter.Text = LocalPlayer.Name:sub(1,1):upper()
AvatarLetter.TextColor3 = Color3.fromRGB(255,255,255)
AvatarLetter.TextSize = 12
AvatarLetter.Font = Enum.Font.GothamBold
AvatarLetter.ZIndex = 6
AvatarLetter.Parent = AvatarCircle

local pName = LocalPlayer.Name
local dispName = (#pName > 3) and (pName:sub(1, #pName-3) .. "***") or pName
local WelcomeLabel = Instance.new("TextLabel")
WelcomeLabel.Size = UDim2.new(1, -38, 1, 0)
WelcomeLabel.Position = UDim2.new(0, 34, 0, 0)
WelcomeLabel.BackgroundTransparency = 1
WelcomeLabel.Text = "Welcome, " .. dispName
WelcomeLabel.TextColor3 = THEME.TEXT
WelcomeLabel.TextSize = 11
WelcomeLabel.Font = Enum.Font.Gotham
WelcomeLabel.TextXAlignment = Enum.TextXAlignment.Left
WelcomeLabel.TextTruncate = Enum.TextTruncate.AtEnd
WelcomeLabel.ZIndex = 5
WelcomeLabel.Parent = UserBadge

-- ============================================================
-- CONTENT AREA (kanan sidebar)
-- ============================================================
local ContentArea = Instance.new("Frame")
ContentArea.Name = "ContentArea"
ContentArea.Size = UDim2.new(1, -159, 1, 0)
ContentArea.Position = UDim2.new(0, 159, 0, 0)
ContentArea.BackgroundColor3 = THEME.CONTENT
ContentArea.BorderSizePixel = 0
ContentArea.ClipsDescendants = true
ContentArea.ZIndex = 2
ContentArea.Parent = Body

-- Rounded kanan bawah saja
local ContentCorner = Instance.new("UICorner")
ContentCorner.CornerRadius = UDim.new(0, 16)
ContentCorner.Parent = ContentArea

-- Cover kiri atas dan kiri bawah content (flatten left corners)
local ContentCoverL = Instance.new("Frame")
ContentCoverL.Size = UDim2.new(0, 16, 1, 0)
ContentCoverL.Position = UDim2.new(0, 0, 0, 0)
ContentCoverL.BackgroundColor3 = THEME.CONTENT
ContentCoverL.BorderSizePixel = 0
ContentCoverL.ZIndex = 2
ContentCoverL.Parent = ContentArea

-- ============================================================
-- TAB PAGES (satu page per nav item)
-- ============================================================
local tabPages = {}
local activeNav = nil

local function CreatePage()
    local page = Instance.new("ScrollingFrame")
    page.Size = UDim2.new(1, -4, 1, -4)
    page.Position = UDim2.new(0, 2, 0, 2)
    page.BackgroundTransparency = 1
    page.ScrollBarThickness = 3
    page.ScrollBarImageColor3 = THEME.SCROLLBAR
    page.CanvasSize = UDim2.new(0, 0, 0, 0)
    page.AutomaticCanvasSize = Enum.AutomaticSize.Y
    page.BorderSizePixel = 0
    page.Visible = false
    page.ZIndex = 3
    page.Parent = ContentArea

    local pl = Instance.new("UIListLayout")
    pl.Padding = UDim.new(0, 6)
    pl.Parent = page

    local pp = Instance.new("UIPadding")
    pp.PaddingLeft   = UDim.new(0, 10)
    pp.PaddingRight  = UDim.new(0, 12)
    pp.PaddingTop    = UDim.new(0, 8)
    pp.PaddingBottom = UDim.new(0, 10)
    pp.Parent = page

    return page
end

-- ============================================================
-- NAV ITEM BUILDER
-- ============================================================
local function AddNavItem(label, icon)
    local page = CreatePage()
    tabPages[label] = page

    local btn = Instance.new("TextButton")
    btn.Name = label
    btn.Size = UDim2.new(1, 0, 0, 36)
    btn.BackgroundColor3 = THEME.SIDEBAR
    btn.BorderSizePixel = 0
    btn.Text = ""
    btn.ZIndex = 4
    btn.Parent = NavList
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)

    -- Active indicator (strip kiri)
    local ActiveBar = Instance.new("Frame")
    ActiveBar.Name = "ActiveBar"
    ActiveBar.Size = UDim2.new(0, 3, 0, 18)
    ActiveBar.Position = UDim2.new(0, 2, 0.5, -9)
    ActiveBar.BackgroundColor3 = THEME.ACCENT
    ActiveBar.BorderSizePixel = 0
    ActiveBar.Visible = false
    ActiveBar.ZIndex = 5
    ActiveBar.Parent = btn
    Instance.new("UICorner", ActiveBar).CornerRadius = UDim.new(1, 0)

    -- Icon label
    local IconLbl = Instance.new("TextLabel")
    IconLbl.Size = UDim2.new(0, 24, 1, 0)
    IconLbl.Position = UDim2.new(0, 10, 0, 0)
    IconLbl.BackgroundTransparency = 1
    IconLbl.Text = icon or ""
    IconLbl.TextColor3 = THEME.TEXT_DIM
    IconLbl.TextSize = 14
    IconLbl.Font = Enum.Font.GothamBold
    IconLbl.ZIndex = 5
    IconLbl.Parent = btn

    -- Label text
    local NavLbl = Instance.new("TextLabel")
    NavLbl.Size = UDim2.new(1, -38, 1, 0)
    NavLbl.Position = UDim2.new(0, 36, 0, 0)
    NavLbl.BackgroundTransparency = 1
    NavLbl.Text = label
    NavLbl.TextColor3 = THEME.TEXT_DIM
    NavLbl.TextSize = 13
    NavLbl.Font = Enum.Font.GothamBold
    NavLbl.TextXAlignment = Enum.TextXAlignment.Left
    NavLbl.ZIndex = 5
    NavLbl.Parent = btn

    btn.MouseButton1Click:Connect(function()
        -- Deactivate semua
        for tName, tPage in pairs(tabPages) do
            tPage.Visible = false
            local tBtn = NavList:FindFirstChild(tName)
            if tBtn then
                tBtn.BackgroundColor3 = THEME.SIDEBAR
                local bar = tBtn:FindFirstChild("ActiveBar")
                if bar then bar.Visible = false end
                local lbl = tBtn:FindFirstChildWhichIsA("TextLabel", true)
                -- cari NavLbl (kedua textlabel)
                for _, child in ipairs(tBtn:GetChildren()) do
                    if child:IsA("TextLabel") then
                        child.TextColor3 = THEME.TEXT_DIM
                    end
                end
            end
        end
        -- Activate ini
        page.Visible = true
        btn.BackgroundColor3 = THEME.ACCENT_DIM
        ActiveBar.Visible = true
        IconLbl.TextColor3 = THEME.SECTION_TXT
        NavLbl.TextColor3 = Color3.fromRGB(255,255,255)
        activeNav = label
    end)

    return page, btn
end

-- ============================================================
-- GUI ELEMENT BUILDERS (untuk isi page)
-- ============================================================

-- Section header (collapsible-looking, seperti Meng Hub)
local function MakeSectionHeader(text, parent)
    local row = Instance.new("Frame")
    row.Size = UDim2.new(1, 0, 0, 30)
    row.BackgroundTransparency = 1
    row.ZIndex = 3
    row.Parent = parent

    local rl = Instance.new("UIListLayout")
    rl.FillDirection = Enum.FillDirection.Horizontal
    rl.VerticalAlignment = Enum.VerticalAlignment.Center
    rl.Parent = row

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, -30, 1, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = text
    lbl.TextColor3 = THEME.SECTION_TXT
    lbl.TextSize = 13
    lbl.Font = Enum.Font.GothamBold
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.ZIndex = 4
    lbl.Parent = row

    local arrow = Instance.new("TextLabel")
    arrow.Size = UDim2.new(0, 24, 1, 0)
    arrow.BackgroundTransparency = 1
    arrow.Text = "v"
    arrow.TextColor3 = THEME.SECTION_TXT
    arrow.TextSize = 12
    arrow.Font = Enum.Font.GothamBold
    arrow.ZIndex = 4
    arrow.Parent = row

    return row
end

-- Card wrapper (container dengan background dan border)
local function MakeCard(parent, height)
    local card = Instance.new("Frame")
    card.Size = UDim2.new(1, 0, 0, height or 40)
    card.BackgroundColor3 = THEME.CARD
    card.BorderSizePixel = 0
    card.ZIndex = 3
    card.Parent = parent
    Instance.new("UICorner", card).CornerRadius = UDim.new(0, 8)
    local s = Instance.new("UIStroke")
    s.Color = THEME.BORDER
    s.Thickness = 1
    s.Parent = card
    return card
end

-- Toggle
local function MakeToggle(text, default, callback, parent)
    local card = MakeCard(parent, 40)
    card.AutomaticSize = Enum.AutomaticSize.None

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, -70, 1, 0)
    lbl.Position = UDim2.new(0, 12, 0, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = text
    lbl.TextColor3 = THEME.TEXT
    lbl.TextSize = 13
    lbl.Font = Enum.Font.Gotham
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.ZIndex = 4
    lbl.Parent = card

    local state = default or false

    local track = Instance.new("Frame")
    track.Size = UDim2.new(0, 44, 0, 22)
    track.Position = UDim2.new(1, -54, 0.5, -11)
    track.BackgroundColor3 = state and THEME.TOGGLE_ON or THEME.TOGGLE_OFF
    track.BorderSizePixel = 0
    track.ZIndex = 4
    track.Parent = card
    Instance.new("UICorner", track).CornerRadius = UDim.new(1, 0)

    local knob = Instance.new("Frame")
    knob.Size = UDim2.new(0, 16, 0, 16)
    knob.Position = state and UDim2.new(1,-18,0.5,-8) or UDim2.new(0,2,0.5,-8)
    knob.BackgroundColor3 = Color3.fromRGB(255,255,255)
    knob.BorderSizePixel = 0
    knob.ZIndex = 5
    knob.Parent = track
    Instance.new("UICorner", knob).CornerRadius = UDim.new(1, 0)

    local hitbox = Instance.new("TextButton")
    hitbox.Size = UDim2.new(1, 0, 1, 0)
    hitbox.BackgroundTransparency = 1
    hitbox.Text = ""
    hitbox.ZIndex = 6
    hitbox.Parent = card

    local function Refresh()
        TweenService:Create(track, TweenInfo.new(0.15), {BackgroundColor3 = state and THEME.TOGGLE_ON or THEME.TOGGLE_OFF}):Play()
        TweenService:Create(knob, TweenInfo.new(0.15), {Position = state and UDim2.new(1,-18,0.5,-8) or UDim2.new(0,2,0.5,-8)}):Play()
    end

    hitbox.MouseButton1Click:Connect(function()
        state = not state
        Refresh()
        if callback then callback(state) end
    end)

    return card
end

-- Paragraph / info card
local function MakeParagraph(title, body, parent)
    local card = Instance.new("Frame")
    card.Size = UDim2.new(1, 0, 0, 0)
    card.AutomaticSize = Enum.AutomaticSize.Y
    card.BackgroundColor3 = THEME.CARD
    card.BorderSizePixel = 0
    card.ZIndex = 3
    card.Parent = parent
    Instance.new("UICorner", card).CornerRadius = UDim.new(0, 8)
    local s = Instance.new("UIStroke")
    s.Color = THEME.BORDER
    s.Thickness = 1
    s.Parent = card
    local pad = Instance.new("UIPadding")
    pad.PaddingLeft   = UDim.new(0, 10)
    pad.PaddingRight  = UDim.new(0, 10)
    pad.PaddingTop    = UDim.new(0, 6)
    pad.PaddingBottom = UDim.new(0, 6)
    pad.Parent = card
    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0, 2)
    layout.Parent = card

    if title and title ~= "" then
        local titleLbl = Instance.new("TextLabel")
        titleLbl.Size = UDim2.new(1, 0, 0, 0)
        titleLbl.AutomaticSize = Enum.AutomaticSize.Y
        titleLbl.BackgroundTransparency = 1
        titleLbl.Text = title
        titleLbl.TextColor3 = THEME.SECTION_TXT
        titleLbl.TextSize = 12
        titleLbl.Font = Enum.Font.GothamBold
        titleLbl.TextXAlignment = Enum.TextXAlignment.Left
        titleLbl.TextWrapped = true
        titleLbl.ZIndex = 4
        titleLbl.Parent = card
    end

    local bodyLbl = Instance.new("TextLabel")
    bodyLbl.Size = UDim2.new(1, 0, 0, 0)
    bodyLbl.AutomaticSize = Enum.AutomaticSize.Y
    bodyLbl.BackgroundTransparency = 1
    bodyLbl.Text = body or ""
    bodyLbl.TextColor3 = THEME.TEXT_DIM
    bodyLbl.TextSize = 12
    bodyLbl.Font = Enum.Font.Gotham
    bodyLbl.TextXAlignment = Enum.TextXAlignment.Left
    bodyLbl.TextWrapped = true
    bodyLbl.ZIndex = 4
    bodyLbl.Parent = card

    return card, bodyLbl
end

-- Status card (khusus config manager)
local function MakeStatusCard(parent)
    local card = MakeCard(parent, 38)
    local iconLbl = Instance.new("TextLabel")
    iconLbl.Size = UDim2.new(0, 28, 1, 0)
    iconLbl.Position = UDim2.new(0, 6, 0, 0)
    iconLbl.BackgroundTransparency = 1
    iconLbl.Text = "C"
    iconLbl.TextColor3 = THEME.ACCENT
    iconLbl.TextSize = 14
    iconLbl.Font = Enum.Font.GothamBold
    iconLbl.ZIndex = 4
    iconLbl.Parent = card

    local statusLbl = Instance.new("TextLabel")
    statusLbl.Size = UDim2.new(1, -40, 1, 0)
    statusLbl.Position = UDim2.new(0, 32, 0, 0)
    statusLbl.BackgroundTransparency = 1
    statusLbl.Text = "Current: None | Autoload: None"
    statusLbl.TextColor3 = THEME.STATUS_OK
    statusLbl.TextSize = 11
    statusLbl.Font = Enum.Font.Gotham
    statusLbl.TextXAlignment = Enum.TextXAlignment.Left
    statusLbl.TextWrapped = true
    statusLbl.ZIndex = 4
    statusLbl.Parent = card

    StatusLabelSetter = function(text) statusLbl.Text = text end
    return card
end

-- Input field
local function MakeInput(labelText, placeholder, callback, parent)
    local card = Instance.new("Frame")
    card.Size = UDim2.new(1, 0, 0, 62)
    card.BackgroundColor3 = THEME.CARD
    card.BorderSizePixel = 0
    card.ZIndex = 3
    card.Parent = parent
    Instance.new("UICorner", card).CornerRadius = UDim.new(0, 8)
    local stroke = Instance.new("UIStroke")
    stroke.Color = THEME.BORDER
    stroke.Thickness = 1
    stroke.Parent = card

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, -12, 0, 20)
    lbl.Position = UDim2.new(0, 10, 0, 4)
    lbl.BackgroundTransparency = 1
    lbl.Text = labelText
    lbl.TextColor3 = THEME.TEXT_DIM
    lbl.TextSize = 11
    lbl.Font = Enum.Font.GothamBold
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.ZIndex = 4
    lbl.Parent = card

    local box = Instance.new("TextBox")
    box.Size = UDim2.new(1, -16, 0, 26)
    box.Position = UDim2.new(0, 8, 0, 28)
    box.BackgroundColor3 = THEME.CARD2
    box.BorderSizePixel = 0
    box.PlaceholderText = placeholder or ""
    box.PlaceholderColor3 = THEME.TEXT_DIM
    box.Text = ""
    box.TextColor3 = THEME.TEXT
    box.TextSize = 12
    box.Font = Enum.Font.Gotham
    box.ClearTextOnFocus = false
    box.ZIndex = 4
    box.Parent = card
    Instance.new("UICorner", box).CornerRadius = UDim.new(0, 5)

    box.Focused:Connect(function() stroke.Color = THEME.ACCENT end)
    box.FocusLost:Connect(function()
        stroke.Color = THEME.BORDER
        if callback then callback(box.Text) end
    end)

    return card, box
end

-- Button (full width)
local function MakeButton(text, callback, parent)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 34)
    btn.BackgroundColor3 = THEME.BTN
    btn.BorderSizePixel = 0
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    btn.TextSize = 13
    btn.Font = Enum.Font.GothamBold
    btn.ZIndex = 3
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

-- Two buttons side by side
local function MakeTwoButtons(textA, cbA, textB, cbB, parent)
    local row = Instance.new("Frame")
    row.Size = UDim2.new(1, 0, 0, 34)
    row.BackgroundTransparency = 1
    row.ZIndex = 3
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
        b.TextColor3 = Color3.fromRGB(255,255,255)
        b.TextSize = 12
        b.Font = Enum.Font.GothamBold
        b.ZIndex = 4
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

-- ============================================================
-- BUILD PAGES
-- ============================================================

-- AUTO FARM PAGE
local AutoFarmPage, AutoFarmNavBtn = AddNavItem("Auto Farm", "F")

MakeSectionHeader("Auto Farm Features", AutoFarmPage)
MakeParagraph("README!", "1. Aktifkan Auto Farm Features\n2. Aktifkan Auto Execute\n3. Aktifkan Disable Killer Chance dan jangan lupa Save Config Lalu Set Autoload\n4. Enjoy!", AutoFarmPage)

MakeToggle("Enable Auto Farm", false, function(state)
    _G.AutoFarmEnabled = state
    if _G.ConfigData then _G.ConfigData.AutoFarmEnabled = state end
    if state then StartAutoFarm() SendNotif("Auto Farm", "Auto Farm aktif!", 3)
    else SendNotif("Auto Farm", "Auto Farm nonaktif.", 3) end
end, AutoFarmPage)

MakeToggle("Auto Execute (Queue on Teleport)", false, function(state)
    SetupAutoExecute(state)
    if state then SendNotif("Auto Execute", "Auto Execute aktif!", 3) end
end, AutoFarmPage)

MakeButton("Manual Server Hop", function()
    SendNotif("Server Hop", "Mencari server...", 3)
    HopServer()
end, AutoFarmPage)

-- CONFIGURATION PAGE
local ConfigPage, ConfigNavBtn = AddNavItem("Configuration", "C")

MakeSectionHeader("Configuration", ConfigPage)
MakeStatusCard(ConfigPage)

local _, configNameBox = MakeInput("Config Name", "Enter the name for u config", function(val)
    _G._configNameInput = val
end, ConfigPage)

MakeSectionHeader("", ConfigPage)  -- spacer visual

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
    SendNotif("Config", #list == 0 and "Tidak ada config." or table.concat(list,", "), 5)
end, "Clear Autoload", function()
    ClearAutoload()
end, ConfigPage)

MakeSectionHeader("Load From External", ConfigPage)

local _, externalJSONBox = MakeInput("External Config JSON", "Paste ur raw JSON config here", function(val)
    _G.ExternalJSONInput = val
end, ConfigPage)

MakeTwoButtons("Load External JSON", function()
    _G.ExternalJSONInput = externalJSONBox.Text
    LoadFromExternalJSON()
end, "Export Config", function()
    local name = (_G._configNameInput or ""):gsub("^%s+",""):gsub("%s+$","")
    if name ~= "" then _G.SelectedConfig = name end
    ExportConfig(_G.SelectedConfig)
end, ConfigPage)

MakeSectionHeader("Server Configuration", ConfigPage)

MakeToggle("Auto Execute", false, function(state)
    SetupAutoExecute(state)
end, ConfigPage)

MakeButton("Reset All Elements to Default", function()
    _G.ConfigData = {}
    _G.AutoFarmEnabled = false
    configNameBox.Text = ""
    SendNotif("Config", "Semua direset ke default!", 3)
end, ConfigPage)

-- ============================================================
-- ACTIVATE FIRST TAB
-- ============================================================
do
    local firstPage = tabPages["Auto Farm"]
    if firstPage then firstPage.Visible = true end
    if AutoFarmNavBtn then
        AutoFarmNavBtn.BackgroundColor3 = THEME.ACCENT_DIM
        local bar = AutoFarmNavBtn:FindFirstChild("ActiveBar")
        if bar then bar.Visible = true end
        for _, child in ipairs(AutoFarmNavBtn:GetChildren()) do
            if child:IsA("TextLabel") then
                child.TextColor3 = Color3.fromRGB(255,255,255)
            end
        end
    end
    activeNav = "Auto Farm"
end

-- Minimize
local minimized = false
MinBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    Body.Visible = not minimized
    local targetH = minimized and 46 or 420
    TweenService:Create(Main, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
        Size = UDim2.new(0, 720, 0, targetH)
    }):Play()
    task.delay(0.05, function()
        local ap = Main.AbsolutePosition
        Shadow.Size = minimized and UDim2.new(0,724,0,50) or UDim2.new(0,724,0,424)
        Shadow.Position = UDim2.new(0, ap.X-2, 0, ap.Y-2)
    end)
end)

-- ============================================================
-- STARTUP
-- ============================================================
SafeMakeFolder(mainFolderName)
SafeMakeFolder(ConfigFolder)
StartStatusLoop()
CheckAndAutoload()

task.delay(1, function()
    SendNotif("GanKunZ Hub", "Loaded! VD Auto Farm v" .. CURRENT_VERSION, 5)
end)

print("[GanKunZ Hub] VD Auto Farm v" .. CURRENT_VERSION .. " | Creator: GanKunZ Hub")
