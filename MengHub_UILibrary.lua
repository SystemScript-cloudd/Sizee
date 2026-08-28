local TweenService       = game:GetService("TweenService")
local UserInputService   = game:GetService("UserInputService")
local HttpService        = game:GetService("HttpService")
local Players            = game:GetService("Players")
local RunService         = game:GetService("RunService")
local CoreGui            = game:GetService("CoreGui")

local LocalPlayer        = Players.LocalPlayer
local PlayerGui          = LocalPlayer:WaitForChild("PlayerGui")

-- ──────────────────────────────────────────────────────────────────
-- GLOBAL CONFIG
-- ──────────────────────────────────────────────────────────────────
_G.ConfigFolder          = _G.ConfigFolder or "Meng Hub/Config/"

-- ──────────────────────────────────────────────────────────────────
-- ASSET ICON MAP  (extracted from constants in bytecode)
-- ──────────────────────────────────────────────────────────────────
local Icons = {
    alert      = "rbxassetid://73186275216515",
    question   = "rbxassetid://17510196486",
    idea       = "rbxassetid://16833255748",
    storm      = "rbxassetid://13321880293",
    dcs        = "rbxassetid://15310731934",
    start      = "rbxassetid://108886429866687",
    next       = "rbxassetid://12662718374",
    rod        = "rbxassetid://103247953194129",
    fish       = "rbxassetid://97167558235554",
    mouse      = "rbxassetid://10088146947",
    sword      = "rbxassetid://10088146947",
    user       = "rbxassetid://16833255748",
    discord    = "rbxassetid://15310731934",
    settings   = "rbxassetid://13321880293",
    crosshair  = "rbxassetid://10088146947",
}

-- ──────────────────────────────────────────────────────────────────
-- THEME  (color constants extracted from Color3.fromRGB opcodes)
-- ──────────────────────────────────────────────────────────────────
local Theme = {
    Background          = Color3.fromRGB(25,  25,  35),
    SecondaryBackground = Color3.fromRGB(30,  30,  42),
    Accent              = Color3.fromRGB(130, 80,  255),
    AccentHover         = Color3.fromRGB(155, 110, 255),
    TabBackground       = Color3.fromRGB(20,  20,  30),
    ElementBackground   = Color3.fromRGB(35,  35,  50),
    ElementBorder       = Color3.fromRGB(55,  55,  75),
    TextPrimary         = Color3.fromRGB(220, 220, 220),
    TextSecondary       = Color3.fromRGB(150, 150, 170),
    TextDisabled        = Color3.fromRGB(90,  90,  110),
    ToggleOn            = Color3.fromRGB(100, 200, 100),
    ToggleOff           = Color3.fromRGB(70,  70,  90),
    SliderFill          = Color3.fromRGB(130, 80,  255),
    NotifyBackground    = Color3.fromRGB(28,  28,  40),
    NotifyBorder        = Color3.fromRGB(130, 80,  255),
    PremiumGold         = Color3.fromRGB(255, 185, 50),
    StrokeColor         = Color3.fromRGB(195, 60,  60),
    White               = Color3.fromRGB(220, 220, 220),
}

-- ──────────────────────────────────────────────────────────────────
-- TWEEN HELPER
-- ──────────────────────────────────────────────────────────────────
local function Tween(instance, tweenInfo, properties)
    local t = TweenService:Create(instance, tweenInfo, properties)
    t:Play()
    return t
end

local FastTween  = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local SlowTween  = TweenInfo.new(0.30, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

-- ──────────────────────────────────────────────────────────────────
-- UI BUILDER HELPERS
-- ──────────────────────────────────────────────────────────────────
local function Create(className, properties)
    local instance = Instance.new(className)
    for prop, value in pairs(properties) do
        instance[prop] = value
    end
    return instance
end

local function AddCorner(parent, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, radius or 6)
    corner.Parent = parent
    return corner
end

local function AddStroke(parent, color, thickness, transparency)
    local stroke = Instance.new("UIStroke")
    stroke.Color        = color       or Theme.ElementBorder
    stroke.Thickness    = thickness   or 1
    stroke.Transparency = transparency or 0.35
    stroke.Parent       = parent
    return stroke
end

local function AddPadding(parent, top, bottom, left, right)
    local pad = Instance.new("UIPadding")
    pad.PaddingTop    = UDim.new(0, top    or 4)
    pad.PaddingBottom = UDim.new(0, bottom or 4)
    pad.PaddingLeft   = UDim.new(0, left   or 8)
    pad.PaddingRight  = UDim.new(0, right  or 8)
    pad.Parent        = parent
    return pad
end

local function AddListLayout(parent, direction, padding, sortOrder)
    local layout = Instance.new("UIListLayout")
    layout.FillDirection       = direction or Enum.FillDirection.Vertical
    layout.Padding             = UDim.new(0, padding or 4)
    layout.SortOrder           = sortOrder or Enum.SortOrder.LayoutOrder
    layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    layout.Parent              = parent
    return layout
end

-- ──────────────────────────────────────────────────────────────────
-- PREMIUM TOOLTIP  (reconstructed from PROTO3 / PremiumTooltip section)
-- ──────────────────────────────────────────────────────────────────

-- Root ScreenGui for the premium tooltip (persistent, always on top)
local PremiumTooltipGui = Create("ScreenGui", {
    Name              = "MenghubPremiumTooltip",
    ResetOnSpawn      = false,
    ZIndexBehavior    = Enum.ZIndexBehavior.Sibling,
    IgnoreGuiInset    = true,
    Parent            = CoreGui,
})

-- Tooltip container frame
local PremiumTooltipFrame = Create("Frame", {
    Name            = "PremiumTooltip",
    Size            = UDim2.new(0, 195, 0, 60),
    Position        = UDim2.new(0, 0, 0, 0),
    BackgroundColor3 = Theme.SecondaryBackground,
    BorderSizePixel = 0,
    Visible         = false,
    ZIndex          = 100,
    Parent          = PremiumTooltipGui,
})
AddCorner(PremiumTooltipFrame, 8)
AddStroke(PremiumTooltipFrame, Theme.PremiumGold, 1, 0.35)
AddPadding(PremiumTooltipFrame, 6, 6, 10, 10)

-- Tooltip UIStroke for extra visual flair
local TooltipExtraStroke = Create("UIStroke", {
    Color        = Theme.PremiumGold,
    Thickness    = 1,
    Transparency = 0.35,
    Parent       = PremiumTooltipFrame,
})

-- Title label: "Premium Required"
local PremiumTitleLabel = Create("TextLabel", {
    Name            = "TitleLabel",
    Size            = UDim2.new(1, 0, 0, 20),
    Position        = UDim2.new(0, 0, 0, 4),
    BackgroundTransparency = 1,
    Text            = "Premium Required",
    TextColor3      = Theme.PremiumGold,
    TextSize        = 13,
    Font            = Enum.Font.GothamBold,
    TextXAlignment  = Enum.TextXAlignment.Left,
    ZIndex          = 101,
    Parent          = PremiumTooltipFrame,
})

-- Sub-label: "unlock this with premium"
local PremiumSubLabel = Create("TextLabel", {
    Name            = "SubLabel",
    Size            = UDim2.new(1, 0, 0, 16),
    Position        = UDim2.new(0, 0, 0, 26),
    BackgroundTransparency = 1,
    Text            = "unlock this with premium",
    TextColor3      = Theme.TextSecondary,
    TextSize        = 11,
    Font            = Enum.Font.Gotham,
    TextXAlignment  = Enum.TextXAlignment.Left,
    ZIndex          = 101,
    Parent          = PremiumTooltipFrame,
})

-- Show / hide premium tooltip near cursor
local function ShowPremiumTooltip(position)
    PremiumTooltipFrame.Position = UDim2.new(0, position.X + 14, 0, position.Y + 14)
    PremiumTooltipFrame.Visible  = true
    PremiumTooltipFrame.BackgroundTransparency = 1
    Tween(PremiumTooltipFrame, FastTween, { BackgroundTransparency = 0 })
end

local function HidePremiumTooltip()
    Tween(PremiumTooltipFrame, FastTween, { BackgroundTransparency = 1 })
    task.delay(0.15, function()
        PremiumTooltipFrame.Visible = false
    end)
end

-- ──────────────────────────────────────────────────────────────────
-- NOTIFICATION SYSTEM  (MakeNotify — reconstructed from PROTO4)
-- ──────────────────────────────────────────────────────────────────

local NotifyGui = Create("ScreenGui", {
    Name           = "MenghubNotifications",
    ResetOnSpawn   = false,
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
    IgnoreGuiInset = true,
    Parent         = CoreGui,
})

local NotifyHolder = Create("Frame", {
    Name                   = "NotifyHolder",
    Size                   = UDim2.new(0, 280, 1, 0),
    Position               = UDim2.new(1, -295, 0, 0),
    BackgroundTransparency = 1,
    Parent                 = NotifyGui,
})
AddListLayout(NotifyHolder, Enum.FillDirection.Vertical, 6)

-- Add padding to holder
local notifyHolderPad = Instance.new("UIPadding")
notifyHolderPad.PaddingTop = UDim.new(0, 12)
notifyHolderPad.Parent     = NotifyHolder

local function MakeNotify(options)
    options = options or {}
    local title       = options.Title       or "Notification"
    local description = options.Description or ""
    local duration    = options.Duration     or 4
    local icon        = options.Icon         and Icons[options.Icon] or Icons.alert
    local notifyType  = options.Type         or "info"  -- "info" | "success" | "error" | "warning"

    -- Color variants by type
    local borderColor = Theme.NotifyBorder
    if notifyType == "success" then borderColor = Theme.ToggleOn
    elseif notifyType == "error" then borderColor = Color3.fromRGB(200, 60, 60)
    elseif notifyType == "warning" then borderColor = Theme.PremiumGold
    end

    -- Notification frame
    local notifyFrame = Create("Frame", {
        Name                   = "Notification",
        Size                   = UDim2.new(1, 0, 0, 68),
        BackgroundColor3       = Theme.NotifyBackground,
        BorderSizePixel        = 0,
        BackgroundTransparency = 0,
        ClipsDescendants       = true,
        Parent                 = NotifyHolder,
    })
    AddCorner(notifyFrame, 8)
    AddStroke(notifyFrame, borderColor, 1, 0.3)

    -- Icon image
    local notifyIcon = Create("ImageLabel", {
        Name                   = "Icon",
        Size                   = UDim2.new(0, 28, 0, 28),
        Position               = UDim2.new(0, 10, 0.5, -14),
        BackgroundTransparency = 1,
        Image                  = icon,
        ImageColor3            = borderColor,
        Parent                 = notifyFrame,
    })

    -- Title label
    local notifyTitle = Create("TextLabel", {
        Name                   = "Title",
        Size                   = UDim2.new(1, -54, 0, 20),
        Position               = UDim2.new(0, 46, 0, 10),
        BackgroundTransparency = 1,
        Text                   = title,
        TextColor3             = Theme.TextPrimary,
        TextSize               = 13,
        Font                   = Enum.Font.GothamBold,
        TextXAlignment         = Enum.TextXAlignment.Left,
        TextTruncate           = Enum.TextTruncate.AtEnd,
        Parent                 = notifyFrame,
    })

    -- Description label
    local notifyDesc = Create("TextLabel", {
        Name                   = "Description",
        Size                   = UDim2.new(1, -54, 0, 28),
        Position               = UDim2.new(0, 46, 0, 30),
        BackgroundTransparency = 1,
        Text                   = description,
        TextColor3             = Theme.TextSecondary,
        TextSize               = 11,
        Font                   = Enum.Font.Gotham,
        TextXAlignment         = Enum.TextXAlignment.Left,
        TextWrapped            = true,
        Parent                 = notifyFrame,
    })

    -- Progress bar (bottom)
    local progressBar = Create("Frame", {
        Name             = "ProgressBar",
        Size             = UDim2.new(1, 0, 0, 3),
        Position         = UDim2.new(0, 0, 1, -3),
        BackgroundColor3 = borderColor,
        BorderSizePixel  = 0,
        Parent           = notifyFrame,
    })
    AddCorner(progressBar, 2)

    -- Animate in
    notifyFrame.Position = UDim2.new(1, 20, 0, 0)
    Tween(notifyFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Position = UDim2.new(0, 0, 0, 0),
    })

    -- Progress shrink
    Tween(progressBar, TweenInfo.new(duration, Enum.EasingStyle.Linear), {
        Size = UDim2.new(0, 0, 0, 3),
    })

    -- Dismiss after duration
    task.delay(duration, function()
        Tween(notifyFrame, SlowTween, { BackgroundTransparency = 1 })
        task.delay(0.3, function()
            notifyFrame:Destroy()
        end)
    end)

    return notifyFrame
end

-- ──────────────────────────────────────────────────────────────────
-- CONFIG SYSTEM  (SaveConfig / LoadConfigFromFile / LoadConfigElements)
-- Extracted from PROTO2 and bytecode constants _G.ConfigFolder etc.
-- ──────────────────────────────────────────────────────────────────

local ConfigElements = {}   -- tracks all registered config elements

local function EnsureFolder(path)
    -- Ensure each segment of the path exists as a folder
    local parts = path:split("/")
    local current = ""
    for _, part in ipairs(parts) do
        if part ~= "" then
            current = current .. part .. "/"
            if not isfolder(current) then
                makefolder(current)
            end
        end
    end
end

local function SaveConfig(configName)
    EnsureFolder(_G.ConfigFolder)
    local data = {}
    for key, element in pairs(ConfigElements) do
        if element.Save then
            data[key] = element:GetValue()
        end
    end
    local encoded = HttpService:JSONEncode(data)
    writefile(_G.ConfigFolder .. configName .. ".json", encoded)
end

local function LoadConfigFromFile(configName)
    local path = _G.ConfigFolder .. configName .. ".json"
    if not isfile(path) then
        return nil
    end
    local success, result = pcall(function()
        return HttpService:JSONDecode(readfile(path))
    end)
    if success then
        return result
    end
    return nil
end

local function LoadConfigElements(configName)
    local data = LoadConfigFromFile(configName)
    if not data then return end
    for key, value in pairs(data) do
        if ConfigElements[key] and ConfigElements[key].SetValue then
            ConfigElements[key]:SetValue(value)
        end
    end
end

-- ──────────────────────────────────────────────────────────────────
-- MAIN LIBRARY TABLE
-- ──────────────────────────────────────────────────────────────────
local MengHub = {}
MengHub.__index = MengHub

-- ──────────────────────────────────────────────────────────────────
-- WINDOW CREATION
-- ──────────────────────────────────────────────────────────────────
function MengHub:CreateWindow(options)
    options = options or {}
    local windowTitle  = options.Title       or "Meng Hub"
    local windowSize   = options.Size        or UDim2.new(0, 560, 0, 380)
    local windowPos    = options.Position    or UDim2.new(0.5, -280, 0.5, -190)
    local configName   = options.ConfigName  or "default"
    local logoIcon     = options.Icon        or Icons.settings

    -- Root ScreenGui
    local screenGui = Create("ScreenGui", {
        Name              = "MengHubUI",
        ResetOnSpawn      = false,
        ZIndexBehavior    = Enum.ZIndexBehavior.Sibling,
        IgnoreGuiInset    = true,
        Parent            = CoreGui,
    })

    -- Main window frame
    local mainFrame = Create("Frame", {
        Name             = "MainFrame",
        Size             = windowSize,
        Position         = windowPos,
        BackgroundColor3 = Theme.Background,
        BorderSizePixel  = 0,
        ClipsDescendants = false,
        Parent           = screenGui,
    })
    AddCorner(mainFrame, 10)
    AddStroke(mainFrame, Theme.ElementBorder, 1, 0.4)

    -- Drop shadow
    local shadowFrame = Create("ImageLabel", {
        Name                   = "Shadow",
        Size                   = UDim2.new(1, 40, 1, 40),
        Position               = UDim2.new(0, -20, 0, -20),
        BackgroundTransparency = 1,
        Image                  = "rbxassetid://5554236805",
        ImageColor3            = Color3.fromRGB(0, 0, 0),
        ImageTransparency      = 0.6,
        ScaleType              = Enum.ScaleType.Slice,
        SliceCenter            = Rect.new(23, 23, 277, 277),
        ZIndex                 = -1,
        Parent                 = mainFrame,
    })

    -- ── Title bar ──
    local titleBar = Create("Frame", {
        Name             = "TitleBar",
        Size             = UDim2.new(1, 0, 0, 44),
        BackgroundColor3 = Theme.TabBackground,
        BorderSizePixel  = 0,
        Parent           = mainFrame,
    })
    AddCorner(titleBar, 10)

    -- Square off bottom corners of title bar
    local titleBarSquare = Create("Frame", {
        Name             = "SquareBottom",
        Size             = UDim2.new(1, 0, 0.5, 0),
        Position         = UDim2.new(0, 0, 0.5, 0),
        BackgroundColor3 = Theme.TabBackground,
        BorderSizePixel  = 0,
        Parent           = titleBar,
    })

    -- Logo icon
    local logoImage = Create("ImageLabel", {
        Name                   = "Logo",
        Size                   = UDim2.new(0, 24, 0, 24),
        Position               = UDim2.new(0, 10, 0.5, -12),
        BackgroundTransparency = 1,
        Image                  = logoIcon,
        ImageColor3            = Theme.Accent,
        Parent                 = titleBar,
    })

    -- Title text
    local titleText = Create("TextLabel", {
        Name                   = "TitleText",
        Size                   = UDim2.new(1, -44, 1, 0),
        Position               = UDim2.new(0, 40, 0, 0),
        BackgroundTransparency = 1,
        Text                   = windowTitle,
        TextColor3             = Theme.TextPrimary,
        TextSize               = 14,
        Font                   = Enum.Font.GothamBold,
        TextXAlignment         = Enum.TextXAlignment.Left,
        Parent                 = titleBar,
    })

    -- Close button
    local closeButton = Create("TextButton", {
        Name                   = "CloseButton",
        Size                   = UDim2.new(0, 30, 0, 30),
        Position               = UDim2.new(1, -38, 0.5, -15),
        BackgroundColor3       = Color3.fromRGB(200, 60, 60),
        Text                   = "×",
        TextColor3             = Theme.White,
        TextSize               = 18,
        Font                   = Enum.Font.GothamBold,
        BorderSizePixel        = 0,
        Parent                 = titleBar,
    })
    AddCorner(closeButton, 6)

    closeButton.MouseButton1Click:Connect(function()
        Tween(mainFrame, SlowTween, { BackgroundTransparency = 1 })
        task.delay(0.3, function() screenGui:Destroy() end)
    end)

    -- Minimize button
    local minimizeButton = Create("TextButton", {
        Name                   = "MinimizeButton",
        Size                   = UDim2.new(0, 30, 0, 30),
        Position               = UDim2.new(1, -74, 0.5, -15),
        BackgroundColor3       = Theme.PremiumGold,
        Text                   = "–",
        TextColor3             = Theme.White,
        TextSize               = 16,
        Font                   = Enum.Font.GothamBold,
        BorderSizePixel        = 0,
        Parent                 = titleBar,
    })
    AddCorner(minimizeButton, 6)

    local isMinimized = false
    local originalSize = windowSize
    minimizeButton.MouseButton1Click:Connect(function()
        isMinimized = not isMinimized
        if isMinimized then
            Tween(mainFrame, FastTween, { Size = UDim2.new(0, originalSize.X.Offset, 0, 44) })
        else
            Tween(mainFrame, FastTween, { Size = originalSize })
        end
    end)

    -- ── Dragging ──
    local dragStart, startPos, dragging = nil, nil, false
    titleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging  = true
            dragStart = input.Position
            startPos  = mainFrame.Position
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            mainFrame.Position = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )
        end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)

    -- ── Tab sidebar ──
    local tabSidebar = Create("Frame", {
        Name             = "TabSidebar",
        Size             = UDim2.new(0, 130, 1, -44),
        Position         = UDim2.new(0, 0, 0, 44),
        BackgroundColor3 = Theme.TabBackground,
        BorderSizePixel  = 0,
        Parent           = mainFrame,
    })
    AddListLayout(tabSidebar, Enum.FillDirection.Vertical, 4)
    AddPadding(tabSidebar, 8, 8, 6, 6)

    -- ── Content area ──
    local contentFrame = Create("Frame", {
        Name             = "ContentFrame",
        Size             = UDim2.new(1, -130, 1, -44),
        Position         = UDim2.new(0, 130, 0, 44),
        BackgroundColor3 = Theme.Background,
        BorderSizePixel  = 0,
        ClipsDescendants = true,
        Parent           = mainFrame,
    })
    AddCorner(contentFrame, 8)

    -- Divider between sidebar and content
    local divider = Create("Frame", {
        Name             = "Divider",
        Size             = UDim2.new(0, 1, 1, -44),
        Position         = UDim2.new(0, 130, 0, 44),
        BackgroundColor3 = Theme.ElementBorder,
        BorderSizePixel  = 0,
        Parent           = mainFrame,
    })

    -- ── Window object returned to user ──
    local Window = {
        ScreenGui    = screenGui,
        MainFrame    = mainFrame,
        TabSidebar   = tabSidebar,
        ContentFrame = contentFrame,
        Tabs         = {},
        ActiveTab    = nil,
        ConfigName   = configName,
    }

    -- ── CreateTab ──
    function Window:CreateTab(tabOptions)
        tabOptions = tabOptions or {}
        local tabName  = tabOptions.Name  or "Tab"
        local tabIcon  = tabOptions.Icon  and Icons[tabOptions.Icon] or nil

        -- Tab button in sidebar
        local tabButton = Create("TextButton", {
            Name                   = "Tab_" .. tabName,
            Size                   = UDim2.new(1, 0, 0, 32),
            BackgroundColor3       = Theme.ElementBackground,
            BackgroundTransparency = 0.6,
            Text                   = "",
            BorderSizePixel        = 0,
            Parent                 = self.TabSidebar,
        })
        AddCorner(tabButton, 6)

        -- Icon (optional)
        if tabIcon then
            local tabIconImg = Create("ImageLabel", {
                Size                   = UDim2.new(0, 16, 0, 16),
                Position               = UDim2.new(0, 8, 0.5, -8),
                BackgroundTransparency = 1,
                Image                  = tabIcon,
                ImageColor3            = Theme.TextSecondary,
                Parent                 = tabButton,
            })
        end

        -- Tab label
        local tabLabel = Create("TextLabel", {
            Size                   = UDim2.new(1, tabIcon and -32 or -10, 1, 0),
            Position               = UDim2.new(0, tabIcon and 30 or 8, 0, 0),
            BackgroundTransparency = 1,
            Text                   = tabName,
            TextColor3             = Theme.TextSecondary,
            TextSize               = 12,
            Font                   = Enum.Font.Gotham,
            TextXAlignment         = Enum.TextXAlignment.Left,
            Parent                 = tabButton,
        })

        -- Scrollable content page for this tab
        local tabPage = Create("ScrollingFrame", {
            Name                     = "Page_" .. tabName,
            Size                     = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency   = 1,
            BorderSizePixel          = 0,
            ScrollBarThickness       = 3,
            ScrollBarImageColor3     = Theme.Accent,
            CanvasSize               = UDim2.new(0, 0, 0, 0),
            AutomaticCanvasSize      = Enum.AutomaticSize.Y,
            Visible                  = false,
            Parent                   = self.ContentFrame,
        })
        AddListLayout(tabPage, Enum.FillDirection.Vertical, 6)
        AddPadding(tabPage, 8, 8, 10, 10)

        -- Activate tab on click
        tabButton.MouseButton1Click:Connect(function()
            -- Deactivate previous
            if self.ActiveTab then
                self.ActiveTab.Page.Visible = false
                Tween(self.ActiveTab.Button, FastTween, {
                    BackgroundColor3       = Theme.ElementBackground,
                    BackgroundTransparency = 0.6,
                })
                self.ActiveTab.Label.TextColor3 = Theme.TextSecondary
                self.ActiveTab.Label.Font       = Enum.Font.Gotham
            end

            -- Activate new
            tabPage.Visible = true
            Tween(tabButton, FastTween, {
                BackgroundColor3       = Theme.Accent,
                BackgroundTransparency = 0,
            })
            tabLabel.TextColor3 = Theme.White
            tabLabel.Font       = Enum.Font.GothamBold

            self.ActiveTab = { Button = tabButton, Page = tabPage, Label = tabLabel }
        end)

        -- Auto-activate first tab
        if #self.Tabs == 0 then
            tabPage.Visible  = true
            tabButton.BackgroundColor3       = Theme.Accent
            tabButton.BackgroundTransparency = 0
            tabLabel.TextColor3 = Theme.White
            tabLabel.Font       = Enum.Font.GothamBold
            self.ActiveTab = { Button = tabButton, Page = tabPage, Label = tabLabel }
        end

        table.insert(self.Tabs, { Button = tabButton, Page = tabPage, Label = tabLabel })

        -- ── Tab element builder ──
        local Tab = { Page = tabPage, Window = self }

        -- ── SECTION LABEL ──
        function Tab:AddSection(sectionName)
            local sectionLabel = Create("TextLabel", {
                Name                   = "Section_" .. sectionName,
                Size                   = UDim2.new(1, 0, 0, 22),
                BackgroundTransparency = 1,
                Text                   = sectionName,
                TextColor3             = Theme.Accent,
                TextSize               = 11,
                Font                   = Enum.Font.GothamBold,
                TextXAlignment         = Enum.TextXAlignment.Left,
                Parent                 = self.Page,
            })
            -- Underline divider
            local sectionLine = Create("Frame", {
                Size             = UDim2.new(1, 0, 0, 1),
                BackgroundColor3 = Theme.ElementBorder,
                BorderSizePixel  = 0,
                Parent           = self.Page,
            })
        end

        -- ────────────────────────────────────────────────────────
        -- TOGGLE
        -- ────────────────────────────────────────────────────────
        function Tab:AddToggle(toggleOptions)
            toggleOptions = toggleOptions or {}
            local toggleName    = toggleOptions.Name     or "Toggle"
            local toggleDefault = toggleOptions.Default  or false
            local isPremium     = toggleOptions.Premium  or false
            local configKey     = toggleOptions.Config   or nil
            local callback      = toggleOptions.Callback or function() end

            local state = toggleDefault

            -- Element row
            local toggleRow = Create("Frame", {
                Name             = "Toggle_" .. toggleName,
                Size             = UDim2.new(1, 0, 0, 36),
                BackgroundColor3 = Theme.ElementBackground,
                BorderSizePixel  = 0,
                Parent           = self.Page,
            })
            AddCorner(toggleRow, 6)
            AddPadding(toggleRow, 0, 0, 10, 10)

            local toggleLabel = Create("TextLabel", {
                Size                   = UDim2.new(1, -60, 1, 0),
                BackgroundTransparency = 1,
                Text                   = toggleName,
                TextColor3             = isPremium and Theme.PremiumGold or Theme.TextPrimary,
                TextSize               = 12,
                Font                   = Enum.Font.Gotham,
                TextXAlignment         = Enum.TextXAlignment.Left,
                Parent                 = toggleRow,
            })

            -- Premium lock icon
            if isPremium then
                local lockIcon = Create("ImageLabel", {
                    Size                   = UDim2.new(0, 14, 0, 14),
                    Position               = UDim2.new(0, toggleLabel.TextBounds.X + 6, 0.5, -7),
                    BackgroundTransparency = 1,
                    Image                  = "rbxassetid://6031094677",
                    ImageColor3            = Theme.PremiumGold,
                    Parent                 = toggleRow,
                })
            end

            -- Toggle pill
            local togglePill = Create("Frame", {
                Name             = "Pill",
                Size             = UDim2.new(0, 40, 0, 22),
                Position         = UDim2.new(1, -44, 0.5, -11),
                BackgroundColor3 = state and Theme.ToggleOn or Theme.ToggleOff,
                BorderSizePixel  = 0,
                Parent           = toggleRow,
            })
            AddCorner(togglePill, 11)

            local toggleKnob = Create("Frame", {
                Name             = "Knob",
                Size             = UDim2.new(0, 16, 0, 16),
                Position         = state and UDim2.new(1, -19, 0.5, -8) or UDim2.new(0, 3, 0.5, -8),
                BackgroundColor3 = Theme.White,
                BorderSizePixel  = 0,
                Parent           = togglePill,
            })
            AddCorner(toggleKnob, 8)

            local function UpdateToggle()
                Tween(togglePill, FastTween, {
                    BackgroundColor3 = state and Theme.ToggleOn or Theme.ToggleOff,
                })
                Tween(toggleKnob, FastTween, {
                    Position = state
                        and UDim2.new(1, -19, 0.5, -8)
                        or  UDim2.new(0, 3, 0.5, -8),
                })
            end

            -- Interaction
            local toggleBtn = Create("TextButton", {
                Size                   = UDim2.new(1, 0, 1, 0),
                BackgroundTransparency = 1,
                Text                   = "",
                Parent                 = toggleRow,
                ZIndex                 = 5,
            })

            toggleBtn.MouseButton1Click:Connect(function()
                if isPremium then
                    local mousePos = UserInputService:GetMouseLocation()
                    ShowPremiumTooltip(mousePos)
                    task.delay(2, HidePremiumTooltip)
                    return
                end
                state = not state
                UpdateToggle()
                callback(state)
            end)

            -- Hover highlight
            toggleBtn.MouseEnter:Connect(function()
                Tween(toggleRow, FastTween, { BackgroundColor3 = Theme.SecondaryBackground })
            end)
            toggleBtn.MouseLeave:Connect(function()
                Tween(toggleRow, FastTween, { BackgroundColor3 = Theme.ElementBackground })
                if isPremium then HidePremiumTooltip() end
            end)

            -- Config integration
            local toggleObj = {
                Save     = configKey ~= nil,
                GetValue = function() return state end,
                SetValue = function(v)
                    state = v
                    UpdateToggle()
                    callback(state)
                end,
            }
            if configKey then ConfigElements[configKey] = toggleObj end
            return toggleObj
        end

        -- ────────────────────────────────────────────────────────
        -- SLIDER
        -- ────────────────────────────────────────────────────────
        function Tab:AddSlider(sliderOptions)
            sliderOptions = sliderOptions or {}
            local sliderName  = sliderOptions.Name     or "Slider"
            local minVal      = sliderOptions.Min      or 0
            local maxVal      = sliderOptions.Max      or 100
            local defaultVal  = sliderOptions.Default  or minVal
            local suffix      = sliderOptions.Suffix   or ""
            local isPremium   = sliderOptions.Premium  or false
            local configKey   = sliderOptions.Config   or nil
            local callback    = sliderOptions.Callback or function() end

            local currentValue = math.clamp(defaultVal, minVal, maxVal)

            local sliderRow = Create("Frame", {
                Name             = "Slider_" .. sliderName,
                Size             = UDim2.new(1, 0, 0, 52),
                BackgroundColor3 = Theme.ElementBackground,
                BorderSizePixel  = 0,
                Parent           = self.Page,
            })
            AddCorner(sliderRow, 6)
            AddPadding(sliderRow, 6, 6, 10, 10)

            local sliderLabel = Create("TextLabel", {
                Size                   = UDim2.new(0.6, 0, 0, 18),
                BackgroundTransparency = 1,
                Text                   = sliderName,
                TextColor3             = isPremium and Theme.PremiumGold or Theme.TextPrimary,
                TextSize               = 12,
                Font                   = Enum.Font.Gotham,
                TextXAlignment         = Enum.TextXAlignment.Left,
                Parent                 = sliderRow,
            })

            local sliderValueLabel = Create("TextLabel", {
                Size                   = UDim2.new(0.4, 0, 0, 18),
                Position               = UDim2.new(0.6, 0, 0, 0),
                BackgroundTransparency = 1,
                Text                   = tostring(currentValue) .. suffix,
                TextColor3             = Theme.TextSecondary,
                TextSize               = 11,
                Font                   = Enum.Font.Gotham,
                TextXAlignment         = Enum.TextXAlignment.Right,
                Parent                 = sliderRow,
            })

            local sliderTrack = Create("Frame", {
                Name             = "Track",
                Size             = UDim2.new(1, 0, 0, 6),
                Position         = UDim2.new(0, 0, 0, 28),
                BackgroundColor3 = Theme.ToggleOff,
                BorderSizePixel  = 0,
                Parent           = sliderRow,
            })
            AddCorner(sliderTrack, 3)

            local fillPercent = (currentValue - minVal) / (maxVal - minVal)
            local sliderFill = Create("Frame", {
                Name             = "Fill",
                Size             = UDim2.new(fillPercent, 0, 1, 0),
                BackgroundColor3 = Theme.SliderFill,
                BorderSizePixel  = 0,
                Parent           = sliderTrack,
            })
            AddCorner(sliderFill, 3)

            local sliderKnob = Create("Frame", {
                Name             = "Knob",
                Size             = UDim2.new(0, 14, 0, 14),
                Position         = UDim2.new(fillPercent, -7, 0.5, -7),
                BackgroundColor3 = Theme.White,
                BorderSizePixel  = 0,
                Parent           = sliderTrack,
            })
            AddCorner(sliderKnob, 7)
            AddStroke(sliderKnob, Theme.SliderFill, 2, 0)

            -- Draggable logic
            local draggingSlider = false

            local function UpdateSliderFromInput(inputX)
                local trackAbsPos  = sliderTrack.AbsolutePosition.X
                local trackAbsSize = sliderTrack.AbsoluteSize.X
                local ratio = math.clamp((inputX - trackAbsPos) / trackAbsSize, 0, 1)
                local rounded = math.floor(minVal + ratio * (maxVal - minVal) + 0.5)
                currentValue = rounded
                local pct = (rounded - minVal) / (maxVal - minVal)
                Tween(sliderFill, FastTween, { Size = UDim2.new(pct, 0, 1, 0) })
                Tween(sliderKnob, FastTween, { Position = UDim2.new(pct, -7, 0.5, -7) })
                sliderValueLabel.Text = tostring(rounded) .. suffix
                callback(rounded)
            end

            sliderTrack.InputBegan:Connect(function(input)
                if isPremium then
                    local mousePos = UserInputService:GetMouseLocation()
                    ShowPremiumTooltip(mousePos)
                    task.delay(2, HidePremiumTooltip)
                    return
                end
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    draggingSlider = true
                    UpdateSliderFromInput(input.Position.X)
                end
            end)
            UserInputService.InputChanged:Connect(function(input)
                if draggingSlider and input.UserInputType == Enum.UserInputType.MouseMovement then
                    UpdateSliderFromInput(input.Position.X)
                end
            end)
            UserInputService.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    draggingSlider = false
                end
            end)

            sliderRow.MouseEnter:Connect(function()
                Tween(sliderRow, FastTween, { BackgroundColor3 = Theme.SecondaryBackground })
            end)
            sliderRow.MouseLeave:Connect(function()
                Tween(sliderRow, FastTween, { BackgroundColor3 = Theme.ElementBackground })
                if isPremium then HidePremiumTooltip() end
            end)

            local sliderObj = {
                Save     = configKey ~= nil,
                GetValue = function() return currentValue end,
                SetValue = function(v)
                    currentValue = math.clamp(v, minVal, maxVal)
                    local pct = (currentValue - minVal) / (maxVal - minVal)
                    Tween(sliderFill,  FastTween, { Size     = UDim2.new(pct, 0, 1, 0) })
                    Tween(sliderKnob,  FastTween, { Position = UDim2.new(pct, -7, 0.5, -7) })
                    sliderValueLabel.Text = tostring(currentValue) .. suffix
                    callback(currentValue)
                end,
            }
            if configKey then ConfigElements[configKey] = sliderObj end
            return sliderObj
        end

        -- ────────────────────────────────────────────────────────
        -- DROPDOWN
        -- ────────────────────────────────────────────────────────
        function Tab:AddDropdown(dropdownOptions)
            dropdownOptions = dropdownOptions or {}
            local dropdownName = dropdownOptions.Name     or "Dropdown"
            local dropItems    = dropdownOptions.Items    or {}
            local defaultItem  = dropdownOptions.Default  or (dropItems[1] or "Select...")
            local isPremium    = dropdownOptions.Premium  or false
            local configKey    = dropdownOptions.Config   or nil
            local callback     = dropdownOptions.Callback or function() end

            local selectedItem = defaultItem
            local isOpen       = false

            local dropRow = Create("Frame", {
                Name             = "Dropdown_" .. dropdownName,
                Size             = UDim2.new(1, 0, 0, 36),
                BackgroundColor3 = Theme.ElementBackground,
                BorderSizePixel  = 0,
                ClipsDescendants = false,
                Parent           = self.Page,
            })
            AddCorner(dropRow, 6)

            local dropLabel = Create("TextLabel", {
                Size                   = UDim2.new(0.55, 0, 1, 0),
                Position               = UDim2.new(0, 10, 0, 0),
                BackgroundTransparency = 1,
                Text                   = dropdownName,
                TextColor3             = isPremium and Theme.PremiumGold or Theme.TextPrimary,
                TextSize               = 12,
                Font                   = Enum.Font.Gotham,
                TextXAlignment         = Enum.TextXAlignment.Left,
                Parent                 = dropRow,
            })

            local dropValueButton = Create("TextButton", {
                Name                   = "ValueButton",
                Size                   = UDim2.new(0.44, 0, 0, 28),
                Position               = UDim2.new(0.56, -4, 0.5, -14),
                BackgroundColor3       = Theme.SecondaryBackground,
                Text                   = selectedItem,
                TextColor3             = Theme.TextSecondary,
                TextSize               = 11,
                Font                   = Enum.Font.Gotham,
                BorderSizePixel        = 0,
                Parent                 = dropRow,
            })
            AddCorner(dropValueButton, 5)
            AddStroke(dropValueButton, Theme.ElementBorder, 1, 0.4)

            -- Dropdown arrow icon
            local arrowLabel = Create("TextLabel", {
                Size                   = UDim2.new(0, 14, 0, 14),
                Position               = UDim2.new(1, -18, 0.5, -7),
                BackgroundTransparency = 1,
                Text                   = "▼",
                TextColor3             = Theme.TextSecondary,
                TextSize               = 8,
                Font                   = Enum.Font.Gotham,
                Parent                 = dropValueButton,
            })

            -- Dropdown list (appears below)
            local dropList = Create("Frame", {
                Name             = "DropList",
                Size             = UDim2.new(0.44, 0, 0, 0),
                Position         = UDim2.new(0.56, -4, 1, 4),
                BackgroundColor3 = Theme.SecondaryBackground,
                BorderSizePixel  = 0,
                ClipsDescendants = true,
                ZIndex           = 50,
                Visible          = false,
                Parent           = dropRow,
            })
            AddCorner(dropList, 6)
            AddStroke(dropList, Theme.ElementBorder, 1, 0.3)
            AddListLayout(dropList, Enum.FillDirection.Vertical, 2)
            AddPadding(dropList, 4, 4, 4, 4)

            -- Populate list items
            for _, item in ipairs(dropItems) do
                local itemButton = Create("TextButton", {
                    Name                   = "Item_" .. item,
                    Size                   = UDim2.new(1, 0, 0, 26),
                    BackgroundColor3       = Theme.ElementBackground,
                    BackgroundTransparency = 0.5,
                    Text                   = item,
                    TextColor3             = Theme.TextPrimary,
                    TextSize               = 11,
                    Font                   = Enum.Font.Gotham,
                    BorderSizePixel        = 0,
                    ZIndex                 = 51,
                    Parent                 = dropList,
                })
                AddCorner(itemButton, 4)

                itemButton.MouseButton1Click:Connect(function()
                    selectedItem            = item
                    dropValueButton.Text    = item
                    isOpen                  = false
                    dropList.Visible        = false
                    arrowLabel.Text         = "▼"
                    callback(item)
                end)
                itemButton.MouseEnter:Connect(function()
                    Tween(itemButton, FastTween, { BackgroundTransparency = 0 })
                end)
                itemButton.MouseLeave:Connect(function()
                    Tween(itemButton, FastTween, { BackgroundTransparency = 0.5 })
                end)
            end

            dropValueButton.MouseButton1Click:Connect(function()
                if isPremium then
                    local mousePos = UserInputService:GetMouseLocation()
                    ShowPremiumTooltip(mousePos)
                    task.delay(2, HidePremiumTooltip)
                    return
                end
                isOpen = not isOpen
                dropList.Visible = isOpen
                arrowLabel.Text = isOpen and "▲" or "▼"
                if isOpen then
                    local listHeight = math.min(#dropItems * 30, 150)
                    Tween(dropList, FastTween, { Size = UDim2.new(0.44, 0, 0, listHeight) })
                else
                    Tween(dropList, FastTween, { Size = UDim2.new(0.44, 0, 0, 0) })
                end
            end)

            dropRow.MouseEnter:Connect(function()
                Tween(dropRow, FastTween, { BackgroundColor3 = Theme.SecondaryBackground })
            end)
            dropRow.MouseLeave:Connect(function()
                Tween(dropRow, FastTween, { BackgroundColor3 = Theme.ElementBackground })
                if isPremium then HidePremiumTooltip() end
            end)

            local dropObj = {
                Save     = configKey ~= nil,
                GetValue = function() return selectedItem end,
                SetValue = function(v)
                    selectedItem         = v
                    dropValueButton.Text = v
                    callback(v)
                end,
            }
            if configKey then ConfigElements[configKey] = dropObj end
            return dropObj
        end

        -- ────────────────────────────────────────────────────────
        -- COLORPICKER
        -- ────────────────────────────────────────────────────────
        function Tab:AddColorpicker(colorOptions)
            colorOptions = colorOptions or {}
            local pickerName   = colorOptions.Name     or "Color"
            local defaultColor = colorOptions.Default  or Color3.fromRGB(255, 100, 100)
            local isPremium    = colorOptions.Premium  or false
            local configKey    = colorOptions.Config   or nil
            local callback     = colorOptions.Callback or function() end

            local currentColor = defaultColor
            local isOpen       = false

            local colorRow = Create("Frame", {
                Name             = "ColorPicker_" .. pickerName,
                Size             = UDim2.new(1, 0, 0, 36),
                BackgroundColor3 = Theme.ElementBackground,
                BorderSizePixel  = 0,
                Parent           = self.Page,
            })
            AddCorner(colorRow, 6)

            local colorLabel = Create("TextLabel", {
                Size                   = UDim2.new(0.7, 0, 1, 0),
                Position               = UDim2.new(0, 10, 0, 0),
                BackgroundTransparency = 1,
                Text                   = pickerName,
                TextColor3             = isPremium and Theme.PremiumGold or Theme.TextPrimary,
                TextSize               = 12,
                Font                   = Enum.Font.Gotham,
                TextXAlignment         = Enum.TextXAlignment.Left,
                Parent                 = colorRow,
            })

            local colorPreview = Create("TextButton", {
                Name             = "Preview",
                Size             = UDim2.new(0, 34, 0, 22),
                Position         = UDim2.new(1, -44, 0.5, -11),
                BackgroundColor3 = currentColor,
                Text             = "",
                BorderSizePixel  = 0,
                Parent           = colorRow,
            })
            AddCorner(colorPreview, 5)
            AddStroke(colorPreview, Theme.White, 1, 0.6)

            -- Popup picker panel
            local pickerPanel = Create("Frame", {
                Name             = "PickerPanel",
                Size             = UDim2.new(0, 200, 0, 175),
                Position         = UDim2.new(1, 10, 0, 0),
                BackgroundColor3 = Theme.SecondaryBackground,
                BorderSizePixel  = 0,
                Visible          = false,
                ZIndex           = 60,
                Parent           = colorRow,
            })
            AddCorner(pickerPanel, 8)
            AddStroke(pickerPanel, Theme.ElementBorder, 1, 0.3)
            AddPadding(pickerPanel, 8, 8, 8, 8)

            -- RGB sliders inside picker
            local function MakeRGBSlider(label, yPos, defaultVal)
                local sliderLabel = Create("TextLabel", {
                    Size                   = UDim2.new(0, 14, 0, 16),
                    Position               = UDim2.new(0, 0, 0, yPos),
                    BackgroundTransparency = 1,
                    Text                   = label,
                    TextColor3             = Theme.TextSecondary,
                    TextSize              = 11,
                    Font                   = Enum.Font.GothamBold,
                    ZIndex                 = 61,
                    Parent                 = pickerPanel,
                })
                local sliderTrackInner = Create("Frame", {
                    Size             = UDim2.new(1, -60, 0, 5),
                    Position         = UDim2.new(0, 18, 0, yPos + 6),
                    BackgroundColor3 = Theme.ToggleOff,
                    BorderSizePixel  = 0,
                    ZIndex           = 61,
                    Parent           = pickerPanel,
                })
                AddCorner(sliderTrackInner, 2)
                local fillFrac = defaultVal / 255
                local fillInner = Create("Frame", {
                    Size             = UDim2.new(fillFrac, 0, 1, 0),
                    BackgroundColor3 = Theme.Accent,
                    BorderSizePixel  = 0,
                    ZIndex           = 62,
                    Parent           = sliderTrackInner,
                })
                AddCorner(fillInner, 2)
                local valueBox = Create("TextLabel", {
                    Size                   = UDim2.new(0, 36, 0, 16),
                    Position               = UDim2.new(1, -38, 0, yPos),
                    BackgroundTransparency = 1,
                    Text                   = tostring(defaultVal),
                    TextColor3             = Theme.TextPrimary,
                    TextSize               = 11,
                    Font                   = Enum.Font.Gotham,
                    ZIndex                 = 61,
                    Parent                 = pickerPanel,
                })
                return sliderTrackInner, fillInner, valueBox
            end

            local rR, rG, rB = math.floor(currentColor.R * 255), math.floor(currentColor.G * 255), math.floor(currentColor.B * 255)
            local rTrack, rFill, rBox = MakeRGBSlider("R", 4,  rR)
            local gTrack, gFill, gBox = MakeRGBSlider("G", 42, rG)
            local bTrack, bFill, bBox = MakeRGBSlider("B", 80, rB)

            local function RebuildColor()
                currentColor     = Color3.fromRGB(rR, rG, rB)
                colorPreview.BackgroundColor3 = currentColor
                callback(currentColor)
            end

            local function BindRGBDrag(track, fill, box, getter, setter)
                local draggingColor = false
                track.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        draggingColor = true
                    end
                end)
                UserInputService.InputChanged:Connect(function(input)
                    if draggingColor and input.UserInputType == Enum.UserInputType.MouseMovement then
                        local ratio = math.clamp((input.Position.X - track.AbsolutePosition.X) / track.AbsoluteSize.X, 0, 1)
                        local val   = math.floor(ratio * 255)
                        setter(val)
                        box.Text   = tostring(val)
                        fill.Size  = UDim2.new(ratio, 0, 1, 0)
                        RebuildColor()
                    end
                end)
                UserInputService.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        draggingColor = false
                    end
                end)
            end

            BindRGBDrag(rTrack, rFill, rBox, function() return rR end, function(v) rR = v end)
            BindRGBDrag(gTrack, gFill, gBox, function() return rG end, function(v) rG = v end)
            BindRGBDrag(bTrack, bFill, bBox, function() return rB end, function(v) rB = v end)

            colorPreview.MouseButton1Click:Connect(function()
                if isPremium then
                    local mousePos = UserInputService:GetMouseLocation()
                    ShowPremiumTooltip(mousePos)
                    task.delay(2, HidePremiumTooltip)
                    return
                end
                isOpen = not isOpen
                pickerPanel.Visible = isOpen
            end)

            colorRow.MouseEnter:Connect(function()
                Tween(colorRow, FastTween, { BackgroundColor3 = Theme.SecondaryBackground })
            end)
            colorRow.MouseLeave:Connect(function()
                Tween(colorRow, FastTween, { BackgroundColor3 = Theme.ElementBackground })
                if isPremium then HidePremiumTooltip() end
            end)

            local colorObj = {
                Save     = configKey ~= nil,
                GetValue = function()
                    return { R = math.floor(currentColor.R * 255), G = math.floor(currentColor.G * 255), B = math.floor(currentColor.B * 255) }
                end,
                SetValue = function(v)
                    if type(v) == "table" then
                        rR, rG, rB = v.R or 255, v.G or 255, v.B or 255
                    elseif typeof(v) == "Color3" then
                        rR = math.floor(v.R * 255)
                        rG = math.floor(v.G * 255)
                        rB = math.floor(v.B * 255)
                    end
                    RebuildColor()
                end,
                GetColor3 = function()
                    return currentColor
                end,
            }
            if configKey then ConfigElements[configKey] = colorObj end
            return colorObj
        end

        -- ────────────────────────────────────────────────────────
        -- KEYBIND
        -- ────────────────────────────────────────────────────────
        function Tab:AddKeybind(keybindOptions)
            keybindOptions = keybindOptions or {}
            local keybindName = keybindOptions.Name     or "Keybind"
            local defaultKey  = keybindOptions.Default  or Enum.KeyCode.Unknown
            local isPremium   = keybindOptions.Premium  or false
            local configKey   = keybindOptions.Config   or nil
            local callback    = keybindOptions.Callback or function() end

            local boundKey    = defaultKey
            local isListening = false

            local keybindRow = Create("Frame", {
                Name             = "Keybind_" .. keybindName,
                Size             = UDim2.new(1, 0, 0, 36),
                BackgroundColor3 = Theme.ElementBackground,
                BorderSizePixel  = 0,
                Parent           = self.Page,
            })
            AddCorner(keybindRow, 6)

            local keybindLabel = Create("TextLabel", {
                Size                   = UDim2.new(0.6, 0, 1, 0),
                Position               = UDim2.new(0, 10, 0, 0),
                BackgroundTransparency = 1,
                Text                   = keybindName,
                TextColor3             = isPremium and Theme.PremiumGold or Theme.TextPrimary,
                TextSize               = 12,
                Font                   = Enum.Font.Gotham,
                TextXAlignment         = Enum.TextXAlignment.Left,
                Parent                 = keybindRow,
            })

            local keyDisplay = Create("TextButton", {
                Name                   = "KeyDisplay",
                Size                   = UDim2.new(0, 70, 0, 24),
                Position               = UDim2.new(1, -80, 0.5, -12),
                BackgroundColor3       = Theme.SecondaryBackground,
                Text                   = boundKey == Enum.KeyCode.Unknown and "None" or boundKey.Name,
                TextColor3             = Theme.TextSecondary,
                TextSize               = 11,
                Font                   = Enum.Font.GothamBold,
                BorderSizePixel        = 0,
                Parent                 = keybindRow,
            })
            AddCorner(keyDisplay, 5)
            AddStroke(keyDisplay, Theme.ElementBorder, 1, 0.4)

            keyDisplay.MouseButton1Click:Connect(function()
                if isPremium then
                    local mousePos = UserInputService:GetMouseLocation()
                    ShowPremiumTooltip(mousePos)
                    task.delay(2, HidePremiumTooltip)
                    return
                end
                isListening       = true
                keyDisplay.Text   = "..."
                keyDisplay.TextColor3 = Theme.Accent
            end)

            UserInputService.InputBegan:Connect(function(input, processed)
                if isListening and input.UserInputType == Enum.UserInputType.Keyboard then
                    isListening       = false
                    boundKey          = input.KeyCode
                    keyDisplay.Text   = input.KeyCode.Name
                    keyDisplay.TextColor3 = Theme.TextSecondary
                end
                -- Fire callback if key matches while not listening
                if not isListening and input.KeyCode == boundKey and not processed then
                    callback(boundKey)
                end
            end)

            keybindRow.MouseEnter:Connect(function()
                Tween(keybindRow, FastTween, { BackgroundColor3 = Theme.SecondaryBackground })
            end)
            keybindRow.MouseLeave:Connect(function()
                Tween(keybindRow, FastTween, { BackgroundColor3 = Theme.ElementBackground })
                if isPremium then HidePremiumTooltip() end
            end)

            local keybindObj = {
                Save     = configKey ~= nil,
                GetValue = function() return boundKey.Name end,
                SetValue = function(v)
                    local ok, key = pcall(function() return Enum.KeyCode[v] end)
                    if ok and key then
                        boundKey         = key
                        keyDisplay.Text  = key.Name
                    end
                end,
                GetKeyCode = function() return boundKey end,
            }
            if configKey then ConfigElements[configKey] = keybindObj end
            return keybindObj
        end

        -- ────────────────────────────────────────────────────────
        -- TEXT INPUT
        -- ────────────────────────────────────────────────────────
        function Tab:AddTextInput(inputOptions)
            inputOptions = inputOptions or {}
            local inputName    = inputOptions.Name        or "Input"
            local placeholder  = inputOptions.Placeholder or "Enter text..."
            local defaultText  = inputOptions.Default     or ""
            local isPremium    = inputOptions.Premium     or false
            local configKey    = inputOptions.Config      or nil
            local callback     = inputOptions.Callback    or function() end

            local currentText = defaultText

            local inputRow = Create("Frame", {
                Name             = "TextInput_" .. inputName,
                Size             = UDim2.new(1, 0, 0, 36),
                BackgroundColor3 = Theme.ElementBackground,
                BorderSizePixel  = 0,
                Parent           = self.Page,
            })
            AddCorner(inputRow, 6)

            local inputLabel = Create("TextLabel", {
                Size                   = UDim2.new(0.42, 0, 1, 0),
                Position               = UDim2.new(0, 10, 0, 0),
                BackgroundTransparency = 1,
                Text                   = inputName,
                TextColor3             = isPremium and Theme.PremiumGold or Theme.TextPrimary,
                TextSize               = 12,
                Font                   = Enum.Font.Gotham,
                TextXAlignment         = Enum.TextXAlignment.Left,
                Parent                 = inputRow,
            })

            local textBox = Create("TextBox", {
                Name                   = "TextBox",
                Size                   = UDim2.new(0.56, 0, 0, 26),
                Position               = UDim2.new(0.43, 0, 0.5, -13),
                BackgroundColor3       = Theme.SecondaryBackground,
                Text                   = defaultText,
                PlaceholderText        = placeholder,
                PlaceholderColor3      = Theme.TextDisabled,
                TextColor3             = Theme.TextPrimary,
                TextSize               = 11,
                Font                   = Enum.Font.Gotham,
                ClearTextOnFocus       = false,
                BorderSizePixel        = 0,
                Parent                 = inputRow,
            })
            AddCorner(textBox, 5)
            AddStroke(textBox, Theme.ElementBorder, 1, 0.4)
            AddPadding(textBox, 0, 0, 6, 6)

            textBox.Focused:Connect(function()
                if isPremium then
                    textBox:ReleaseFocus()
                    local mousePos = UserInputService:GetMouseLocation()
                    ShowPremiumTooltip(mousePos)
                    task.delay(2, HidePremiumTooltip)
                    return
                end
                Tween(textBox, FastTween, { BackgroundColor3 = Theme.ElementBackground })
                AddStroke(textBox, Theme.Accent, 1, 0.1)
            end)

            textBox.FocusLost:Connect(function(enterPressed)
                currentText = textBox.Text
                Tween(textBox, FastTween, { BackgroundColor3 = Theme.SecondaryBackground })
                AddStroke(textBox, Theme.ElementBorder, 1, 0.4)
                callback(currentText, enterPressed)
            end)

            inputRow.MouseEnter:Connect(function()
                Tween(inputRow, FastTween, { BackgroundColor3 = Theme.SecondaryBackground })
            end)
            inputRow.MouseLeave:Connect(function()
                Tween(inputRow, FastTween, { BackgroundColor3 = Theme.ElementBackground })
                if isPremium then HidePremiumTooltip() end
            end)

            local inputObj = {
                Save     = configKey ~= nil,
                GetValue = function() return currentText end,
                SetValue = function(v)
                    currentText   = tostring(v)
                    textBox.Text  = currentText
                    callback(currentText, false)
                end,
            }
            if configKey then ConfigElements[configKey] = inputObj end
            return inputObj
        end

        -- ────────────────────────────────────────────────────────
        -- BUTTON
        -- ────────────────────────────────────────────────────────
        function Tab:AddButton(buttonOptions)
            buttonOptions = buttonOptions or {}
            local buttonName = buttonOptions.Name     or "Button"
            local isPremium  = buttonOptions.Premium  or false
            local callback   = buttonOptions.Callback or function() end

            local buttonRow = Create("Frame", {
                Name             = "Button_" .. buttonName,
                Size             = UDim2.new(1, 0, 0, 36),
                BackgroundColor3 = Theme.ElementBackground,
                BorderSizePixel  = 0,
                Parent           = self.Page,
            })
            AddCorner(buttonRow, 6)

            local buttonEl = Create("TextButton", {
                Name                   = "Btn",
                Size                   = UDim2.new(1, 0, 1, 0),
                BackgroundTransparency = 1,
                Text                   = buttonName,
                TextColor3             = isPremium and Theme.PremiumGold or Theme.TextPrimary,
                TextSize               = 12,
                Font                   = Enum.Font.GothamBold,
                BorderSizePixel        = 0,
                Parent                 = buttonRow,
            })

            buttonEl.MouseButton1Click:Connect(function()
                if isPremium then
                    local mousePos = UserInputService:GetMouseLocation()
                    ShowPremiumTooltip(mousePos)
                    task.delay(2, HidePremiumTooltip)
                    return
                end
                Tween(buttonRow, FastTween, { BackgroundColor3 = Theme.Accent })
                task.delay(0.15, function()
                    Tween(buttonRow, FastTween, { BackgroundColor3 = Theme.ElementBackground })
                end)
                callback()
            end)

            buttonEl.MouseEnter:Connect(function()
                Tween(buttonRow, FastTween, { BackgroundColor3 = Theme.SecondaryBackground })
            end)
            buttonEl.MouseLeave:Connect(function()
                Tween(buttonRow, FastTween, { BackgroundColor3 = Theme.ElementBackground })
                if isPremium then HidePremiumTooltip() end
            end)
        end

        return Tab
    end

    -- Config shortcuts on Window
    function Window:SaveConfig()
        SaveConfig(self.ConfigName)
    end

    function Window:LoadConfig()
        LoadConfigElements(self.ConfigName)
    end

    -- Entry animation
    mainFrame.BackgroundTransparency = 1
    Tween(mainFrame, SlowTween, { BackgroundTransparency = 0 })

    return Window
end

-- ──────────────────────────────────────────────────────────────────
-- PUBLIC API SURFACE
-- ──────────────────────────────────────────────────────────────────
MengHub.MakeNotify       = MakeNotify
MengHub.Icons            = Icons
MengHub.Theme            = Theme
MengHub.SaveConfig       = SaveConfig
MengHub.LoadConfigFromFile   = LoadConfigFromFile
MengHub.LoadConfigElements   = LoadConfigElements
MengHub.ShowPremiumTooltip   = ShowPremiumTooltip
MengHub.HidePremiumTooltip   = HidePremiumTooltip

-- ──────────────────────────────────────────────────────────────────
-- EXAMPLE USAGE  (remove or guard behind a flag in production)
-- ──────────────────────────────────────────────────────────────────
--[[
local Window = MengHub:CreateWindow({
    Title      = "Meng Hub",
    ConfigName = "myconfig",
    Icon       = "sword",
})

local MainTab = Window:CreateTab({ Name = "Combat", Icon = "sword" })
MainTab:AddSection("Aimbot")

MainTab:AddToggle({
    Name     = "Silent Aim",
    Default  = false,
    Config   = "SilentAim",
    Callback = function(value)
        print("Silent Aim:", value)
    end,
})

MainTab:AddSlider({
    Name     = "FOV",
    Min      = 1,
    Max      = 360,
    Default  = 90,
    Suffix   = "°",
    Config   = "FOV",
    Callback = function(value)
        print("FOV:", value)
    end,
})

MainTab:AddDropdown({
    Name     = "Hitpart",
    Items    = { "Head", "Torso", "HumanoidRootPart" },
    Default  = "Head",
    Config   = "Hitpart",
    Callback = function(value)
        print("Hitpart:", value)
    end,
})

local PremiumTab = Window:CreateTab({ Name = "Premium", Icon = "fish" })
PremiumTab:AddToggle({
    Name    = "Auto Farm",
    Premium = true,
})

-- Notify example
MengHub.MakeNotify({
    Title       = "Meng Hub",
    Description = "Script loaded successfully!",
    Icon        = "alert",
    Type        = "success",
    Duration    = 4,
})
]]

return MengHub
