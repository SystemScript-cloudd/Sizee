if _G.MengHubLoaded then
    warn("[Meng Hub] Script sudah running!")
    return
end
_G.MengHubLoaded = true

-- ═══════════════════════════════════════════════════════
--  SERVICES
-- ═══════════════════════════════════════════════════════
local Players           = game:GetService("Players")
local RunService        = game:GetService("RunService")
local UserInputService  = game:GetService("UserInputService")
local TweenService      = game:GetService("TweenService")
local TeleportService   = game:GetService("TeleportService")
local CollectionService = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HttpService       = game:GetService("HttpService")
local Lighting          = game:GetService("Lighting")

local LP    = Players.LocalPlayer
local Cam   = workspace.CurrentCamera
local Char, HRP, Hum

local function RefreshChar()
    Char = LP.Character
    if not Char then return end
    HRP  = Char:FindFirstChild("HumanoidRootPart")
    Hum  = Char:FindFirstChildWhichIsA("Humanoid")
end
RefreshChar()

local IsMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled

local VIM
pcall(function() VIM = game:GetService("VirtualInputManager") end)

-- ═══════════════════════════════════════════════════════
--  KEZODX LIBRARY
-- ═══════════════════════════════════════════════════════
local repo         = "https://raw.githubusercontent.com/kezodxyz/KezodX/refs/heads/main/"
local Library      = loadstring(game:HttpGet(repo .. "Library.lua"))()
local ThemeManager = loadstring(game:HttpGet(repo .. "addons/ThemeManager.lua"))()
local SaveManager  = loadstring(game:HttpGet(repo .. "addons/SaveManager.lua"))()

local Toggles = Library.Toggles
local Options  = Library.Options

-- ═══════════════════════════════════════════════════════
--  CONFIG FOLDER
-- ═══════════════════════════════════════════════════════
local CFG_FOLDER = "MengHub_VD/Config/"
if not isfolder("MengHub_VD") then makefolder("MengHub_VD") end
if not isfolder(CFG_FOLDER)   then makefolder(CFG_FOLDER)   end

local SelectedConfig = ""
local CurrentLoaded  = "None"

local function GetConfigList()
    local list = {}
    if isfolder(CFG_FOLDER) then
        for _, f in ipairs(listfiles(CFG_FOLDER)) do
            local name = f:match("([^/\\]+)%.json$")
            if name then list[#list+1] = name end
        end
    end
    table.sort(list)
    return list
end

-- ═══════════════════════════════════════════════════════
--  DRAWING (FOV)
-- ═══════════════════════════════════════════════════════
local FOVCircle, VeilFOVCircle
local DrawingSupported = false

pcall(function()
    FOVCircle = Drawing.new("Circle")
    FOVCircle.Thickness = 1.5
    FOVCircle.NumSides = 64
    FOVCircle.Radius = 120
    FOVCircle.Filled = false
    FOVCircle.Visible = false
    FOVCircle.Color = Color3.fromRGB(255, 255, 255)

    VeilFOVCircle = Drawing.new("Circle")
    VeilFOVCircle.Thickness = 1.5
    VeilFOVCircle.NumSides = 64
    VeilFOVCircle.Radius = 60
    VeilFOVCircle.Filled = false
    VeilFOVCircle.Visible = false
    VeilFOVCircle.Color = Color3.fromRGB(128, 0, 255)

    DrawingSupported = true
end)

-- ═══════════════════════════════════════════════════════
--  WINDOW
-- ═══════════════════════════════════════════════════════
local Window = Library:CreateWindow({
    Title             = "Meng Hub",
    Footer            = "Peacefull Community",
    Icon              = 90292614315729,
    NotifySide        = "Right",
    ShowCustomCursor  = not IsMobile,
    Center            = true,
    AutoShow          = true,
    MobileButtonsSide = "Right",
    Resizable         = false,
})

local Tabs = {
    Aimbot     = Window:AddTab("Aimbot",      "crosshair"),
    ESP        = Window:AddTab("ESP",          "eye"),
    Survivors  = Window:AddTab("Survivors",   "shield"),
    Killer     = Window:AddTab("Killer",      "sword"),
    Movement   = Window:AddTab("Movement",    "wind"),
    Emote      = Window:AddTab("Emote & Skin","star"),
    Config     = Window:AddTab("Config",      "save"),
    Misc       = Window:AddTab("Misc",        "settings"),
    UISettings = Window:AddTab("UI Settings", "sliders-horizontal"),
}

-- ═══════════════════════════════════════════════════════
--  UTILITY
-- ═══════════════════════════════════════════════════════
local function IsAlive(char)
    local h = char and char:FindFirstChildWhichIsA("Humanoid")
    return h and h.Health > 0
end

local function IsKillerChar(char)
    if not char then return false end
    return char:FindFirstChild("KillerValue") ~= nil
        or CollectionService:HasTag(char, "Killer")
        or char:GetAttribute("Role") == "Killer"
end

local function IsKillerPlayer(player)
    local tn = (player.Team and player.Team.Name or ""):lower()
    if tn:find("killer") then return true end
    if player.Character then return IsKillerChar(player.Character) end
    return false
end

local function TV(key)
    return Toggles[key] and Toggles[key].Value
end
local function OV(key)
    return Options[key] and Options[key].Value
end

local function GetPos(obj)
    if not obj then return nil end
    local ok, result = pcall(function()
        if obj:IsA("BasePart") then return obj.Position end
        if obj.PrimaryPart then return obj.PrimaryPart.Position end
        local bp = obj:FindFirstChildWhichIsA("BasePart")
        if bp then return bp.Position end
        return nil
    end)
    return ok and result or nil
end

local ALLOWED_REMOTES = {
    BasicAttack = true, Attack = true, Hit = true,
    Parry = true, ParryClient = true,
    Heal = true, SelfHeal = true,
    Generator = true, Vault = true, Unhook = true, Gate = true,
    Skillcheck = true, SkillCheck = true,
    PalletDrop = true, CarrySurvivorEvent = true,
}

local function SafeFire(remote, ...)
    if remote and (remote:IsA("RemoteEvent") or remote:IsA("RemoteFunction")) then
        pcall(function(...) remote:FireServer(...) end, ...)
    end
end

local function FindRemote(names)
    local rem = ReplicatedStorage:FindFirstChild("Remotes")
    if not rem then return nil end
    for _, name in ipairs(names) do
        if ALLOWED_REMOTES[name] then
            local r = rem:FindFirstChild(name, true)
            if r then return r end
        end
    end
    return nil
end

-- ═══════════════════════════════════════════════════════
--  MAP DATA
-- ═══════════════════════════════════════════════════════
local MapData = { generators={}, pallets={}, vaults={}, hooks={}, gates={} }

local function ScanMap()
    MapData.generators = {}
    MapData.pallets = {}
    MapData.vaults = {}
    MapData.hooks = {}
    MapData.gates = {}

    local mapF = workspace:FindFirstChild("Map")
    if not mapF then return end

    for _, obj in ipairs(mapF:GetDescendants()) do
        if obj:IsA("Model") or obj:IsA("BasePart") then
            local n = obj.Name:lower()
            if n:find("generator") then
                table.insert(MapData.generators, obj)
            elseif n:find("pallet") and not n:find("wrong") then
                table.insert(MapData.pallets, obj)
            elseif n:find("vault") then
                table.insert(MapData.vaults, obj)
            elseif n:find("hook") then
                table.insert(MapData.hooks, obj)
            elseif n:find("gate") then
                table.insert(MapData.gates, obj)
            end
        end
    end
end

local function GetClosestGen()
    if not HRP then return nil end
    local best, bd = nil, math.huge
    for _, g in ipairs(MapData.generators) do
        local pos = GetPos(g)
        if pos then
            local d = (HRP.Position - pos).Magnitude
            if d < bd then bd = d; best = g end
        end
    end
    return best
end

local function GetFarthestGenFromKiller()
    if not HRP then return nil end
    local killerPos = nil
    for _, p in ipairs(Players:GetPlayers()) do
        if IsKillerPlayer(p) and p.Character then
            local khrp = p.Character:FindFirstChild("HumanoidRootPart")
            if khrp then killerPos = khrp.Position break end
        end
    end
    if not killerPos then return GetClosestGen() end

    local best, bd = nil, -1
    for _, g in ipairs(MapData.generators) do
        local pos = GetPos(g)
        if pos then
            local d = (pos - killerPos).Magnitude
            if d > bd then bd = d; best = g end
        end
    end
    return best
end

task.delay(2, ScanMap)
task.delay(8, ScanMap)

-- ═══════════════════════════════════════════════════════
--  CUSTOM ESP COLORS (default)
-- ═══════════════════════════════════════════════════════
local ESPColors = {
    Generator = Color3.fromRGB(0, 255, 100),
    Gate      = Color3.fromRGB(255, 200, 0),
    Hook      = Color3.fromRGB(255, 50, 50),
    Pallet    = Color3.fromRGB(180, 120, 50),
    Vault     = Color3.fromRGB(100, 150, 255),
    Killer    = Color3.fromRGB(255, 80, 80),
    Survivor  = Color3.fromRGB(80, 200, 255),
}

-- ═══════════════════════════════════════════════════════
--  ESP SYSTEM
-- ═══════════════════════════════════════════════════════
local ESPCache = {}
local ObjectESP = {
    Generator = {}, Gate = {}, Hook = {}, Pallet = {}, Vault = {}
}
local GenProgressESP = {} -- progress labels

local function ClearPlayerESP(char)
    local data = ESPCache[char]
    if data then
        pcall(function() if data.bill then data.bill:Destroy() end end)
        pcall(function() if data.highlight then data.highlight:Destroy() end end)
        ESPCache[char] = nil
    end
end

local function ClearAllPlayerESP()
    for char in pairs(ESPCache) do ClearPlayerESP(char) end
end

local function MakePlayerESP(char, isKiller)
    if ESPCache[char] then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    local col = isKiller and ESPColors.Killer or ESPColors.Survivor

    local highlight = Instance.new("Highlight")
    highlight.Adornee = char
    highlight.FillTransparency = 0.6
    highlight.OutlineTransparency = 0
    highlight.FillColor = col
    highlight.OutlineColor = col
    highlight.Parent = char

    local bill = Instance.new("BillboardGui")
    bill.Adornee = hrp
    bill.Size = UDim2.new(0, 200, 0, 55)
    bill.StudsOffset = Vector3.new(0, 3.2, 0)
    bill.AlwaysOnTop = true
    bill.Parent = char

    local nameL = Instance.new("TextLabel")
    nameL.Name = "NameL"
    nameL.Size = UDim2.new(1, 0, 0, 16)
    nameL.BackgroundTransparency = 1
    nameL.TextColor3 = Color3.new(1,1,1)
    nameL.TextStrokeTransparency = 0.4
    nameL.Font = Enum.Font.GothamBold
    nameL.TextSize = 13
    nameL.Parent = bill

    local distL = Instance.new("TextLabel")
    distL.Name = "DistL"
    distL.Size = UDim2.new(1, 0, 0, 14)
    distL.Position = UDim2.new(0, 0, 0, 16)
    distL.BackgroundTransparency = 1
    distL.TextColor3 = Color3.fromRGB(200,200,200)
    distL.TextStrokeTransparency = 0.4
    distL.Font = Enum.Font.Gotham
    distL.TextSize = 11
    distL.Parent = bill

    local roleL = Instance.new("TextLabel")
    roleL.Name = "RoleL"
    roleL.Size = UDim2.new(1, 0, 0, 14)
    roleL.Position = UDim2.new(0, 0, 0, 30)
    roleL.BackgroundTransparency = 1
    roleL.TextColor3 = col
    roleL.TextStrokeTransparency = 0.4
    roleL.Font = Enum.Font.Gotham
    roleL.TextSize = 11
    roleL.Text = isKiller and "KILLER" or "SURVIVOR"
    roleL.Parent = bill

    local stunL = Instance.new("TextLabel")
    stunL.Name = "StunL"
    stunL.Size = UDim2.new(1, 0, 0, 14)
    stunL.Position = UDim2.new(0, 0, 0, 44)
    stunL.BackgroundTransparency = 1
    stunL.TextColor3 = Color3.fromRGB(255,255,0)
    stunL.TextStrokeTransparency = 0.4
    stunL.Font = Enum.Font.GothamBold
    stunL.TextSize = 12
    stunL.Visible = false
    stunL.Parent = bill

    ESPCache[char] = { bill = bill, highlight = highlight, isKiller = isKiller }
end

local function ClearObjectESPType(typeName)
    local list = ObjectESP[typeName]
    if not list then return end
    for _, v in ipairs(list) do
        pcall(function() if v.bill then v.bill:Destroy() end end)
        pcall(function() if v.highlight then v.highlight:Destroy() end end)
        pcall(function() if v.progress then v.progress:Destroy() end end)
    end
    ObjectESP[typeName] = {}
end

local function ClearAllObjectESP()
    for typeName in pairs(ObjectESP) do ClearObjectESPType(typeName) end
    for _, v in pairs(GenProgressESP) do
        pcall(function() if v then v:Destroy() end end)
    end
    GenProgressESP = {}
end

local function GetGeneratorProgress(gen)
    -- Coba berbagai cara baca progress generator
    local progress = nil
    pcall(function()
        -- Attribute
        progress = gen:GetAttribute("Progress") or gen:GetAttribute("RepairProgress") or gen:GetAttribute("GenProgress")
        if progress then return end

        -- Value objects
        local val = gen:FindFirstChild("Progress") or gen:FindFirstChild("RepairProgress") or gen:FindFirstChild("ActualRepairPoint")
        if val and val:IsA("NumberValue") or val:IsA("IntValue") then
            progress = val.Value
            return
        end

        -- Nested
        for _, desc in ipairs(gen:GetDescendants()) do
            if desc.Name:lower():find("progress") and (desc:IsA("NumberValue") or desc:IsA("IntValue")) then
                progress = desc.Value
                return
            end
            if desc.Name == "ActualRepairPoint" and (desc:IsA("NumberValue") or desc:IsA("IntValue")) then
                progress = desc.Value
                return
            end
        end
    end)
    return progress
end

local function AddObjESP(obj, color, label, typeName, showProgress)
    local part = nil
    pcall(function()
        if obj:IsA("BasePart") then part = obj
        elseif obj.PrimaryPart then part = obj.PrimaryPart
        else part = obj:FindFirstChildWhichIsA("BasePart") end
    end)
    if not part then return end

    local highlight = Instance.new("Highlight")
    highlight.Adornee = obj
    highlight.FillTransparency = 0.7
    highlight.OutlineTransparency = 0.3
    highlight.FillColor = color
    highlight.OutlineColor = color
    highlight.Parent = obj

    local billH = showProgress and 36 or 20
    local bill = Instance.new("BillboardGui")
    bill.Adornee = part
    bill.Size = UDim2.new(0, 130, 0, billH)
    bill.StudsOffset = Vector3.new(0, 2.2, 0)
    bill.AlwaysOnTop = true
    bill.Parent = obj

    local text = Instance.new("TextLabel")
    text.Name = "Label"
    text.Size = UDim2.new(1, 0, 0, 18)
    text.BackgroundTransparency = 1
    text.Text = label
    text.TextColor3 = color
    text.TextStrokeTransparency = 0.4
    text.Font = Enum.Font.GothamBold
    text.TextSize = 12
    text.Parent = bill

    local progressLabel = nil
    if showProgress then
        progressLabel = Instance.new("TextLabel")
        progressLabel.Name = "Progress"
        progressLabel.Size = UDim2.new(1, 0, 0, 16)
        progressLabel.Position = UDim2.new(0, 0, 0, 18)
        progressLabel.BackgroundTransparency = 1
        progressLabel.Text = "..."
        progressLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        progressLabel.TextStrokeTransparency = 0.3
        progressLabel.Font = Enum.Font.Gotham
        progressLabel.TextSize = 11
        progressLabel.Parent = bill
    end

    table.insert(ObjectESP[typeName], {
        bill = bill,
        highlight = highlight,
        progress = progressLabel,
        obj = obj
    })
end

local function RebuildObjectESP()
    ClearAllObjectESP()

    local showProg = TV("ESPGeneratorProgress")

    if TV("ESPGenerator") then
        for _, g in ipairs(MapData.generators) do
            AddObjESP(g, ESPColors.Generator, "Generator", "Generator", showProg)
        end
    end
    if TV("ESPGate") then
        for _, g in ipairs(MapData.gates) do
            AddObjESP(g, ESPColors.Gate, "Gate", "Gate", false)
        end
    end
    if TV("ESPHook") then
        for _, h in ipairs(MapData.hooks) do
            AddObjESP(h, ESPColors.Hook, "Hook", "Hook", false)
        end
    end
    if TV("ESPPallet") then
        for _, p in ipairs(MapData.pallets) do
            AddObjESP(p, ESPColors.Pallet, "Pallet", "Pallet", false)
        end
    end
    if TV("ESPVault") then
        for _, v in ipairs(MapData.vaults) do
            AddObjESP(v, ESPColors.Vault, "Vault", "Vault", false)
        end
    end
end

-- Update progress text setiap frame (ringan)
local function UpdateGeneratorProgressLabels()
    if not TV("ESPGenerator") or not TV("ESPGeneratorProgress") then return end
    local list = ObjectESP.Generator
    if not list then return end
    for _, entry in ipairs(list) do
        if entry.progress and entry.obj then
            local prog = GetGeneratorProgress(entry.obj)
            if prog then
                local pct = math.clamp(math.floor(tonumber(prog) or 0), 0, 100)
                entry.progress.Text = pct .. "%"
                if pct >= 100 then
                    entry.progress.TextColor3 = Color3.fromRGB(0, 255, 100)
                elseif pct >= 50 then
                    entry.progress.TextColor3 = Color3.fromRGB(255, 220, 50)
                else
                    entry.progress.TextColor3 = Color3.fromRGB(255, 255, 255)
                end
            else
                entry.progress.Text = "?"
            end
        end
    end
end

-- ═══════════════════════════════════════════════════════
--  FEATURE SETUP
-- ═══════════════════════════════════════════════════════

local autoParryThread
local function SetupAutoParry(enable)
    if autoParryThread then pcall(function() task.cancel(autoParryThread) end); autoParryThread = nil end
    if not enable then return end
    autoParryThread = task.spawn(function()
        while TV("AutoParry") or TV("TriggerAutoParry") do
            task.wait(0.1)
            if not HRP or not Hum or Hum.Health <= 0 then continue end
            local range = OV("ParryRange") or 8
            local thresh = OV("FacingThreshAP") or 45
            for _, p in ipairs(Players:GetPlayers()) do
                if IsKillerPlayer(p) and p.Character then
                    local khrp = p.Character:FindFirstChild("HumanoidRootPart")
                    if khrp then
                        local dist = (HRP.Position - khrp.Position).Magnitude
                        local swinging = p.Character:GetAttribute("isAttacking") or p.Character:GetAttribute("isSwinging") or p.Character:GetAttribute("Attacking")
                        if dist <= range and swinging then
                            local dir = (khrp.Position - HRP.Position).Unit
                            local angle = math.deg(math.acos(math.clamp(HRP.CFrame.LookVector:Dot(dir), -1, 1)))
                            if angle <= thresh then
                                local r = FindRemote({"ParryClient", "Parry"})
                                SafeFire(r)
                            end
                        end
                    end
                end
            end
        end
    end)
end

local autoHookThread
local function SetupAutoHook(enable)
    if autoHookThread then pcall(function() task.cancel(autoHookThread) end); autoHookThread = nil end
    if not enable then return end
    if _G.setAutoHookEnabled then pcall(_G.setAutoHookEnabled, enable) end
    autoHookThread = task.spawn(function()
        while TV("AutoHook") do
            task.wait(0.25)
            if not HRP then continue end
            local r = FindRemote({"Unhook"})
            if r then
                for _, p in ipairs(Players:GetPlayers()) do
                    if p ~= LP and p.Character and p.Character:GetAttribute("IsHooked") then
                        local thrp = p.Character:FindFirstChild("HumanoidRootPart")
                        if thrp and (HRP.Position - thrp.Position).Magnitude < 12 then
                            SafeFire(r, p.Character)
                        end
                    end
                end
            end
        end
    end)
end

local selfHealThread
local function SetupSelfHeal(enable)
    if selfHealThread then pcall(function() task.cancel(selfHealThread) end); selfHealThread = nil end
    if not enable then return end
    if _G.setSelfHealEnabled then pcall(_G.setSelfHealEnabled, true) end
    selfHealThread = task.spawn(function()
        while TV("SelfHeal") do
            task.wait(0.6)
            if not Hum or Hum.Health <= 0 or Hum.Health >= Hum.MaxHealth then continue end
            local r = FindRemote({"Heal", "SelfHeal"})
            SafeFire(r)
        end
    end)
end

local skillcheckThread
local function SetupSkillcheck(enable)
    if skillcheckThread then pcall(function() task.cancel(skillcheckThread) end); skillcheckThread = nil end
    if not enable then return end
    skillcheckThread = task.spawn(function()
        while TV("AutoSkillcheck") do
            task.wait(0.08)
            local mode = OV("SkillcheckMode") or "Instant"
            local sc = FindRemote({"Skillcheck", "SkillCheck"})
            if sc then
                if mode == "Instant" then SafeFire(sc, true)
                elseif mode == "Perfect" then SafeFire(sc, "Perfect")
                else task.wait(math.random(40,100)/1000); SafeFire(sc, true) end
            end
        end
    end)
end

local autoGenThread
local function SetupAutoGen(enable, withTP)
    if autoGenThread then pcall(function() task.cancel(autoGenThread) end); autoGenThread = nil end
    if not enable then return end
    autoGenThread = task.spawn(function()
        while (withTP and TV("AutoGeneratorTP")) or (not withTP and TV("AutoGenerator")) do
            task.wait(0.4)
            if not HRP then continue end
            local gen = GetClosestGen()
            if gen then
                local pos = GetPos(gen)
                if pos then
                    if withTP and (HRP.Position - pos).Magnitude > 8 then
                        pcall(function() HRP.CFrame = CFrame.new(pos + Vector3.new(0, 3, 0)) end)
                    end
                    local r = FindRemote({"Generator"})
                    SafeFire(r, gen)
                end
            end
        end
    end)
end

local fastVaultThread
local function SetupFastVault(enable)
    if fastVaultThread then pcall(function() task.cancel(fastVaultThread) end); fastVaultThread = nil end
    if not enable then return end
    if _G.setFastVaultEnabled then pcall(_G.setFastVaultEnabled, enable) end
    fastVaultThread = task.spawn(function()
        while TV("FastVault") do
            task.wait(0.2)
            if not HRP then continue end
            local delay = OV("VaultDelay") or 0
            for _, vault in ipairs(MapData.vaults) do
                local pos = GetPos(vault)
                if pos and (HRP.Position - pos).Magnitude < 7 then
                    if delay > 0 then task.wait(delay) end
                    local r = FindRemote({"Vault"})
                    SafeFire(r)
                end
            end
        end
    end)
end

local function _StartAutoDropPallet()
    task.spawn(function()
        while TV("AutoDropPallet") do
            task.wait(0.2)
            if not HRP then continue end
            for _, pallet in ipairs(MapData.pallets) do
                local pos = GetPos(pallet)
                if pos and (HRP.Position - pos).Magnitude < 10 then
                    local killerNear = false
                    for _, p in ipairs(Players:GetPlayers()) do
                        if IsKillerPlayer(p) and p.Character then
                            local khrp = p.Character:FindFirstChild("HumanoidRootPart")
                            if khrp and (pos - khrp.Position).Magnitude < 18 then
                                killerNear = true break
                            end
                        end
                    end
                    if killerNear then
                        local r = FindRemote({"PalletDrop"})
                        SafeFire(r, pallet)
                    end
                end
            end
        end
    end)
end

local autoGateThread
local function SetupAutoGate(enable)
    if autoGateThread then pcall(function() task.cancel(autoGateThread) end); autoGateThread = nil end
    if not enable then return end
    if _G.setGateOneTapEnabled then pcall(_G.setGateOneTapEnabled, enable) end
    autoGateThread = task.spawn(function()
        while TV("AutoGateOneTap") do
            task.wait(0.4)
            if not HRP then continue end
            for _, gate in ipairs(MapData.gates) do
                local pos = GetPos(gate)
                if pos and (HRP.Position - pos).Magnitude < 15 then
                    local r = FindRemote({"Gate"})
                    SafeFire(r)
                end
            end
        end
    end)
end

-- ========== BYPASS GENERATOR ==========
local bypassGenThread
local function SetupBypassGenerator(enable)
    if bypassGenThread then pcall(function() task.cancel(bypassGenThread) end); bypassGenThread = nil end
    if not enable then return end
    bypassGenThread = task.spawn(function()
        while TV("BypassGenerator") do
            task.wait(0.35)
            if not HRP then continue end
            local gen = GetClosestGen()
            if gen then
                local pos = GetPos(gen)
                if pos and (HRP.Position - pos).Magnitude < 18 then
                    -- Fire generator remote berkali-kali (bypass style)
                    local r = FindRemote({"Generator"})
                    for i = 1, 3 do
                        SafeFire(r, gen)
                        task.wait(0.05)
                    end
                end
            end
        end
    end)
end

-- ========== BYPASS GATE ==========
local bypassGateThread
local function SetupBypassGate(enable)
    if bypassGateThread then pcall(function() task.cancel(bypassGateThread) end); bypassGateThread = nil end
    if not enable then return end
    bypassGateThread = task.spawn(function()
        while TV("BypassGate") do
            task.wait(0.4)
            if not HRP then continue end
            for _, gate in ipairs(MapData.gates) do
                local pos = GetPos(gate)
                if pos and (HRP.Position - pos).Magnitude < 20 then
                    local r = FindRemote({"Gate"})
                    for i = 1, 4 do
                        SafeFire(r)
                        task.wait(0.04)
                    end
                end
            end
        end
    end)
end

-- ========== FLEE KILLER (Auto Menjauh) ==========
local fleeThread
local function SetupFleeKiller(enable)
    if fleeThread then pcall(function() task.cancel(fleeThread) end); fleeThread = nil end
    if not enable then return end
    fleeThread = task.spawn(function()
        while TV("FleeKiller") do
            task.wait(0.2)
            if not HRP or not Hum then continue end
            local fleeDist = OV("FleeDistance") or 25
            local killerHRP = nil
            for _, p in ipairs(Players:GetPlayers()) do
                if IsKillerPlayer(p) and p.Character then
                    local k = p.Character:FindFirstChild("HumanoidRootPart")
                    if k then
                        local d = (HRP.Position - k.Position).Magnitude
                        if d < fleeDist then
                            killerHRP = k
                            break
                        end
                    end
                end
            end
            if killerHRP then
                -- Arah menjauh dari killer
                local away = (HRP.Position - killerHRP.Position)
                if away.Magnitude > 0.1 then
                    away = away.Unit
                    local targetPos = HRP.Position + away * 8
                    pcall(function()
                        HRP.CFrame = CFrame.new(targetPos, targetPos + away)
                        if Hum then
                            Hum:Move(away, false)
                        end
                    end)
                end
            end
        end
    end)
end

local function GetClosestTarget(fov, partName, killerOnly)
    local center = Vector2.new(Cam.ViewportSize.X/2, Cam.ViewportSize.Y/2)
    local best, bestDist = nil, fov or 120
    partName = partName or "HumanoidRootPart"

    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LP and p.Character and IsAlive(p.Character) then
            if killerOnly and not IsKillerPlayer(p) then continue end
            local part = p.Character:FindFirstChild(partName) or p.Character:FindFirstChild("HumanoidRootPart")
            if part then
                local sp, onScreen = Cam:WorldToViewportPoint(part.Position)
                if onScreen then
                    local dist = (Vector2.new(sp.X, sp.Y) - center).Magnitude
                    if dist < bestDist then
                        if TV("Wallcheck") then
                            local rp = RaycastParams.new()
                            rp.FilterDescendantsInstances = {Char}
                            rp.FilterType = Enum.RaycastFilterType.Exclude
                            local hit = workspace:Raycast(Cam.CFrame.Position, (part.Position - Cam.CFrame.Position), rp)
                            if hit and not hit.Instance:IsDescendantOf(p.Character) then continue end
                        end
                        bestDist = dist
                        best = part
                    end
                end
            end
        end
    end
    return best
end

local function PredictedCFrame(target)
    if not target then return nil end
    local t = (OV("PredictionTime") or 10) / 1000
    local vel = target.AssemblyLinearVelocity or Vector3.zero
    return target.CFrame + (vel * t)
end

local aimbotConn
local function SetupAimbotCamera(enable)
    if aimbotConn then pcall(function() aimbotConn:Disconnect() end) aimbotConn = nil end
    if not enable then return end
    if _G.setAimbotEnabled then pcall(_G.setAimbotEnabled, enable) end
    aimbotConn = RunService.RenderStepped:Connect(function()
        if not TV("AimbotEnabled") then return end
        local target = GetClosestTarget(OV("FOVAimbot") or 90, OV("AimPart") or "Head")
        if target then
            local cf = CFrame.new(Cam.CFrame.Position, target.Position)
            Cam.CFrame = Cam.CFrame:Lerp(cf, 0.15)
        end
    end)
end

-- Silent Aim
local silentAimActive = false
local oldNamecall, hookedMt = nil, nil
local ATTACK_REMOTES = { BasicAttack = true, Attack = true, Hit = true }

local function isAttackRemote(remote)
    return remote and ATTACK_REMOTES[remote.Name] == true
end

local function SetupSilentAim(enable)
    if enable == silentAimActive then return end
    if silentAimActive and hookedMt and oldNamecall then
        pcall(function()
            setreadonly(hookedMt, false)
            hookedMt.__namecall = oldNamecall
            setreadonly(hookedMt, true)
        end)
        silentAimActive = false
        oldNamecall, hookedMt = nil, nil
    end
    if not enable then return end

    local success, err = pcall(function()
        local mt = getrawmetatable(game)
        oldNamecall = mt.__namecall
        hookedMt = mt
        setreadonly(mt, false)
        mt.__namecall = newcclosure(function(self, ...)
            local method = getnamecallmethod()
            if method == "FireServer" and TV("SilentAim") and isAttackRemote(self) then
                local args = {...}
                local target = GetClosestTarget(OV("FOVSize") or 120, OV("AimPart") or "HumanoidRootPart")
                if target then
                    local pred = PredictedCFrame(target)
                    for i, v in ipairs(args) do
                        if typeof(v) == "CFrame" then args[i] = pred or target.CFrame
                        elseif typeof(v) == "Vector3" then args[i] = (pred and pred.Position) or target.Position end
                    end
                    return oldNamecall(self, unpack(args))
                end
            end
            return oldNamecall(self, ...)
        end)
        setreadonly(mt, true)
        silentAimActive = true
    end)
    if not success then
        warn("[Meng Hub] Silent Aim gagal:", err)
        silentAimActive = false
        Library:Notify({Title="Silent Aim", Description="Gagal aktifkan.", Time=4})
    else
        Library:Notify({Title="Silent Aim", Description="Silent Aim aktif.", Time=3})
    end
end

local killAllThread
local function SetupKillAll(enable)
    if killAllThread then pcall(function() task.cancel(killAllThread) end) killAllThread = nil end
    if not enable then return end
    if _G.setKillAllEnabled then pcall(_G.setKillAllEnabled, enable) end
    killAllThread = task.spawn(function()
        while TV("KillAll") do
            task.wait(0.15)
            if not HRP then continue end
            local atk = FindRemote({"BasicAttack", "Attack", "Hit"})
            for _, p in ipairs(Players:GetPlayers()) do
                if p ~= LP and p.Character and IsAlive(p.Character) then
                    local thrp = p.Character:FindFirstChild("HumanoidRootPart")
                    if thrp and not p.Character:GetAttribute("IsHooked") then
                        SafeFire(atk, p.Character)
                    end
                end
            end
        end
    end)
end

local autoAtkThread
local function SetupAutoAttack(enable)
    if autoAtkThread then pcall(function() task.cancel(autoAtkThread) end) autoAtkThread = nil end
    if not enable then return end
    autoAtkThread = task.spawn(function()
        while TV("AutoAttack") do
            local mode = OV("AutoAttackMode") or "Legit"
            local range = OV("AttackRange") or 10
            task.wait(mode == "Instant" and 0.08 or math.random(18, 30)/100)
            if not HRP then continue end
            local atk = FindRemote({"BasicAttack", "Attack", "Hit"})
            for _, p in ipairs(Players:GetPlayers()) do
                if p ~= LP and p.Character and IsAlive(p.Character) then
                    local thrp = p.Character:FindFirstChild("HumanoidRootPart")
                    if thrp and (HRP.Position - thrp.Position).Magnitude <= range then
                        SafeFire(atk, p.Character)
                    end
                end
            end
        end
    end)
end

local autoHookKillerThread
local function SetupAutoHookKiller(enable)
    if autoHookKillerThread then pcall(function() task.cancel(autoHookKillerThread) end) autoHookKillerThread = nil end
    if not enable then return end
    autoHookKillerThread = task.spawn(function()
        while TV("AutoHookKiller") do
            task.wait(0.2)
            if not HRP then continue end
            local range = OV("AttackRange") or 12
            local r = FindRemote({"CarrySurvivorEvent"})
            if r then
                for _, p in ipairs(Players:GetPlayers()) do
                    if p ~= LP and p.Character and IsAlive(p.Character) then
                        local thrp = p.Character:FindFirstChild("HumanoidRootPart")
                        if thrp and not p.Character:GetAttribute("IsHooked") and (HRP.Position - thrp.Position).Magnitude <= range then
                            SafeFire(r, p.Character)
                        end
                    end
                end
            end
        end
    end)
end

local autoRunConn, wHeld = nil, false
local function SetupAutoRun(enable)
    if autoRunConn then pcall(function() autoRunConn:Disconnect() end) autoRunConn = nil end
    if wHeld and VIM then pcall(function() VIM:SendKeyEvent(false, Enum.KeyCode.W, false, game) end) wHeld = false end
    if not enable or IsMobile then return end
    autoRunConn = RunService.Heartbeat:Connect(function()
        if not TV("AutoRun") then
            if wHeld and VIM then pcall(function() VIM:SendKeyEvent(false, Enum.KeyCode.W, false, game) end) wHeld = false end
            return
        end
        if VIM and not wHeld then wHeld = true pcall(function() VIM:SendKeyEvent(true, Enum.KeyCode.W, false, game) end) end
    end)
end

local instantTPThread
local function SetupInstantTPGate(enable)
    if instantTPThread then pcall(function() task.cancel(instantTPThread) end) instantTPThread = nil end
    if not enable then return end
    if _G.setInstantTPEnabled then pcall(_G.setInstantTPEnabled, enable) end
    instantTPThread = task.spawn(function()
        while TV("InstantTPGate") do
            task.wait(0.6)
            if not HRP then continue end
            for _, gate in ipairs(MapData.gates) do
                local pos = GetPos(gate)
                if pos and (HRP.Position - pos).Magnitude < 35 then
                    pcall(function() HRP.CFrame = CFrame.new(pos + Vector3.new(0, 3, 0)) end)
                    local r = FindRemote({"Gate"})
                    SafeFire(r)
                    break
                end
            end
        end
    end)
end

local function SetupFlowstate(enable) if _G.setFlowstate then pcall(_G.setFlowstate, enable) end end
local function SetupTrollTP(enable) if _G.setTrollTPEnabled then pcall(_G.setTrollTPEnabled, enable) end end
local function SetupBlockAllVault(enable) if _G.setBlockAllVault then pcall(_G.setBlockAllVault, enable) end end
local function SetupGodModeGlobal(enable) if _G.setGodMode then pcall(_G.setGodMode, enable) end end
local function SetupMoonwalk(enable) if _G.setMoonwalk then pcall(_G.setMoonwalk, enable) end end
local function SetupNoclip(enable) if _G.setNoclipEnabled then pcall(_G.setNoclipEnabled, enable) end end
local function SetupSpeedBoost(enable) if _G.setSpeedBoost then pcall(_G.setSpeedBoost, enable) end end
local function SetupHiddenAimbot(enable) if _G.setHiddenAimbot then pcall(_G.setHiddenAimbot, enable) end end
local function SetupESPGlobal(enable) if _G.setESP then pcall(_G.setESP, enable) end end
local function SetupEmoteGlobal(enable) if _G.setEmoteEnabled then pcall(_G.setEmoteEnabled, enable) end end
local function SetupTriggerAP(enable) if _G.setTriggerAPEnabled then pcall(_G.setTriggerAPEnabled, enable) end end
local function SetupInvisibility(enable) if _G.setInvisibility then pcall(_G.setInvisibility, enable) end end
local function SetupQuickRecovery(enable) if _G.setQuickRecovery then pcall(_G.setQuickRecovery, enable) end end
local function SetupPerfectLanding(enable) if _G.setPerfectLanding then pcall(_G.setPerfectLanding, enable) end end
local function SetupSnakeStep(enable) if _G.setSnakeStep then pcall(_G.setSnakeStep, enable) end end
local function SetupSpectator(enable) if _G.setSpectator then pcall(_G.setSpectator, enable) end end
local function SetupSpearSilentAim(enable) if _G.setSpearSilentAim then pcall(_G.setSpearSilentAim, enable) end end
local function SetupAimbotFlashlight(enable) if _G.setAimbotFlashlight then pcall(_G.setAimbotFlashlight, enable) end end

local EMOTE_IDS = {
    Fist = "rbxassetid://140604838213617",
    Meme = "rbxassetid://135602581462761",
    ["Meme 2"] = "rbxassetid://95942836778998",
    Critical = "rbxassetid://140181868959125",
    Adrenaline = "rbxassetid://92125118598365",
    Brandon = "rbxassetid://111920872708571",
    Jerk = "rbxassetid://92303584765773",
}
local EMOTE_NAMES = {"Fist","Meme","Meme 2","Critical","Adrenaline","Brandon","Jerk"}

local emoteThread
local function SetupPlayEmote(enable)
    if emoteThread then pcall(function() task.cancel(emoteThread) end) emoteThread = nil end
    if not enable then return end
    SetupEmoteGlobal(true)
    emoteThread = task.spawn(function()
        while TV("PlayEmote") do
            task.wait(3)
            local ch = Char
            if not ch then continue end
            local hum = ch:FindFirstChildWhichIsA("Humanoid")
            if not hum then continue end
            local animator = hum:FindFirstChildWhichIsA("Animator") or ch:FindFirstChildWhichIsA("Animator")
            if not animator then continue end
            local emName = OV("SelectEmote") or "Fist"
            local id = EMOTE_IDS[emName] or EMOTE_IDS.Fist
            local anim = Instance.new("Animation")
            anim.AnimationId = id
            local track = animator:LoadAnimation(anim)
            if not track.IsPlaying then track:Play() end
        end
    end)
end

-- ═══════════════════════════════════════════════════════
--  TABS UI
-- ═══════════════════════════════════════════════════════

-- AIMBOT
local AimL = Tabs.Aimbot:AddLeftGroupbox("Silent Aim", "crosshair")
AimL:AddToggle("SilentAim", { Text = "Enable Silent Aim", Default = false, Risky = true })
AimL:AddToggle("AimbotEnabled", { Text = "Enable Aimbot (Camera)", Default = false })
AimL:AddToggle("ShowFOVCircle", { Text = "Show FOV Circle", Default = false })
AimL:AddToggle("ShowVeilFOVCircle", { Text = "Show Veil FOV Circle", Default = false })
AimL:AddToggle("Wallcheck", { Text = "Wallcheck", Default = true })
AimL:AddToggle("HiddenAimbot", { Text = "Hidden Aimbot", Default = false })
AimL:AddToggle("SpearSilentAim", { Text = "Spear Silent Aim", Default = false })
AimL:AddToggle("AimbotFlashlight", { Text = "Aimbot Flashlight", Default = false })

local AimR = Tabs.Aimbot:AddRightGroupbox("Aimbot Settings", "settings")
AimR:AddSlider("FOVSize", { Text = "FOV Degree", Default = 120, Min = 10, Max = 500, Rounding = 0, Suffix = " px" })
AimR:AddSlider("FOVAimbot", { Text = "FOV Aimbot", Default = 90, Min = 10, Max = 300, Rounding = 0, Suffix = " px" })
AimR:AddSlider("PredictionTime", { Text = "Prediction Time", Default = 10, Min = 0, Max = 50, Rounding = 0, Suffix = " ms" })
AimR:AddDropdown("AimPart", { Text = "Target Part", Values = {"HumanoidRootPart","Head","UpperTorso"}, Default = 1 })

-- ESP
local ESPLeft = Tabs.ESP:AddLeftGroupbox("Players", "users")
ESPLeft:AddToggle("ESPEnabled", { Text = "Enable ESP", Default = false })
ESPLeft:AddToggle("ESPSurvivor", { Text = "ESP Survivor", Default = true })
ESPLeft:AddToggle("ESPKiller", { Text = "ESP Killer", Default = true })
ESPLeft:AddToggle("ShowName", { Text = "Show Name", Default = true })
ESPLeft:AddToggle("ShowDist", { Text = "Show Distance", Default = true })
ESPLeft:AddToggle("ShowRole", { Text = "Show Role", Default = true })
ESPLeft:AddToggle("ShowStunRing", { Text = "Show Stun Ring", Default = false })
ESPLeft:AddToggle("ShowPlatform", { Text = "Show Platform", Default = false })

local ESPRight = Tabs.ESP:AddRightGroupbox("Objects", "map-pin")
ESPRight:AddToggle("ESPGenerator", { Text = "ESP Generator", Default = false })
ESPRight:AddToggle("ESPGeneratorProgress", { Text = "ESP Generator Progress", Default = false })
ESPRight:AddToggle("ESPGate", { Text = "ESP Gate", Default = false })
ESPRight:AddToggle("ESPHook", { Text = "ESP Hook", Default = false })
ESPRight:AddToggle("ESPPallet", { Text = "ESP Pallet", Default = false })
ESPRight:AddToggle("ESPVault", { Text = "ESP Vault", Default = false })

-- Custom Colors
local ESPColorBox = Tabs.ESP:AddLeftGroupbox("Custom ESP Colors", "palette")
ESPColorBox:AddLabel("Generator Color")
ESPColorBox:AddColorPicker("ColorGenerator", {
    Default = Color3.fromRGB(0, 255, 100),
    Callback = function(c) ESPColors.Generator = c; RebuildObjectESP() end
})
ESPColorBox:AddLabel("Gate Color")
ESPColorBox:AddColorPicker("ColorGate", {
    Default = Color3.fromRGB(255, 200, 0),
    Callback = function(c) ESPColors.Gate = c; RebuildObjectESP() end
})
ESPColorBox:AddLabel("Hook Color")
ESPColorBox:AddColorPicker("ColorHook", {
    Default = Color3.fromRGB(255, 50, 50),
    Callback = function(c) ESPColors.Hook = c; RebuildObjectESP() end
})
ESPColorBox:AddLabel("Pallet Color")
ESPColorBox:AddColorPicker("ColorPallet", {
    Default = Color3.fromRGB(180, 120, 50),
    Callback = function(c) ESPColors.Pallet = c; RebuildObjectESP() end
})
ESPColorBox:AddLabel("Vault Color")
ESPColorBox:AddColorPicker("ColorVault", {
    Default = Color3.fromRGB(100, 150, 255),
    Callback = function(c) ESPColors.Vault = c; RebuildObjectESP() end
})
ESPColorBox:AddLabel("Killer Color")
ESPColorBox:AddColorPicker("ColorKiller", {
    Default = Color3.fromRGB(255, 80, 80),
    Callback = function(c)
        ESPColors.Killer = c
        ClearAllPlayerESP()
    end
})
ESPColorBox:AddLabel("Survivor Color")
ESPColorBox:AddColorPicker("ColorSurvivor", {
    Default = Color3.fromRGB(80, 200, 255),
    Callback = function(c)
        ESPColors.Survivor = c
        ClearAllPlayerESP()
    end
})

-- SURVIVORS
local SurvL = Tabs.Survivors:AddLeftGroupbox("Auto Actions", "zap")
SurvL:AddToggle("AutoSkillcheck", { Text = "Auto Skillcheck Perfect", Default = false })
SurvL:AddDropdown("SkillcheckMode", { Text = "Skillcheck Mode", Values = {"Instant","Perfect","Legit"}, Default = 1 })
SurvL:AddToggle("AutoRun", { Text = "Auto Run [PC]", Default = false })
SurvL:AddToggle("Flowstate", { Text = "Flowstate", Default = false })
SurvL:AddToggle("QuickRecovery", { Text = "Quick Recovery", Default = false })
SurvL:AddToggle("PerfectLanding", { Text = "Perfect Landing", Default = false })
SurvL:AddToggle("SnakeStep", { Text = "Snake Step", Default = false })

local SurvR = Tabs.Survivors:AddRightGroupbox("Parry & Heal", "shield")
SurvR:AddToggle("AutoParry", { Text = "Auto Parry", Default = false })
SurvR:AddToggle("TriggerAutoParry", { Text = "Trigger Auto Parry", Default = false })
SurvR:AddSlider("ParryRange", { Text = "Parry Range", Default = 8, Min = 3, Max = 20, Rounding = 0, Suffix = " st" })
SurvR:AddSlider("FacingThreshAP", { Text = "Facing Threshold Parry", Default = 45, Min = 5, Max = 180, Rounding = 0, Suffix = "°" })
SurvR:AddToggle("AutoHook", { Text = "Auto Hook (Unhook)", Default = false })
SurvR:AddToggle("SelfHeal", { Text = "Self Heal", Default = false })

local SurvL2 = Tabs.Survivors:AddLeftGroupbox("Generator & Gate", "cpu")
SurvL2:AddToggle("AutoGenerator", { Text = "Auto Generator", Default = false })
SurvL2:AddToggle("AutoGeneratorTP", { Text = "Auto Generator (With TP)", Default = false, Risky = true })
SurvL2:AddToggle("BypassGenerator", { Text = "Bypass Generator", Default = false, Risky = true })
SurvL2:AddToggle("AutoGateOneTap", { Text = "Auto Gate One Tap", Default = false, Risky = true })
SurvL2:AddToggle("BypassGate", { Text = "Bypass Gate", Default = false, Risky = true })
SurvL2:AddToggle("InstantTPGate", { Text = "Instant TP Gate", Default = false, Risky = true })
SurvL2:AddToggle("TrollTP", { Text = "Troll TP", Default = false, Risky = true })

local SurvR2 = Tabs.Survivors:AddRightGroupbox("Pallet & Vault & Flee", "layers")
SurvR2:AddToggle("AutoDropPallet", { Text = "Auto Drop Pallet", Default = false })
SurvR2:AddToggle("FastVault", { Text = "Fast Vault", Default = false })
SurvR2:AddSlider("VaultDelay", { Text = "Delay Before Vault", Default = 0, Min = 0, Max = 2, Rounding = 1, Suffix = " s" })
SurvR2:AddToggle("BlockAllVault", { Text = "Block All Vault", Default = false })
SurvR2:AddToggle("FleeKiller", { Text = "Flee Killer (Auto Menjauh)", Default = false })
SurvR2:AddSlider("FleeDistance", { Text = "Flee Distance", Default = 25, Min = 10, Max = 60, Rounding = 0, Suffix = " st" })

-- KILLER
local KillL = Tabs.Killer:AddLeftGroupbox("Killer Utility", "sword")
KillL:AddToggle("KillAll", { Text = "Kill All Instant", Default = false, Risky = true })
KillL:AddToggle("AutoAttack", { Text = "Auto Attack", Default = false })
KillL:AddDropdown("AutoAttackMode", { Text = "Auto Attack Mode", Values = {"Legit","Instant"}, Default = 1 })
KillL:AddToggle("AutoHookKiller", { Text = "Auto Hook Survivor", Default = false })
KillL:AddSlider("AttackRange", { Text = "Attack Range", Default = 10, Min = 5, Max = 50, Rounding = 0, Suffix = " st" })

-- MOVEMENT
local MovL = Tabs.Movement:AddLeftGroupbox("Speed & Physics", "wind")
MovL:AddToggle("SpeedBoost", { Text = "Speed Boost", Default = false, Risky = true })
MovL:AddSlider("SpeedValue", { Text = "Speed Value", Default = 30, Min = 16, Max = 100, Rounding = 0, Suffix = " sp" })
MovL:AddToggle("Noclip", { Text = "Noclip", Default = false, Risky = true })
MovL:AddToggle("GodMode", { Text = "God Mode", Default = false, Risky = true })
MovL:AddToggle("NoFallDamage", { Text = "No Fall Damage", Default = false })
MovL:AddToggle("Moonwalk", { Text = "Moonwalk", Default = false })
MovL:AddToggle("Invisibility", { Text = "Invisibility", Default = false })
MovL:AddToggle("Spectator", { Text = "Spectator", Default = false })

-- EMOTE
local EmoteL = Tabs.Emote:AddLeftGroupbox("Emote Features", "star")
EmoteL:AddToggle("PlayEmote", { Text = "Play Emote", Default = false })
EmoteL:AddDropdown("SelectEmote", { Text = "Select Emote", Values = EMOTE_NAMES, Default = 1 })

local EmoteR = Tabs.Emote:AddRightGroupbox("Fake Avatar", "user")
EmoteR:AddInput("FakeAvatarUsername", { Text = "Username (@username)", Default = "", Placeholder = "@username..." })
EmoteR:AddDropdown("FakeAvatarPreset", {
    Text = "Avatar Preset",
    Values = {"Self Avatar","Alex","Brandon","Tony","Richard","Cobra","Rabbit","Richter"},
    Default = 1
})
EmoteR:AddButton({
    Text = "Apply Fake Avatar",
    Func = function()
        local username = (OV("FakeAvatarUsername") or ""):gsub("^@", "")
        local preset = OV("FakeAvatarPreset") or "Self Avatar"
        task.spawn(function()
            local ch = Char
            if not ch then Library:Notify({Title="Fake Avatar", Description="Character belum spawn!", Time=3}) return end
            local uid
            if username ~= "" then
                local ok, id = pcall(function() return Players:GetUserIdFromNameAsync(username) end)
                if not ok or not id then Library:Notify({Title="Fake Avatar", Description="Username tidak ditemukan!", Time=3}) return end
                uid = id
            elseif preset ~= "Self Avatar" then
                local ok, id = pcall(function() return Players:GetUserIdFromNameAsync(preset) end)
                if ok and id then uid = id end
            else uid = LP.UserId end
            if not uid then return end
            local ok, appearance = pcall(function() return Players:GetCharacterAppearanceAsync(uid) end)
            if not ok or not appearance then Library:Notify({Title="Fake Avatar", Description="Gagal load avatar!", Time=3}) return end
            for _, item in ipairs(ch:GetChildren()) do
                if item:IsA("Accessory") or item:IsA("Shirt") or item:IsA("Pants") or item:IsA("ShirtGraphic") or item:IsA("BodyColors") then item:Destroy() end
            end
            for _, item in ipairs(appearance:GetChildren()) do
                if item:IsA("Accessory") or item:IsA("Shirt") or item:IsA("Pants") or item:IsA("ShirtGraphic") or item:IsA("BodyColors") then
                    item:Clone().Parent = ch
                end
            end
            Library:Notify({Title="Fake Avatar", Description="Avatar diterapkan!", Time=3})
        end)
    end
})

-- MISC
local MiscL = Tabs.Misc:AddLeftGroupbox("Spoof & Extra", "user")
MiscL:AddInput("SpoofName", { Text = "Spoof Name", Default = "", Placeholder = "Write name..." })
MiscL:AddInput("SpoofGold", { Text = "Spoof Gold", Default = "", Placeholder = "Write number..." })
MiscL:AddInput("SpoofScrew", {Text = "Spoof Screw", Default = "", Placeholder = "Write number..." })
MiscL:AddToggle("MaxFPS", { Text = "Max FPS", Default = false })

local MiscR = Tabs.Misc:AddRightGroupbox("Cursor & Other", "mouse-pointer")
MiscR:AddToggle("CursorFeatures", { Text = "Cursor Features", Default = false })
MiscR:AddToggle("ShowPlatform", { Text = "Show Platform", Default = false })

-- CONFIG
local ConfigLeft = Tabs.Config:AddLeftGroupbox("Config Manager", "save")
ConfigLeft:AddDropdown("ConfigDropdown", {
    Text = "Select Config", Values = GetConfigList(), Default = 1,
    Callback = function(v) SelectedConfig = v end
})
ConfigLeft:AddInput("ConfigNameInput", { Text = "Config Name", Default = "", Placeholder = "Masukkan nama config..." })
ConfigLeft:AddButton({
    Text = "Save Config",
    Func = function()
        local name = OV("ConfigNameInput")
        if not name or name == "" then name = SelectedConfig end
        if not name or name == "" then Library:Notify({Title="Config", Description="Nama config kosong!", Time=3}) return end
        local data = { Toggles = {}, Options = {} }
        for key, toggle in pairs(Toggles) do data.Toggles[key] = toggle.Value end
        for key, option in pairs(Options) do if option.Value ~= nil then data.Options[key] = option.Value end end
        writefile(CFG_FOLDER .. name .. ".json", HttpService:JSONEncode(data))
        SelectedConfig = name CurrentLoaded = name
        Options.ConfigDropdown:SetValues(GetConfigList())
        Library:Notify({Title="Config", Description="Config \""..name.."\" disimpan!", Time=3})
    end
})
ConfigLeft:AddButton({
    Text = "Load Config",
    Func = function()
        local name = SelectedConfig or OV("ConfigNameInput")
        if not name or name == "" then Library:Notify({Title="Config", Description="Pilih config dulu!", Time=3}) return end
        local path = CFG_FOLDER .. name .. ".json"
        if not isfile(path) then Library:Notify({Title="Config", Description="File tidak ditemukan!", Time=3}) return end
        local success, data = pcall(function() return HttpService:JSONDecode(readfile(path)) end)
        if not success or not data then Library:Notify({Title="Config", Description="Gagal membaca config!", Time=3}) return end
        if data.Toggles then for key, value in pairs(data.Toggles) do if Toggles[key] then Toggles[key]:SetValue(value) end end end
        if data.Options then for key, value in pairs(data.Options) do if Options[key] then Options[key]:SetValue(value) end end end
        CurrentLoaded = name
        Library:Notify({Title="Config", Description="Config \""..name.."\" diload!", Time=3})
    end
})
ConfigLeft:AddButton({
    Text = "Delete Config",
    Func = function()
        local name = SelectedConfig
        if not name or name == "" then return end
        local path = CFG_FOLDER .. name .. ".json"
        if isfile(path) then
            delfile(path)
            Options.ConfigDropdown:SetValues(GetConfigList())
            Library:Notify({Title="Config", Description="Config dihapus!", Time=3})
        end
    end
})
ConfigLeft:AddButton({
    Text = "Refresh List",
    Func = function()
        Options.ConfigDropdown:SetValues(GetConfigList())
        Library:Notify({Title="Config", Description="List di-refresh!", Time=2})
    end
})

local ConfigRight = Tabs.Config:AddRightGroupbox("Autoload & Extra", "folder")
ConfigRight:AddButton({
    Text = "Set Autoload",
    Func = function()
        local name = SelectedConfig
        if not name or name == "" then Library:Notify({Title="Autoload", Description="Pilih config dulu!", Time=3}) return end
        writefile(CFG_FOLDER .. "Autoload.txt", name)
        Library:Notify({Title="Autoload", Description="Autoload diset ke \""..name.."\"", Time=3})
    end
})
ConfigRight:AddButton({
    Text = "Clear Autoload",
    Func = function()
        if isfile(CFG_FOLDER .. "Autoload.txt") then
            delfile(CFG_FOLDER .. "Autoload.txt")
            Library:Notify({Title="Autoload", Description="Autoload dihapus!", Time=2})
        end
    end
})
ConfigRight:AddDivider()
ConfigRight:AddInput("ExternalJSON", { Text = "External JSON", Default = "", Placeholder = "Paste raw JSON..." })
ConfigRight:AddButton({
    Text = "Load External JSON",
    Func = function()
        local raw = OV("ExternalJSON")
        if not raw or raw == "" then return end
        local success, data = pcall(function() return HttpService:JSONDecode(raw) end)
        if not success or not data then Library:Notify({Title="External", Description="JSON tidak valid!", Time=3}) return end
        if data.Toggles then for key, value in pairs(data.Toggles) do if Toggles[key] then Toggles[key]:SetValue(value) end end end
        if data.Options then for key, value in pairs(data.Options) do if Options[key] then Options[key]:SetValue(value) end end end
        Library:Notify({Title="External", Description="External JSON diload!", Time=3})
    end
})
ConfigRight:AddButton({
    Text = "Export Current Config",
    Func = function()
        local data = { Toggles = {}, Options = {} }
        for key, toggle in pairs(Toggles) do data.Toggles[key] = toggle.Value end
        for key, option in pairs(Options) do if option.Value ~= nil then data.Options[key] = option.Value end end
        setclipboard(HttpService:JSONEncode(data))
        Library:Notify({Title="Export", Description="Config dicopy ke clipboard!", Time=3})
    end
})

-- ═══════════════════════════════════════════════════════
--  TOGGLE CALLBACKS
-- ═══════════════════════════════════════════════════════
Toggles.AutoParry:OnChanged(function(v) SetupAutoParry(v) end)
Toggles.TriggerAutoParry:OnChanged(function(v) SetupTriggerAP(v) SetupAutoParry(v or TV("AutoParry")) end)
Toggles.AutoHook:OnChanged(function(v) SetupAutoHook(v) end)
Toggles.SelfHeal:OnChanged(function(v) SetupSelfHeal(v) end)
Toggles.AutoSkillcheck:OnChanged(function(v) SetupSkillcheck(v) end)
Toggles.AutoGenerator:OnChanged(function(v) SetupAutoGen(v, false) end)
Toggles.AutoGeneratorTP:OnChanged(function(v) SetupAutoGen(v, true) end)
Toggles.BypassGenerator:OnChanged(function(v) SetupBypassGenerator(v) end)
Toggles.BypassGate:OnChanged(function(v) SetupBypassGate(v) end)
Toggles.FleeKiller:OnChanged(function(v) SetupFleeKiller(v) end)
Toggles.FastVault:OnChanged(function(v) SetupFastVault(v) end)
Toggles.AutoDropPallet:OnChanged(function(v) if v then _StartAutoDropPallet() end end)
Toggles.AutoGateOneTap:OnChanged(function(v) SetupAutoGate(v) end)

Toggles.SilentAim:OnChanged(function(v) SetupSilentAim(v) end)
Toggles.AimbotEnabled:OnChanged(function(v) SetupAimbotCamera(v) end)
Toggles.KillAll:OnChanged(function(v) SetupKillAll(v) end)
Toggles.AutoAttack:OnChanged(function(v) SetupAutoAttack(v) end)
Toggles.AutoHookKiller:OnChanged(function(v) SetupAutoHookKiller(v) end)
Toggles.AutoRun:OnChanged(function(v) SetupAutoRun(v) end)
Toggles.InstantTPGate:OnChanged(function(v) SetupInstantTPGate(v) end)
Toggles.PlayEmote:OnChanged(function(v) SetupPlayEmote(v) end)

Toggles.Flowstate:OnChanged(function(v) SetupFlowstate(v) end)
Toggles.TrollTP:OnChanged(function(v) SetupTrollTP(v) end)
Toggles.BlockAllVault:OnChanged(function(v) SetupBlockAllVault(v) end)
Toggles.HiddenAimbot:OnChanged(function(v) SetupHiddenAimbot(v) end)
Toggles.SpearSilentAim:OnChanged(function(v) SetupSpearSilentAim(v) end)
Toggles.AimbotFlashlight:OnChanged(function(v) SetupAimbotFlashlight(v) end)
Toggles.QuickRecovery:OnChanged(function(v) SetupQuickRecovery(v) end)
Toggles.PerfectLanding:OnChanged(function(v) SetupPerfectLanding(v) end)
Toggles.SnakeStep:OnChanged(function(v) SetupSnakeStep(v) end)
Toggles.Invisibility:OnChanged(function(v) SetupInvisibility(v) end)
Toggles.Spectator:OnChanged(function(v) SetupSpectator(v) end)
Toggles.Moonwalk:OnChanged(function(v) SetupMoonwalk(v) end)

Toggles.GodMode:OnChanged(function(v)
    SetupGodModeGlobal(v)
    if Hum then
        if v then Hum.MaxHealth = 9e9 Hum.Health = 9e9
        else Hum.MaxHealth = 100 Hum.Health = math.min(Hum.Health, 100) end
    end
end)

Toggles.SpeedBoost:OnChanged(function(v)
    SetupSpeedBoost(v)
    if Hum then Hum.WalkSpeed = v and (OV("SpeedValue") or 30) or 16 end
end)

Toggles.Noclip:OnChanged(function(v) SetupNoclip(v) end)

Toggles.ESPEnabled:OnChanged(function(v)
    SetupESPGlobal(v)
    if not v then ClearAllPlayerESP() end
end)

local function OnObjectESPChanged()
    RebuildObjectESP()
end
Toggles.ESPGenerator:OnChanged(OnObjectESPChanged)
Toggles.ESPGeneratorProgress:OnChanged(OnObjectESPChanged)
Toggles.ESPGate:OnChanged(OnObjectESPChanged)
Toggles.ESPHook:OnChanged(OnObjectESPChanged)
Toggles.ESPPallet:OnChanged(OnObjectESPChanged)
Toggles.ESPVault:OnChanged(OnObjectESPChanged)

Toggles.MaxFPS:OnChanged(function(v)
    if v and setfpscap then pcall(setfpscap, 999)
    elseif setfpscap then pcall(setfpscap, 60) end
end)

-- ═══════════════════════════════════════════════════════
--  RENDER LOOP
-- ═══════════════════════════════════════════════════════
RunService.RenderStepped:Connect(function()
    if not Char or not Char.Parent then RefreshChar() end
    if not Char then return end

    if DrawingSupported then
        local fovOn = TV("ShowFOVCircle")
        FOVCircle.Visible = fovOn
        if fovOn then
            FOVCircle.Position = Vector2.new(Cam.ViewportSize.X/2, Cam.ViewportSize.Y/2)
            FOVCircle.Radius = OV("FOVSize") or 120
        end
        local veilOn = TV("ShowVeilFOVCircle")
        VeilFOVCircle.Visible = veilOn
        if veilOn then
            VeilFOVCircle.Position = Vector2.new(Cam.ViewportSize.X/2, Cam.ViewportSize.Y/2)
            VeilFOVCircle.Radius = (OV("FOVAimbot") or 90) / 2
        end
    end

    if TV("Noclip") then
        for _, p in ipairs(Char:GetDescendants()) do
            if p:IsA("BasePart") then p.CanCollide = false end
        end
    end

    if TV("GodMode") and Hum and Hum.Health < 9e9 then Hum.Health = 9e9 end

    -- Update generator progress labels
    UpdateGeneratorProgressLabels()

    if TV("ESPEnabled") then
        local active = {}
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LP and p.Character and IsAlive(p.Character) then
                local c = p.Character
                local isKil = IsKillerPlayer(p)
                local showIt = (isKil and TV("ESPKiller")) or (not isKil and TV("ESPSurvivor"))
                if showIt then
                    active[c] = true
                    local existing = ESPCache[c]
                    if not existing or existing.isKiller ~= isKil then
                        if existing then ClearPlayerESP(c) end
                        MakePlayerESP(c, isKil)
                    end
                    local data = ESPCache[c]
                    if data and data.bill then
                        local nameL = data.bill:FindFirstChild("NameL")
                        local distL = data.bill:FindFirstChild("DistL")
                        local roleL = data.bill:FindFirstChild("RoleL")
                        local stunL = data.bill:FindFirstChild("StunL")
                        if nameL then nameL.Text = TV("ShowName") and p.Name or "" end
                        if distL and HRP then
                            local thrp = c:FindFirstChild("HumanoidRootPart")
                            if thrp then distL.Text = TV("ShowDist") and (math.floor((HRP.Position - thrp.Position).Magnitude) .. " st") or "" end
                        end
                        if roleL then roleL.Visible = TV("ShowRole") end
                        if stunL then
                            local stun = c:GetAttribute("isStunned") or c:GetAttribute("Stunned")
                            stunL.Visible = TV("ShowStunRing") and stun
                            stunL.Text = stun and "STUNNED" or ""
                        end
                    end
                end
            end
        end
        for c in pairs(ESPCache) do if not active[c] then ClearPlayerESP(c) end end
    else
        ClearAllPlayerESP()
    end
end)

RunService.Heartbeat:Connect(function()
    if not Hum then return end
    if TV("SpeedBoost") then Hum.WalkSpeed = OV("SpeedValue") or 30 end
    if TV("NoFallDamage") then
        Hum:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
        Hum:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
    end
end)

LP.CharacterAdded:Connect(function(newChar)
    Char = newChar
    HRP = newChar:WaitForChild("HumanoidRootPart", 5)
    Hum = newChar:WaitForChild("Humanoid", 5)

    if TV("GodMode") and Hum then Hum.MaxHealth = 9e9 Hum.Health = 9e9 end
    if TV("SpeedBoost") and Hum then Hum.WalkSpeed = OV("SpeedValue") or 30 end

    if TV("AutoParry") then SetupAutoParry(true) end
    if TV("AutoHook") then SetupAutoHook(true) end
    if TV("SelfHeal") then SetupSelfHeal(true) end
    if TV("AutoSkillcheck") then SetupSkillcheck(true) end
    if TV("AutoGenerator") then SetupAutoGen(true, false) end
    if TV("AutoGeneratorTP") then SetupAutoGen(true, true) end
    if TV("BypassGenerator") then SetupBypassGenerator(true) end
    if TV("BypassGate") then SetupBypassGate(true) end
    if TV("FleeKiller") then SetupFleeKiller(true) end
    if TV("FastVault") then SetupFastVault(true) end
    if TV("AutoDropPallet") then _StartAutoDropPallet() end
    if TV("AutoGateOneTap") then SetupAutoGate(true) end
    if TV("AimbotEnabled") then SetupAimbotCamera(true) end
    if TV("KillAll") then SetupKillAll(true) end
    if TV("AutoAttack") then SetupAutoAttack(true) end
    if TV("AutoHookKiller") then SetupAutoHookKiller(true) end
    if TV("AutoRun") then SetupAutoRun(true) end
    if TV("InstantTPGate") then SetupInstantTPGate(true) end
    if TV("PlayEmote") then SetupPlayEmote(true) end
    if TV("Flowstate") then SetupFlowstate(true) end
    if TV("TrollTP") then SetupTrollTP(true) end
    if TV("BlockAllVault") then SetupBlockAllVault(true) end
    if TV("HiddenAimbot") then SetupHiddenAimbot(true) end
    if TV("SpearSilentAim") then SetupSpearSilentAim(true) end
    if TV("AimbotFlashlight") then SetupAimbotFlashlight(true) end
    if TV("QuickRecovery") then SetupQuickRecovery(true) end
    if TV("PerfectLanding") then SetupPerfectLanding(true) end
    if TV("SnakeStep") then SetupSnakeStep(true) end
    if TV("Invisibility") then SetupInvisibility(true) end
    if TV("Spectator") then SetupSpectator(true) end
    if TV("Moonwalk") then SetupMoonwalk(true) end
    if TV("Noclip") then SetupNoclip(true) end
    if TV("ESPEnabled") then SetupESPGlobal(true) end

    task.delay(2, function()
        ScanMap()
        RebuildObjectESP()
    end)
end)

Players.PlayerRemoving:Connect(function(p)
    if p.Character then ClearPlayerESP(p.Character) end
end)

task.spawn(function()
    task.wait(3)
    if isfile(CFG_FOLDER .. "Autoload.txt") then
        local name = readfile(CFG_FOLDER .. "Autoload.txt")
        if name and name ~= "" and isfile(CFG_FOLDER .. name .. ".json") then
            local success, data = pcall(function() return HttpService:JSONDecode(readfile(CFG_FOLDER .. name .. ".json")) end)
            if success and data then
                if data.Toggles then for key, value in pairs(data.Toggles) do if Toggles[key] then Toggles[key]:SetValue(value) end end end
                if data.Options then for key, value in pairs(data.Options) do if Options[key] then Options[key]:SetValue(value) end end end
                CurrentLoaded = name SelectedConfig = name
                Library:Notify({Title="Autoload", Description="Config \""..name.."\" berhasil diload!", Time=4})
            end
        end
    end
end)

Library:Notify({
    Title = "Meng Hub v7 + C & D",
    Description = "ESP Progress + Custom Color + Bypass + Flee Killer | " .. (IsMobile and "Mobile" or "PC"),
    Time = 5
})

warn("[Meng Hub v7 C+D] Loaded | Drawing:", DrawingSupported and "Supported" or "Not Supported")
