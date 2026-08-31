--[[
    UILibrary.lua
    Mobile-friendly Roblox UI library
    Features:
      • Sidebar + tabs
      • Button
      • Toggle
      • Slider
      • Dropdown
      • Dragging (mouse + touch)
      • Responsive/mobile layout
      • Icon + background image support

    Usage:
        local Library = loadstring(game:HttpGet("YOUR_RAW_URL/UILibrary.lua"))()

        local Window = Library:CreateWindow({
            Name = "Sacred Hub",
            Icon = "rbxassetid://126146667089048",
            Background = "rbxassetid://120504693781888"
        })

        local Combat = Window:CreateTab("Combat")
        Combat:CreateButton("Test Button", function()
            print("clicked")
        end)

        Combat:CreateToggle("Enabled", false, function(value)
            print("toggle:", value)
        end)

        Combat:CreateSlider("FOV", 0, 180, 90, function(value)
            print("fov:", value)
        end)

        Combat:CreateDropdown("Mode", {"Closest", "FOV", "Random"}, "Closest", function(value)
            print("mode:", value)
        end)
]]

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local LocalPlayer = Players.LocalPlayer

local Library = {}
Library.__index = Library

local Theme = {
    Background = Color3.fromRGB(13, 14, 18),
    Panel = Color3.fromRGB(18, 19, 24),
    Panel2 = Color3.fromRGB(23, 24, 30),
    Stroke = Color3.fromRGB(52, 54, 64),
    Text = Color3.fromRGB(240, 240, 245),
    SubText = Color3.fromRGB(155, 158, 170),
    Accent = Color3.fromRGB(130, 95, 255),
    AccentDark = Color3.fromRGB(88, 62, 190),
    White = Color3.fromRGB(255, 255, 255),
    Black = Color3.fromRGB(0, 0, 0),
}

local function New(className, properties, parent)
    local object = Instance.new(className)
    for property, value in pairs(properties or {}) do
        object[property] = value
    end
    object.Parent = parent
    return object
end

local function Corner(parent, radius)
    return New("UICorner", {
        CornerRadius = UDim.new(0, radius or 8)
    }, parent)
end

local function Stroke(parent, color, transparency)
    return New("UIStroke", {
        Color = color or Theme.Stroke,
        Transparency = transparency or 0,
        Thickness = 1
    }, parent)
end

local function Padding(parent, left, right, top, bottom)
    return New("UIPadding", {
        PaddingLeft = UDim.new(0, left or 0),
        PaddingRight = UDim.new(0, right or 0),
        PaddingTop = UDim.new(0, top or 0),
        PaddingBottom = UDim.new(0, bottom or 0)
    }, parent)
end

local function Tween(object, properties, duration)
    return TweenService:Create(
        object,
        TweenInfo.new(duration or 0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
        properties
    )
end

local function MakeDraggable(handle, target)
    local dragging = false
    local dragStart
    local startPosition
    local connection

    local function update(input)
        local delta = input.Position - dragStart
        target.Position = UDim2.new(
            startPosition.X.Scale,
            startPosition.X.Offset + delta.X,
            startPosition.Y.Scale,
            startPosition.Y.Offset + delta.Y
        )
    end

    handle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then

            dragging = true
            dragStart = input.Position
            startPosition = target.Position

            connection = UserInputService.InputChanged:Connect(function(changed)
                if changed.UserInputType == Enum.UserInputType.MouseMovement
                    or changed.UserInputType == Enum.UserInputType.Touch then
                    if dragging then
                        update(changed)
                    end
                end
            end)

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                    if connection then
                        connection:Disconnect()
                        connection = nil
                    end
                end
            end)
        end
    end)
end

function Library:CreateWindow(config)
    config = config or {}

    local self = setmetatable({}, Library)

    self.Name = config.Name or "UILibrary"
    self.Icon = config.Icon or "rbxassetid://126146667089048"
    self.Background = config.Background or "rbxassetid://120504693781888"
    self.Tabs = {}
    self.CurrentTab = nil

    local playerGui = LocalPlayer:WaitForChild("PlayerGui")

    local old = playerGui:FindFirstChild("UILibrary_" .. self.Name)
    if old then
        old:Destroy()
    end

    self.Gui = New("ScreenGui", {
        Name = "UILibrary_" .. self.Name,
        ResetOnSpawn = false,
        IgnoreGuiInset = true,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    }, playerGui)

    -- Small floating reopen button
    self.OpenButton = New("ImageButton", {
        Name = "OpenButton",
        Size = UDim2.fromOffset(48, 48),
        Position = UDim2.new(0, 18, 0.5, -24),
        BackgroundColor3 = Theme.Panel,
        Image = self.Icon,
        ScaleType = Enum.ScaleType.Crop,
        AutoButtonColor = false,
        Visible = false
    }, self.Gui)
    Corner(self.OpenButton, 12)
    Stroke(self.OpenButton, Theme.Stroke)

    self.OpenButton.MouseButton1Click:Connect(function()
        self.OpenButton.Visible = false
        self.Main.Visible = true
        self.Main.Size = UDim2.fromOffset(0, 0)

        Tween(self.Main, {
            Size = UDim2.new(
                math.clamp(config.WidthScale or 0.84, 0.72, 0.94),
                0,
                math.clamp(config.HeightScale or 0.72, 0.55, 0.88),
                0
            )
        }, 0.3):Play()
    end)

    self.Main = New("Frame", {
        Name = "Main",
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.new(
            math.clamp(config.WidthScale or 0.84, 0.72, 0.94),
            0,
            math.clamp(config.HeightScale or 0.72, 0.55, 0.88),
            0
        ),
        BackgroundColor3 = Theme.Background,
        ClipsDescendants = true
    }, self.Gui)
    Corner(self.Main, 14)
    Stroke(self.Main, Theme.Stroke)

    -- Background image
    self.BackgroundImage = New("ImageLabel", {
        Name = "BackgroundImage",
        Size = UDim2.fromScale(1, 1),
        BackgroundTransparency = 1,
        Image = self.Background,
        ScaleType = Enum.ScaleType.Crop,
        ImageTransparency = config.BackgroundTransparency or 0.78,
        ZIndex = 0
    }, self.Main)

    New("Frame", {
        Name = "Overlay",
        Size = UDim2.fromScale(1, 1),
        BackgroundColor3 = Theme.Black,
        BackgroundTransparency = 0.32,
        BorderSizePixel = 0,
        ZIndex = 1
    }, self.Main)

    -- Top bar
    self.Topbar = New("Frame", {
        Name = "Topbar",
        Size = UDim2.new(1, 0, 0, 58),
        BackgroundColor3 = Theme.Panel,
        BackgroundTransparency = 0.08,
        BorderSizePixel = 0,
        ZIndex = 5
    }, self.Main)

    MakeDraggable(self.Topbar, self.Main)

    self.IconImage = New("ImageLabel", {
        Name = "Icon",
        Size = UDim2.fromOffset(34, 34),
        Position = UDim2.new(0, 14, 0.5, -17),
        BackgroundTransparency = 1,
        Image = self.Icon,
        ScaleType = Enum.ScaleType.Crop,
        ZIndex = 6
    }, self.Topbar)
    Corner(self.IconImage, 9)

    self.Title = New("TextLabel", {
        Name = "Title",
        Size = UDim2.new(1, -150, 1, 0),
        Position = UDim2.new(0, 58, 0, 0),
        BackgroundTransparency = 1,
        Text = self.Name,
        Font = Enum.Font.GothamBold,
        TextSize = 16,
        TextColor3 = Theme.Text,
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 6
    }, self.Topbar)

    self.Close = New("TextButton", {
        Name = "Close",
        Size = UDim2.fromOffset(38, 38),
        Position = UDim2.new(1, -48, 0.5, -19),
        BackgroundColor3 = Theme.Panel2,
        Text = "×",
        Font = Enum.Font.GothamBold,
        TextSize = 24,
        TextColor3 = Theme.SubText,
        AutoButtonColor = false,
        ZIndex = 7
    }, self.Topbar)
    Corner(self.Close, 9)

    self.Close.MouseEnter:Connect(function()
        Tween(self.Close, {TextColor3 = Theme.White}, 0.12):Play()
    end)
    self.Close.MouseLeave:Connect(function()
        Tween(self.Close, {TextColor3 = Theme.SubText}, 0.12):Play()
    end)

    self.Close.MouseButton1Click:Connect(function()
        self.Main.Visible = false
        self.OpenButton.Visible = true
    end)

    self.Minimize = New("TextButton", {
        Name = "Minimize",
        Size = UDim2.fromOffset(38, 38),
        Position = UDim2.new(1, -91, 0.5, -19),
        BackgroundColor3 = Theme.Panel2,
        Text = "−",
        Font = Enum.Font.GothamBold,
        TextSize = 20,
        TextColor3 = Theme.SubText,
        AutoButtonColor = false,
        ZIndex = 7
    }, self.Topbar)
    Corner(self.Minimize, 9)

    self.Minimize.MouseButton1Click:Connect(function()
        local newSize = UDim2.new(1, -110, 0, 58)
        if self.Content.Visible then
            self.Content.Visible = false
            Tween(self.Main, {Size = newSize}, 0.25):Play()
        else
            self.Content.Visible = true
            Tween(self.Main, {
                Size = UDim2.new(
                    math.clamp(config.WidthScale or 0.84, 0.72, 0.94),
                    0,
                    math.clamp(config.HeightScale or 0.72, 0.55, 0.88),
                    0
                )
            }, 0.25):Play()
        end
    end)

    -- Content
    self.Content = New("Frame", {
        Name = "Content",
        Size = UDim2.new(1, 0, 1, -58),
        Position = UDim2.new(0, 0, 0, 58),
        BackgroundTransparency = 1,
        ZIndex = 3
    }, self.Main)

    -- Sidebar
    self.Sidebar = New("Frame", {
        Name = "Sidebar",
        Size = UDim2.new(0, 154, 1, 0),
        BackgroundColor3 = Theme.Panel,
        BackgroundTransparency = 0.04,
        BorderSizePixel = 0,
        ZIndex = 4
    }, self.Content)

    Padding(self.Sidebar, 10, 10, 12, 10)

    self.TabList = New("ScrollingFrame", {
        Name = "TabList",
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ScrollBarThickness = 2,
        ScrollBarImageTransparency = 0.7,
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        CanvasSize = UDim2.new(),
        ZIndex = 5
    }, self.Sidebar)

    New("UIListLayout", {
        Padding = UDim.new(0, 6),
        SortOrder = Enum.SortOrder.LayoutOrder
    }, self.TabList)

    -- Pages container
    self.Pages = New("Frame", {
        Name = "Pages",
        Size = UDim2.new(1, -154, 1, 0),
        Position = UDim2.new(0, 154, 0, 0),
        BackgroundTransparency = 1,
        ZIndex = 4
    }, self.Content)

    -- Mobile adjustment
    local function ApplyResponsive()
        local viewport = workspace.CurrentCamera and workspace.CurrentCamera.ViewportSize
        if not viewport then return end

        if viewport.X < 700 then
            self.Main.Size = UDim2.new(0.94, 0, 0.86, 0)
            self.Sidebar.Size = UDim2.new(0, 112, 1, 0)
            self.Pages.Size = UDim2.new(1, -112, 1, 0)
            self.Pages.Position = UDim2.new(0, 112, 0, 0)
            self.Title.TextSize = 14
        else
            self.Main.Size = UDim2.new(
                math.clamp(config.WidthScale or 0.84, 0.72, 0.94),
                0,
                math.clamp(config.HeightScale or 0.72, 0.55, 0.88),
                0
            )
            self.Sidebar.Size = UDim2.new(0, 154, 1, 0)
            self.Pages.Size = UDim2.new(1, -154, 1, 0)
            self.Pages.Position = UDim2.new(0, 154, 0, 0)
            self.Title.TextSize = 16
        end
    end

    if workspace.CurrentCamera then
        workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(ApplyResponsive)
    end
    ApplyResponsive()

    return self
end

function Library:CreateTab(name)
    local tab = {}
    tab.Name = name
    tab.Library = self
    tab.Elements = {}

    local order = #self.Tabs + 1
    table.insert(self.Tabs, tab)

    tab.Button = New("TextButton", {
        Name = name .. "_Tab",
        Size = UDim2.new(1, 0, 0, 40),
        BackgroundColor3 = Theme.Panel2,
        BackgroundTransparency = 1,
        Text = name,
        Font = Enum.Font.GothamMedium,
        TextSize = 12,
        TextColor3 = Theme.SubText,
        TextXAlignment = Enum.TextXAlignment.Left,
        AutoButtonColor = false,
        LayoutOrder = order,
        ZIndex = 6
    }, self.TabList)
    Corner(tab.Button, 8)
    Padding(tab.Button, 12, 6, 0, 0)

    tab.Page = New("ScrollingFrame", {
        Name = name .. "_Page",
        Size = UDim2.fromScale(1, 1),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ScrollBarThickness = 3,
        ScrollBarImageTransparency = 0.65,
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        CanvasSize = UDim2.new(),
        Visible = false,
        ZIndex = 5
    }, self.Pages)

    Padding(tab.Page, 14, 14, 14, 14)

    New("UIListLayout", {
        Padding = UDim.new(0, 8),
        SortOrder = Enum.SortOrder.LayoutOrder
    }, tab.Page)

    local function Select()
        for _, other in ipairs(self.Tabs) do
            other.Page.Visible = false
            Tween(other.Button, {
                BackgroundTransparency = 1,
                TextColor3 = Theme.SubText
            }, 0.15):Play()
        end

        tab.Page.Visible = true
        Tween(tab.Button, {
            BackgroundTransparency = 0,
            BackgroundColor3 = Theme.AccentDark,
            TextColor3 = Theme.White
        }, 0.15):Play()

        self.CurrentTab = tab
    end

    tab.Button.MouseButton1Click:Connect(Select)

    if not self.CurrentTab then
        Select()
    end

    function tab:CreateSection(title)
        local section = New("TextLabel", {
            Size = UDim2.new(1, 0, 0, 26),
            BackgroundTransparency = 1,
            Text = title,
            Font = Enum.Font.GothamBold,
            TextSize = 12,
            TextColor3 = Theme.Text,
            TextXAlignment = Enum.TextXAlignment.Left,
            LayoutOrder = #self.Elements + 1,
            ZIndex = 6
        }, self.Page)

        table.insert(self.Elements, section)
        return section
    end

    function tab:CreateButton(text, callback)
        local button = New("TextButton", {
            Size = UDim2.new(1, 0, 0, 42),
            BackgroundColor3 = Theme.Panel,
            Text = text,
            Font = Enum.Font.GothamMedium,
            TextSize = 13,
            TextColor3 = Theme.Text,
            AutoButtonColor = false,
            LayoutOrder = #self.Elements + 1,
            ZIndex = 6
        }, self.Page)
        Corner(button, 9)
        Stroke(button, Theme.Stroke)

        button.MouseEnter:Connect(function()
            Tween(button, {BackgroundColor3 = Theme.Panel2}, 0.12):Play()
        end)

        button.MouseLeave:Connect(function()
            Tween(button, {BackgroundColor3 = Theme.Panel}, 0.12):Play()
        end)

        button.MouseButton1Click:Connect(function()
            if typeof(callback) == "function" then
                task.spawn(callback)
            end
        end)

        table.insert(self.Elements, button)
        return button
    end

    function tab:CreateToggle(text, default, callback)
        local state = default == true

        local holder = New("Frame", {
            Size = UDim2.new(1, 0, 0, 48),
            BackgroundColor3 = Theme.Panel,
            LayoutOrder = #self.Elements + 1,
            ZIndex = 6
        }, self.Page)
        Corner(holder, 9)
        Stroke(holder, Theme.Stroke)

        local label = New("TextLabel", {
            Size = UDim2.new(1, -76, 1, 0),
            Position = UDim2.fromOffset(14, 0),
            BackgroundTransparency = 1,
            Text = text,
            Font = Enum.Font.GothamMedium,
            TextSize = 13,
            TextColor3 = Theme.Text,
            TextXAlignment = Enum.TextXAlignment.Left,
            ZIndex = 7
        }, holder)

        local switch = New("TextButton", {
            Size = UDim2.fromOffset(42, 23),
            Position = UDim2.new(1, -56, 0.5, -11),
            BackgroundColor3 = Theme.Panel2,
            Text = "",
            AutoButtonColor = false,
            ZIndex = 7
        }, holder)
        Corner(switch, 12)

        local knob = New("Frame", {
            Size = UDim2.fromOffset(17, 17),
            Position = UDim2.fromOffset(3, 3),
            BackgroundColor3 = Theme.SubText,
            ZIndex = 8
        }, switch)
        Corner(knob, 20)

        local function update(value, fire)
            state = value == true

            Tween(switch, {
                BackgroundColor3 = state and Theme.Accent or Theme.Panel2
            }, 0.15):Play()

            Tween(knob, {
                Position = state
                    and UDim2.new(1, -20, 0, 3)
                    or UDim2.fromOffset(3, 3),
                BackgroundColor3 = state and Theme.White or Theme.SubText
            }, 0.15):Play()

            if fire and typeof(callback) == "function" then
                task.spawn(callback, state)
            end
        end

        switch.MouseButton1Click:Connect(function()
            update(not state, true)
        end)

        update(state, false)

        holder:SetAttribute("Value", state)

        local api = {}
        function api:Set(value)
            update(value, true)
            holder:SetAttribute("Value", state)
        end
        function api:Get()
            return state
        end

        table.insert(self.Elements, holder)
        return api
    end

    function tab:CreateSlider(text, min, max, default, callback)
        min = tonumber(min) or 0
        max = tonumber(max) or 100
        default = math.clamp(tonumber(default) or min, min, max)

        local value = default

        local holder = New("Frame", {
            Size = UDim2.new(1, 0, 0, 62),
            BackgroundColor3 = Theme.Panel,
            LayoutOrder = #self.Elements + 1,
            ZIndex = 6
        }, self.Page)
        Corner(holder, 9)
        Stroke(holder, Theme.Stroke)

        local label = New("TextLabel", {
            Size = UDim2.new(1, -80, 0, 28),
            Position = UDim2.fromOffset(14, 5),
            BackgroundTransparency = 1,
            Text = text,
            Font = Enum.Font.GothamMedium,
            TextSize = 13,
            TextColor3 = Theme.Text,
            TextXAlignment = Enum.TextXAlignment.Left,
            ZIndex = 7
        }, holder)

        local valueLabel = New("TextLabel", {
            Size = UDim2.fromOffset(60, 28),
            Position = UDim2.new(1, -72, 0, 5),
            BackgroundTransparency = 1,
            Text = tostring(value),
            Font = Enum.Font.GothamBold,
            TextSize = 12,
            TextColor3 = Theme.SubText,
            TextXAlignment = Enum.TextXAlignment.Right,
            ZIndex = 7
        }, holder)

        local bar = New("Frame", {
            Size = UDim2.new(1, -28, 0, 6),
            Position = UDim2.fromOffset(14, 42),
            BackgroundColor3 = Theme.Panel2,
            ZIndex = 7
        }, holder)
        Corner(bar, 6)

        local fill = New("Frame", {
            Size = UDim2.new((value - min) / (max - min), 0, 1, 0),
            BackgroundColor3 = Theme.Accent,
            ZIndex = 8
        }, bar)
        Corner(fill, 6)

        local dragging = false

        local function setFromX(x, fire)
            local percent = math.clamp(
                (x - bar.AbsolutePosition.X) / bar.AbsoluteSize.X,
                0,
                1
            )

            value = min + (max - min) * percent
            value = math.floor(value + 0.5)

            fill.Size = UDim2.new(percent, 0, 1, 0)
            valueLabel.Text = tostring(value)

            if fire and typeof(callback) == "function" then
                task.spawn(callback, value)
            end
        end

        bar.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1
                or input.UserInputType == Enum.UserInputType.Touch then

                dragging = true
                setFromX(input.Position.X, true)
            end
        end)

        UserInputService.InputChanged:Connect(function(input)
            if dragging and (
                input.UserInputType == Enum.UserInputType.MouseMovement
                or input.UserInputType == Enum.UserInputType.Touch
            ) then
                setFromX(input.Position.X, true)
            end
        end)

        UserInputService.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1
                or input.UserInputType == Enum.UserInputType.Touch then
                dragging = false
            end
        end)

        local api = {}
        function api:Set(newValue)
            value = math.clamp(tonumber(newValue) or min, min, max)
            local percent = (value - min) / (max - min)
            fill.Size = UDim2.new(percent, 0, 1, 0)
            valueLabel.Text = tostring(math.floor(value + 0.5))

            if typeof(callback) == "function" then
                task.spawn(callback, value)
            end
        end
        function api:Get()
            return value
        end

        table.insert(self.Elements, holder)
        return api
    end

    function tab:CreateDropdown(text, options, default, callback)
        options = options or {}
        local selected = default or options[1] or "Select"

        local holder = New("Frame", {
            Size = UDim2.new(1, 0, 0, 48),
            BackgroundColor3 = Theme.Panel,
            ClipsDescendants = true,
            LayoutOrder = #self.Elements + 1,
            ZIndex = 10
        }, self.Page)
        Corner(holder, 9)
        Stroke(holder, Theme.Stroke)

        local button = New("TextButton", {
            Size = UDim2.new(1, 0, 0, 48),
            BackgroundTransparency = 1,
            Text = "",
            AutoButtonColor = false,
            ZIndex = 11
        }, holder)

        local label = New("TextLabel", {
            Size = UDim2.new(0.52, 0, 1, 0),
            Position = UDim2.fromOffset(14, 0),
            BackgroundTransparency = 1,
            Text = text,
            Font = Enum.Font.GothamMedium,
            TextSize = 13,
            TextColor3 = Theme.Text,
            TextXAlignment = Enum.TextXAlignment.Left,
            ZIndex = 12
        }, button)

        local selectedLabel = New("TextLabel", {
            Size = UDim2.new(0.42, -20, 1, 0),
            Position = UDim2.new(0.58, 0, 0, 0),
            BackgroundTransparency = 1,
            Text = tostring(selected) .. "  ▾",
            Font = Enum.Font.GothamMedium,
            TextSize = 12,
            TextColor3 = Theme.SubText,
            TextXAlignment = Enum.TextXAlignment.Right,
            ZIndex = 12
        }, button)

        local list = New("Frame", {
            Size = UDim2.new(1, -20, 0, math.min(#options * 34, 170)),
            Position = UDim2.fromOffset(10, 50),
            BackgroundColor3 = Theme.Panel2,
            Visible = true,
            ZIndex = 13
        }, holder)
        Corner(list, 8)
        Stroke(list, Theme.Stroke)

        local scroll = New("ScrollingFrame", {
            Size = UDim2.fromScale(1, 1),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            ScrollBarThickness = 2,
            AutomaticCanvasSize = Enum.AutomaticSize.Y,
            CanvasSize = UDim2.new(),
            ZIndex = 14
        }, list)

        New("UIListLayout", {
            Padding = UDim.new(0, 2),
            SortOrder = Enum.SortOrder.LayoutOrder
        }, scroll)

        for index, option in ipairs(options) do
            local optionButton = New("TextButton", {
                Size = UDim2.new(1, -8, 0, 32),
                BackgroundTransparency = 1,
                Text = tostring(option),
                Font = Enum.Font.GothamMedium,
                TextSize = 12,
                TextColor3 = Theme.Text,
                AutoButtonColor = false,
                LayoutOrder = index,
                ZIndex = 15
            }, scroll)
            Corner(optionButton, 6)

            optionButton.MouseButton1Click:Connect(function()
                selected = option
                selectedLabel.Text = tostring(selected) .. "  ▾"

                Tween(holder, {
                    Size = UDim2.new(1, 0, 0, 48)
                }, 0.18):Play()

                if typeof(callback) == "function" then
                    task.spawn(callback, selected)
                end
            end)
        end

        local opened = false

        local function setOpen(value)
            opened = value

            if opened then
                local height = 56 + math.min(#options * 34, 170)
                Tween(holder, {
                    Size = UDim2.new(1, 0, 0, height)
                }, 0.2):Play()
            else
                Tween(holder, {
                    Size = UDim2.new(1, 0, 0, 48)
                }, 0.2):Play()
            end
        end

        button.MouseButton1Click:Connect(function()
            setOpen(not opened)
        end)

        local api = {}
        function api:Set(option)
            selected = option
            selectedLabel.Text = tostring(selected) .. "  ▾"
            if typeof(callback) == "function" then
                task.spawn(callback, selected)
            end
        end
        function api:Get()
            return selected
        end

        table.insert(self.Elements, holder)
        return api
    end

    return tab
end

return Library
