-- utils/ui.lua
local UI = {}

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local GuiService = game:GetService("GuiService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local Config = shared.PilgrammedConfig or {DefaultSettings = {}}

local zoneGap, titleHeight, bottomHeight = 10, 40, 25
local tabPanelWidth = 135

local guiElements = {}
local tabButtons = {}
local tabs = {}

local function brightenColor(color, amount)
    amount = amount or 0.2
    local h, s, v = color:ToHSV()
    v = math.clamp(v + amount, 0, 1)
    return Color3.fromHSV(h, s, v)
end

function UI.CreateMainGui()
    local gui = Instance.new("ScreenGui")
    gui.ResetOnSpawn = false
    gui.Name = "PilgrammedUtility"
    gui.Parent = player:WaitForChild("PlayerGui")

    local mainFrame = Instance.new("Frame", gui)
    mainFrame.Size = UDim2.new(0, 580, 0, 440)
    mainFrame.Position = UDim2.new(0.5, -290, 0.5, -220)
    mainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    mainFrame.BorderSizePixel = 0
    Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 8)

    -- Title Bar
    local titleBar = Instance.new("Frame", mainFrame)
    titleBar.Size = UDim2.new(1, -2*zoneGap, 0, titleHeight)
    titleBar.Position = UDim2.new(0, zoneGap, 0, zoneGap)
    titleBar.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    titleBar.Active = true
    Instance.new("UICorner", titleBar).CornerRadius = UDim.new(0, 6)

    local titleLabel = Instance.new("TextLabel", titleBar)
    titleLabel.Size = UDim2.new(1, -160, 1, 0)
    titleLabel.Position = UDim2.new(0, 12, 0, 0)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = "Pilgrammed Utility"
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextSize = 18
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left

    -- Title Buttons
    local function createTitleButton(text, posX, callback)
        local btn = Instance.new("TextButton", titleBar)
        btn.Size = UDim2.new(0, 30, 0, 30)
        btn.Position = UDim2.new(1, posX, 0, 5)
        btn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
        btn.Text = text
        btn.Font = Enum.Font.GothamBold
        btn.TextSize = 16
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.BorderSizePixel = 0
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 5)
        btn.MouseButton1Click:Connect(callback)
        return btn
    end

    createTitleButton("–", -70, function()
        mainFrame.Visible = false
        -- Можно добавить кнопку восстановления позже
    end)

    createTitleButton("×", -35, function()
        gui:Destroy()
    end)

    -- Tab Panel
    local tabPanel = Instance.new("ScrollingFrame", mainFrame)
    tabPanel.Name = "TabPanel"
    tabPanel.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    tabPanel.BorderSizePixel = 0
    tabPanel.Position = UDim2.new(0, zoneGap, 0, titleHeight + zoneGap*2)
    tabPanel.Size = UDim2.new(0, tabPanelWidth, 1, -(titleHeight + bottomHeight + zoneGap*4))
    tabPanel.ScrollBarThickness = 6
    tabPanel.AutomaticCanvasSize = Enum.AutomaticSize.Y
    Instance.new("UICorner", tabPanel).CornerRadius = UDim.new(0, 6)

    local tabLayout = Instance.new("UIListLayout", tabPanel)
    tabLayout.Padding = UDim.new(0, 6)
    tabLayout.SortOrder = Enum.SortOrder.LayoutOrder

    -- Content Zone
    local contentZone = Instance.new("ScrollingFrame", mainFrame)
    contentZone.Name = "ContentZone"
    contentZone.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    contentZone.BorderSizePixel = 0
    contentZone.Position = UDim2.new(0, tabPanelWidth + zoneGap*2, 0, titleHeight + zoneGap*2)
    contentZone.Size = UDim2.new(1, -(tabPanelWidth + zoneGap*3), 1, -(titleHeight + bottomHeight + zoneGap*4))
    contentZone.ScrollBarThickness = 6
    contentZone.AutomaticCanvasSize = Enum.AutomaticSize.Y
    Instance.new("UICorner", contentZone).CornerRadius = UDim.new(0, 6)

    local contentLayout = Instance.new("UIListLayout", contentZone)
    contentLayout.Padding = UDim.new(0, 12)
    contentLayout.SortOrder = Enum.SortOrder.LayoutOrder

    -- Сохранение
    UI.MainFrame = mainFrame
    UI.TabPanel = tabPanel
    UI.ContentZone = contentZone
    UI.Tabs = tabs
    UI.Gui = gui

    -- Drag
    local dragging = false
    local dragStart, startPos

    titleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = mainFrame.Position
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
    end)

    print("✅ UI System loaded with title buttons")
    return UI
end

function UI.CreateTab(name, icon, order)
    local tab = { Name = name, Container = nil, Button = nil }

    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 34)
    btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    btn.Text = (icon or "•") .. "  " .. name
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 15
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.BorderSizePixel = 0
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    btn.LayoutOrder = order or #tabs + 1
    btn.Parent = UI.TabPanel

    tab.Button = btn

    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, 0, 0, 0)
    container.BackgroundTransparency = 1
    container.AutomaticSize = Enum.AutomaticSize.Y
    container.Visible = false
    container.LayoutOrder = #tabs + 1
    container.Parent = UI.ContentZone

    Instance.new("UIListLayout", container).Padding = UDim.new(0, 10)

    tab.Container = container

    table.insert(tabs, tab)
    table.insert(tabButtons, btn)

    btn.MouseButton1Click:Connect(function()
        for _, t in ipairs(tabs) do
            t.Container.Visible = false
        end
        container.Visible = true
    end)

    if #tabs == 1 then container.Visible = true end

    return container
end

return UI
