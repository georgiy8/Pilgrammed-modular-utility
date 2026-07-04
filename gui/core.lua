-- gui/core.lua
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local GuiService = game:GetService("GuiService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local Config = require(script.Parent.Parent.config)

local Core = {}

local zoneGap, titleHeight, bottomHeight = 10, 40, 20
local tabPanelWidth = 120

local guiElements = {}
local tabButtons = {}
local tabs = {}
local tabOrder = 0
local settingsTab = nil

local currentSettings = table.clone(Config.DefaultSettings)

local function brightenColor(color, amount)
    amount = amount or 0.2
    local h, s, v = color:ToHSV()
    v = math.clamp(v + amount, 0, 1)
    return Color3.fromHSV(h, s, v)
end

local function applyColors()
    if currentSettings.gradientEnabled then
        for _, elem in ipairs(guiElements) do
            local gradient = elem:FindFirstChildOfClass("UIGradient") or Instance.new("UIGradient")
            gradient.Parent = elem
            
            local c1 = brightenColor(Config.Colors[currentSettings.color1], 0.15)
            local c2 = brightenColor(Config.Colors[currentSettings.color2], 0.15)
            
            gradient.Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0, c1),
                ColorSequenceKeypoint.new(1, c2)
            })
            gradient.Rotation = currentSettings.gradientRotation
        end
    else
        for _, elem in ipairs(guiElements) do
            local gradient = elem:FindFirstChildOfClass("UIGradient")
            if gradient then gradient:Destroy() end
            elem.BackgroundColor3 = brightenColor(Config.Colors[currentSettings.color1], 0.15)
        end
    end
end

-- Продолжение gui/core.lua

function Core.CreateGUI()
    local gui = Instance.new("ScreenGui")
    gui.ResetOnSpawn = false
    gui.Name = "Pilgrammed Script by Georgiy/8"
    gui.Parent = player:WaitForChild("PlayerGui")

    local mainFrame = Instance.new("Frame", gui)
    mainFrame.Size = UDim2.new(0, 500, 0, 400)
    mainFrame.Position = UDim2.new(0.5, -250, 0.5, -200)
    mainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    mainFrame.BorderSizePixel = 0
    Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 6)

    local titleBar = Instance.new("Frame", mainFrame)
    titleBar.Size = UDim2.new(1, -2 * zoneGap, 0, titleHeight)
    titleBar.Position = UDim2.new(0, zoneGap, 0, zoneGap)
    titleBar.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    titleBar.BorderSizePixel = 0
    titleBar.Active = true
    Instance.new("UICorner", titleBar).CornerRadius = UDim.new(0, 6)

    local titleLabel = Instance.new("TextLabel", titleBar)
    titleLabel.Size = UDim2.new(1, -140, 1, 0)
    titleLabel.Position = UDim2.new(0, 10, 0, 0)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = "Pilgrammed Script by Georgiy/8"
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextSize = 18
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left

    local tabPanel = Instance.new("ScrollingFrame", mainFrame)
    tabPanel.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    tabPanel.BorderSizePixel = 0
    tabPanel.ScrollBarThickness = 6
    tabPanel.AutomaticCanvasSize = Enum.AutomaticSize.Y
    tabPanel.ScrollingDirection = Enum.ScrollingDirection.Y
    Instance.new("UICorner", tabPanel).CornerRadius = UDim.new(0, 6)

    local contentZone = Instance.new("ScrollingFrame", mainFrame)
    contentZone.Name = "ContentZone"
    contentZone.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    contentZone.BorderSizePixel = 0
    contentZone.ScrollBarThickness = 6
    contentZone.AutomaticCanvasSize = Enum.AutomaticSize.Y
    contentZone.ScrollingDirection = Enum.ScrollingDirection.Y
    Instance.new("UICorner", contentZone).CornerRadius = UDim.new(0, 6)

    local bottomBar = Instance.new("Frame", mainFrame)
    bottomBar.Size = UDim2.new(1, -2 * zoneGap, 0, bottomHeight)
    bottomBar.Position = UDim2.new(0, zoneGap, 1, -(bottomHeight + zoneGap))
    bottomBar.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    bottomBar.BorderSizePixel = 0
    Instance.new("UICorner", bottomBar).CornerRadius = UDim.new(0, 6)

    table.insert(guiElements, mainFrame)
    table.insert(guiElements, titleBar)
    table.insert(guiElements, tabPanel)
    table.insert(guiElements, contentZone)
    table.insert(guiElements, bottomBar)

    Core.MainFrame = mainFrame
    Core.TabPanel = tabPanel
    Core.ContentZone = contentZone
    Core.BottomBar = bottomBar
    Core.Gui = gui

    Core.ApplyColors = applyColors

    return Core
end

-- Продолжение gui/core.lua (Часть 3)

local function updateLayout()
    RunService.Heartbeat:Wait()
    local mainW, mainH = Core.MainFrame.AbsoluteSize.X, Core.MainFrame.AbsoluteSize.Y
    local leftOffset = tabPanelWidth + zoneGap * 2
    local contentWidth = math.max(0, mainW - leftOffset - zoneGap)
    local contentHeight = math.max(0, mainH - (titleHeight + bottomHeight + zoneGap * 4))

    Core.TabPanel.Size = UDim2.new(0, tabPanelWidth, 0, contentHeight)
    Core.TabPanel.Position = UDim2.new(0, zoneGap, 0, titleHeight + zoneGap * 2)
    
    Core.ContentZone.Position = UDim2.new(0, leftOffset, 0, titleHeight + zoneGap * 2)
    Core.ContentZone.Size = UDim2.new(0, contentWidth, 0, contentHeight)
end

-- Drag
local dragging, dragStart, startPos
Core.MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = Core.MainFrame.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        Core.MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
end)

-- Resize
local resizing = false
-- (resize handle code можно добавить позже)

Core.UpdateLayout = updateLayout

function Core.NewTab(name, icon, position)
    local currentOrder = (name == "Settings") and 9999 or (position or (tabOrder = tabOrder + 1))

    local btn = Instance.new("TextButton", Core.TabPanel)
    btn.Text = icon .. " " .. name
    btn.Size = UDim2.new(1, 0, 0, 28)
    btn.LayoutOrder = currentOrder
    btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 16
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 4)

    table.insert(tabButtons, btn)

    local container = Instance.new("Frame", Core.ContentZone)
    container.Size = UDim2.new(1, 0, 0, 0)
    container.BackgroundTransparency = 1
    container.AutomaticSize = Enum.AutomaticSize.Y
    container.Visible = false

    local tabData = {
        name = name,
        button = btn,
        container = container
    }
    table.insert(tabs, tabData)

    btn.MouseButton1Click:Connect(function()
        for _, t in ipairs(tabs) do
            t.container.Visible = false
        end
        container.Visible = true
        Core.UpdateLayout()
    end)

    if name == "Settings" then
        settingsTab = tabData
    end

    return container
end

-- Продолжение gui/core.lua (Часть 4 - финал)

-- Title Buttons
local function createTitleButton(txt, offset, callback)
    local btn = Instance.new("TextButton", Core.MainFrame:FindFirstChildWhichIsA("Frame")) -- titleBar
    btn.Size = UDim2.new(0, 30, 0, 30)
    btn.Position = UDim2.new(1, -offset, 0, 5)
    btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    btn.Text = txt
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 18
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.BorderSizePixel = 0
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 4)
    btn.MouseButton1Click:Connect(callback)
end

-- Minimize, Maximize, Close
createTitleButton("_", 100, function()
    Core.MainFrame.Visible = false
    -- restore logic
end)

createTitleButton("□", 65, function()
    -- maximize logic
end)

createTitleButton("X", 30, function()
    Core.Gui:Destroy()
end)

-- Инициализация
Core.CreateGUI()
Core.ApplyColors()

print("✅ gui/core.lua fully loaded!")
return Core
