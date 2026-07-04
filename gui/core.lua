-- gui/core.lua

local Core = {}

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

Core.Gui = nil
Core.MainFrame = nil
Core.TabPanel = nil
Core.ContentZone = nil
Core.BottomBar = nil

Core.Tabs = {}
Core.ActiveTab = nil
Core.RegisteredObjects = {}

Core.Colors = {
    Background = Color3.fromRGB(20, 20, 20),
    Secondary = Color3.fromRGB(30, 30, 30),
    Accent = Color3.fromRGB(70, 130, 255),
    Text = Color3.fromRGB(255, 255, 255),
    Border = Color3.fromRGB(60, 60, 60)
}

local dragging = false
local dragInput
local dragStart
local startPos

local function brightenColor(color, amount)
    return Color3.new(
        math.clamp(color.R + amount, 0, 1),
        math.clamp(color.G + amount, 0, 1),
        math.clamp(color.B + amount, 0, 1)
    )
end

function Core.RegisterObject(obj, property, colorKey)
    table.insert(Core.RegisteredObjects, {
        Object = obj,
        Property = property,
        ColorKey = colorKey
    })
end

function Core.ApplyColors()
    for _, item in ipairs(Core.RegisteredObjects) do
        if item.Object and item.Object.Parent then
            local color = Core.Colors[item.ColorKey]

            if color then
                pcall(function()
                    item.Object[item.Property] = color
                end)
            end
        end
    end
end

function Core.ClearContent()
    for _, child in ipairs(Core.ContentZone:GetChildren()) do
        if not child:IsA("UIListLayout") then
            child:Destroy()
        end
    end
end

function Core.SelectTab(tabName)
    local tab = Core.Tabs[tabName]
    if not tab then
        return
    end

    Core.ActiveTab = tabName

    for name, data in pairs(Core.Tabs) do
        if name == tabName then
            data.Button.BackgroundColor3 = brightenColor(Core.Colors.Accent, 0.1)
        else
            data.Button.BackgroundColor3 = Core.Colors.Secondary
        end
    end

    Core.ClearContent()

    if tab.Callback then
        tab.Callback()
    end
end

function Core.CreateTab(tabName, callback)
    local button = Instance.new("TextButton")

    button.Name = tabName
    button.Size = UDim2.new(1, -10, 0, 35)
    button.Text = tabName
    button.Font = Enum.Font.Gotham
    button.TextSize = 14
    button.TextColor3 = Core.Colors.Text
    button.BackgroundColor3 = Core.Colors.Secondary
    button.BorderSizePixel = 0
    button.Parent = Core.TabPanel

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = button

    button.MouseButton1Click:Connect(function()
        Core.SelectTab(tabName)
    end)

    Core.Tabs[tabName] = {
        Button = button,
        Callback = callback
    }

    return button
end

function Core.CreateSection(title)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, -10, 0, 45)
    frame.BackgroundColor3 = Core.Colors.Secondary
    frame.BorderSizePixel = 0
    frame.Parent = Core.ContentZone

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = frame

    local label = Instance.new("TextLabel")
    label.BackgroundTransparency = 1
    label.Size = UDim2.new(1, -10, 1, 0)
    label.Position = UDim2.new(0, 10, 0, 0)
    label.Text = title
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Font = Enum.Font.Gotham
    label.TextSize = 14
    label.TextColor3 = Core.Colors.Text
    label.Parent = frame

    return frame
end

function Core.CreateButton(text, callback)
    local button = Instance.new("TextButton")

    button.Size = UDim2.new(1, -10, 0, 40)
    button.BackgroundColor3 = Core.Colors.Secondary
    button.TextColor3 = Core.Colors.Text
    button.Text = text
    button.Font = Enum.Font.Gotham
    button.TextSize = 14
    button.BorderSizePixel = 0
    button.Parent = Core.ContentZone

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = button

    button.MouseButton1Click:Connect(function()
        if callback then
            callback()
        end
    end)

    return button
end

function Core.CreateToggle(text, defaultValue, callback)
    local state = defaultValue

    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, -10, 0, 40)
    button.BackgroundColor3 = Core.Colors.Secondary
    button.TextColor3 = Core.Colors.Text
    button.Font = Enum.Font.Gotham
    button.TextSize = 14
    button.BorderSizePixel = 0
    button.Parent = Core.ContentZone

    local function update()
        button.Text = string.format(
            "%s [%s]",
            text,
            state and "ON" or "OFF"
        )
    end

    update()

    button.MouseButton1Click:Connect(function()
        state = not state
        update()

        if callback then
            callback(state)
        end
    end)

    return button
end

function Core.Init(Config)
    if PlayerGui:FindFirstChild("PilgrammedUtility") then
        PlayerGui.PilgrammedUtility:Destroy()
    end

    local gui = Instance.new("ScreenGui")
    gui.Name = "PilgrammedUtility"
    gui.ResetOnSpawn = false
    gui.Parent = PlayerGui

    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "MainFrame"
    mainFrame.Size = UDim2.new(0, 700, 0, 500)
    mainFrame.Position = UDim2.new(0.5, -350, 0.5, -250)
    mainFrame.BackgroundColor3 = Core.Colors.Background
    mainFrame.BorderSizePixel = 0
    mainFrame.Parent = gui

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = mainFrame

    local titleBar = Instance.new("Frame")
    titleBar.Size = UDim2.new(1, 0, 0, 40)
    titleBar.BackgroundColor3 = Core.Colors.Secondary
    titleBar.BorderSizePixel = 0
    titleBar.Parent = mainFrame

    local title = Instance.new("TextLabel")
    title.BackgroundTransparency = 1
    title.Size = UDim2.new(1, -10, 1, 0)
    title.Position = UDim2.new(0, 10, 0, 0)
    title.Text = "Pilgrammed Utility"
    title.TextColor3 = Core.Colors.Text
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Font = Enum.Font.GothamBold
    title.TextSize = 16
    title.Parent = titleBar

    local tabPanel = Instance.new("Frame")
    tabPanel.Size = UDim2.new(0, 140, 1, -40)
    tabPanel.Position = UDim2.new(0, 0, 0, 40)
    tabPanel.BackgroundColor3 = Core.Colors.Secondary
    tabPanel.BorderSizePixel = 0
    tabPanel.Parent = mainFrame

    local tabLayout = Instance.new("UIListLayout")
    tabLayout.Padding = UDim.new(0, 5)
    tabLayout.Parent = tabPanel

    local contentZone = Instance.new("ScrollingFrame")
    contentZone.Size = UDim2.new(1, -150, 1, -50)
    contentZone.Position = UDim2.new(0, 145, 0, 45)
    contentZone.BackgroundTransparency = 1
    contentZone.BorderSizePixel = 0
    contentZone.CanvasSize = UDim2.new()
    contentZone.ScrollBarThickness = 4
    contentZone.Parent = mainFrame

    local contentLayout = Instance.new("UIListLayout")
    contentLayout.Padding = UDim.new(0, 5)
    contentLayout.Parent = contentZone

    contentLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        contentZone.CanvasSize = UDim2.new(
            0,
            0,
            0,
            contentLayout.AbsoluteContentSize.Y + 10
        )
    end)

    titleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = mainFrame.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    titleBar.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart

            mainFrame.Position = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )
        end
    end)

    Core.Gui = gui
    Core.MainFrame = mainFrame
    Core.TabPanel = tabPanel
    Core.ContentZone = contentZone

    Core.ApplyColors()
end

return Core
