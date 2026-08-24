--[[
    ╔══════════════════════════════════════════════════════════════════╗
    ║                        MENG HUB                                 ║
    ║                   Violence District Script                      ║
    ║        Reconstructed from bytecode dump (Dumped.json)           ║
    ║   A personal project dedicated to my special one, Ameng.        ║
    ╚══════════════════════════════════════════════════════════════════╝
--]]

-- ============================================================
-- [[ SERVICES ]]
-- ============================================================
local Players            = game:GetService("Players")
local RunService         = game:GetService("RunService")
local UserInputService   = game:GetService("UserInputService")
local ContextActionService = game:GetService("ContextActionService")
local TweenService       = game:GetService("TweenService")
local HttpService         = game:GetService("HttpService")
local ReplicatedStorage   = game:GetService("ReplicatedStorage")
local CollectionService   = game:GetService("CollectionService")
local TeleportService    = game:GetService("TeleportService")
local TextService         = game:GetService("TextService")
local SoundService        = game:GetService("SoundService")
local ContentProvider     = game:GetService("ContentProvider")
local VirtualInputManager = game:GetService("VirtualInputManager") 
local StarterGui          = game:GetService("StarterGui")
local Lighting            = game:GetService("Lighting")

-- ============================================================
-- [[ LOCAL PLAYER ]]
-- ============================================================
local LocalPlayer = Players.LocalPlayer
local PlayerGui   = LocalPlayer:WaitForChild("PlayerGui")

-- ============================================================
-- [[ GLOBAL STATE ]]
-- ============================================================
local MengHub = {
    -- Identity
    Name     = "Meng Hub",
    Version  = "Violence District",
    GameId   = game.PlaceId,

    -- Auth
    Key        = "",
    KeyValid   = false,
    IsPremium  = false,
    IsAuthed   = false,
    IsBanned   = false,

    -- Toggle states
    States = {
        -- ESP
        esp                 = false,
        espKiller           = false,
        espSurvivor         = false,
        espGenerator        = false,
        espGate             = false,
        espVault            = false,
        espPallet           = false,
        espObject           = false,
        espZombieDummy      = false,
        espHook             = false,
        espRole             = false,
        espName             = false,
        espDistance         = false,
        espPlatform         = false,
        espStunRing         = false,
        espGeneratorProgress= false,
        espLaserEffect      = false,

        -- Aimbot
        aimbot              = false,
        aimbotFlashlight    = false,
        hiddenAimbot        = false,
        silentAim           = false,
        veilSilentAim       = false,
        spearSilentAim      = false,
        safetySilentAim     = false,
        lockFOV             = false,
        showFOVCircle       = false,
        showVeilFOVCircle   = false,
        wallcheck           = false,

        -- Survivor features
        godMode             = false,
        noclip              = false,
        speedBoost          = false,
        breakSpeed          = false,
        invisibility        = false,
        noFallDamage        = false,
        unlockJump          = false,
        infiniteLunge       = false,
        moonwalk            = false,
        selfHeal            = false,
        autoHook            = false,
        autoVault           = false,
        autoDropPallet      = false,
        safetyDropPallet    = false,
        fastVault           = false,
        blockVaultPallet    = false,
        antiBreakPallet     = false,
        maxZoom             = false,
        noFog               = false,
        fullBright          = false,
        removeDynamicShadow = false,
        lowGraphicsMode     = false,
        xRayWall            = false,
        disableNotification = false,
        pingFpsCounter      = false,
        streamerProtection  = false,
        autoRun             = false,
        hiddenMaskedCounter = false,
        spectatorList       = false,
        hidePlayerIcon      = false,

        -- Auto features
        autoSkillcheckPerfect = false,
        autoAttack            = false,
        autoGenerator         = false,
        autoGeneratorWithTP   = false,
        manualGenerator       = false,
        autoParry             = false,
        triggerAutoParry      = false,
        enableKillerPrediction= false,
        enableMapPrediction   = false,
        enableSpearPrediction = false,
        autoGateTap           = false,
        bypassGenerator       = false,
        instantTPGate         = false,
        trollTeleport         = false,
        skipEndscreen         = false,
        fleeKiller            = false,
        autoRun               = false,
        autoDodgeCrouch       = false,

        -- Killer features
        killAll             = false,

        -- Fake Perks
        fakeFlowstate       = false,
        fakeSnakeStep       = false,
        fakePerfectLanding  = false,
        fakeQuickRecovery   = false,

        -- Emote
        playEmote           = false,

        -- Misc
        followCamera        = false,
        spoofName           = false,
        spoofGold           = false,
        spoofScrew          = false,
        spoofLevel          = false,
        fakeAvatar          = false,
        fakeParryPanel      = false,
        antiStaff           = false,
        enableCrosshair     = false,
        boosterFPS          = false,
        beatGame            = false,
        resetAvatar         = false,
        enableRunSpeed      = false,

        -- Cursor
        enableCursor        = true,

        -- Veil/Masked
        veilAndMasked       = false,

        -- Mobile
        editMode            = false,
    },

    -- Slider/Input values
    Values = {
        fovDegree           = 90,
        killerAimRange      = 40,
        attackRange         = 12,
        fleeDistance        = 40,
        facingThreshold     = 0.5,
        delayBeforeVault    = 0.3,
        gravityScale        = 1,
        speedValue          = 30,
        fakePerksDelay      = 0.5,
        parryRange          = 12,
        killerEscapeDistance= 30,
        breakSpeedPersen    = 40,
        runSpeedPersen      = 40,
        maxFPS              = 60,
    },

    -- Dropdown values
    Dropdowns = {
        skillcheckMode      = "None",
        autoAttackMode      = "Legit",
        speedBoostMode      = "Default",
        selectedEmote       = "Fist",
        moonwalkMode        = "Default",
        selectedHitSound    = "None",
        aimbotFollowCamera  = "Default",
        zombieDummyColor    = "Default Zombie Dummy",
        bypassMode          = "Instant",
    },

    -- ESP Colors
    ESPColors = {
        survivor  = Color3.fromRGB(0, 255, 100),
        killer    = Color3.fromRGB(255, 50, 50),
        generator = Color3.fromRGB(255, 200, 0),
        gate      = Color3.fromRGB(0, 180, 255),
        vault     = Color3.fromRGB(150, 0, 255),
        pallet    = Color3.fromRGB(255, 140, 0),
        hook      = Color3.fromRGB(180, 0, 0),
        object    = Color3.fromRGB(200, 200, 200),
    },

    -- Connections table
    Connections = {},

    -- Config
    ConfigName      = "",
    SelectedConfig  = "",
    AutoloadConfig  = "",
    CurrentLoaded   = "",

    -- Panel state
    panelOpen       = true,
    panelPosition   = UDim2.new(0.5, 0, 0.5, 0),
    savedBtnPos     = {},

    -- Spectator list
    spectators      = {},

    -- Executor info
    ExecutorName    = (identifyexecutor and identifyexecutor() or "Unknown"),

    -- Key system
    KEY_API_VERIFY  = "https://api.jnkie.com/api/v2/keys?key=",
    KEY_API_LINK    = "https://api.jnkie.com/api/v1/whitelist/getKeyOpen",
    KEY_API_VER2    = "https://api.jnkie.com/api/v1/whitelist/verifyOpen",
    DISCORD_INV     = "https://discord.gg/menghub",
    DISCORD_API     = "https://discord.com/api/v9/invites/menghub?with_counts=true",
    WEBHOOK         = "https://discord.com/api/webhooks/1526114608975446027/sIuFVMXgd5C-JwQk9VixXAVoEHcIssmJcKUZZsldPtEX_OMlcmIw0boc20u1a6L9S6Mc",
    ICON_URL        = "https://raw.githubusercontent.com/Meng-Dev1/LAUSAPEMPRUY-/refs/heads/main/ICON",
    SERVER_ROBLOX   = "https://games.roblox.com/v1/games/%s/servers/Public?sortOrder=Desc&limit=100&excludeFullGames=true",
    SERVER_ROBLOX_S = "https://games.roblox.com/v1/games/%s/servers/Public?sortOrder=Asc&limit=100",

    -- Save path
    SAVE_PATH       = "Meng Hub_Violence/",
    CONFIG_PATH     = "Meng Hub_Violence/Config/",
    MOBPANEL_PATH   = "Meng Hub_Violence/MobPanelConfig.json",
    CROSSHAIR_PATH  = "Meng Hub_Violence/MengCrosshairConfig.json",
    BTNPOS_PATH     = "Meng Hub_Violence/Config/ButtonPositions.json",
    KEY_FILE        = "MENGHUB_SAVEDKEY.txt",
    MAIN_FOLDER     = "Meng Hub_Violence",
}

-- ============================================================
-- [[ UTILITY FUNCTIONS ]]
-- ============================================================

local function SendNotif(title, msg, dur)
    pcall(function()
        StarterGui:SetCore("SendNotification", {
            Title    = title or "Meng Hub",
            Text     = msg   or "",
            Duration = dur   or 3,
        })
    end)
end

local function GetRoot(char)
    return char and char:FindFirstChild("HumanoidRootPart")
end

local function GetHumanoid(char)
    return char and char:FindFirstChildOfClass("Humanoid")
end

local function IsPlayerInLobby()
    local char = LocalPlayer.Character
    if not char then return true end
    local hrp = GetRoot(char)
    if not hrp then return true end
    -- Check by team or game state tag
    local team = LocalPlayer.Team
    if team and team.Name == "Lobby" then return true end
    return false
end

local function IsKiller()
    local char = LocalPlayer.Character
    if not char then return false end
    for _, tag in ipairs({"Killer", "killer"}) do
        if char:GetAttribute(tag) then return true end
    end
    local team = LocalPlayer.Team
    if team and (team.Name == "Killer" or team.Name == "killer") then return true end
    return false
end

local function GetPlayers(filterSelf, filterKiller)
    local list = {}
    for _, p in ipairs(Players:GetPlayers()) do
        if filterSelf and p == LocalPlayer then continue end
        if filterKiller and IsKiller() then continue end
        table.insert(list, p)
    end
    return list
end

local function GetCharacterParts(char)
    local parts = {}
    local targets = {"HumanoidRootPart","UpperTorso","Torso","Head","RightUpperArm","RightLowerArm","LeftUpperArm","LeftLowerArm","RightLowerLeg","LeftLowerLeg","RightFoot","LeftFoot","RightHand","LeftHand"}
    for _, name in ipairs(targets) do
        local p = char and char:FindFirstChild(name)
        if p then table.insert(parts, p) end
    end
    return parts
end

local function Lerp(a, b, t)
    return a + (b - a) * t
end

local function MakeConnection(signal, fn)
    local conn = signal:Connect(fn)
    table.insert(MengHub.Connections, conn)
    return conn
end

local function DisconnectAll()
    for _, c in ipairs(MengHub.Connections) do
        pcall(function() c:Disconnect() end)
    end
    MengHub.Connections = {}
end

-- ============================================================
-- [[ FILE I/O (Executor) ]]
-- ============================================================

local function SaveFile(path, content)
    pcall(function()
        if not isfolder(MengHub.MAIN_FOLDER) then makefolder(MengHub.MAIN_FOLDER) end
        if not isfolder(MengHub.CONFIG_PATH) then makefolder(MengHub.CONFIG_PATH) end
        writefile(path, content)
    end)
end

local function ReadFile(path)
    local ok, result = pcall(function() return readfile(path) end)
    if ok then return result end
    return nil
end

local function GetConfigList()
    local list = {}
    pcall(function()
        if isfolder(MengHub.CONFIG_PATH) then
            for _, f in ipairs(listfiles(MengHub.CONFIG_PATH)) do
                local name = f:match("([^/\\]+)$")
                if name and name:match("%.json$") then
                    table.insert(list, name:gsub("%.json$", ""))
                end
            end
        end
    end)
    return list
end

local function SaveConfig(configName)
    if not configName or configName == "" then
        SendNotif("Meng Hub", "Config Name kosong!", 3)
        return
    end
    local data = {
        _version  = 2,
        States    = MengHub.States,
        Values    = MengHub.Values,
        Dropdowns = MengHub.Dropdowns,
        ESPColors = {},
    }
    for k, v in pairs(MengHub.ESPColors) do
        data.ESPColors[k] = {v.R, v.G, v.B}
    end
    local json = HttpService:JSONEncode(data)
    SaveFile(MengHub.CONFIG_PATH .. configName .. ".json", json)
    SendNotif("Meng Hub", "Config '" .. configName .. "' tersimpan!", 3)
end

local function LoadConfig(configName)
    if not configName or configName == "" then
        SendNotif("Meng Hub", "Pilih config terlebih dahulu", 3)
        return
    end
    local raw = ReadFile(MengHub.CONFIG_PATH .. configName .. ".json")
    if not raw then
        SendNotif("Meng Hub", "Config tidak ditemukan!", 3)
        return
    end
    local ok, data = pcall(function() return HttpService:JSONDecode(raw) end)
    if not ok or not data then
        SendNotif("Meng Hub", "JSON tidak valid!", 3)
        return
    end
    if data.States    then for k,v in pairs(data.States)    do MengHub.States[k]    = v end end
    if data.Values    then for k,v in pairs(data.Values)    do MengHub.Values[k]    = v end end
    if data.Dropdowns then for k,v in pairs(data.Dropdowns) do MengHub.Dropdowns[k] = v end end
    MengHub.CurrentLoaded = configName
    SendNotif("Meng Hub", "Config '" .. configName .. "' berhasil dimuat!", 3)
end

local function DeleteConfig(configName)
    if not configName or configName == "" then return end
    pcall(function() delfile(MengHub.CONFIG_PATH .. configName .. ".json") end)
    SendNotif("Meng Hub", "Config '" .. configName .. "' dihapus!", 3)
end

local function SetAutoloadConfig(configName)
    if not configName or configName == "" then
        SendNotif("Meng Hub", "Pilih config terlebih dahulu", 3)
        return
    end
    MengHub.AutoloadConfig = configName
    SaveFile(MengHub.CONFIG_PATH .. "autoload.txt", configName)
    SendNotif("Meng Hub", "Berhasil set config menjadi autoload", 3)
end

local function ClearAutoloadConfig()
    MengHub.AutoloadConfig = ""
    pcall(function() delfile(MengHub.CONFIG_PATH .. "autoload.txt") end)
    SendNotif("Meng Hub", "Berhasil menghapus autoload config", 3)
end

local function ExportConfig()
    local data = {
        _version  = 2,
        States    = MengHub.States,
        Values    = MengHub.Values,
        Dropdowns = MengHub.Dropdowns,
    }
    local json = HttpService:JSONEncode(data)
    if setclipboard then setclipboard(json) end
    SendNotif("Meng Hub", "Config disalin ke clipboard!", 3)
end

local function LoadFromExternalJSON(jsonStr)
    if not jsonStr or jsonStr == "" then
        SendNotif("Meng Hub", "JSON input kosong!", 3)
        return
    end
    local ok, data = pcall(function() return HttpService:JSONDecode(jsonStr) end)
    if not ok or not data then
        SendNotif("Meng Hub", "JSON tidak valid! Cek formatnya", 3)
        return
    end
    if data.States    then for k,v in pairs(data.States)    do MengHub.States[k]    = v end end
    if data.Values    then for k,v in pairs(data.Values)    do MengHub.Values[k]    = v end end
    if data.Dropdowns then for k,v in pairs(data.Dropdowns) do MengHub.Dropdowns[k] = v end end
    SendNotif("Meng Hub", "Berhasil load config dari external JSON", 3)
end

local function SaveMobPanelSettings(settings)
    local json = HttpService:JSONEncode(settings or {})
    SaveFile(MengHub.MOBPANEL_PATH, json)
    SendNotif("Meng Hub", "Mob Panel settings saved!", 2)
end

-- ============================================================
-- [[ KEY SYSTEM ]]
-- ============================================================

local function CheckKey(key)
    if not key or key == "" then return false, "empty" end
    key = key:gsub("%s+", "")

    local ok, res = pcall(function()
        return request({
            Url     = MengHub.KEY_API_VERIFY .. key,
            Method  = "GET",
            Headers = { Authorization = "Bearer 12e68073-3750-4dd7-a08b-4797aea81896" },
        })
    end)
    if not ok then return false, "server_error" end

    local decoded
    ok, decoded = pcall(function() return HttpService:JSONDecode(res.Body) end)
    if not ok then return false, "decode_error" end

    local status = decoded.status or decoded.Status or "unknown"
    status = tostring(status):lower()

    if status == "valid" or status == "ok" or status == "active" then
        local isPremium = (decoded.type == "Premium" or decoded.tier == "premium")
        return true, isPremium and "premium" or "valid"
    elseif status == "banned" or status == "hwid_ban" then
        return false, "banned"
    elseif status == "hwid_mismatch" or status == "already_used" then
        return false, "hwid_mismatch"
    elseif status == "expired" or status == "key_expired" then
        return false, "expired"
    elseif status == "premium_required" then
        return false, "premium_required"
    else
        return false, "invalid"
    end
end

local function GetKeyLink()
    local ok, res = pcall(function()
        return request({
            Url    = MengHub.KEY_API_LINK,
            Method = "GET",
        })
    end)
    if not ok then return nil end
    local dec
    pcall(function() dec = HttpService:JSONDecode(res.Body) end)
    if dec and dec.link then return dec.link end
    return nil
end

-- ============================================================
-- [[ ANTI-SPY / ANTI-STAFF ]]
-- ============================================================

local function DetectRemoteSpy()
    -- Detect common remote spy signatures
    local spyKeywords = {"turtlespy","turtle spy","utopiaspy","simplespy","spy v","spy gui","cobaltspy","cobalt spy","remotespy","remote spy","cmdbar","iy_","infiniteyield","yield","infinite"}

    for _, kw in ipairs(spyKeywords) do
        for _, v in ipairs(getgenv and getgenv() or {}) do
            if tostring(v):lower():find(kw) then
                return true, "Remote Spy Detected [" .. kw .. "]"
            end
        end
    end

    -- Check for __namecall hook
    if hookmetamethod and debug then
        local mt = getrawmetatable and getrawmetatable(game)
        if mt and rawget(mt, "__namecall") then
            return true, "Detected __namecall hook..."
        end
    end

    -- Check for C-closure spy
    if checkclosure then
        local remote = ReplicatedStorage:FindFirstChildOfClass("RemoteEvent")
        if remote then
            local ok, info = pcall(function() return debug.getinfo(remote.FireServer) end)
            if ok and info and info.what == "C" then
                -- normal
            elseif ok and info and info.what ~= "C" then
                return true, "Detected Remote Spy (C-Closure)..."
            end
        end
    end

    return false, nil
end

local function SendAntiSpyWebhook(reason)
    pcall(function()
        local data = {
            embeds = {{
                title       = "**Anti-Spy Triggered**",
                description = "Meng Hub • Anti Spy System",
                color       = 0xFF0000,
                fields      = {
                    { name = "Username",           value = LocalPlayer.Name,        inline = true },
                    { name  = "Display Name",      value = LocalPlayer.DisplayName, inline = true },
                    { name  = "Suspicious Activity", value = reason or "Remote Spy / Suspicious Activity terdeteksi" },
                    { name  = "Reason",            value = reason or "NO_KEY" },
                    { name  = "Date",              value = tostring(os.date("!%Y-%m-%dT%H:%M:%SZ")) },
                },
            }},
        }
        request({
            Url     = MengHub.WEBHOOK,
            Method  = "POST",
            Headers = { ["Content-Type"] = "application/json" },
            Body    = HttpService:JSONEncode(data),
        })
    end)
end

local function CheckForStaff()
    if not MengHub.States.antiStaff then return end
    local staffGroups = {
        { id = 8818124, minRank = 1 }, -- VD group example
    }
    for _, p in ipairs(Players:GetPlayers()) do
        if p == LocalPlayer then continue end
        for _, g in ipairs(staffGroups) do
            local ok, rank = pcall(function()
                return p:GetRankInGroup(g.id)
            end)
            if ok and rank >= g.minRank then
                SendNotif("Meng Hub", "[ANTI-STAFF DETECTION]\nStaff: " .. p.Name .. "\nRole: " .. tostring(rank), 5)
                LocalPlayer:Kick("[Meng Hub] Staff detected!")
            end
        end
    end
end

-- ============================================================
-- [[ ESP SYSTEM ]]
-- ============================================================

local ESPObjects = {}

local function CreateESPBillboard(parent, name)
    if not parent or not parent.Parent then return nil end
    local existing = parent:FindFirstChild("MengHubESP_Bill")
    if existing then existing:Destroy() end

    local bill = Instance.new("BillboardGui")
    bill.Name          = "MengHubESP_Bill"
    bill.Size          = UDim2.new(0, 120, 0, 50)
    bill.StudsOffset   = Vector3.new(0, 2.5, 0)
    bill.AlwaysOnTop   = true
    bill.ResetOnSpawn  = false
    bill.Parent        = parent

    local frame = Instance.new("Frame")
    frame.Name            = "bgFrame"
    frame.BackgroundColor3 = Color3.fromRGB(0,0,0)
    frame.BackgroundTransparency = 0.5
    frame.Size            = UDim2.new(1,0,1,0)
    frame.BorderSizePixel = 0
    frame.Parent          = bill

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0,4)
    corner.Parent       = frame

    local padding = Instance.new("UIPadding")
    padding.PaddingLeft   = UDim.new(0,4)
    padding.PaddingRight  = UDim.new(0,4)
    padding.PaddingTop    = UDim.new(0,2)
    padding.PaddingBottom = UDim.new(0,2)
    padding.Parent        = frame

    local nameLbl = Instance.new("TextLabel")
    nameLbl.Name            = "nameLbl"
    nameLbl.Text            = name or ""
    nameLbl.TextColor3      = Color3.fromRGB(255,255,255)
    nameLbl.BackgroundTransparency = 1
    nameLbl.Size            = UDim2.new(1,0,0.5,0)
    nameLbl.Font            = Enum.Font.GothamBold
    nameLbl.TextSize        = 13
    nameLbl.TextTruncate    = Enum.TextTruncate.AtEnd
    nameLbl.Parent          = frame

    local distLbl = Instance.new("TextLabel")
    distLbl.Name            = "distLbl"
    distLbl.Text            = "0m"
    distLbl.TextColor3      = Color3.fromRGB(200,200,200)
    distLbl.BackgroundTransparency = 1
    distLbl.Size            = UDim2.new(1,0,0.5,0)
    distLbl.Position        = UDim2.new(0,0,0.5,0)
    distLbl.Font            = Enum.Font.Gotham
    distLbl.TextSize        = 11
    distLbl.Parent          = frame

    -- Platform icon placeholder
    local platformIcon = Instance.new("ImageLabel")
    platformIcon.Name               = "platformIcon"
    platformIcon.BackgroundTransparency = 1
    platformIcon.Size               = UDim2.new(0,14,0,14)
    platformIcon.Position           = UDim2.new(1,-16,0,2)
    platformIcon.Parent             = frame

    return bill
end

local function CreateESPHighlight(parent, color, outlineColor)
    if not parent then return nil end
    local existing = parent:FindFirstChild("MengHubESP_Highlight")
    if existing then existing:Destroy() end

    local hl = Instance.new("Highlight")
    hl.Name         = "MengHubESP_Highlight"
    hl.FillColor    = color or Color3.fromRGB(255,255,255)
    hl.OutlineColor = outlineColor or Color3.fromRGB(255,255,255)
    hl.FillTransparency = 0.7
    hl.OutlineTransparency = 0
    hl.DepthMode    = Enum.HighlightDepthMode.AlwaysOnTop
    hl.Adornee      = parent
    hl.Parent       = parent
    return hl
end

local function CreateVaultBoxESP(part)
    if not part then return end
    local box = Instance.new("BoxHandleAdornment")
    box.Name            = "MengHubVaultHighlight"
    box.Size            = part.Size + Vector3.new(0.2,0.2,0.2)
    box.Color3          = MengHub.ESPColors.vault
    box.Transparency    = 0.5
    box.AlwaysOnTop     = true
    box.ZIndex          = 5
    box.Adornee         = part
    box.Parent          = part
    return box
end

local function RemoveESP(model)
    if not model then return end
    for _, d in ipairs(model:GetDescendants()) do
        if d.Name == "MengHubESP_Bill" or d.Name == "MengHubESP_Highlight" or d.Name == "MengHubVaultHighlight" then
            d:Destroy()
        end
    end
    ESPObjects[model] = nil
end

local function UpdateESPForPlayer(player)
    local char = player.Character
    if not char then return end
    local hrp  = GetRoot(char)
    if not hrp then return end

    -- Remove old
    RemoveESP(char)

    if not MengHub.States.esp then return end

    local isKillerPlayer = false
    local pTeam = player.Team
    if pTeam then
        isKillerPlayer = (pTeam.Name == "Killer" or pTeam.Name:lower() == "killer")
    end

    local color
    if isKillerPlayer then
        if not MengHub.States.espKiller then return end
        color = MengHub.ESPColors.killer
    else
        if not MengHub.States.espSurvivor then return end
        color = MengHub.ESPColors.survivor
    end

    local hl  = CreateESPHighlight(char, color, color)
    local bill = CreateESPBillboard(hrp, player.Name)

    ESPObjects[char] = { highlight = hl, billboard = bill, player = player }
end

local function SetESP(enabled)
    MengHub.States.esp = enabled
    if not enabled then
        for model, _ in pairs(ESPObjects) do
            RemoveESP(model)
        end
        return
    end
    for _, p in ipairs(Players:GetPlayers()) do
        if p == LocalPlayer then continue end
        UpdateESPForPlayer(p)
    end
end

-- ESP Update loop
RunService.RenderStepped:Connect(function()
    if not MengHub.States.esp then return end
    local myHRP = GetRoot(LocalPlayer.Character)
    for model, data in pairs(ESPObjects) do
        if not model or not model.Parent then
            ESPObjects[model] = nil
            continue
        end
        local bill = data.billboard
        if bill and MengHub.States.espDistance then
            local distLbl = bill:FindFirstChild("bgFrame") and bill:FindFirstChild("bgFrame"):FindFirstChild("distLbl")
            if distLbl and myHRP then
                local hrp = model:FindFirstChild("HumanoidRootPart")
                if hrp then
                    local dist = (myHRP.Position - hrp.Position).Magnitude
                    distLbl.Text = string.format("%.0fm", dist)
                end
            end
        end
    end
end)

-- ============================================================
-- [[ FOV CIRCLE ]]
-- ============================================================

local FOVCircleGui
local FOVCircle

local function UpdateFOVCircle()
    if not FOVCircleGui or not FOVCircleGui.Parent then
        FOVCircleGui = Instance.new("ScreenGui")
        FOVCircleGui.Name          = "FOVCircleGui"
        FOVCircleGui.ResetOnSpawn  = false
        FOVCircleGui.IgnoreGuiInset= true
        FOVCircleGui.Parent        = PlayerGui

        FOVCircle = Instance.new("Frame")
        FOVCircle.Name              = "FOVCircle"
        FOVCircle.BackgroundTransparency = 1
        FOVCircle.BorderSizePixel   = 0
        FOVCircle.Parent            = FOVCircleGui

        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(1,0)
        corner.Parent       = FOVCircle

        local stroke = Instance.new("UIStroke")
        stroke.Color     = Color3.fromRGB(255,255,255)
        stroke.Thickness = 1.5
        stroke.Parent    = FOVCircle
    end
    local fov = MengHub.Values.fovDegree
    local cam = workspace.CurrentCamera
    local vpSize = cam.ViewportSize
    local px = math.tan(math.rad(fov/2)) / math.tan(math.rad(cam.FieldOfView/2)) * (vpSize.Y/2)
    FOVCircle.Size     = UDim2.new(0, px*2, 0, px*2)
    FOVCircle.Position = UDim2.new(0.5, -px, 0.5, -px)
end

local function SetFOVCircle(enabled)
    MengHub.States.showFOVCircle = enabled
    if FOVCircleGui then
        FOVCircleGui.Enabled = enabled
    end
    if enabled then
        UpdateFOVCircle()
    end
end

-- ============================================================
-- [[ AIMBOT ]]
-- ============================================================

local AimbotTarget = nil
local AimbotEnabled = false

local function GetNearestTarget(fovRadius, wallcheckEnabled)
    local cam      = workspace.CurrentCamera
    local myHRP    = GetRoot(LocalPlayer.Character)
    if not myHRP or not cam then return nil end

    local bestTarget = nil
    local bestDist   = math.huge

    for _, p in ipairs(Players:GetPlayers()) do
        if p == LocalPlayer then continue end
        local char = p.Character
        if not char then continue end
        local hrp  = GetRoot(char)
        if not hrp then continue end
        local hum  = GetHumanoid(char)
        if not hum or hum.Health <= 0 then continue end

        -- Check if on screen & within FOV
        local screenPos, onScreen = cam:WorldToViewportPoint(hrp.Position)
        if not onScreen then continue end

        local center = Vector2.new(cam.ViewportSize.X/2, cam.ViewportSize.Y/2)
        local dist2D = (Vector2.new(screenPos.X, screenPos.Y) - center).Magnitude
        if fovRadius and dist2D > fovRadius then continue end

        -- Wallcheck
        if wallcheckEnabled then
            local ray = workspace:Raycast(cam.CFrame.Position, hrp.Position - cam.CFrame.Position, RaycastParams.new())
            if ray and ray.Instance and not ray.Instance:IsDescendantOf(char) then
                continue
            end
        end

        local dist3D = (myHRP.Position - hrp.Position).Magnitude
        if dist3D < bestDist then
            bestDist   = dist3D
            bestTarget = hrp
        end
    end
    return bestTarget
end

local function SetAimbotEnabled(enabled)
    MengHub.States.aimbot = enabled
    AimbotEnabled = enabled
end

RunService.RenderStepped:Connect(function()
    if not AimbotEnabled then return end
    local fovPx = nil
    if MengHub.States.lockFOV then
        local cam   = workspace.CurrentCamera
        local fov   = MengHub.Values.fovDegree
        local vpSize = cam.ViewportSize
        fovPx = math.tan(math.rad(fov/2)) / math.tan(math.rad(cam.FieldOfView/2)) * (vpSize.Y/2)
    end

    AimbotTarget = GetNearestTarget(fovPx, MengHub.States.wallcheck)
    if AimbotTarget and AimbotTarget.Parent then
        local cam = workspace.CurrentCamera
        local dir = (AimbotTarget.Position - cam.CFrame.Position).Unit
        cam.CFrame = CFrame.new(cam.CFrame.Position, cam.CFrame.Position + dir)
    end
end)

-- ============================================================
-- [[ SILENT AIM (TWIST OF FATE) ]]
-- ============================================================

local SilentAimActive = false

local function SetSilentAim(enabled)
    MengHub.States.silentAim = enabled
    SilentAimActive = enabled
end

-- ============================================================
-- [[ VEIL SILENT AIM ]]
-- ============================================================

local function SetVeilSilentAim(enabled)
    MengHub.States.veilSilentAim = enabled
end

-- ============================================================
-- [[ SPEAR SILENT AIM ]]
-- ============================================================

local function SetSpearSilentAim(enabled)
    MengHub.States.spearSilentAim = enabled
end

-- ============================================================
-- [[ GOD MODE ]]
-- ============================================================

local GodModeConn

local function SetGodMode(enabled)
    MengHub.States.godMode = enabled
    if GodModeConn then
        GodModeConn:Disconnect()
        GodModeConn = nil
    end
    if not enabled then
        SendNotif("Meng Hub", "godmode: disabled", 2)
        return
    end
    local char = LocalPlayer.Character
    local hum  = char and GetHumanoid(char)
    if hum then
        hum.MaxHealth = math.huge
        hum.Health    = math.huge
    end
    GodModeConn = RunService.Heartbeat:Connect(function()
        local c  = LocalPlayer.Character
        local h2 = c and GetHumanoid(c)
        if h2 then
            h2.MaxHealth = math.huge
            h2.Health    = math.huge
        end
    end)
    SendNotif("Meng Hub", "[Toggle] God Mode: ON", 2)
end

-- ============================================================
-- [[ NOCLIP ]]
-- ============================================================

local NoclipConn

local function SetNoclipEnabled(enabled)
    MengHub.States.noclip = enabled
    if NoclipConn then NoclipConn:Disconnect(); NoclipConn = nil end
    if not enabled then
        local char = LocalPlayer.Character
        if char then
            for _, p in ipairs(char:GetDescendants()) do
                if p:IsA("BasePart") then p.CanCollide = true end
            end
        end
        SendNotif("Meng Hub", "[Toggle] Noclip: OFF", 2)
        return
    end
    NoclipConn = RunService.Stepped:Connect(function()
        local char = LocalPlayer.Character
        if not char then return end
        for _, p in ipairs(char:GetDescendants()) do
            if p:IsA("BasePart") then p.CanCollide = false end
        end
    end)
    SendNotif("Meng Hub", "[Toggle] Noclip: ON", 2)
end

-- ============================================================
-- [[ SPEED BOOST ]]
-- ============================================================

local OriginalWalkSpeed = 16
local SpeedBoostConn

local function SetSpeedBoost(enabled)
    MengHub.States.speedBoost = enabled
    if SpeedBoostConn then SpeedBoostConn:Disconnect(); SpeedBoostConn = nil end
    local char = LocalPlayer.Character
    local hum  = char and GetHumanoid(char)
    if not enabled then
        if hum then hum.WalkSpeed = OriginalWalkSpeed end
        SendNotif("Meng Hub", "speedboost: disabled", 2)
        return
    end
    local spd = MengHub.Values.speedValue or 30
    if hum then
        OriginalWalkSpeed = hum.WalkSpeed
        hum.WalkSpeed = spd
    end
    SpeedBoostConn = RunService.Heartbeat:Connect(function()
        local c = LocalPlayer.Character
        local h = c and GetHumanoid(c)
        if h then h.WalkSpeed = MengHub.Values.speedValue or 30 end
    end)
    SendNotif("Meng Hub", "[Toggle] Speed Boost: ON", 2)
end

-- ============================================================
-- [[ INVISIBILITY ]]
-- ============================================================

local InvisConn
local InvisHighlight

local function SetInvisibility(enabled)
    MengHub.States.invisibility = enabled
    if InvisConn then InvisConn:Disconnect(); InvisConn = nil end
    if InvisHighlight then InvisHighlight:Destroy(); InvisHighlight = nil end

    local char = LocalPlayer.Character
    if not enabled then
        if char then
            for _, p in ipairs(char:GetDescendants()) do
                if p:IsA("BasePart") or p:IsA("Decal") then
                    p.LocalTransparencyModifier = 0
                end
            end
        end
        SendNotif("Meng Hub", "invisibility: disabled", 2)
        return
    end

    local function applyInvis(c)
        if not c then return end
        for _, p in ipairs(c:GetDescendants()) do
            if p:IsA("BasePart") or p:IsA("Decal") then
                p.LocalTransparencyModifier = 1
            end
        end
        -- Indicator
        if not InvisHighlight then
            InvisHighlight = Instance.new("Highlight")
            InvisHighlight.Name            = "MengHub_InvisibilityIndicator"
            InvisHighlight.FillColor       = Color3.fromRGB(100,100,255)
            InvisHighlight.OutlineColor    = Color3.fromRGB(150,150,255)
            InvisHighlight.FillTransparency= 0.5
            InvisHighlight.Adornee         = c
            InvisHighlight.Parent          = c
        end
    end
    applyInvis(char)
    InvisConn = RunService.RenderStepped:Connect(function()
        applyInvis(LocalPlayer.Character)
    end)
    SendNotif("Meng Hub", "[Toggle] Invisibility: ON", 2)
end

-- ============================================================
-- [[ NO FALL DAMAGE ]]
-- ============================================================

local function SetupNoFallMonitor()
    local char = LocalPlayer.Character
    if not char then return end
    local hum = GetHumanoid(char)
    if not hum then return end
    hum:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
    hum.StateChanged:Connect(function(old, new)
        if new == Enum.HumanoidStateType.FallingDown then
            hum:ChangeState(Enum.HumanoidStateType.Landed)
        end
    end)
end

-- ============================================================
-- [[ UNLOCK JUMP ]]
-- ============================================================

local function SetUnlockJump(enabled)
    MengHub.States.unlockJump = enabled
    local char = LocalPlayer.Character
    local hum  = char and GetHumanoid(char)
    if hum then
        hum:SetStateEnabled(Enum.HumanoidStateType.Jumping, enabled)
    end
    SendNotif("Meng Hub", "unlock jump: " .. (enabled and "on" or "off"), 2)
end

-- ============================================================
-- [[ MOONWALK ]]
-- ============================================================

local MoonwalkConn

local function SetMoonwalk(enabled)
    MengHub.States.moonwalk = enabled
    if MoonwalkConn then MoonwalkConn:Disconnect(); MoonwalkConn = nil end
    if not enabled then
        SendNotif("Meng Hub", "moonwalk: disabled", 2)
        return
    end
    local lastPos
    MoonwalkConn = RunService.Heartbeat:Connect(function()
        local char = LocalPlayer.Character
        local hrp  = GetRoot(char)
        if not hrp then return end
        if lastPos then
            local delta = hrp.CFrame.Position - lastPos
            hrp.CFrame  = CFrame.new(hrp.CFrame.Position - delta * 2) * hrp.CFrame.Rotation
        end
        lastPos = hrp.CFrame.Position
    end)
    SendNotif("Meng Hub", "[Toggle] Moonwalk: ON", 2)
end

-- ============================================================
-- [[ SELF HEAL ]]
-- ============================================================

local SelfHealConn

local function SetSelfHealEnabled(enabled)
    MengHub.States.selfHeal = enabled
    if SelfHealConn then SelfHealConn:Disconnect(); SelfHealConn = nil end
    if not enabled then
        SendNotif("Meng Hub", "self heal: disabled", 2)
        return
    end
    -- Trigger the heal remote
    local function doHeal()
        local remotes = ReplicatedStorage:FindFirstChild("Remotes")
        if remotes then
            local healEvent = remotes:FindFirstChild("HealEvent") or remotes:FindFirstChild("selfheal")
            if healEvent and healEvent:IsA("RemoteEvent") then
                healEvent:FireServer()
            end
        end
    end
    SelfHealConn = RunService.Heartbeat:Connect(function()
        local char = LocalPlayer.Character
        local hum  = char and GetHumanoid(char)
        if hum and hum.Health < hum.MaxHealth then
            doHeal()
        end
    end)
    SendNotif("Meng Hub", "[Toggle] Self Heal: ON", 2)
end

-- ============================================================
-- [[ AUTO HOOK ]]
-- ============================================================

local AutoHookConn
local processedObjects = {}

local function SetAutoHookEnabled(enabled)
    MengHub.States.autoHook = enabled
    if AutoHookConn then AutoHookConn:Disconnect(); AutoHookConn = nil end
    if not enabled then
        processedObjects = {}
        SendNotif("Meng Hub", "auto hook: disabled", 2)
        return
    end

    local function tryHook()
        local tagged = CollectionService:GetTagged("Hook")
        for _, hook in ipairs(tagged) do
            if processedObjects[hook] then continue end
            processedObjects[hook] = true
            local remotes = ReplicatedStorage:FindFirstChild("Remotes")
            if remotes then
                local hookEv = remotes:FindFirstChild("AutoHookSection") or remotes:FindFirstChild("hook")
                if hookEv then
                    pcall(function() hookEv:FireServer(hook) end)
                end
            end
        end
    end

    AutoHookConn = RunService.Heartbeat:Connect(tryHook)
    SendNotif("Meng Hub", "[Toggle] Auto Hook: ON", 2)
end

-- ============================================================
-- [[ AUTO VAULT ]]
-- ============================================================

local function SetAutoVault(enabled)
    MengHub.States.autoVault = enabled
    SendNotif("Meng Hub", "auto vault: " .. (enabled and "on" or "off"), 2)
end

-- ============================================================
-- [[ FAST VAULT ]]
-- ============================================================

local function SetFastVaultEnabled(enabled)
    MengHub.States.fastVault = enabled
    SendNotif("Meng Hub", "fast vault: " .. (enabled and "on" or "off"), 2)
end

-- ============================================================
-- [[ BLOCK ALL VAULT & PALLET ]]
-- ============================================================

local BlockVaultConn

local function SetBlockAllVault(enabled)
    MengHub.States.blockVaultPallet = enabled
    if BlockVaultConn then BlockVaultConn:Disconnect(); BlockVaultConn = nil end
    if not enabled then
        SendNotif("Meng Hub", "[Toggle] Block Pallet & Vault: OFF", 2)
        return
    end

    BlockVaultConn = RunService.Heartbeat:Connect(function()
        local remotes = ReplicatedStorage:FindFirstChild("Remotes")
        if not remotes then return end
        -- Intercept vault events
        local vaultTrigger = remotes:FindFirstChild("VaultTrigger")
        local palletSlide  = remotes:FindFirstChild("PalletSlideEvent")
        -- Block by disconnecting or overriding
    end)
    SendNotif("Meng Hub", "[Toggle] Block Pallet & Vault: ON", 2)
end

-- ============================================================
-- [[ INFINITE LUNGE ]]
-- ============================================================

local LungeConn

local function SetInfiniteLunge(enabled)
    MengHub.States.infiniteLunge = enabled
    if LungeConn then LungeConn:Disconnect(); LungeConn = nil end
    if not enabled then
        SendNotif("Meng Hub", "Infinite Lunge: OFF", 2)
        return
    end
    -- Monitor lunge animation, reset cooldown via attribute
    LungeConn = RunService.Heartbeat:Connect(function()
        local char = LocalPlayer.Character
        if not char then return end
        char:SetAttribute("lungeboost", true)
    end)
    SendNotif("Meng Hub", "Infinite Lunge: ON", 2)
end

-- ============================================================
-- [[ AUTO SKILLCHECK PERFECT ]]
-- ============================================================

local SkillcheckConn

local function SetAutoSkillcheckPerfect(enabled)
    MengHub.States.autoSkillcheckPerfect = enabled
    if SkillcheckConn then SkillcheckConn:Disconnect(); SkillcheckConn = nil end
    if not enabled then
        SendNotif("Meng Hub", "auto skillcheck perfect: disabled", 2)
        return
    end
    local mode = MengHub.Dropdowns.skillcheckMode  -- "None", "Instant", "Random"

    SkillcheckConn = RunService.Heartbeat:Connect(function()
        local pg = PlayerGui:FindFirstChild("SkillCheckPromptGui") or PlayerGui:FindFirstChild("SkillCheckPromptGui-con")
        if not pg then return end
        -- Find the action button and fire it
        local btn = pg:FindFirstChild("action", true) or pg:FindFirstDescendant and pg:FindFirstDescendant("action")
        if btn and btn:IsA("TextButton") then
            pcall(function()
                if mode == "Instant" then
                    btn.Activated:Fire()
                elseif mode == "Random" then
                    task.delay(math.random() * 0.2, function()
                        btn.Activated:Fire()
                    end)
                else
                    btn.Activated:Fire()
                end
            end)
        end
    end)
    SendNotif("Meng Hub", "auto skillcheck perfect: enabled (" .. mode .. ")", 2)
end

-- ============================================================
-- [[ AUTO ATTACK ]]
-- ============================================================

local AutoAttackConn

local function SetAutoAttack(enabled)
    MengHub.States.autoAttack = enabled
    if AutoAttackConn then AutoAttackConn:Disconnect(); AutoAttackConn = nil end
    if not enabled then
        SendNotif("Meng Hub", "auto attack: disabled", 2)
        return
    end
    local range = MengHub.Values.attackRange or 12

    AutoAttackConn = RunService.Heartbeat:Connect(function()
        local char  = LocalPlayer.Character
        local myHRP = GetRoot(char)
        if not myHRP then return end

        for _, p in ipairs(Players:GetPlayers()) do
            if p == LocalPlayer then continue end
            local pChar = p.Character
            local pHRP  = GetRoot(pChar)
            if not pHRP then continue end
            if (myHRP.Position - pHRP.Position).Magnitude <= range then
                local remotes = ReplicatedStorage:FindFirstChild("Remotes")
                if remotes then
                    local atk = remotes:FindFirstChild("BasicAttack") or remotes:FindFirstChild("Attacks")
                    if atk then pcall(function() atk:FireServer(pHRP) end) end
                end
            end
        end
    end)
    SendNotif("Meng Hub", "auto attack: enabled", 2)
end

-- ============================================================
-- [[ AUTO GENERATOR ]]
-- ============================================================

local AutoGenConn
local GenConnections = {}

local function SetAutoGenerator(enabled, withTP)
    MengHub.States.autoGenerator      = enabled
    MengHub.States.autoGeneratorWithTP = withTP or false
    for _, c in ipairs(GenConnections) do pcall(function() c:Disconnect() end) end
    GenConnections = {}

    if AutoGenConn then AutoGenConn:Disconnect(); AutoGenConn = nil end
    if not enabled then
        SendNotif("Meng Hub", "auto generator: disabled", 2)
        return
    end

    AutoGenConn = RunService.Heartbeat:Connect(function()
        local gens = CollectionService:GetTagged("GeneratorPoint") or CollectionService:GetTagged("Generators")
        local myHRP = GetRoot(LocalPlayer.Character)
        if not myHRP then return end

        for _, gen in ipairs(gens) do
            if not gen.Parent then continue end
            local genPos = gen:IsA("BasePart") and gen.Position or (gen.PrimaryPart and gen.PrimaryPart.Position)
            if not genPos then continue end

            if withTP and (myHRP.Position - genPos).Magnitude > 10 then
                LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(genPos + Vector3.new(0,3,0))
                task.wait(0.1)
            end

            local remotes = ReplicatedStorage:FindFirstChild("Remotes")
            if remotes then
                local repairEv = remotes:FindFirstChild("RepairEvent") or remotes:FindFirstChild("ProgressRepair")
                if repairEv then
                    pcall(function() repairEv:FireServer(gen) end)
                end
            end
        end
    end)
    SendNotif("Meng Hub", "auto generator: enabled" .. (withTP and " (with TP)" or ""), 2)
end

-- ============================================================
-- [[ BYPASS GENERATOR ]]
-- ============================================================

local function SetBypassGenerator(enabled)
    MengHub.States.bypassGenerator = enabled
    SendNotif("Meng Hub", "Bypass Generator: " .. (enabled and "ON" or "OFF"), 2)
end

-- ============================================================
-- [[ AUTO PARRY ]]
-- ============================================================

local AutoParryConn

local function SetAutoParry(enabled)
    MengHub.States.autoParry = enabled
    if AutoParryConn then AutoParryConn:Disconnect(); AutoParryConn = nil end
    if not enabled then
        SendNotif("Meng Hub", "auto parry: disabled", 2)
        return
    end
    AutoParryConn = RunService.Heartbeat:Connect(function()
        local remotes = ReplicatedStorage:FindFirstChild("Remotes")
        if not remotes then return end
        local parryEv = remotes:FindFirstChild("parryResult") or remotes:FindFirstChild("parry")
        if parryEv then
            pcall(function() parryEv:FireServer(true) end)
        end
    end)
    SendNotif("Meng Hub", "auto parry: enabled", 2)
end

-- ============================================================
-- [[ TRIGGER AUTO PARRY ]]
-- ============================================================

local function SetTriggerAPEnabled(enabled)
    MengHub.States.triggerAutoParry = enabled
    SendNotif("Meng Hub", "[Toggle] Trigger Auto Parry: " .. (enabled and "ON" or "OFF"), 2)
end

-- ============================================================
-- [[ AUTO GATE TAP ]]
-- ============================================================

local GateOneTapConn

local function SetGateOneTapEnabled(enabled)
    MengHub.States.autoGateTap = enabled
    if GateOneTapConn then GateOneTapConn:Disconnect(); GateOneTapConn = nil end
    if not enabled then
        SendNotif("Meng Hub", "auto gate one tap: disabled", 2)
        return
    end
    GateOneTapConn = RunService.Heartbeat:Connect(function()
        local remotes  = ReplicatedStorage:FindFirstChild("Remotes")
        if not remotes then return end
        local gateRemote = remotes:FindFirstChild("GateClient") or remotes:FindFirstChild("gateRemote")
        if gateRemote then
            pcall(function() gateRemote:FireServer("ESCAPED") end)
        end
    end)
    SendNotif("Meng Hub", "auto gate one tap: enabled", 2)
end

-- ============================================================
-- [[ INSTANT TP GATE ]]
-- ============================================================

local function SetInstantTPEnabled(enabled)
    MengHub.States.instantTPGate = enabled
    SendNotif("Meng Hub", "Instant TP Gate: " .. (enabled and "ON" or "OFF"), 2)
end

-- ============================================================
-- [[ TROLL TELEPORT ]]
-- ============================================================

local TrollTPConn

local function SetTrollTPEnabled(enabled)
    MengHub.States.trollTeleport = enabled
    if TrollTPConn then TrollTPConn:Disconnect(); TrollTPConn = nil end
    if not enabled then
        SendNotif("Meng Hub", "Troll Teleport: OFF", 2)
        return
    end
    local savedPos
    TrollTPConn = RunService.Heartbeat:Connect(function()
        local hrp = GetRoot(LocalPlayer.Character)
        if not hrp then return end
        if not savedPos then savedPos = hrp.CFrame end
        -- Teleport back after gate trigger
    end)
    SendNotif("Meng Hub", "[Toggle] Troll Teleport: ON", 2)
end

-- ============================================================
-- [[ FLEE KILLER ]]
-- ============================================================

local FleeKillerConn

local function SetFleeKiller(enabled)
    MengHub.States.fleeKiller = enabled
    if FleeKillerConn then FleeKillerConn:Disconnect(); FleeKillerConn = nil end
    if not enabled then
        SendNotif("Meng Hub", "flee killer: disabled", 2)
        return
    end
    local fleeDist = MengHub.Values.fleeDistance or 40

    FleeKillerConn = RunService.Heartbeat:Connect(function()
        local myHRP = GetRoot(LocalPlayer.Character)
        if not myHRP then return end

        for _, p in ipairs(Players:GetPlayers()) do
            if p == LocalPlayer then continue end
            local pChar = p.Character
            local pHRP  = GetRoot(pChar)
            if not pHRP then continue end
            -- Check if killer
            local pTeam = p.Team
            if not pTeam or (pTeam.Name ~= "Killer" and pTeam.Name:lower() ~= "killer") then continue end

            local dist = (myHRP.Position - pHRP.Position).Magnitude
            if dist < fleeDist then
                -- Move away
                local dir   = (myHRP.Position - pHRP.Position).Unit
                local newPos = myHRP.Position + dir * 10
                myHRP.CFrame = CFrame.new(newPos)
            end
        end
    end)
    SendNotif("Meng Hub", "flee killer: enabled", 2)
end

-- ============================================================
-- [[ KILL ALL (Killer feature) ]]
-- ============================================================

local KillAllConn

local function SetKillAllEnabled(enabled)
    MengHub.States.killAll = enabled
    if KillAllConn then KillAllConn:Disconnect(); KillAllConn = nil end
    if not enabled then
        SendNotif("Meng Hub", "kill all: disabled", 2)
        return
    end
    KillAllConn = RunService.Heartbeat:Connect(function()
        local remotes = ReplicatedStorage:FindFirstChild("Remotes")
        if not remotes then return end
        local killEv  = remotes:FindFirstChild("killall") or remotes:FindFirstChild("KillAllToggle")
        for _, p in ipairs(Players:GetPlayers()) do
            if p == LocalPlayer then continue end
            local char = p.Character
            if not char then continue end
            local hrp  = GetRoot(char)
            if hrp and killEv then
                pcall(function() killEv:FireServer(p) end)
            end
        end
    end)
    SendNotif("Meng Hub", "kill all: enabled", 2)
end

-- ============================================================
-- [[ FAKE PERKS ]]
-- ============================================================

local function SetFlowstate(enabled)
    MengHub.States.fakeFlowstate = enabled
    local remotes = ReplicatedStorage:FindFirstChild("Remotes")
    if remotes then
        local ev = remotes:FindFirstChild("Flowstate")
        if ev then pcall(function() ev:FireServer(enabled) end) end
    end
    SendNotif("Meng Hub", "fake perks flowstate: " .. (enabled and "on" or "off"), 2)
end

local function SetSnakeStep(enabled)
    MengHub.States.fakeSnakeStep = enabled
    SendNotif("Meng Hub", "fake perks snake step: " .. (enabled and "on" or "off"), 2)
end

local function SetPerfectLanding(enabled)
    MengHub.States.fakePerfectLanding = enabled
    SendNotif("Meng Hub", "fake perfect landing: " .. (enabled and "on" or "off"), 2)
end

local function SetQuickRecovery(enabled)
    MengHub.States.fakeQuickRecovery = enabled
    SendNotif("Meng Hub", "fake quick recovery: " .. (enabled and "on" or "off"), 2)
end

-- ============================================================
-- [[ EMOTE SYSTEM ]]
-- ============================================================

local function SetEmoteEnabled(enabled)
    MengHub.States.playEmote = enabled
end

local function PlayEmote(emoteName)
    local emoteMap = {
        ["Fist"]    = "rbxassetid://698251653",
        ["Meme"]    = "rbxassetid://72042024",
        ["Meme 2"]  = "rbxassetid://92125118598365",
        ["Brandon"] = "rbxassetid://110355011987939",
        ["Cobra"]   = "rbxassetid://75939529748815",
        ["Rabbit"]  = "rbxassetid://127096285501517",
        ["Jerk Off"]= "rbxassetid://135388781922226",
    }
    local animId = emoteMap[emoteName]
    if not animId then return end
    local char = LocalPlayer.Character
    local hum  = char and GetHumanoid(char)
    if not hum then return end
    local animator = hum:FindFirstChildOfClass("Animator")
    if not animator then return end

    local anim = Instance.new("Animation")
    anim.AnimationId = animId
    local track = animator:LoadAnimation(anim)
    track:Play()
    SendNotif("Meng Hub", "Playing emote: " .. emoteName, 2)
end

-- ============================================================
-- [[ LIGHTING / GRAPHICS ]]
-- ============================================================

local function SetFullBright(enabled)
    MengHub.States.fullBright = enabled
    if enabled then
        Lighting.Brightness         = 2
        Lighting.ClockTime          = 14
        Lighting.FogEnd             = 100000
        Lighting.GlobalShadows      = false
        Lighting.OutdoorAmbient     = Color3.fromRGB(128,128,128)
        Lighting.Ambient            = Color3.fromRGB(128,128,128)
        local atmos = Lighting:FindFirstChildOfClass("Atmosphere")
        if atmos then atmos.Density = 0 end
    else
        Lighting.Brightness         = 1
        Lighting.ClockTime          = 14
        Lighting.GlobalShadows      = true
        Lighting.OutdoorAmbient     = Color3.fromRGB(70,70,70)
        Lighting.Ambient            = Color3.fromRGB(0,0,0)
    end
end

local function SetNoFog(enabled)
    MengHub.States.noFog = enabled
    if enabled then
        Lighting.FogEnd   = 100000
        Lighting.FogStart = 100000
        local atmos = Lighting:FindFirstChildOfClass("Atmosphere")
        if atmos then atmos.Density = 0 end
    end
end

local function SetLowGraphicsMode(enabled)
    MengHub.States.lowGraphicsMode = enabled
    if enabled then
        settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
        workspace:SetAttribute("SavedQualitySetting", "QualityLevel1")
    else
        settings().Rendering.QualityLevel = Enum.QualityLevel.Automatic
    end
end

local function SetRemoveDynamicShadow(enabled)
    MengHub.States.removeDynamicShadow = enabled
    Lighting.GlobalShadows = not enabled
    Lighting.ShadowSoftness = enabled and 0 or 0.2
end

local function SetBoosterFPS(enabled)
    MengHub.States.boosterFPS = enabled
    if enabled then
        workspace.StreamingEnabled = false
        settings().Rendering.EagerBulkExecution = true
        pcall(function()
            workspace.MeshPartDetailLevel = Enum.MeshPartDetailLevel.Level01
        end)
    end
end

local function SetMaxFPS(fps)
    MengHub.Values.maxFPS = fps
    if setfpscap then
        setfpscap(fps)
    end
end

-- ============================================================
-- [[ CAMERA FEATURES ]]
-- ============================================================

local function SetMaxZoom(enabled)
    MengHub.States.maxZoom = enabled
    if enabled then
        LocalPlayer.CameraMaxZoomDistance = 1000
    else
        LocalPlayer.CameraMaxZoomDistance = 128
    end
end

local function SetFOV(degree)
    MengHub.Values.fovDegree = degree
    workspace.CurrentCamera.FieldOfView = degree
end

-- ============================================================
-- [[ SPOOF FEATURES ]]
-- ============================================================

local function SpoofName(name)
    if not name or name == "" then return end
    MengHub.States.spoofName = true
    pcall(function()
        StarterGui:SetCore("SetCore", { Name = name })
    end)
    SendNotif("Meng Hub", "Spoof Name: " .. name .. " (This only spoof yours)", 3)
end

local function SpoofGold(amount)
    MengHub.States.spoofGold = true
    SendNotif("Meng Hub", "Spoof Gold: " .. tostring(amount), 2)
end

local function SpoofScrew(amount)
    MengHub.States.spoofScrew = true
    SendNotif("Meng Hub", "Spoof Screw: " .. tostring(amount), 2)
end

local function SpoofLevel(level)
    MengHub.States.spoofLevel = true
    SendNotif("Meng Hub", "Spoof Level: " .. tostring(level), 2)
end

-- ============================================================
-- [[ FAKE AVATAR ]]
-- ============================================================

local function ApplyFakeAvatar(userId)
    if not userId then return end
    pcall(function()
        local char    = LocalPlayer.Character
        if not char then return end
        local hum     = GetHumanoid(char)
        if not hum then return end
        local desc    = game.Players:GetCharacterAppearanceAsync(userId)
        hum:ApplyDescription(desc)
        SendNotif("Meng Hub", "fake avatar diterapkan: @" .. tostring(userId), 3)
    end)
end

local function ApplyFakeAvatarByUsername(username)
    if not username or username == "" then
        SendNotif("Meng Hub", "Masukkan username dulu!", 3)
        return
    end
    local ok, uid = pcall(function()
        return Players:GetUserIdFromNameAsync(username)
    end)
    if not ok or not uid then
        SendNotif("Meng Hub", "Username tidak ditemukan: " .. username, 3)
        return
    end
    ApplyFakeAvatar(uid)
    SendNotif("Meng Hub", "fake avatar diterapkan: @" .. username, 3)
end

local function ResetAvatar()
    pcall(function()
        local char = LocalPlayer.Character
        local hum  = char and GetHumanoid(char)
        if hum then
            local desc = game.Players:GetCharacterAppearanceAsync(LocalPlayer.UserId)
            hum:ApplyDescription(desc)
            SendNotif("Meng Hub", "avatar berhasil di-reset ke semula!", 3)
        end
    end)
end

-- ============================================================
-- [[ AIMBOT FLASHLIGHT ]]
-- ============================================================

local function SetAimbotFlashlight(enabled)
    MengHub.States.aimbotFlashlight = enabled
    SendNotif("Meng Hub", (enabled and "[Toggle] Aimbot Flashlight: ON" or "Aimbot Flashlight: OFF"), 2)
end

-- ============================================================
-- [[ HIDDEN AIMBOT ]]
-- ============================================================

local HiddenAimbotConn

local function SetHiddenAimbot(enabled)
    MengHub.States.hiddenAimbot = enabled
    if HiddenAimbotConn then HiddenAimbotConn:Disconnect(); HiddenAimbotConn = nil end
    if not enabled then
        SendNotif("Meng Hub", "hidden aimbot: disabled", 2)
        return
    end
    -- Works against Hidden/Stalker/Abysswalker killers
    local function checkKillerValid()
        for _, p in ipairs(Players:GetPlayers()) do
            local char = p.Character
            if not char then continue end
            for _, tag in ipairs({"Hidden-mob","Stalker","Abysswalker"}) do
                if CollectionService:HasTag(char, tag) then return p end
            end
        end
        return nil
    end

    HiddenAimbotConn = RunService.RenderStepped:Connect(function()
        local target = checkKillerValid()
        if not target then
            SendNotif("Meng Hub", "hidden aimbot: enabled (waiting for Hidden)", 2)
            return
        end
        -- Aim at killer
        local char = target.Character
        local hrp  = GetRoot(char)
        if hrp then
            local cam = workspace.CurrentCamera
            local dir = (hrp.Position - cam.CFrame.Position).Unit
            cam.CFrame = CFrame.new(cam.CFrame.Position, cam.CFrame.Position + dir)
        end
    end)
    SendNotif("Meng Hub", "hidden aimbot: enabled", 2)
end

-- ============================================================
-- [[ PREDICTION / MAP PREDICTION ]]
-- ============================================================

local PredictUI
local MapPredictConn

local function SetMapPrediction(enabled)
    MengHub.States.enableMapPrediction = enabled
    if not enabled then
        if PredictUI then PredictUI:Destroy(); PredictUI = nil end
        return
    end
    -- Create prediction overlay
    if PredictUI then PredictUI:Destroy() end
    PredictUI = Instance.new("ScreenGui")
    PredictUI.Name         = "PredictUI"
    PredictUI.ResetOnSpawn = false
    PredictUI.Parent       = PlayerGui

    local frame = Instance.new("Frame")
    frame.Name              = "MainFrame"
    frame.BackgroundColor3  = Color3.fromRGB(0,0,0)
    frame.BackgroundTransparency = 0.4
    frame.Size              = UDim2.new(0,200,0,80)
    frame.Position          = UDim2.new(0,10,0.5,0)
    frame.Parent            = PredictUI
    Instance.new("UICorner",frame).CornerRadius = UDim.new(0,8)

    local mapTitle = Instance.new("TextLabel")
    mapTitle.Name           = "MapTitle"
    mapTitle.Text           = "MAP"
    mapTitle.TextColor3     = Color3.fromRGB(255,200,0)
    mapTitle.BackgroundTransparency = 1
    mapTitle.Size           = UDim2.new(1,0,0.4,0)
    mapTitle.Font           = Enum.Font.GothamBold
    mapTitle.TextSize       = 14
    mapTitle.Parent         = frame

    local mapVal = Instance.new("TextLabel")
    mapVal.Name             = "MAP"
    mapVal.Text             = "Scanning..."
    mapVal.TextColor3       = Color3.fromRGB(255,255,255)
    mapVal.BackgroundTransparency = 1
    mapVal.Size             = UDim2.new(1,0,0.3,0)
    mapVal.Position         = UDim2.new(0,0,0.35,0)
    mapVal.Font             = Enum.Font.Gotham
    mapVal.TextSize         = 12
    mapVal.Parent           = frame

    local killerTitle = Instance.new("TextLabel")
    killerTitle.Name        = "KillerTitle"
    killerTitle.Text        = "KILLER"
    killerTitle.TextColor3  = Color3.fromRGB(255,80,80)
    killerTitle.BackgroundTransparency = 1
    killerTitle.Size        = UDim2.new(1,0,0.3,0)
    killerTitle.Position    = UDim2.new(0,0,0.65,0)
    killerTitle.Font        = Enum.Font.GothamBold
    killerTitle.TextSize    = 12
    killerTitle.Parent      = frame

    MapPredictConn = RunService.Heartbeat:Connect(function()
        -- Try read map/killer from game attributes
        local mapAttr    = game:GetAttribute("MapValue")
        local killerAttr = game:GetAttribute("KillerValue")
        if mapVal then
            mapVal.Text = mapAttr and tostring(mapAttr) or "?"
        end
        if killerTitle then
            killerTitle.Text = "KILLER: " .. (killerAttr and tostring(killerAttr) or "?")
        end
    end)
end

-- ============================================================
-- [[ KING SCOURGE DETECTOR ]]
-- ============================================================

local KSDetectUI

local function SetupKingScourgeDetector()
    if KSDetectUI then KSDetectUI:Destroy() end
    KSDetectUI = Instance.new("ScreenGui")
    KSDetectUI.Name         = "KSDetectUI"
    KSDetectUI.ResetOnSpawn = false
    KSDetectUI.Parent       = PlayerGui

    local frame = Instance.new("Frame")
    frame.BackgroundColor3      = Color3.fromRGB(20,20,20)
    frame.BackgroundTransparency= 0.3
    frame.Size                  = UDim2.new(0,180,0,50)
    frame.Position              = UDim2.new(0,10,0,10)
    frame.Parent                = KSDetectUI
    Instance.new("UICorner",frame).CornerRadius = UDim.new(0,6)

    local lbl = Instance.new("TextLabel")
    lbl.Name              = "Status"
    lbl.Text              = "King Scourge's: Waiting"
    lbl.TextColor3        = Color3.fromRGB(255,255,100)
    lbl.BackgroundTransparency = 1
    lbl.Size              = UDim2.new(1,0,1,0)
    lbl.Font              = Enum.Font.GothamBold
    lbl.TextSize          = 13
    lbl.Parent            = frame

    -- Monitor King Scourge start
    local remotes = ReplicatedStorage:FindFirstChild("Remotes")
    if remotes then
        local ksStart = remotes:FindFirstChild("KingScourgeStart")
        local ksHit   = remotes:FindFirstChild("KingScourgeHit")
        if ksStart then
            ksStart.OnClientEvent:Connect(function()
                lbl.Text = "King Scourge's: ACTIVE!"
                SendNotif("Meng Hub", "Killer is using King Scourge!", 3)
            end)
        end
    end
end

-- ============================================================
-- [[ SPECTATOR LIST ]]
-- ============================================================

local SpectatorGui
local SpectatorListConn

local function SetSpectator(enabled)
    MengHub.States.spectatorList = enabled
    if SpectatorGui then SpectatorGui:Destroy(); SpectatorGui = nil end
    if SpectatorListConn then SpectatorListConn:Disconnect(); SpectatorListConn = nil end
    if not enabled then
        SendNotif("Meng Hub", "[Toggle] Spectator List: OFF", 2)
        return
    end

    SpectatorGui = Instance.new("ScreenGui")
    SpectatorGui.Name         = "SpectatorGui"
    SpectatorGui.ResetOnSpawn = false
    SpectatorGui.Parent       = PlayerGui

    local mainFrame = Instance.new("Frame")
    mainFrame.Name              = "MainFrame"
    mainFrame.BackgroundColor3  = Color3.fromRGB(10,10,10)
    mainFrame.BackgroundTransparency = 0.3
    mainFrame.Size              = UDim2.new(0,180,0,200)
    mainFrame.Position          = UDim2.new(1,-190,0.5,-100)
    mainFrame.Parent            = SpectatorGui
    Instance.new("UICorner",mainFrame).CornerRadius = UDim.new(0,8)

    local titleLbl = Instance.new("TextLabel")
    titleLbl.Text           = "     Spectators"
    titleLbl.TextColor3     = Color3.fromRGB(255,255,255)
    titleLbl.BackgroundTransparency = 1
    titleLbl.Size           = UDim2.new(1,0,0,30)
    titleLbl.Font           = Enum.Font.GothamBold
    titleLbl.TextSize       = 14
    titleLbl.Parent         = mainFrame

    local countLbl = Instance.new("TextLabel")
    countLbl.Name           = "CountLabel"
    countLbl.Text           = "0"
    countLbl.TextColor3     = Color3.fromRGB(200,200,200)
    countLbl.BackgroundTransparency = 1
    countLbl.Size           = UDim2.new(1,0,0,20)
    countLbl.Position       = UDim2.new(0,0,0,30)
    countLbl.Font           = Enum.Font.Gotham
    countLbl.TextSize       = 11
    countLbl.Parent         = mainFrame

    local listFrame = Instance.new("ScrollingFrame")
    listFrame.Name          = "ListFrame"
    listFrame.Size          = UDim2.new(1,-10,1,-55)
    listFrame.Position      = UDim2.new(0,5,0,55)
    listFrame.BackgroundTransparency = 1
    listFrame.ScrollBarThickness = 3
    listFrame.ScrollBarImageColor3 = Color3.fromRGB(100,100,255)
    listFrame.Parent        = mainFrame
    Instance.new("UIListLayout", listFrame).SortOrder = Enum.SortOrder.LayoutOrder

    local function updateSpectators()
        for _, c in ipairs(listFrame:GetChildren()) do
            if not c:IsA("UIListLayout") then c:Destroy() end
        end
        local count = 0
        for _, p in ipairs(Players:GetPlayers()) do
            if p == LocalPlayer then continue end
            local target = p:GetAttribute("spectator")
            if target == LocalPlayer.Name then
                count = count + 1
                local row = Instance.new("Frame")
                row.Name  = "spec"
                row.Size  = UDim2.new(1,0,0,30)
                row.BackgroundTransparency = 1
                row.LayoutOrder = count
                row.Parent = listFrame

                local img = Instance.new("ImageLabel")
                img.Size   = UDim2.new(0,24,0,24)
                img.Position = UDim2.new(0,2,0.5,-12)
                img.BackgroundTransparency = 1
                img.Image  = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. tostring(p.UserId)
                img.Parent = row
                Instance.new("UICorner",img).CornerRadius = UDim.new(1,0)

                local nameLbl2 = Instance.new("TextLabel")
                nameLbl2.Text         = p.Name
                nameLbl2.TextColor3   = Color3.fromRGB(255,255,255)
                nameLbl2.BackgroundTransparency = 1
                nameLbl2.Size         = UDim2.new(1,-32,1,0)
                nameLbl2.Position     = UDim2.new(0,30,0,0)
                nameLbl2.Font         = Enum.Font.Gotham
                nameLbl2.TextSize     = 12
                nameLbl2.TextXAlignment = Enum.TextXAlignment.Left
                nameLbl2.Parent       = row
            end
        end
        countLbl.Text = count > 0 and tostring(count) .. " spectating" or "No spectators"
    end

    SpectatorListConn = RunService.Heartbeat:Connect(updateSpectators)
    SendNotif("Meng Hub", "[Toggle] Spectator List: ON", 2)
end

-- ============================================================
-- [[ PING & FPS COUNTER ]]
-- ============================================================

local StatsUI
local StatsConn

local function SetPingFPSCounter(enabled)
    MengHub.States.pingFpsCounter = enabled
    if StatsUI then StatsUI:Destroy(); StatsUI = nil end
    if StatsConn then StatsConn:Disconnect(); StatsConn = nil end
    if not enabled then return end

    StatsUI = Instance.new("ScreenGui")
    StatsUI.Name         = "SimpleStatsUI"
    StatsUI.ResetOnSpawn = false
    StatsUI.Parent       = PlayerGui

    local container = Instance.new("Frame")
    container.Name              = "Container"
    container.BackgroundColor3  = Color3.fromRGB(0,0,0)
    container.BackgroundTransparency = 0.5
    container.Size              = UDim2.new(0,160,0,24)
    container.Position          = UDim2.new(1,-170,0,5)
    container.Parent            = StatsUI
    Instance.new("UICorner",container).CornerRadius = UDim.new(0,6)

    local statLabel = Instance.new("TextLabel")
    statLabel.Name            = "StatLabel"
    statLabel.Text            = "<font color='#7CFFB2'>-- FPS</font>  <font color='#555555'>|</font>  <font color='#FF6B6B'>-- ms</font>"
    statLabel.RichText        = true
    statLabel.TextColor3      = Color3.fromRGB(255,255,255)
    statLabel.BackgroundTransparency = 1
    statLabel.Size            = UDim2.new(1,0,1,0)
    statLabel.Font            = Enum.Font.GothamBold
    statLabel.TextSize        = 12
    statLabel.Parent          = container

    local stats = game:GetService("Stats")

    StatsConn = RunService.Heartbeat:Connect(function()
        local fps  = math.floor(1 / RunService.Heartbeat:Wait())
        local ping = math.floor(stats.Network.ServerStatsItem["Data Ping"]:GetValue())
        local fpsColor  = fps >= 60 and "#7CFFB2" or (fps >= 30 and "#FFD166" or "#FF6B6B")
        local pingColor = ping <= 80 and "#7CFFB2" or (ping <= 150 and "#FFD166" or "#FF6B6B")
        statLabel.Text = string.format(
            "<font color='%s'>%d FPS</font>  <font color='#555555'>|</font>  <font color='%s'>%d ms</font>",
            fpsColor, fps, pingColor, ping
        )
    end)
end

-- ============================================================
-- [[ SERVER HOP ]]
-- ============================================================

local function ServerHop(smallOnly)
    SendNotif("Meng Hub", smallOnly and "searching for a small server..." or "finding new server...", 3)
    task.spawn(function()
        local url = smallOnly
            and string.format(MengHub.SERVER_ROBLOX_S, game.PlaceId)
            or  string.format(MengHub.SERVER_ROBLOX, game.PlaceId)

        local ok, res = pcall(function()
            return HttpService:GetAsync(url)
        end)
        if not ok then
            SendNotif("Meng Hub", "error connecting to Roblox API!", 3)
            return
        end

        local dec
        ok, dec = pcall(function() return HttpService:JSONDecode(res) end)
        if not ok or not dec then
            SendNotif("Meng Hub", "failed to parse server list!", 3)
            return
        end

        local data = dec.data or dec
        if not data or #data == 0 then
            SendNotif("Meng Hub", "no available servers found!", 3)
            return
        end

        local target = nil
        if smallOnly then
            for _, s in ipairs(data) do
                if (s.playing or 0) < 5 then
                    target = s
                    break
                end
            end
            if not target then
                SendNotif("Meng Hub", "no small servers ( < 5 players) found!", 3)
                return
            end
            SendNotif("Meng Hub", "found server with " .. tostring(target.playing) .. " players", 3)
        else
            -- Pick random server that's not current
            for _, s in ipairs(data) do
                if s.id ~= game.JobId then
                    target = s
                    break
                end
            end
        end

        if not target then
            SendNotif("Meng Hub", "no available servers found!", 3)
            return
        end

        TeleportService:TeleportToPlaceInstance(game.PlaceId, target.id, LocalPlayer)
    end)
end

local function RejoinServer()
    SendNotif("Meng Hub", "Rejoining server...", 2)
    TeleportService:Teleport(game.PlaceId, LocalPlayer)
end

local function ReturnToLobby()
    SendNotif("Meng Hub", "Return To Lobby", 2)
    local remotes = ReplicatedStorage:FindFirstChild("Remotes")
    if remotes then
        local ev = remotes:FindFirstChild("ReturnToLobby")
        if ev then pcall(function() ev:FireServer() end) end
    end
end

-- ============================================================
-- [[ RESET CHARACTER ]]
-- ============================================================

local function ResetCharacter()
    local char = LocalPlayer.Character
    local hum  = char and GetHumanoid(char)
    if hum then hum.Health = 0 end
end

-- ============================================================
-- [[ HIDDEN & MASKED COUNTER ]]
-- ============================================================

local HMCounterUI

local function SetHiddenMaskedCounter(enabled)
    MengHub.States.hiddenMaskedCounter = enabled
    if HMCounterUI then HMCounterUI:Destroy(); HMCounterUI = nil end
    if not enabled then
        SendNotif("Meng Hub", "hidden & masked counter: disabled", 2)
        return
    end

    HMCounterUI = Instance.new("ScreenGui")
    HMCounterUI.Name         = "HiddenMaskedCounter"
    HMCounterUI.ResetOnSpawn = false
    HMCounterUI.Parent       = PlayerGui

    local frame = Instance.new("Frame")
    frame.BackgroundColor3  = Color3.fromRGB(0,0,0)
    frame.BackgroundTransparency = 0.4
    frame.Size              = UDim2.new(0,180,0,30)
    frame.Position          = UDim2.new(0,10,0,40)
    frame.Parent            = HMCounterUI
    Instance.new("UICorner",frame).CornerRadius = UDim.new(0,6)

    local lbl = Instance.new("TextLabel")
    lbl.Text           = "Hidden & Masked: 0"
    lbl.TextColor3     = Color3.fromRGB(200,100,255)
    lbl.BackgroundTransparency = 1
    lbl.Size           = UDim2.new(1,0,1,0)
    lbl.Font           = Enum.Font.GothamBold
    lbl.TextSize       = 12
    lbl.Parent         = frame

    RunService.Heartbeat:Connect(function()
        local count = 0
        for _, p in ipairs(Players:GetPlayers()) do
            local char = p.Character
            if char then
                for _, tag in ipairs({"Hidden-mob","Masked","Stalker"}) do
                    if CollectionService:HasTag(char, tag) then count += 1; break end
                end
            end
        end
        lbl.Text = "Hidden & Masked: " .. tostring(count)
    end)

    SendNotif("Meng Hub", "hidden & masked counter: enabled", 2)
end

-- ============================================================
-- [[ PROTECT NAME ]]
-- ============================================================

local ProtectNameConn
local ProtectNameEnabled = false

local function SetProtectName(enabled)
    ProtectNameEnabled = enabled
    MengHub.States.streamerProtection = enabled
    if ProtectNameConn then ProtectNameConn:Disconnect(); ProtectNameConn = nil end
    if not enabled then
        SendNotif("Meng Hub", "[PROTECT NAME] ✗ OFF - Restored", 2)
        return
    end
    local function hideNames()
        for _, bill in ipairs(PlayerGui:GetDescendants()) do
            if bill:IsA("BillboardGui") and bill.Name:find("Name") then
                bill.Enabled = false
            end
        end
    end
    ProtectNameConn = RunService.Heartbeat:Connect(hideNames)
end

-- ============================================================
-- [[ HIDE PLAYER ICON ]]
-- ============================================================

local function SetHidePlayerIcon(enabled)
    MengHub.States.hidePlayerIcon = enabled
    pcall(function()
        StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, not enabled)
    end)
    SendNotif("Meng Hub", "[HIDE ICON] " .. (enabled and "✓ ON" or "✗ OFF - Restored"), 2)
end

-- ============================================================
-- [[ AUTO RUN (PC) ]]
-- ============================================================

local AutoRunConn
local AutoRunEnabled = false

local function SetAutoRun(enabled)
    AutoRunEnabled = enabled
    MengHub.States.autoRun = enabled
    if AutoRunConn then AutoRunConn:Disconnect(); AutoRunConn = nil end
    if not enabled then
        SendNotif("Meng Hub", "auto run: disabled", 2)
        return
    end
    AutoRunConn = RunService.Heartbeat:Connect(function()
        local char = LocalPlayer.Character
        local hum  = char and GetHumanoid(char)
        if hum then
            hum.MoveDirection = (workspace.CurrentCamera.CFrame.LookVector * Vector3.new(1,0,1)).Unit
        end
    end)
    SendNotif("Meng Hub", "auto run: enabled", 2)
end

-- ============================================================
-- [[ AUTO DODGE CROUCH ]]
-- ============================================================

local AutoDodgeConn

local function SetAutoDodgeCrouch(enabled)
    MengHub.States.autoDodgeCrouch = enabled
    if AutoDodgeConn then AutoDodgeConn:Disconnect(); AutoDodgeConn = nil end
    if not enabled then
        SendNotif("Meng Hub", "auto dodge crouch: disabled", 2)
        return
    end
    AutoDodgeConn = RunService.Heartbeat:Connect(function()
        local char = LocalPlayer.Character
        local hrp  = GetRoot(char)
        if not hrp then return end
        for _, p in ipairs(Players:GetPlayers()) do
            if p == LocalPlayer then continue end
            local pChar = p.Character
            local pHRP  = GetRoot(pChar)
            if not pHRP then continue end
            if (hrp.Position - pHRP.Position).Magnitude < 10 then
                VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.C, false, game)
                task.wait(0.1)
                VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.C, false, game)
            end
        end
    end)
    SendNotif("Meng Hub", "auto dodge crouch: enabled", 2)
end

-- ============================================================
-- [[ BREAK SPEED ]]
-- ============================================================

local BreakSpeedConn

local function SetBreakSpeed(enabled)
    MengHub.States.breakSpeed = enabled
    if BreakSpeedConn then BreakSpeedConn:Disconnect(); BreakSpeedConn = nil end
    if not enabled then
        SendNotif("Meng Hub", "break speed: disabled", 2)
        return
    end
    BreakSpeedConn = RunService.Heartbeat:Connect(function()
        local char = LocalPlayer.Character
        local hrp  = GetRoot(char)
        if not hrp then return end
        -- Break sprint speed by setting velocity
        local pct = MengHub.Values.breakSpeedPersen / 100
        local vel = hrp.AssemblyLinearVelocity
        hrp.AssemblyLinearVelocity = vel * pct
    end)
    SendNotif("Meng Hub", "break speed: enabled (" .. tostring(MengHub.Values.breakSpeedPersen) .. "%)", 2)
end

-- ============================================================
-- [[ NO FLASHLIGHT (ANTI BLIND) ]]
-- ============================================================

local function SetNoFlashlight(enabled)
    RunService.Heartbeat:Connect(function()
        if not enabled then return end
        local char = LocalPlayer.Character
        if not char then return end
        for _, p in ipairs(Players:GetPlayers()) do
            local pc = p.Character
            if not pc then continue end
            for _, obj in ipairs(pc:GetDescendants()) do
                if obj:IsA("SpotLight") or obj:IsA("PointLight") or obj:IsA("SurfaceLight") then
                    obj.Enabled = false
                end
            end
        end
    end)
end

-- ============================================================
-- [[ X-RAY WALL ]]
-- ============================================================

local XrayConn

local function SetXRay(enabled)
    MengHub.States.xRayWall = enabled
    if XrayConn then XrayConn:Disconnect(); XrayConn = nil end
    if not enabled then return end
    XrayConn = RunService.Heartbeat:Connect(function()
        for _, v in ipairs(workspace:GetDescendants()) do
            if v:IsA("BasePart") and not v:FindFirstAncestorWhichIsA("Model") then
                v.LocalTransparencyModifier = 0.8
            end
        end
    end)
end

-- ============================================================
-- [[ GRAVITY SCALE ]]
-- ============================================================

local function SetGravityScale(scale)
    MengHub.Values.gravityScale = scale
    workspace.Gravity = 196.2 * scale
end

-- ============================================================
-- [[ KILL ALL INSTANT ]]
-- ============================================================

local function KickPlayer(player)
    if not player then return end
    pcall(function()
        local remotes = ReplicatedStorage:FindFirstChild("Remotes")
        if remotes then
            local kickEv = remotes:FindFirstChild("Kick") or remotes:FindFirstChild("KickPlayer")
            if kickEv then kickEv:FireServer(player) end
        end
    end)
end

-- ============================================================
-- [[ CARRY SURVIVOR ]]
-- ============================================================

local function CarrySurvivor(player)
    local remotes = ReplicatedStorage:FindFirstChild("Remotes")
    if remotes then
        local ev = remotes:FindFirstChild("CarrySurvivorEvent")
        if ev then pcall(function() ev:FireServer(player) end) end
    end
end

-- ============================================================
-- [[ BEAT GAME (AUTO ESCAPE) ]]
-- ============================================================

local BeatGameConn

local function SetBeatGame(enabled)
    MengHub.States.beatGame = enabled
    if BeatGameConn then BeatGameConn:Disconnect(); BeatGameConn = nil end
    if not enabled then return end
    BeatGameConn = RunService.Heartbeat:Connect(function()
        local remotes = ReplicatedStorage:FindFirstChild("Remotes")
        if not remotes then return end
        local escEv = remotes:FindFirstChild("ESCAPED") or remotes:FindFirstChild("PlayerActionEvent")
        if escEv then pcall(function() escEv:FireServer("ESCAPED") end) end
    end)
    SendNotif("Meng Hub", "Beat Game: enabled", 2)
end

-- ============================================================
-- [[ SKILL NO COOLDOWN ]]
-- ============================================================

local NoCDActive = false
local NoCDThread

local function ActivateSkillNoCD()
    if NoCDThread then task.cancel(NoCDThread); NoCDThread = nil end
    NoCDActive = true

    -- Detect which killer is being used
    local char = LocalPlayer.Character
    if not char then
        SendNotif("Meng Hub", "you are not using stalker/hidden/abysswalker!", 3)
        return
    end

    -- Check for Hidden
    if char:FindFirstChild("Hidden-mob") or CollectionService:HasTag(char, "Hidden-mob") then
        SendNotif("Meng Hub", "Hidden No CD aktif!", 3)
        NoCDThread = task.spawn(function()
            while NoCDActive do
                pcall(function()
                    local remotes = ReplicatedStorage:FindFirstChild("Remotes")
                    if remotes then
                        local sk1 = remotes:FindFirstChild("triggerSkill1") or remotes:FindFirstChild("move1")
                        if sk1 then sk1:FireServer() end
                    end
                end)
                task.wait(0.05)
            end
        end)
        return
    end

    -- Check for Stalker
    if char:FindFirstChild("Stalker") or CollectionService:HasTag(char, "Stalker") then
        SendNotif("Meng Hub", "Stalker No CD aktif!", 3)
        return
    end

    -- Check for Abysswalker
    if char:FindFirstChild("Abysswalker") or CollectionService:HasTag(char, "Abysswalker") then
        SendNotif("Meng Hub", "Abysswalker No CD aktif!", 3)
        return
    end

    SendNotif("Meng Hub", "Killer ini belum support No CD!", 3)
end

-- ============================================================
-- [[ ENABLE RUN SPEED ]]
-- ============================================================

local RunSpeedConn

local function SetRunSpeed(enabled)
    MengHub.States.enableRunSpeed = enabled
    if RunSpeedConn then RunSpeedConn:Disconnect(); RunSpeedConn = nil end
    if not enabled then return end
    local pct = MengHub.Values.runSpeedPersen / 100
    RunSpeedConn = RunService.Heartbeat:Connect(function()
        local char = LocalPlayer.Character
        local hum  = char and GetHumanoid(char)
        if hum then
            hum.WalkSpeed = 16 * (1 + pct)
        end
    end)
end

-- ============================================================
-- [[ FAKE PARRY PANEL ]]
-- ============================================================

local FakeParryPanel

local function ToggleFakeParryPanel(enabled)
    MengHub.States.fakeParryPanel = enabled
    if FakeParryPanel then FakeParryPanel:Destroy(); FakeParryPanel = nil end
    if not enabled then return end

    FakeParryPanel = Instance.new("ScreenGui")
    FakeParryPanel.Name         = "FakeParryPanel"
    FakeParryPanel.ResetOnSpawn = false
    FakeParryPanel.Parent       = PlayerGui

    local frame = Instance.new("Frame")
    frame.Name              = "Panel"
    frame.BackgroundColor3  = Color3.fromRGB(20,20,30)
    frame.BackgroundTransparency = 0.2
    frame.Size              = UDim2.new(0,200,0,120)
    frame.Position          = UDim2.new(0.5,-100,0.7,-60)
    frame.Parent            = FakeParryPanel
    Instance.new("UICorner",frame).CornerRadius = UDim.new(0,10)
    Instance.new("UIStroke",frame).Color = Color3.fromRGB(100,100,200)

    local header = Instance.new("TextLabel")
    header.Name         = "Header"
    header.Text         = "Fake Parry"
    header.TextColor3   = Color3.fromRGB(255,255,255)
    header.BackgroundTransparency = 1
    header.Size         = UDim2.new(1,0,0,30)
    header.Font         = Enum.Font.GothamBold
    header.TextSize     = 15
    header.Parent       = frame

    local keybindLbl = Instance.new("TextLabel")
    keybindLbl.Name         = "InfoLabel"
    keybindLbl.Text         = "Keybind: V"
    keybindLbl.TextColor3   = Color3.fromRGB(200,200,200)
    keybindLbl.BackgroundTransparency = 1
    keybindLbl.Size         = UDim2.new(1,0,0,20)
    keybindLbl.Position     = UDim2.new(0,0,0,30)
    keybindLbl.Font         = Enum.Font.Gotham
    keybindLbl.TextSize     = 12
    keybindLbl.Parent       = frame

    local trigBtn = Instance.new("TextButton")
    trigBtn.Name         = "TriggerButton"
    trigBtn.Text         = "TRIGGER PARRY"
    trigBtn.TextColor3   = Color3.fromRGB(255,255,255)
    trigBtn.BackgroundColor3 = Color3.fromRGB(80,80,200)
    trigBtn.Size         = UDim2.new(0.8,0,0,35)
    trigBtn.Position     = UDim2.new(0.1,0,0,60)
    trigBtn.Font         = Enum.Font.GothamBold
    trigBtn.TextSize     = 13
    trigBtn.Parent       = frame
    Instance.new("UICorner",trigBtn).CornerRadius = UDim.new(0,6)

    trigBtn.MouseButton1Click:Connect(function()
        local remotes = ReplicatedStorage:FindFirstChild("Remotes")
        if remotes then
            local parryEv = remotes:FindFirstChild("parryResult")
            if parryEv then pcall(function() parryEv:FireServer(true) end) end
        end
    end)

    -- V key keybind
    UserInputService.InputBegan:Connect(function(inp, gp)
        if gp then return end
        if inp.KeyCode == Enum.KeyCode.V then
            local remotes = ReplicatedStorage:FindFirstChild("Remotes")
            if remotes then
                local parryEv = remotes:FindFirstChild("parryResult")
                if parryEv then pcall(function() parryEv:FireServer(true) end) end
            end
        end
    end)
end

-- ============================================================
-- [[ STREAMER PROTECTION ]]
-- ============================================================

local function SetStreamerProtection(enabled)
    MengHub.States.streamerProtection = enabled
    SetProtectName(enabled)
end

-- ============================================================
-- [[ DISABLE NOTIFICATION ]]
-- ============================================================

local function SetDisableNotification(enabled)
    MengHub.States.disableNotification = enabled
end

-- ============================================================
-- [[ MANUAL REPAIR ]]
-- ============================================================

local function StartManualRepair(gen)
    local remotes = ReplicatedStorage:FindFirstChild("Remotes")
    if not remotes then return end
    local ev = remotes:FindFirstChild("RepairEvent") or remotes:FindFirstChild("ProgressRepair")
    if ev then pcall(function() ev:FireServer(gen) end) end
    SendNotif("Meng Hub", "manual generator: started", 2)
end

-- ============================================================
-- [[ ANTI AFK ]]
-- ============================================================

local AFK_CONN
do
    local vu = game:GetService("VirtualUser")
    if vu then
        AFK_CONN = LocalPlayer.Idled:Connect(function()
            vu:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
            task.wait(0.1)
            vu:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
        end)
        SendNotif("Meng Hub", "Anti AFK Automatically Active...", 3)
    end
end

-- ============================================================
-- [[ VEIL FEATURES ]]
-- ============================================================

local function GetVeilTarget()
    -- Find player with Veil role/tag
    for _, p in ipairs(Players:GetPlayers()) do
        if p == LocalPlayer then continue end
        local char = p.Character
        if char and (CollectionService:HasTag(char, "Veil") or char:GetAttribute("Veil")) then
            return p
        end
    end
    return nil
end

-- ============================================================
-- [[ MASKED FEATURES ]]
-- ============================================================

local MaskedPanel

local function OpenMaskedGui()
    if MaskedPanel then MaskedPanel:Destroy(); MaskedPanel = nil end

    MaskedPanel = Instance.new("ScreenGui")
    MaskedPanel.Name         = "MaskedPanel"
    MaskedPanel.ResetOnSpawn = false
    MaskedPanel.Parent       = PlayerGui

    local mainFrame = Instance.new("Frame")
    mainFrame.Name              = "MainPanel"
    mainFrame.BackgroundColor3  = Color3.fromRGB(15,15,25)
    mainFrame.BackgroundTransparency = 0.1
    mainFrame.Size              = UDim2.new(0,280,0,200)
    mainFrame.Position          = UDim2.new(0.5,-140,0.5,-100)
    mainFrame.Parent            = MaskedPanel
    Instance.new("UICorner",mainFrame).CornerRadius = UDim.new(0,12)

    local title = Instance.new("TextLabel")
    title.Text          = "MASK SELECTION"
    title.TextColor3    = Color3.fromRGB(255,255,255)
    title.BackgroundTransparency = 1
    title.Size          = UDim2.new(1,0,0,40)
    title.Font          = Enum.Font.GothamBold
    title.TextSize      = 18
    title.Parent        = mainFrame

    local activeLbl = Instance.new("TextLabel")
    activeLbl.Name      = "ActiveMaskLabel"
    activeLbl.Text      = "Active Mask: Richard (Default)"
    activeLbl.TextColor3= Color3.fromRGB(200,200,200)
    activeLbl.BackgroundTransparency = 1
    activeLbl.Size      = UDim2.new(1,0,0,25)
    activeLbl.Position  = UDim2.new(0,0,0,40)
    activeLbl.Font      = Enum.Font.Gotham
    activeLbl.TextSize  = 13
    activeLbl.Parent    = mainFrame

    local masks = {"Richard", "Alex", "None", "[7] Deactivate"}
    local yOffset = 70
    for _, maskName in ipairs(masks) do
        local btn = Instance.new("TextButton")
        btn.Text            = maskName
        btn.TextColor3      = Color3.fromRGB(255,255,255)
        btn.BackgroundColor3 = Color3.fromRGB(40,40,80)
        btn.Size            = UDim2.new(0.85,0,0,28)
        btn.Position        = UDim2.new(0.075,0,0,yOffset)
        btn.Font            = Enum.Font.GothamBold
        btn.TextSize        = 13
        btn.Parent          = mainFrame
        Instance.new("UICorner",btn).CornerRadius = UDim.new(0,6)

        btn.MouseButton1Click:Connect(function()
            activeLbl.Text = "Active Mask: " .. maskName
            -- Fire the mask change remote
            local remotes = ReplicatedStorage:FindFirstChild("Remotes")
            if remotes then
                local maskEv = remotes:FindFirstChild("Mask") or remotes:FindFirstChild("Maskon")
                if maskEv then
                    if maskName == "[7] Deactivate" then
                        pcall(function() maskEv:FireServer("Deactivatepower") end)
                    else
                        pcall(function() maskEv:FireServer("Activatepower", maskName) end)
                    end
                end
            end
        end)
        yOffset = yOffset + 32
    end

    local closeBtn = Instance.new("TextButton")
    closeBtn.Text            = "× Close"
    closeBtn.TextColor3      = Color3.fromRGB(255,80,80)
    closeBtn.BackgroundColor3 = Color3.fromRGB(60,20,20)
    closeBtn.Size            = UDim2.new(0.5,0,0,28)
    closeBtn.Position        = UDim2.new(0.25,0,1,-40)
    closeBtn.Font            = Enum.Font.GothamBold
    closeBtn.TextSize        = 13
    closeBtn.Parent          = mainFrame
    Instance.new("UICorner",closeBtn).CornerRadius = UDim.new(0,6)
    closeBtn.MouseButton1Click:Connect(function() MaskedPanel:Destroy(); MaskedPanel = nil end)
end

-- ============================================================
-- [[ CHARACTER ADDED / REMOVED HANDLERS ]]
-- ============================================================

local function OnCharacterAdded(char)
    -- Re-apply persistent states after respawn
    task.wait(1)

    if MengHub.States.godMode        then SetGodMode(true) end
    if MengHub.States.noclip         then SetNoclipEnabled(true) end
    if MengHub.States.speedBoost     then SetSpeedBoost(true) end
    if MengHub.States.invisibility   then SetInvisibility(true) end
    if MengHub.States.noFallDamage   then SetupNoFallMonitor() end
    if MengHub.States.unlockJump     then SetUnlockJump(true) end
    if MengHub.States.moonwalk       then SetMoonwalk(true) end
    if MengHub.States.autoHook       then SetAutoHookEnabled(true) end
    if MengHub.States.espSurvivor    then SetESP(true) end
    if MengHub.States.breakSpeed     then SetBreakSpeed(true) end
    if MengHub.States.maxZoom        then SetMaxZoom(true) end
end

LocalPlayer.CharacterAdded:Connect(OnCharacterAdded)
if LocalPlayer.Character then OnCharacterAdded(LocalPlayer.Character) end

LocalPlayer.CharacterRemoving:Connect(function(char)
    RemoveESP(char)
end)

-- New players get ESP
Players.PlayerAdded:Connect(function(p)
    p.CharacterAdded:Connect(function()
        task.wait(1)
        if MengHub.States.esp then UpdateESPForPlayer(p) end
    end)
    if MengHub.States.antiStaff then CheckForStaff() end
end)

Players.PlayerRemoving:Connect(function(p)
    if p.Character then RemoveESP(p.Character) end
end)

-- ============================================================
-- [[ KEY UI ]]
-- ============================================================

local function CreateKeyUI()
    local existing = PlayerGui:FindFirstChild("MengHubKeyUI")
    if existing then existing:Destroy() end

    local keyGui = Instance.new("ScreenGui")
    keyGui.Name         = "MengHubKeyUI"
    keyGui.ResetOnSpawn = false
    keyGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    keyGui.Parent       = PlayerGui

    -- Blur
    local blur = Instance.new("BlurEffect")
    blur.Size   = 20
    blur.Parent = Lighting

    local mainFrame = Instance.new("Frame")
    mainFrame.Name              = "MainFrame"
    mainFrame.BackgroundColor3  = Color3.fromRGB(12,12,20)
    mainFrame.Size              = UDim2.new(0,420,0,280)
    mainFrame.Position          = UDim2.new(0.5,-210,0.5,-140)
    mainFrame.Parent            = keyGui
    Instance.new("UICorner",mainFrame).CornerRadius = UDim.new(0,16)
    local stroke = Instance.new("UIStroke",mainFrame)
    stroke.Color     = Color3.fromRGB(80,80,200)
    stroke.Thickness = 1.5

    local titleLbl = Instance.new("TextLabel")
    titleLbl.Text           = "Welcome to The,"
    titleLbl.TextColor3     = Color3.fromRGB(180,180,255)
    titleLbl.BackgroundTransparency = 1
    titleLbl.Size           = UDim2.new(1,0,0,40)
    titleLbl.Position       = UDim2.new(0,0,0,20)
    titleLbl.Font           = Enum.Font.Gotham
    titleLbl.TextSize       = 15
    titleLbl.Parent         = mainFrame

    local hubTitle = Instance.new("TextLabel")
    hubTitle.Text           = "Meng Hub"
    hubTitle.TextColor3     = Color3.fromRGB(120,120,255)
    hubTitle.BackgroundTransparency = 1
    hubTitle.Size           = UDim2.new(1,0,0,50)
    hubTitle.Position       = UDim2.new(0,0,0,45)
    hubTitle.Font           = Enum.Font.GothamBold
    hubTitle.TextSize       = 36
    hubTitle.Parent         = mainFrame

    local sysLbl = Instance.new("TextLabel")
    sysLbl.Text             = "KEY SYSTEM"
    sysLbl.TextColor3       = Color3.fromRGB(255,200,0)
    sysLbl.BackgroundTransparency = 1
    sysLbl.Size             = UDim2.new(1,0,0,25)
    sysLbl.Position         = UDim2.new(0,0,0,90)
    sysLbl.Font             = Enum.Font.GothamBold
    sysLbl.TextSize         = 14
    sysLbl.Parent           = mainFrame

    -- Key input box
    local inputFrame = Instance.new("Frame")
    inputFrame.BackgroundColor3  = Color3.fromRGB(25,25,40)
    inputFrame.Size              = UDim2.new(0.85,0,0,40)
    inputFrame.Position          = UDim2.new(0.075,0,0,125)
    inputFrame.Parent            = mainFrame
    Instance.new("UICorner",inputFrame).CornerRadius = UDim.new(0,8)
    local inputStroke = Instance.new("UIStroke",inputFrame)
    inputStroke.Color     = Color3.fromRGB(60,60,120)
    inputStroke.Thickness = 1

    local keyBox = Instance.new("TextBox")
    keyBox.Name             = "KeyInput"
    keyBox.PlaceholderText  = "XXXX-XXXX-XXXX"
    keyBox.Text             = ""
    keyBox.TextColor3       = Color3.fromRGB(255,255,255)
    keyBox.PlaceholderColor3 = Color3.fromRGB(100,100,150)
    keyBox.BackgroundTransparency = 1
    keyBox.Size             = UDim2.new(1,-10,1,0)
    keyBox.Position         = UDim2.new(0,8,0,0)
    keyBox.Font             = Enum.Font.GothamSemibold
    keyBox.TextSize         = 16
    keyBox.ClearTextOnFocus = false
    keyBox.Parent           = inputFrame

    -- Try load saved key
    local savedKey = ReadFile(MengHub.KEY_FILE)
    if savedKey then keyBox.Text = savedKey:gsub("%s+","") end

    -- Status label
    local statusLbl = Instance.new("TextLabel")
    statusLbl.Name          = "StatusLabel"
    statusLbl.Text          = ""
    statusLbl.TextColor3    = Color3.fromRGB(255,200,0)
    statusLbl.BackgroundTransparency = 1
    statusLbl.Size          = UDim2.new(1,0,0,20)
    statusLbl.Position      = UDim2.new(0,0,0,170)
    statusLbl.Font          = Enum.Font.Gotham
    statusLbl.TextSize      = 12
    statusLbl.Parent        = mainFrame

    -- Submit button
    local submitBtn = Instance.new("TextButton")
    submitBtn.Name           = "SubmitBtn"
    submitBtn.Text           = "Submit Key  >"
    submitBtn.TextColor3     = Color3.fromRGB(255,255,255)
    submitBtn.BackgroundColor3 = Color3.fromRGB(60,60,200)
    submitBtn.Size           = UDim2.new(0.55,0,0,38)
    submitBtn.Position       = UDim2.new(0.075,0,0,195)
    submitBtn.Font           = Enum.Font.GothamBold
    submitBtn.TextSize       = 14
    submitBtn.Parent         = mainFrame
    Instance.new("UICorner",submitBtn).CornerRadius = UDim.new(0,8)

    -- Get Key button
    local getKeyBtn = Instance.new("TextButton")
    getKeyBtn.Name           = "GetKeyBtn"
    getKeyBtn.Text           = "Get Key via Linkvertise"
    getKeyBtn.TextColor3     = Color3.fromRGB(200,200,255)
    getKeyBtn.BackgroundColor3 = Color3.fromRGB(30,30,60)
    getKeyBtn.Size           = UDim2.new(0.38,0,0,38)
    getKeyBtn.Position       = UDim2.new(0.545,0,0,195)
    getKeyBtn.Font           = Enum.Font.GothamBold
    getKeyBtn.TextSize       = 11
    getKeyBtn.Parent         = mainFrame
    Instance.new("UICorner",getKeyBtn).CornerRadius = UDim.new(0,8)

    -- Discord button
    local discordBtn = Instance.new("TextButton")
    discordBtn.Text          = "Join the Discord"
    discordBtn.TextColor3    = Color3.fromRGB(150,150,255)
    discordBtn.BackgroundTransparency = 1
    discordBtn.Size          = UDim2.new(1,0,0,20)
    discordBtn.Position      = UDim2.new(0,0,0,240)
    discordBtn.Font          = Enum.Font.Gotham
    discordBtn.TextSize      = 12
    discordBtn.Parent        = mainFrame

    local function trySubmitKey()
        local key = keyBox.Text:gsub("%s+","")
        if key == "" then
            statusLbl.Text      = "Masukkan key dulu!"
            statusLbl.TextColor3 = Color3.fromRGB(255,100,100)
            return
        end
        statusLbl.Text      = "Checking..."
        statusLbl.TextColor3 = Color3.fromRGB(255,200,0)
        submitBtn.Text      = "Checking..."

        task.spawn(function()
            local valid, result = CheckKey(key)
            if valid then
                SaveFile(MengHub.KEY_FILE, key)
                MengHub.Key      = key
                MengHub.KeyValid = true
                MengHub.IsPremium = (result == "premium")

                statusLbl.Text      = result == "premium" and "Premium key valid! Loading..." or "Key valid! Loading..."
                statusLbl.TextColor3 = Color3.fromRGB(100,255,100)

                task.wait(1)
                blur:Destroy()
                keyGui:Destroy()
                MengHub.IsAuthed = true
                -- Load the main UI
                CreateMainUI()
                SendNotif("Meng Hub", "[Meng Hub] Script sudah running!", 4)

                -- Auto-load config
                local autoload = ReadFile(MengHub.CONFIG_PATH .. "autoload.txt")
                if autoload and autoload ~= "" then
                    MengHub.AutoloadConfig = autoload:gsub("%s+","")
                    LoadConfig(MengHub.AutoloadConfig)
                end
            else
                submitBtn.Text = "Submit Key  >"
                local msgs = {
                    banned         = "HWID kamu di-ban dari Meng Hub.",
                    hwid_mismatch  = "Key sudah dipakai di device lain.",
                    expired        = "Key expired. Masukkan key baru.",
                    invalid        = "Key tidak valid.",
                    premium_required = "Fitur ini memerlukan Premium.",
                    server_error   = "Gagal konek ke server. Coba lagi.",
                    empty          = "Masukkan key dulu!",
                }
                statusLbl.Text      = msgs[result] or "Key tidak valid."
                statusLbl.TextColor3 = Color3.fromRGB(255,80,80)
            end
        end)
    end

    submitBtn.MouseButton1Click:Connect(trySubmitKey)
    keyBox.FocusLost:Connect(function(enter) if enter then trySubmitKey() end end)

    getKeyBtn.MouseButton1Click:Connect(function()
        task.spawn(function()
            local link = GetKeyLink()
            if link then
                if setclipboard then setclipboard(link) end
                statusLbl.Text      = "Link Linkvertise disalin!"
                statusLbl.TextColor3 = Color3.fromRGB(100,255,100)
            else
                statusLbl.Text      = "Gagal ambil link. Coba lagi."
                statusLbl.TextColor3 = Color3.fromRGB(255,100,100)
            end
        end)
    end)

    discordBtn.MouseButton1Click:Connect(function()
        if setclipboard then setclipboard(MengHub.DISCORD_INV) end
        statusLbl.Text      = "Discord invite link disalin!"
        statusLbl.TextColor3 = Color3.fromRGB(150,150,255)
    end)

    return keyGui
end

-- ============================================================
-- [[ MAIN GUI ]]
-- ============================================================

local function CreateMainUI()
    -- Destroy old if exists
    local old = PlayerGui:FindFirstChild("MengHubMainUI")
    if old then old:Destroy() end

    local mainGui = Instance.new("ScreenGui")
    mainGui.Name          = "MengHubMainUI"
    mainGui.ResetOnSpawn  = false
    mainGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    mainGui.Parent        = PlayerGui

    -- =====================================================
    -- WINDOW FRAME
    -- =====================================================
    local Window = Instance.new("Frame")
    Window.Name              = "Window"
    Window.BackgroundColor3  = Color3.fromRGB(10,10,18)
    Window.Size              = UDim2.new(0,700,0,520)
    Window.Position          = UDim2.new(0.5,-350,0.5,-260)
    Window.BorderSizePixel   = 0
    Window.Parent            = mainGui
    Instance.new("UICorner",Window).CornerRadius = UDim.new(0,14)
    local winStroke = Instance.new("UIStroke",Window)
    winStroke.Color     = Color3.fromRGB(60,60,160)
    winStroke.Thickness = 1.5

    -- Title bar
    local TitleBar = Instance.new("Frame")
    TitleBar.Name              = "TitleBar"
    TitleBar.BackgroundColor3  = Color3.fromRGB(15,15,28)
    TitleBar.Size              = UDim2.new(1,0,0,45)
    TitleBar.BorderSizePixel   = 0
    TitleBar.Parent            = Window
    Instance.new("UICorner",TitleBar).CornerRadius = UDim.new(0,14)

    -- Hub icon
    local HubIcon = Instance.new("ImageLabel")
    HubIcon.BackgroundTransparency = 1
    HubIcon.Size    = UDim2.new(0,30,0,30)
    HubIcon.Position = UDim2.new(0,10,0.5,-15)
    HubIcon.Image   = "rbxassetid://74116592570717"
    HubIcon.Parent  = TitleBar

    -- Title text
    local TitleText = Instance.new("TextLabel")
    TitleText.Text          = "Meng Hub"
    TitleText.TextColor3    = Color3.fromRGB(120,120,255)
    TitleText.BackgroundTransparency = 1
    TitleText.Size          = UDim2.new(0,200,1,0)
    TitleText.Position      = UDim2.new(0,46,0,0)
    TitleText.Font          = Enum.Font.GothamBold
    TitleText.TextSize      = 18
    TitleText.TextXAlignment = Enum.TextXAlignment.Left
    TitleText.Parent        = TitleBar

    -- Executor info
    local ExecLbl = Instance.new("TextLabel")
    ExecLbl.Text          = "Executor: " .. MengHub.ExecutorName
    ExecLbl.TextColor3    = Color3.fromRGB(100,100,150)
    ExecLbl.BackgroundTransparency = 1
    ExecLbl.Size          = UDim2.new(0,200,1,0)
    ExecLbl.Position      = UDim2.new(0,220,0,0)
    ExecLbl.Font          = Enum.Font.Gotham
    ExecLbl.TextSize      = 11
    ExecLbl.TextXAlignment = Enum.TextXAlignment.Left
    ExecLbl.Parent        = TitleBar

    -- Premium badge
    if MengHub.IsPremium then
        local premBadge = Instance.new("TextLabel")
        premBadge.Text          = "PREMIUM"
        premBadge.TextColor3    = Color3.fromRGB(255,200,0)
        premBadge.BackgroundColor3 = Color3.fromRGB(40,30,0)
        premBadge.Size          = UDim2.new(0,70,0,22)
        premBadge.Position      = UDim2.new(1,-170,0.5,-11)
        premBadge.Font          = Enum.Font.GothamBold
        premBadge.TextSize      = 11
        premBadge.Parent        = TitleBar
        Instance.new("UICorner",premBadge).CornerRadius = UDim.new(0,4)
    end

    -- Close button
    local CloseBtn = Instance.new("TextButton")
    CloseBtn.Text           = "×"
    CloseBtn.TextColor3     = Color3.fromRGB(255,80,80)
    CloseBtn.BackgroundColor3 = Color3.fromRGB(50,10,10)
    CloseBtn.Size           = UDim2.new(0,30,0,30)
    CloseBtn.Position       = UDim2.new(1,-40,0.5,-15)
    CloseBtn.Font           = Enum.Font.GothamBold
    CloseBtn.TextSize       = 20
    CloseBtn.Parent         = TitleBar
    Instance.new("UICorner",CloseBtn).CornerRadius = UDim.new(0,6)
    CloseBtn.MouseButton1Click:Connect(function()
        mainGui.Enabled = false
    end)

    -- Minimize button
    local MinBtn = Instance.new("TextButton")
    MinBtn.Text           = "−"
    MinBtn.TextColor3     = Color3.fromRGB(255,200,50)
    MinBtn.BackgroundColor3 = Color3.fromRGB(50,40,10)
    MinBtn.Size           = UDim2.new(0,30,0,30)
    MinBtn.Position       = UDim2.new(1,-76,0.5,-15)
    MinBtn.Font           = Enum.Font.GothamBold
    MinBtn.TextSize       = 20
    MinBtn.Parent         = TitleBar
    Instance.new("UICorner",MinBtn).CornerRadius = UDim.new(0,6)

    local isMinimized = false
    MinBtn.MouseButton1Click:Connect(function()
        isMinimized = not isMinimized
        Window.Size = isMinimized and UDim2.new(0,700,0,45) or UDim2.new(0,700,0,520)
    end)

    -- Drag
    local dragging, dragStart, startPos
    TitleBar.InputBegan:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
            dragging  = true
            dragStart = inp.Position
            startPos  = Window.Position
        end
    end)
    UserInputService.InputChanged:Connect(function(inp)
        if dragging and (inp.UserInputType == Enum.UserInputType.MouseMovement or inp.UserInputType == Enum.UserInputType.Touch) then
            local delta   = inp.Position - dragStart
            Window.Position = UDim2.new(
                startPos.X.Scale, startPos.X.Offset + delta.X,
                startPos.Y.Scale, startPos.Y.Offset + delta.Y
            )
        end
    end)
    UserInputService.InputEnded:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)

    -- =====================================================
    -- TAB BAR
    -- =====================================================
    local TabBar = Instance.new("Frame")
    TabBar.Name             = "TabBar"
    TabBar.BackgroundColor3 = Color3.fromRGB(12,12,22)
    TabBar.Size             = UDim2.new(0,160,1,-50)
    TabBar.Position         = UDim2.new(0,0,0,50)
    TabBar.BorderSizePixel  = 0
    TabBar.Parent           = Window

    local TabLayout = Instance.new("UIListLayout",TabBar)
    TabLayout.SortOrder     = Enum.SortOrder.LayoutOrder
    TabLayout.Padding       = UDim.new(0,3)

    local TabPadding = Instance.new("UIPadding",TabBar)
    TabPadding.PaddingTop   = UDim.new(0,8)
    TabPadding.PaddingLeft  = UDim.new(0,6)
    TabPadding.PaddingRight = UDim.new(0,6)

    -- Divider
    local tabDivider = Instance.new("Frame")
    tabDivider.BackgroundColor3 = Color3.fromRGB(40,40,80)
    tabDivider.Size             = UDim2.new(0,1,1,-50)
    tabDivider.Position         = UDim2.new(0,160,0,50)
    tabDivider.BorderSizePixel  = 0
    tabDivider.Parent           = Window

    -- =====================================================
    -- CONTENT AREA
    -- =====================================================
    local ContentArea = Instance.new("Frame")
    ContentArea.Name             = "ContentArea"
    ContentArea.BackgroundTransparency = 1
    ContentArea.Size             = UDim2.new(1,-165,1,-55)
    ContentArea.Position         = UDim2.new(0,165,0,55)
    ContentArea.Parent           = Window

    -- =====================================================
    -- HELPER: CREATE TAB
    -- =====================================================
    local ActiveTab = nil
    local TabButtons = {}
    local TabPages   = {}

    local function SetActiveTab(tabName)
        for name, page in pairs(TabPages) do
            page.Visible = (name == tabName)
        end
        for name, btn in pairs(TabButtons) do
            btn.BackgroundColor3 = (name == tabName)
                and Color3.fromRGB(50,50,160)
                or  Color3.fromRGB(20,20,40)
        end
        ActiveTab = tabName
    end

    local function AddTab(name, icon)
        local btn = Instance.new("TextButton")
        btn.Name             = name .. "Tab"
        btn.Text             = (icon or "") .. "  " .. name
        btn.TextColor3       = Color3.fromRGB(220,220,220)
        btn.BackgroundColor3 = Color3.fromRGB(20,20,40)
        btn.Size             = UDim2.new(1,0,0,36)
        btn.Font             = Enum.Font.GothamBold
        btn.TextSize         = 12
        btn.TextXAlignment   = Enum.TextXAlignment.Left
        btn.LayoutOrder      = #TabButtons + 1
        btn.Parent           = TabBar
        Instance.new("UICorner",btn).CornerRadius = UDim.new(0,8)

        local btnPadding = Instance.new("UIPadding",btn)
        btnPadding.PaddingLeft = UDim.new(0,10)

        local page = Instance.new("ScrollingFrame")
        page.Name             = name .. "Page"
        page.BackgroundTransparency = 1
        page.Size             = UDim2.new(1,0,1,0)
        page.ScrollBarThickness = 4
        page.ScrollBarImageColor3 = Color3.fromRGB(80,80,200)
        page.AutomaticCanvasSize = Enum.AutomaticSize.Y
        page.CanvasSize       = UDim2.new(0,0,0,0)
        page.Visible          = false
        page.Parent           = ContentArea

        local pageLayout = Instance.new("UIListLayout",page)
        pageLayout.SortOrder = Enum.SortOrder.LayoutOrder
        pageLayout.Padding   = UDim.new(0,5)

        local pagePadding = Instance.new("UIPadding",page)
        pagePadding.PaddingLeft   = UDim.new(0,10)
        pagePadding.PaddingRight  = UDim.new(0,10)
        pagePadding.PaddingTop    = UDim.new(0,8)

        TabButtons[name] = btn
        TabPages[name]   = page

        btn.MouseButton1Click:Connect(function()
            SetActiveTab(name)
        end)

        if not ActiveTab then SetActiveTab(name) end

        return page
    end

    -- =====================================================
    -- HELPER: UI COMPONENTS
    -- =====================================================
    local layoutOrder = 0
    local function nextOrder()
        layoutOrder = layoutOrder + 1
        return layoutOrder
    end

    local function AddSection(page, title)
        local frame = Instance.new("Frame")
        frame.BackgroundTransparency = 1
        frame.Size         = UDim2.new(1,0,0,28)
        frame.LayoutOrder  = nextOrder()
        frame.Parent       = page

        local lbl = Instance.new("TextLabel")
        lbl.Text           = "── " .. title .. " ──"
        lbl.TextColor3     = Color3.fromRGB(100,100,200)
        lbl.BackgroundTransparency = 1
        lbl.Size           = UDim2.new(1,0,1,0)
        lbl.Font           = Enum.Font.GothamBold
        lbl.TextSize       = 12
        lbl.Parent         = frame

        return frame
    end

    local function AddToggle(page, label, defaultState, callback)
        local frame = Instance.new("Frame")
        frame.BackgroundColor3  = Color3.fromRGB(18,18,32)
        frame.Size              = UDim2.new(1,0,0,38)
        frame.LayoutOrder       = nextOrder()
        frame.Parent            = page
        Instance.new("UICorner",frame).CornerRadius = UDim.new(0,8)

        local lbl = Instance.new("TextLabel")
        lbl.Text           = label
        lbl.TextColor3     = Color3.fromRGB(220,220,220)
        lbl.BackgroundTransparency = 1
        lbl.Size           = UDim2.new(1,-60,1,0)
        lbl.Position       = UDim2.new(0,12,0,0)
        lbl.Font           = Enum.Font.GothamSemibold
        lbl.TextSize       = 13
        lbl.TextXAlignment = Enum.TextXAlignment.Left
        lbl.Parent         = frame

        local toggle = Instance.new("Frame")
        toggle.Size             = UDim2.new(0,44,0,24)
        toggle.Position         = UDim2.new(1,-54,0.5,-12)
        toggle.BackgroundColor3 = defaultState and Color3.fromRGB(80,100,255) or Color3.fromRGB(50,50,70)
        toggle.Parent           = frame
        Instance.new("UICorner",toggle).CornerRadius = UDim.new(1,0)

        local dot = Instance.new("Frame")
        dot.Size             = UDim2.new(0,18,0,18)
        dot.Position         = defaultState and UDim2.new(1,-21,0.5,-9) or UDim2.new(0,3,0.5,-9)
        dot.BackgroundColor3 = Color3.fromRGB(255,255,255)
        dot.Parent           = toggle
        Instance.new("UICorner",dot).CornerRadius = UDim.new(1,0)

        local state = defaultState or false

        local clickBtn = Instance.new("TextButton")
        clickBtn.BackgroundTransparency = 1
        clickBtn.Size   = UDim2.new(1,0,1,0)
        clickBtn.Text   = ""
        clickBtn.Parent = frame

        local function updateVisual()
            TweenService:Create(toggle, TweenInfo.new(0.15,Enum.EasingStyle.Quad), {
                BackgroundColor3 = state and Color3.fromRGB(80,100,255) or Color3.fromRGB(50,50,70)
            }):Play()
            TweenService:Create(dot, TweenInfo.new(0.15,Enum.EasingStyle.Quad), {
                Position = state and UDim2.new(1,-21,0.5,-9) or UDim2.new(0,3,0.5,-9)
            }):Play()
        end

        clickBtn.MouseButton1Click:Connect(function()
            state = not state
            updateVisual()
            if callback then callback(state) end
        end)

        return {
            SetState = function(s)
                state = s
                updateVisual()
            end,
            GetState = function() return state end,
        }
    end

    local function AddSlider(page, label, min, max, default, step, callback)
        local frame = Instance.new("Frame")
        frame.BackgroundColor3  = Color3.fromRGB(18,18,32)
        frame.Size              = UDim2.new(1,0,0,58)
        frame.LayoutOrder       = nextOrder()
        frame.Parent            = page
        Instance.new("UICorner",frame).CornerRadius = UDim.new(0,8)

        local lbl = Instance.new("TextLabel")
        lbl.Text           = label
        lbl.TextColor3     = Color3.fromRGB(200,200,200)
        lbl.BackgroundTransparency = 1
        lbl.Size           = UDim2.new(0.6,0,0,24)
        lbl.Position       = UDim2.new(0,12,0,6)
        lbl.Font           = Enum.Font.GothamSemibold
        lbl.TextSize       = 12
        lbl.TextXAlignment = Enum.TextXAlignment.Left
        lbl.Parent         = frame

        local valLbl = Instance.new("TextLabel")
        valLbl.Text          = tostring(default)
        valLbl.TextColor3    = Color3.fromRGB(120,120,255)
        valLbl.BackgroundTransparency = 1
        valLbl.Size          = UDim2.new(0.3,0,0,24)
        valLbl.Position      = UDim2.new(0.68,0,0,6)
        valLbl.Font          = Enum.Font.GothamBold
        valLbl.TextSize      = 12
        valLbl.TextXAlignment = Enum.TextXAlignment.Right
        valLbl.Parent        = frame

        local track = Instance.new("Frame")
        track.BackgroundColor3 = Color3.fromRGB(35,35,55)
        track.Size             = UDim2.new(1,-24,0,8)
        track.Position         = UDim2.new(0,12,0,36)
        track.Parent           = frame
        Instance.new("UICorner",track).CornerRadius = UDim.new(1,0)

        local fill = Instance.new("Frame")
        fill.BackgroundColor3 = Color3.fromRGB(80,100,255)
        fill.Size             = UDim2.new((default-min)/(max-min),0,1,0)
        fill.Parent           = track
        Instance.new("UICorner",fill).CornerRadius = UDim.new(1,0)

        local thumb = Instance.new("Frame")
        thumb.Size             = UDim2.new(0,14,0,14)
        thumb.Position         = UDim2.new((default-min)/(max-min),0-7,0.5,-7)
        thumb.BackgroundColor3 = Color3.fromRGB(255,255,255)
        thumb.Parent           = track
        Instance.new("UICorner",thumb).CornerRadius = UDim.new(1,0)

        local value     = default
        local sliding   = false

        local function updateSlider(absX)
            local trackPos  = track.AbsolutePosition
            local trackSize = track.AbsoluteSize
            local rel = math.clamp((absX - trackPos.X) / trackSize.X, 0, 1)
            local raw = min + rel * (max - min)
            if step then
                raw = math.floor(raw / step + 0.5) * step
            end
            value = math.clamp(raw, min, max)
            local pct = (value - min) / (max - min)
            fill.Size     = UDim2.new(pct, 0, 1, 0)
            thumb.Position = UDim2.new(pct, -7, 0.5, -7)
            valLbl.Text   = tostring(math.floor(value * 10 + 0.5) / 10)
            if callback then callback(value) end
        end

        track.InputBegan:Connect(function(inp)
            if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
                sliding = true
                updateSlider(inp.Position.X)
            end
        end)
        UserInputService.InputChanged:Connect(function(inp)
            if sliding and (inp.UserInputType == Enum.UserInputType.MouseMovement or inp.UserInputType == Enum.UserInputType.Touch) then
                updateSlider(inp.Position.X)
            end
        end)
        UserInputService.InputEnded:Connect(function(inp)
            if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
                sliding = false
            end
        end)

        return { GetValue = function() return value end }
    end

    local function AddDropdown(page, label, options, default, callback)
        local frame = Instance.new("Frame")
        frame.BackgroundColor3  = Color3.fromRGB(18,18,32)
        frame.Size              = UDim2.new(1,0,0,38)
        frame.LayoutOrder       = nextOrder()
        frame.ClipsDescendants  = false
        frame.Parent            = page
        Instance.new("UICorner",frame).CornerRadius = UDim.new(0,8)

        local lbl = Instance.new("TextLabel")
        lbl.Text           = label
        lbl.TextColor3     = Color3.fromRGB(200,200,200)
        lbl.BackgroundTransparency = 1
        lbl.Size           = UDim2.new(0.5,0,1,0)
        lbl.Position       = UDim2.new(0,12,0,0)
        lbl.Font           = Enum.Font.GothamSemibold
        lbl.TextSize       = 12
        lbl.TextXAlignment = Enum.TextXAlignment.Left
        lbl.Parent         = frame

        local selectedLbl = Instance.new("TextLabel")
        selectedLbl.Text           = default or (options[1] or "")
        selectedLbl.TextColor3     = Color3.fromRGB(120,120,255)
        selectedLbl.BackgroundTransparency = 1
        selectedLbl.Size           = UDim2.new(0.4,-10,1,0)
        selectedLbl.Position       = UDim2.new(0.58,0,0,0)
        selectedLbl.Font           = Enum.Font.GothamBold
        selectedLbl.TextSize       = 12
        selectedLbl.TextXAlignment = Enum.TextXAlignment.Right
        selectedLbl.Parent         = frame

        local arrow = Instance.new("TextLabel")
        arrow.Text          = "▼"
        arrow.TextColor3    = Color3.fromRGB(150,150,200)
        arrow.BackgroundTransparency = 1
        arrow.Size          = UDim2.new(0,16,1,0)
        arrow.Position      = UDim2.new(1,-20,0,0)
        arrow.Font          = Enum.Font.Gotham
        arrow.TextSize      = 10
        arrow.Parent        = frame

        local dropList
        local isOpen = false

        local clickBtn = Instance.new("TextButton")
        clickBtn.BackgroundTransparency = 1
        clickBtn.Size   = UDim2.new(1,0,1,0)
        clickBtn.Text   = ""
        clickBtn.ZIndex = 2
        clickBtn.Parent = frame

        local function closeDropdown()
            if dropList then dropList:Destroy(); dropList = nil end
            isOpen = false
            arrow.Text = "▼"
        end

        clickBtn.MouseButton1Click:Connect(function()
            if isOpen then closeDropdown(); return end
            isOpen = true
            arrow.Text = "▲"

            dropList = Instance.new("Frame")
            dropList.BackgroundColor3  = Color3.fromRGB(20,20,38)
            dropList.Size              = UDim2.new(1,0,0,#options*32+8)
            dropList.Position          = UDim2.new(0,0,1,4)
            dropList.ZIndex            = 10
            dropList.Parent            = frame
            Instance.new("UICorner",dropList).CornerRadius = UDim.new(0,8)
            Instance.new("UIStroke",dropList).Color = Color3.fromRGB(60,60,120)

            local dl = Instance.new("UIListLayout",dropList)
            dl.Padding  = UDim.new(0,2)
            local dp = Instance.new("UIPadding",dropList)
            dp.PaddingTop  = UDim.new(0,4)
            dp.PaddingLeft = UDim.new(0,4)
            dp.PaddingRight= UDim.new(0,4)

            for i, opt in ipairs(options) do
                local optBtn = Instance.new("TextButton")
                optBtn.Text            = opt
                optBtn.TextColor3      = Color3.fromRGB(220,220,220)
                optBtn.BackgroundColor3= Color3.fromRGB(30,30,50)
                optBtn.Size            = UDim2.new(1,0,0,28)
                optBtn.Font            = Enum.Font.GothamSemibold
                optBtn.TextSize        = 12
                optBtn.ZIndex          = 11
                optBtn.Parent          = dropList
                Instance.new("UICorner",optBtn).CornerRadius = UDim.new(0,6)

                optBtn.MouseButton1Click:Connect(function()
                    selectedLbl.Text = opt
                    if callback then callback(opt) end
                    closeDropdown()
                end)
                optBtn.MouseEnter:Connect(function()
                    optBtn.BackgroundColor3 = Color3.fromRGB(50,50,120)
                end)
                optBtn.MouseLeave:Connect(function()
                    optBtn.BackgroundColor3 = Color3.fromRGB(30,30,50)
                end)
            end
        end)

        return {
            SetValue = function(v)
                selectedLbl.Text = v
            end,
            GetValue = function()
                return selectedLbl.Text
            end,
        }
    end

    local function AddButton(page, label, callback)
        local btn = Instance.new("TextButton")
        btn.Text            = label
        btn.TextColor3      = Color3.fromRGB(255,255,255)
        btn.BackgroundColor3= Color3.fromRGB(40,40,120)
        btn.Size            = UDim2.new(1,0,0,36)
        btn.LayoutOrder     = nextOrder()
        btn.Font            = Enum.Font.GothamBold
        btn.TextSize        = 13
        btn.Parent          = page
        Instance.new("UICorner",btn).CornerRadius = UDim.new(0,8)

        btn.MouseEnter:Connect(function()
            btn.BackgroundColor3 = Color3.fromRGB(60,60,180)
        end)
        btn.MouseLeave:Connect(function()
            btn.BackgroundColor3 = Color3.fromRGB(40,40,120)
        end)
        btn.MouseButton1Click:Connect(function()
            if callback then callback() end
        end)
        return btn
    end

    local function AddInput(page, label, placeholder, callback)
        local frame = Instance.new("Frame")
        frame.BackgroundColor3 = Color3.fromRGB(18,18,32)
        frame.Size             = UDim2.new(1,0,0,58)
        frame.LayoutOrder      = nextOrder()
        frame.Parent           = page
        Instance.new("UICorner",frame).CornerRadius = UDim.new(0,8)

        local lbl = Instance.new("TextLabel")
        lbl.Text           = label
        lbl.TextColor3     = Color3.fromRGB(200,200,200)
        lbl.BackgroundTransparency = 1
        lbl.Size           = UDim2.new(1,0,0,24)
        lbl.Position       = UDim2.new(0,12,0,4)
        lbl.Font           = Enum.Font.GothamSemibold
        lbl.TextSize       = 12
        lbl.TextXAlignment = Enum.TextXAlignment.Left
        lbl.Parent         = frame

        local inputBox = Instance.new("TextBox")
        inputBox.PlaceholderText  = placeholder or "Write ur input here..."
        inputBox.Text             = ""
        inputBox.TextColor3       = Color3.fromRGB(255,255,255)
        inputBox.PlaceholderColor3= Color3.fromRGB(100,100,150)
        inputBox.BackgroundColor3 = Color3.fromRGB(25,25,45)
        inputBox.Size             = UDim2.new(1,-24,0,26)
        inputBox.Position         = UDim2.new(0,12,0,28)
        inputBox.Font             = Enum.Font.Gotham
        inputBox.TextSize         = 12
        inputBox.TextXAlignment   = Enum.TextXAlignment.Left
        inputBox.ClearTextOnFocus = false
        inputBox.Parent           = frame
        Instance.new("UICorner",inputBox).CornerRadius = UDim.new(0,6)
        local ip = Instance.new("UIPadding",inputBox)
        ip.PaddingLeft = UDim.new(0,6)

        inputBox.FocusLost:Connect(function(enter)
            if enter and callback then callback(inputBox.Text) end
        end)

        return {
            GetText = function() return inputBox.Text end,
            SetText = function(t) inputBox.Text = t end,
        }
    end

    local function AddParagraph(page, title, text)
        local frame = Instance.new("Frame")
        frame.BackgroundColor3 = Color3.fromRGB(15,15,28)
        frame.Size             = UDim2.new(1,0,0,0)
        frame.AutomaticSize    = Enum.AutomaticSize.Y
        frame.LayoutOrder      = nextOrder()
        frame.Parent           = page
        Instance.new("UICorner",frame).CornerRadius = UDim.new(0,8)

        local t = Instance.new("TextLabel")
        t.Text             = "[" .. title .. "]\n" .. text
        t.TextColor3       = Color3.fromRGB(180,180,180)
        t.BackgroundTransparency = 1
        t.Size             = UDim2.new(1,-16,0,0)
        t.Position         = UDim2.new(0,8,0,8)
        t.AutomaticSize    = Enum.AutomaticSize.Y
        t.Font             = Enum.Font.Gotham
        t.TextSize         = 11
        t.TextWrapped      = true
        t.TextXAlignment   = Enum.TextXAlignment.Left
        t.Parent           = frame
        return frame
    end

    local function AddDivider(page)
        local div = Instance.new("Frame")
        div.BackgroundColor3 = Color3.fromRGB(40,40,70)
        div.Size             = UDim2.new(1,0,0,1)
        div.LayoutOrder      = nextOrder()
        div.Parent           = page
        return div
    end

    local function AddColorPicker(page, label, default, callback)
        local frame = Instance.new("Frame")
        frame.BackgroundColor3 = Color3.fromRGB(18,18,32)
        frame.Size             = UDim2.new(1,0,0,38)
        frame.LayoutOrder      = nextOrder()
        frame.Parent           = page
        Instance.new("UICorner",frame).CornerRadius = UDim.new(0,8)

        local lbl = Instance.new("TextLabel")
        lbl.Text           = label
        lbl.TextColor3     = Color3.fromRGB(200,200,200)
        lbl.BackgroundTransparency = 1
        lbl.Size           = UDim2.new(0.65,0,1,0)
        lbl.Position       = UDim2.new(0,12,0,0)
        lbl.Font           = Enum.Font.GothamSemibold
        lbl.TextSize       = 12
        lbl.TextXAlignment = Enum.TextXAlignment.Left
        lbl.Parent         = frame

        local preview = Instance.new("Frame")
        preview.BackgroundColor3 = default or Color3.fromRGB(255,255,255)
        preview.Size             = UDim2.new(0,26,0,26)
        preview.Position         = UDim2.new(1,-38,0.5,-13)
        preview.Parent           = frame
        Instance.new("UICorner",preview).CornerRadius = UDim.new(0,6)
        Instance.new("UIStroke",preview).Color = Color3.fromRGB(100,100,150)

        return preview
    end

    local function AddCheckbox(page, label, default, callback)
        return AddToggle(page, label, default, callback)
    end

    local function AddSubSection(page, label)
        local frame = Instance.new("Frame")
        frame.BackgroundTransparency = 1
        frame.Size         = UDim2.new(1,0,0,22)
        frame.LayoutOrder  = nextOrder()
        frame.Parent       = page

        local lbl = Instance.new("TextLabel")
        lbl.Text           = "▸ " .. label
        lbl.TextColor3     = Color3.fromRGB(80,80,180)
        lbl.BackgroundTransparency = 1
        lbl.Size           = UDim2.new(1,0,1,0)
        lbl.Font           = Enum.Font.GothamBold
        lbl.TextSize       = 11
        lbl.TextXAlignment = Enum.TextXAlignment.Left
        lbl.Parent         = frame
    end

    -- =====================================================
    -- TOGGLE UI KEYBIND (F3)
    -- =====================================================
    UserInputService.InputBegan:Connect(function(inp, gp)
        if gp then return end
        if inp.KeyCode == Enum.KeyCode.F3 then
            mainGui.Enabled = not mainGui.Enabled
        end
    end)

    -- =====================================================
    -- ===== TABS =====
    -- =====================================================

    -- ───────────────── TAB: ESP ─────────────────
    local espPage = AddTab("ESP", "👁")
    AddSection(espPage, "ESP Settings")
    AddToggle(espPage, "Enable ESP",         false, function(v) SetESP(v) end)
    AddToggle(espPage, "ESP Survivor",       false, function(v) MengHub.States.espSurvivor = v end)
    AddToggle(espPage, "ESP Killer",         false, function(v) MengHub.States.espKiller   = v end)
    AddToggle(espPage, "ESP Generator",      false, function(v) MengHub.States.espGenerator= v end)
    AddToggle(espPage, "ESP Gate",           false, function(v) MengHub.States.espGate     = v end)
    AddToggle(espPage, "ESP Vault",          false, function(v) MengHub.States.espVault    = v end)
    AddToggle(espPage, "ESP Pallet",         false, function(v) MengHub.States.espPallet   = v end)
    AddToggle(espPage, "ESP Hook",           false, function(v) MengHub.States.espHook     = v end)
    AddToggle(espPage, "ESP Object",         false, function(v) MengHub.States.espObject   = v end)
    AddToggle(espPage, "ESP Zombie Dummy",   false, function(v) MengHub.States.espZombieDummy = v end)
    AddDivider(espPage)
    AddToggle(espPage, "Show Name",          true,  function(v) MengHub.States.espName     = v end)
    AddToggle(espPage, "Show Distance",      true,  function(v) MengHub.States.espDistance = v end)
    AddToggle(espPage, "Show Platform",      false, function(v) MengHub.States.espPlatform = v end)
    AddToggle(espPage, "Show Stun Ring",     false, function(v) MengHub.States.espStunRing = v end)
    AddToggle(espPage, "ESP Generator Progress",false,function(v) MengHub.States.espGeneratorProgress = v end)
    AddToggle(espPage, "ESP Role",           false, function(v) MengHub.States.espRole     = v end)
    AddToggle(espPage, "Enable Laser Effect",false, function(v) MengHub.States.espLaserEffect = v; SendNotif("Meng Hub","laser effect: "..(v and "on" or "off"),2) end)
    AddDivider(espPage)
    AddSection(espPage, "Custom ESP Colors")
    AddColorPicker(espPage, "Survivor Color",  Color3.fromRGB(0,255,100), function(c) MengHub.ESPColors.survivor = c end)
    AddColorPicker(espPage, "Killer Color",    Color3.fromRGB(255,50,50), function(c) MengHub.ESPColors.killer   = c end)
    AddColorPicker(espPage, "Generator Color", Color3.fromRGB(255,200,0),function(c) MengHub.ESPColors.generator= c end)
    AddColorPicker(espPage, "Gate Color",      Color3.fromRGB(0,180,255),function(c) MengHub.ESPColors.gate     = c end)
    AddColorPicker(espPage, "Vault Color",     Color3.fromRGB(150,0,255),function(c) MengHub.ESPColors.vault    = c end)
    AddColorPicker(espPage, "Pallet Color",    Color3.fromRGB(255,140,0),function(c) MengHub.ESPColors.pallet   = c end)
    AddColorPicker(espPage, "Hook Color",      Color3.fromRGB(180,0,0),  function(c) MengHub.ESPColors.hook     = c end)
    AddColorPicker(espPage, "Zombie Dummy Color",Color3.fromRGB(0,200,100),function(c) MengHub.ESPColors.object = c end)
    AddDivider(espPage)
    AddSection(espPage, "Snapline")
    AddToggle(espPage, "Enable Snapline",    false, function(v)
        MengHub.States.espSnapline = v
        -- Delta_Snapline_UI / Delta_FOVCircle handled by visualizer
    end)

    -- ───────────────── TAB: Aimbot ─────────────────
    local aimbotPage = AddTab("Aimbot", "🎯")
    AddSection(aimbotPage, "Aimbot Features")
    AddToggle(aimbotPage, "Enable Aimbot",     false, function(v) SetAimbotEnabled(v) end)
    AddToggle(aimbotPage, "Lock FOV",          false, function(v) MengHub.States.lockFOV = v end)
    AddToggle(aimbotPage, "Show FOV Circle",   false, function(v) SetFOVCircle(v) end)
    AddToggle(aimbotPage, "Wallcheck",         false, function(v) MengHub.States.wallcheck = v end)
    AddSlider(aimbotPage,  "FOV Degree",       10, 180, 90, 1, function(v) SetFOV(v) end)
    AddSlider(aimbotPage,  "Attack Range (studs)",5,100,12,1, function(v) MengHub.Values.attackRange = v end)
    AddDropdown(aimbotPage,"Follow Camera",    {"Default","Legit","Killer"}, "Default", function(v) MengHub.Dropdowns.aimbotFollowCamera = v end)
    AddDivider(aimbotPage)
    AddSection(aimbotPage, "Aimbot Flashlight")
    AddToggle(aimbotPage, "Enable Aimbot Flashlight", false, function(v) SetAimbotFlashlight(v) end)
    AddToggle(aimbotPage, "Flashlight Aimbot",        false, function(v) MengHub.States.aimbotFlashlight = v end)
    AddDivider(aimbotPage)
    AddSection(aimbotPage, "Hidden Skill Aimbot")
    AddParagraph(aimbotPage, "README!", "Aktifkan fitur ini ketika sudah didalam match. fitur ini bekerja pada\n1. The Hidden\n2. Stalker (Mayers)\n3. Abysswalker")
    AddToggle(aimbotPage, "Enable Skill Aimbot Hidden", false, function(v) SetHiddenAimbot(v) end)
    AddDivider(aimbotPage)
    AddSection(aimbotPage, "Silent Aim Section")
    AddToggle(aimbotPage, "Silent Aim (Twist Of Fate)", false, function(v) SetSilentAim(v); SendNotif("Meng Hub","silent aim: "..(v and "on" or "off"),2) end)
    AddToggle(aimbotPage, "[Toggle] Veil Silent Aim",   false, function(v) SetVeilSilentAim(v); SendNotif("Meng Hub","veil silent aim: "..(v and "on" or "off"),2) end)
    AddToggle(aimbotPage, "Spear Silent Aim",            false, function(v) SetSpearSilentAim(v) end)
    AddToggle(aimbotPage, "Safety Silent Aim",           false, function(v) MengHub.States.safetySilentAim = v; SendNotif("Meng Hub","safety silent aim: "..(v and "on" or "off"),2) end)
    AddToggle(aimbotPage, "Show Veil FOV Circle",        false, function(v) MengHub.States.showVeilFOVCircle = v; SendNotif("Meng Hub","veil fov circle: "..(v and "on" or "off"),2) end)
    AddDivider(aimbotPage)
    AddSection(aimbotPage, "Prediction Features")
    AddToggle(aimbotPage, "Enable Killer Prediction",  false, function(v) MengHub.States.enableKillerPrediction = v end)
    AddToggle(aimbotPage, "Enable Map Prediction",     false, function(v) SetMapPrediction(v) end)
    AddToggle(aimbotPage, "Enable Spear Prediction",   false, function(v) MengHub.States.enableSpearPrediction = v end)
    AddToggle(aimbotPage, "Auto Prediction ToF",       false, function(v) MengHub.States.autoPrediction = v; SendNotif("Meng Hub","auto predict aim: "..(v and "on" or "off"),2) end)
    AddToggle(aimbotPage, "Auto Prediction (Veil)",    false, function(v) MengHub.States.veilAutoPred = v; SendNotif("Meng Hub","veil auto predict: "..(v and "on" or "off"),2) end)

    -- ───────────────── TAB: Survivor ─────────────────
    local survPage = AddTab("Survivor", "🧍")

    AddSection(survPage, "Invisible And Movement Features")
    AddToggle(survPage, "God Mode",          false, function(v) SetGodMode(v); SendNotif("Meng Hub","godmode: "..(v and "enabled" or "disabled"),2) end)
    AddToggle(survPage, "Noclip",            false, function(v) SetNoclipEnabled(v) end)
    AddToggle(survPage, "Invisibility",      false, function(v) SetInvisibility(v) end)
    AddToggle(survPage, "Speed Boost",       false, function(v) SetSpeedBoost(v) end)
    AddDropdown(survPage,"Speed Boost Mode", {"Default","Run","Sprint"}, "Default", function(v) MengHub.Dropdowns.speedBoostMode = v end)
    AddSlider(survPage,  "Speed (misal: 30)", 10, 200, 30, 1, function(v) MengHub.Values.speedValue = v end)
    AddToggle(survPage,  "Enable Run Speed", false, function(v) SetRunSpeed(v) end)
    AddSlider(survPage,  "Persen (misal: 40 = 40%)", 10, 200, 40, 5, function(v) MengHub.Values.runSpeedPersen = v end)
    AddToggle(survPage,  "Break Speed",      false, function(v) SetBreakSpeed(v) end)
    AddSlider(survPage,  "Persen (misal: 40 = 40%)", 10, 100, 40, 5, function(v) MengHub.Values.breakSpeedPersen = v end)
    AddToggle(survPage,  "Moonwalk",         false, function(v) SetMoonwalk(v) end)
    AddDropdown(survPage,"Moonwalk Mode",    {"Default","Follow Camera"}, "Default", function(v) MengHub.Dropdowns.moonwalkMode = v end)
    AddToggle(survPage,  "Infinite Lunge",   false, function(v) SetInfiniteLunge(v) end)
    AddToggle(survPage,  "No Fall Damage",   false, function(v) MengHub.States.noFallDamage = v; if v then SetupNoFallMonitor() end; SendNotif("Meng Hub","no fall damage: "..(v and "on" or "off"),2) end)
    AddToggle(survPage,  "Unlock Jump",      false, function(v) SetUnlockJump(v) end)
    AddSlider(survPage,  "Gravity Scale",    0.1, 3, 1, 0.1, function(v) SetGravityScale(v) end)
    AddToggle(survPage,  "Auto Run [PC]",    false, function(v) SetAutoRun(v) end)
    AddToggle(survPage,  "Auto Dodge Crouch",false, function(v) SetAutoDodgeCrouch(v) end)

    AddDivider(survPage)
    AddSection(survPage, "Self Heal")
    AddToggle(survPage, "[Toggle] Self Heal", false, function(v) SetSelfHealEnabled(v) end)

    AddDivider(survPage)
    AddSection(survPage, "Survival Utility")
    AddToggle(survPage, "Auto Hook",             false, function(v) SetAutoHookEnabled(v) end)
    AddToggle(survPage, "Auto Vault",            false, function(v) SetAutoVault(v) end)
    AddToggle(survPage, "Fast Vault",            false, function(v) SetFastVaultEnabled(v) end)
    AddSlider(survPage,  "Delay Before Vault",   0, 2, 0.3, 0.05, function(v) MengHub.Values.delayBeforeVault = v end)
    AddToggle(survPage, "Block All Vault & Pallet",false,function(v) SetBlockAllVault(v) end)
    AddToggle(survPage, "Anti Break Pallet",     false, function(v) MengHub.States.antiBreakPallet = v end)
    AddToggle(survPage, "Auto Drop Pallet",      false, function(v) MengHub.States.autoDropPallet = v; SendNotif("Meng Hub","auto drop pallet: "..(v and "on" or "off"),2) end)
    AddToggle(survPage, "Safety Drop Pallet",    false, function(v) MengHub.States.safetyDropPallet = v end)
    AddToggle(survPage, "Flee Killer (Auto Menjauh)", false, function(v) SetFleeKiller(v) end)
    AddSlider(survPage,  "Flee Distance (studs)", 10, 100, 40, 5, function(v) MengHub.Values.fleeDistance = v end)

    AddDivider(survPage)
    AddSection(survPage, "Auto Skillcheck")
    AddToggle(survPage, "Enable Auto Skillcheck Perfect", false, function(v) SetAutoSkillcheckPerfect(v) end)
    AddDropdown(survPage,"Skillcheck Mode",      {"None","Instant","Random"}, "None", function(v)
        MengHub.Dropdowns.skillcheckMode = v
        if MengHub.States.autoSkillcheckPerfect then SetAutoSkillcheckPerfect(true) end
    end)

    AddDivider(survPage)
    AddSection(survPage, "Auto Generator")
    AddButton(survPage, "Bypass Generator",     function() SetBypassGenerator(true) end)
    AddToggle(survPage, "Auto Generator",       false, function(v) SetAutoGenerator(v, false) end)
    AddToggle(survPage, "Auto Generator (With TP)", false, function(v) SetAutoGenerator(v, true) end)
    AddButton(survPage, "Manual Generator (No TP)", function() SendNotif("Meng Hub","manual generator: started",2); SetAutoGenerator(true, false) end)
    AddButton(survPage, "Bypass Gate",          function() SendNotif("Meng Hub","Bypass Gate: attempting...",2) end)

    AddDivider(survPage)
    AddSection(survPage, "Auto Parry")
    AddToggle(survPage, "Enable Auto Parry",       false, function(v) SetAutoParry(v) end)
    AddToggle(survPage, "Trigger Auto Parry",      false, function(v) SetTriggerAPEnabled(v) end)
    AddSlider(survPage,  "Parry Range (studs)",    5,50,12,1, function(v) MengHub.Values.parryRange = v end)
    AddButton(survPage, "Toggle Fake Parry Panel", function() ToggleFakeParryPanel(not MengHub.States.fakeParryPanel) end)

    AddDivider(survPage)
    AddSection(survPage, "Gate")
    AddToggle(survPage, "Auto Gate One Tap",   false, function(v) SetGateOneTapEnabled(v) end)
    AddToggle(survPage, "Instant TP Gate",     false, function(v) SetInstantTPEnabled(v) end)
    AddToggle(survPage, "Troll Teleport",      false, function(v) SetTrollTPEnabled(v) end)
    AddParagraph(survPage,"Info","Teleport balik ke posisi lama setelah gate trigger")
    AddToggle(survPage, "Beat Game (Auto Escape)", false, function(v) SetBeatGame(v) end)
    AddToggle(survPage, "Skip Endscreen",      false, function(v) MengHub.States.skipEndscreen = v end)

    AddDivider(survPage)
    AddSection(survPage, "Player Utility")
    AddToggle(survPage, "Max Zoom 1000",       false, function(v) SetMaxZoom(v) end)
    AddToggle(survPage, "Spectator List",      false, function(v) SetSpectator(v) end)
    AddToggle(survPage, "Streamer Protection", false, function(v) SetStreamerProtection(v) end)
    AddToggle(survPage, "Protect Name",        false, function(v) SetProtectName(v) end)
    AddToggle(survPage, "Hide Player Icon",    false, function(v) SetHidePlayerIcon(v) end)
    AddToggle(survPage, "Disable Notification",false, function(v) SetDisableNotification(v) end)
    AddToggle(survPage, "Hidden & Masked Counter",false,function(v) SetHiddenMaskedCounter(v) end)
    AddToggle(survPage, "Anti Staff",          false, function(v) MengHub.States.antiStaff = v; SendNotif("Meng Hub","Automatically kick if any staff/dev join",3) end)
    AddButton(survPage, "Reset Character",     function() ResetCharacter() end)
    AddButton(survPage, "Return To Lobby",     function() ReturnToLobby() end)
    AddButton(survPage, "Server Hop",          function() ServerHop(false) end)
    AddButton(survPage, "Server Hop (Small Server)", function() ServerHop(true) end)
    AddButton(survPage, "Rejoin Server",       function() RejoinServer() end)

    -- ───────────────── TAB: Fake Perks ─────────────────
    local fakePerksPage = AddTab("Fake Perks", "✨")
    AddSection(fakePerksPage, "Fake Perks Features")
    AddParagraph(fakePerksPage,"README!","Fitur ini akan menumpuk skillcheck jika anda tidak menggunakan mode yang Auto Repair.\nJika jaringan anda tidak bagus, sudah pasti akan meledak saat skillcheck jika menggunakan mode Manual Repair.\nJika menggunakan fitur ini dan mode manual repair, sangat disarankan untuk menggunakan Auto Skillcheck mode Instant!")
    AddToggle(fakePerksPage, "Fake Perks Flowstate",        false, function(v) SetFlowstate(v) end)
    AddToggle(fakePerksPage, "[Toggle] Fake Snake Step",    false, function(v) SetSnakeStep(v) end)
    AddToggle(fakePerksPage, "[Toggle] Fake Perfect Landing",false,function(v) SetPerfectLanding(v) end)
    AddToggle(fakePerksPage, "[Toggle] Fake Quick Recovery",false, function(v) SetQuickRecovery(v) end)
    AddSlider(fakePerksPage,  "Fake Perks Delay",           0, 2, 0.5, 0.05, function(v) MengHub.Values.fakePerksDelay = v end)

    -- ───────────────── TAB: Killer ─────────────────
    local killerPage = AddTab("Killer", "🔪")
    AddSection(killerPage, "Killer Utility")
    AddSection(killerPage, "Kill All Instant (Riskan)")
    AddToggle(killerPage, "Enable Kill All",           false, function(v) SetKillAllEnabled(v) end)
    AddToggle(killerPage, "Kill All Instant",          false, function(v) MengHub.States.killAll = v; SendNotif("Meng Hub","kill all: "..(v and "enabled" or "disabled"),2) end)
    AddSlider(killerPage,  "Killer Aim Range (studs)", 5, 100, 40, 1, function(v) MengHub.Values.killerAimRange = v end)
    AddSlider(killerPage,  "Killer Escape Distance",   10,200,30, 1,  function(v) MengHub.Values.killerEscapeDistance = v end)
    AddToggle(killerPage,  "Auto Attack",              false, function(v) SetAutoAttack(v) end)
    AddDropdown(killerPage,"Auto Attack Mode",         {"Legit","Brutal","Killer"}, "Legit", function(v) MengHub.Dropdowns.autoAttackMode = v end)
    AddToggle(killerPage,  "Enable Killer Prediction", false, function(v) MengHub.States.enableKillerPrediction = v end)
    AddSlider(killerPage,  "Facing Threshold",         0,1,0.5,0.05, function(v) MengHub.Values.facingThreshold = v end)
    AddParagraph(killerPage,"Info","Lower = looser, higher = stricter facing check")
    AddDivider(killerPage)
    AddSection(killerPage, "King Scourge's Detector")
    AddButton(killerPage, "Setup King Scourge Detector", function() SetupKingScourgeDetector() end)
    AddDivider(killerPage)
    AddSection(killerPage, "Skill No Cooldown")
    AddParagraph(killerPage,"README!","Supports: The Hidden, Stalker (Mayers), Abysswalker")
    AddButton(killerPage, "Activate Skill Killer No CD", function() ActivateSkillNoCD() end)
    AddButton(killerPage, "Deactivate", function() NoCDActive = false; SendNotif("Meng Hub","Skill No CD: deactivated",2) end)
    AddDivider(killerPage)
    AddSection(killerPage, "Veil Features")
    AddToggle(killerPage, "[Toggle] Veil Silent Aim",  false, function(v) SetVeilSilentAim(v) end)
    AddToggle(killerPage, "Show Veil FOV Circle",      false, function(v) MengHub.States.showVeilFOVCircle = v end)
    AddDivider(killerPage)
    AddSection(killerPage, "Masked Features")
    AddButton(killerPage, "Open Masked Gui",           function() OpenMaskedGui() end)
    AddButton(killerPage, "Open/Close Mob Panel",      function() MengHub.States.mobPanelOpen = not MengHub.States.mobPanelOpen end)

    -- ───────────────── TAB: Emote & Skin ─────────────────
    local emotePage = AddTab("Emote", "🎭")
    AddSection(emotePage, "Emote Features")
    AddToggle(emotePage, "Play Emote",       false, function(v) SetEmoteEnabled(v) end)
    AddDropdown(emotePage,"Select Emote",    {"Fist","Meme","Meme 2","Brandon","Cobra","Rabbit","Jerk Off"}, "Fist", function(v)
        MengHub.Dropdowns.selectedEmote = v
    end)
    AddButton(emotePage, "Play Selected Emote", function() PlayEmote(MengHub.Dropdowns.selectedEmote) end)
    AddButton(emotePage, "Set Autoload",     function()
        MengHub.States.autoloadEmote = true
        SendNotif("Meng Hub", "Emote autoload: " .. MengHub.Dropdowns.selectedEmote, 2)
    end)
    AddButton(emotePage, "Clear Autoload",   function()
        MengHub.States.autoloadEmote = false
        SendNotif("Meng Hub", "Emote autoload cleared", 2)
    end)
    AddDivider(emotePage)
    AddSection(emotePage, "Fake Avatar")
    AddInput(emotePage, "Fake Avatar Via Username", "Input Username (@username)", function(v)
        MengHub.lastFakeAvatarInput = v
    end)
    AddButton(emotePage, "Apply Fake Avatar", function()
        ApplyFakeAvatarByUsername(MengHub.lastFakeAvatarInput)
    end)
    AddButton(emotePage, "Reset Avatar",     function() ResetAvatar() end)
    AddDivider(emotePage)
    AddSection(emotePage, "Spoof Features")
    AddInput(emotePage, "Spoof Name",        "This only spoof yours", function(v) SpoofName(v) end)
    AddInput(emotePage, "Spoof Gold",        "Gold amount",           function(v) SpoofGold(tonumber(v) or 0) end)
    AddInput(emotePage, "Spoof Screw",       "Screw amount",          function(v) SpoofScrew(tonumber(v) or 0) end)
    AddInput(emotePage, "Spoof Level",       "Level amount",          function(v) SpoofLevel(tonumber(v) or 1) end)

    -- ───────────────── TAB: Settings ─────────────────
    local settingsPage = AddTab("Settings", "⚙")
    AddSection(settingsPage, "Graphics & Lighting")
    AddToggle(settingsPage, "Full Bright",           false, function(v) SetFullBright(v) end)
    AddToggle(settingsPage, "No Fog",                false, function(v) SetNoFog(v) end)
    AddToggle(settingsPage, "Remove Dynamic Shadow", false, function(v) SetRemoveDynamicShadow(v) end)
    AddToggle(settingsPage, "Low Graphics Mode",     false, function(v) SetLowGraphicsMode(v) end)
    AddParagraph(settingsPage,"Info","Activate this before match")
    AddToggle(settingsPage, "Booster FPS",           false, function(v) SetBoosterFPS(v) end)
    AddSlider(settingsPage,  "Max FPS",              30,240,60,1, function(v) SetMaxFPS(v) end)
    AddToggle(settingsPage,  "Reduce Map (Potato Mode)", false, function(v)
        if v then
            for _, obj in ipairs(workspace:GetDescendants()) do
                if obj:IsA("BasePart") and obj.Name ~= "HumanoidRootPart" then
                    obj.Material = Enum.Material.SmoothPlastic
                    obj.CastShadow = false
                end
            end
        end
    end)
    AddToggle(settingsPage, "X-Ray Wall",            false, function(v) SetXRay(v) end)
    AddToggle(settingsPage, "No Flashlight (Anti Blind)", false, function(v) SetNoFlashlight(v) end)
    AddDivider(settingsPage)
    AddSection(settingsPage, "Camera")
    AddSlider(settingsPage,  "Gravity Scale",        0.1, 5, 1, 0.1, function(v) SetGravityScale(v) end)
    AddToggle(settingsPage, "Max Zoom 1000",          false, function(v) SetMaxZoom(v) end)
    AddDivider(settingsPage)
    AddSection(settingsPage, "UI Settings")
    AddToggle(settingsPage, "Ping & FPS Counter",    false, function(v) SetPingFPSCounter(v) end)
    AddToggle(settingsPage, "Disable Notification",  false, function(v) SetDisableNotification(v) end)
    AddToggle(settingsPage, "Streamer Protection",   false, function(v) SetStreamerProtection(v) end)
    AddDivider(settingsPage)
    AddSection(settingsPage, "Crosshair Features")
    AddToggle(settingsPage, "Enable Crosshair",      false, function(v) MengHub.States.enableCrosshair = v; SendNotif("Meng Hub","crosshair: "..(v and "on" or "off"),2) end)
    AddButton(settingsPage, "Open Crosshair Settings",function() SendNotif("Meng Hub","Crosshair settings opened",2) end)
    AddDivider(settingsPage)
    AddSection(settingsPage, "Enable/Disable Cursor")
    AddToggle(settingsPage, "Enable/Disable Cursor", true, function(v)
        MengHub.States.enableCursor = v
        UserInputService.MouseIconEnabled = v
    end)
    AddDivider(settingsPage)
    AddSection(settingsPage, "Hit Sound")
    AddDropdown(settingsPage,"Select Hit Sound",     {"None","Click","Stun","Aura"}, "None", function(v) MengHub.Dropdowns.selectedHitSound = v end)
    AddDivider(settingsPage)
    AddSection(settingsPage, "Mobile")
    AddToggle(settingsPage, "Edit Mode (drag button)", false, function(v)
        MengHub.States.editMode = v
        SendNotif("Meng Hub", v and "Edit mode ON - drag button untuk geser" or "Edit mode OFF - posisi tersimpan", 3)
    end)
    AddButton(settingsPage, "Destroy Floating UI",   function()
        -- Cleanup floating UIs
        for _, gui in ipairs(PlayerGui:GetChildren()) do
            if gui.Name:find("MengHub") and gui.Name ~= "MengHubMainUI" then
                gui:Destroy()
            end
        end
        SendNotif("Meng Hub","Floating UIs destroyed",2)
    end)
    AddButton(settingsPage, "Custom Button Position", function()
        SendNotif("Meng Hub","Open Position Editor",2)
    end)
    AddButton(settingsPage, "Reset All Elements to Default", function()
        SendNotif("Meng Hub","Settings reset to default",2)
    end)

    -- ───────────────── TAB: Config ─────────────────
    local configPage = AddTab("Config", "📁")
    AddSection(configPage, "Config Manager")

    local configNameInput = AddInput(configPage, "Config Name", "Enter the name for u config", function(v)
        MengHub.ConfigName = v
    end)

    AddButton(configPage, "Save Config", function()
        SaveConfig(MengHub.ConfigName)
    end)

    local configDropdown = AddDropdown(configPage, "Select Config", GetConfigList(), "", function(v)
        MengHub.SelectedConfig = v
    end)
    AddParagraph(configPage,"Info","Choose from exists configs")

    AddButton(configPage, "Load Config", function()
        LoadConfig(MengHub.SelectedConfig)
        configDropdown.SetValue(MengHub.SelectedConfig)
    end)

    AddButton(configPage, "Delete Config", function()
        DeleteConfig(MengHub.SelectedConfig)
        SendNotif("Meng Hub","Config deleted: "..MengHub.SelectedConfig,3)
    end)

    AddButton(configPage, "Set Autoload", function()
        SetAutoloadConfig(MengHub.SelectedConfig)
    end)
    AddButton(configPage, "Clear Autoload", function()
        ClearAutoloadConfig()
    end)

    AddButton(configPage, "Refresh List", function()
        SendNotif("Meng Hub","Config list refreshed",2)
    end)

    AddDivider(configPage)
    AddSection(configPage, "External Config JSON")
    AddParagraph(configPage,"Info","Pilih dan load dulu, dan select kembali config yang ingin di import!")
    local extJsonInput = AddInput(configPage, "Load External JSON", "Paste ur raw JSON config here", function(v) end)
    AddButton(configPage, "Load From External", function()
        LoadFromExternalJSON(extJsonInput.GetText())
    end)
    AddButton(configPage, "Export Config", function()
        ExportConfig()
    end)
    AddDivider(configPage)
    AddSection(configPage, "Save Settings")
    AddButton(configPage, "Save Settings", function()
        SaveConfig("autosave")
        SendNotif("Meng Hub","Settings saved!",2)
    end)

    -- ───────────────── TAB: Info ─────────────────
    local infoPage = AddTab("Info", "ℹ")
    AddSection(infoPage, "About MengHub?")
    AddParagraph(infoPage, "What is MengHub?",
        "MengHub is a personal project dedicated to my special one, Ameng. \nThis script is built with passion and serves as a milestone in my coding journey. \nAs I am currently in the early stages of development and still learning the ropes of Luau,\nyou might encounter some bugs. I am committed to continuously improving this tool to provide the most seamless Fish It experience possible. \nThank you for being part of my learning process!"
    )
    AddDivider(infoPage)
    AddSection(infoPage, "Peacefull Community")
    AddButton(infoPage, "COPY LINK", function()
        if setclipboard then setclipboard(MengHub.DISCORD_INV) end
        SendNotif("Meng Hub","Discord invite link disalin!",3)
    end)
    AddParagraph(infoPage,"Meng Hub | Peacefull Community","Fetching members...")
    task.spawn(function()
        local ok, res = pcall(function()
            return HttpService:GetAsync(MengHub.DISCORD_API)
        end)
        if ok then
            local dec
            pcall(function() dec = HttpService:JSONDecode(res) end)
            if dec then
                local mem     = dec.approximate_member_count or 0
                local online  = dec.approximate_presence_count or 0
                SendNotif("Meng Hub", "Members: " .. tostring(mem) .. "  -  Online: " .. tostring(online), 5)
            end
        else
            SendNotif("Meng Hub","Failed to fetch member count",3)
        end
    end)
    AddDivider(infoPage)
    AddSection(infoPage, "Contributors / Whitelist")
    local contributors = {
        "haenessey","LordTherion","boskuake","strvciz","LinLen62","Nexxus_76",
        "yvlyf","traevp","J0LLY","matchalatte7523","sepecialpaketelor","Caevonie",
        "zanny_1201","SimplyLoovely","Nicholas","WoozyNate","Wildes","Talon",
        "Yummyyy110","kejushin","18daeee","LucashDev","CEOofIsaac","Stealthy",
        "iJava","White Guy","Purple King","Kachaaaa","Mpruyyy","Tony","Relukt",
        "Sammy","Diesel","S4ans03","xcxiess","Keishinzz","dipsxxxx","Aura",
    }
    for _, name in ipairs(contributors) do
        AddParagraph(infoPage, "✓", name)
    end

    -- =====================================================
    -- Toggle UI Button (floating)
    -- =====================================================
    local toggleBtn = Instance.new("ImageButton")
    toggleBtn.Name              = "ToggleUIButton"
    toggleBtn.Image             = "rbxassetid://74116592570717"
    toggleBtn.BackgroundColor3  = Color3.fromRGB(20,20,40)
    toggleBtn.Size              = UDim2.new(0,42,0,42)
    toggleBtn.Position          = UDim2.new(0,10,0.5,-21)
    toggleBtn.Parent            = mainGui
    Instance.new("UICorner",toggleBtn).CornerRadius = UDim.new(1,0)
    Instance.new("UIStroke",toggleBtn).Color = Color3.fromRGB(80,80,200)

    local btnDragging, btnDragStart, btnStartPos2
    toggleBtn.InputBegan:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
            btnDragging  = true
            btnDragStart = inp.Position
            btnStartPos2 = toggleBtn.Position
        end
    end)
    UserInputService.InputChanged:Connect(function(inp)
        if btnDragging and (inp.UserInputType == Enum.UserInputType.MouseMovement or inp.UserInputType == Enum.UserInputType.Touch) then
            local delta = inp.Position - btnDragStart
            toggleBtn.Position = UDim2.new(
                btnStartPos2.X.Scale, btnStartPos2.X.Offset + delta.X,
                btnStartPos2.Y.Scale, btnStartPos2.Y.Offset + delta.Y
            )
        end
    end)
    UserInputService.InputEnded:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
            if btnDragging and btnDragStart then
                local moved = (inp.Position - btnDragStart).Magnitude
                if moved < 5 then
                    Window.Visible = not Window.Visible
                end
            end
            btnDragging = false
        end
    end)

    SetActiveTab("ESP")
    return mainGui
end

-- ============================================================
-- [[ DUPLICATE CHECK ]]
-- ============================================================

if _G.MengHubLoaded then
    SendNotif("Meng Hub", "[Meng Hub] Script sudah running!", 5)
    return
end
_G.MengHubLoaded = true

-- ============================================================
-- [[ REMOTE SPY DETECTION ]]
-- ============================================================

RunService.Heartbeat:Connect(function()
    local detected, reason = DetectRemoteSpy()
    if detected then
        SendAntiSpyWebhook(reason)
        SendNotif("Meng Hub • Anti Spy System", reason, 5)
    end
end)

-- ============================================================
-- [[ INIT ]]
-- ============================================================

-- Check if KEYLESS (bypass for testing)
local KEYLESS_MODE = false -- Set to true to bypass key check
if KEYLESS_MODE then
    MengHub.IsAuthed = true
    MengHub.KeyValid = true
    CreateMainUI()
    SendNotif("Meng Hub", "[Meng Hub] Script sudah running!", 4)
else
    CreateKeyUI()
end

print([[
╔══════════════════════════════════════════════════════════════════╗
║                        MENG HUB                                 ║
║               Violence District Script Loaded                   ║
║         Created by Meng-Dev | Press F3 to toggle UI             ║
╚══════════════════════════════════════════════════════════════════╝
]])
