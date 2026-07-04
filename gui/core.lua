-- gui/core.lua
-- Универсальный каркас окна: создание окна, вкладок, drag/resize, тема оформления.
-- Никакой игровой логики здесь нет и быть не должно — только UI.

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local GuiService = game:GetService("GuiService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local Config = require(script.Parent.Parent.config)

local Core = {}

local zoneGap, titleHeight, bottomHeight = 10, 40, 20
local tabPanelWidth = 120

local guiElements = {}   -- фоновые панели, к которым применяется тема
local tabButtons = {}    -- кнопки вкладок (тоже красятся темой)
local tabs = {}          -- {name, icon, order, button, container}
local tabOrder = 0
local settingsTab = nil
local SETTINGS_ORDER = 9999

local currentSettings = table.clone(Config.DefaultSettings)
Core.Settings = currentSettings

-- ==================== Цвет ====================

local function brightenColor(color, amount)
    amount = amount or 0.2
    local h, s, v = color:ToHSV()
    v = math.clamp(v + amount, 0, 1)
    return Color3.fromHSV(h, s, v)
end
Core.BrightenColor = brightenColor

local function applyColors()
    if currentSettings.gradientEnabled then
        local c1 = brightenColor(Config.Colors[currentSettings.color1], 0.15)
        local c2 = brightenColor(Config.Colors[currentSettings.color2], 0.15)

        for _, elem in ipairs(guiElements) do
            local gradient = elem:FindFirstChildOfClass("UIGradient") or Instance.new("UIGradient")
            gradient.Parent = elem
            gradient.Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0, c1),
                ColorSequenceKeypoint.new(1, c2),
            })
            gradient.Rotation = currentSettings.gradientRotation
        end

        local bc1 = brightenColor(Config.Colors[currentSettings.color1], 0.25)
        local bc2 = brightenColor(Config.Colors[currentSettings.color2], 0.25)
        for _, btn in ipairs(tabButtons) do
            local gradient = btn:FindFirstChildOfClass("UIGradient") or Instance.new("UIGradient")
            gradient.Parent = btn
            gradient.Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0, bc1),
                ColorSequenceKeypoint.new(1, bc2),
            })
            gradient.Rotation = currentSettings.gradientRotation
        end
    else
        for _, elem in ipairs(guiElements) do
            local gradient = elem:FindFirstChildOfClass("UIGradient")
            if gradient then gradient:Destroy() end
            elem.BackgroundColor3 = brightenColor(Config.Colors[currentSettings.color1], 0.15)
        end
        for _, btn in ipairs(tabButtons) do
            local gradient = btn:FindFirstChildOfClass("UIGradient")
            if gradient then gradient:Destroy() end
            btn.BackgroundColor3 = brightenColor(Config.Colors[currentSettings.color1], 0.25)
        end
    end
end
Core.ApplyColors = applyColors

-- ==================== Создание окна ====================

function Core.CreateGUI(guiName)
    local gui = Instance.new("ScreenGui")
    gui.ResetOnSpawn = false
    gui.Name = guiName or "Modular Utility"
    gui.Parent = player:WaitForChild("PlayerGui")

    local mainFrame = Instance.new("Frame", gui)
    mainFrame.Size = UDim2.new(0, 500, 0, 400)
    mainFrame.Position = UDim2.new(0.5, -250, 0.5, -200)
    mainFrame.BackgroundColor3 = Config.Colors.DarkGray
    mainFrame.BorderSizePixel = 0
    Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 6)

    local titleBar = Instance.new("Frame", mainFrame)
    titleBar.Size = UDim2.new(1, -2 * zoneGap, 0, titleHeight)
    titleBar.Position = UDim2.new(0, zoneGap, 0, zoneGap)
    titleBar.BackgroundColor3 = Config.Colors.MediumGray
    titleBar.BorderSizePixel = 0
    titleBar.Active = true
    Instance.new("UICorner", titleBar).CornerRadius = UDim.new(0, 6)

    local titleLabel = Instance.new("TextLabel", titleBar)
    titleLabel.Size = UDim2.new(1, -140, 1, 0)
    titleLabel.Position = UDim2.new(0, 10, 0, 0)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = gui.Name
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextSize = 18
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left

    local tabPanel = Instance.new("ScrollingFrame", mainFrame)
    tabPanel.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    tabPanel.BorderSizePixel = 0
    tabPanel.ScrollBarThickness = 6
    tabPanel.AutomaticCanvasSize = Enum.AutomaticSize.Y
    tabPanel.CanvasSize = UDim2.new(0, 0, 0, 0)
    tabPanel.ScrollingDirection = Enum.ScrollingDirection.Y
    Instance.new("UICorner", tabPanel).CornerRadius = UDim.new(0, 6)

    local tabPadding = Instance.new("UIPadding", tabPanel)
    tabPadding.PaddingLeft = UDim.new(0, 6)
    tabPadding.PaddingRight = UDim.new(0, 6)
    tabPadding.PaddingTop = UDim.new(0, 6)
    tabPadding.PaddingBottom = UDim.new(0, 6)

    local tabLayout = Instance.new("UIListLayout", tabPanel)
    tabLayout.Padding = UDim.new(0, 6)
    tabLayout.SortOrder = Enum.SortOrder.LayoutOrder

    local contentZone = Instance.new("ScrollingFrame", mainFrame)
    contentZone.Name = "ContentZone"
    contentZone.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    contentZone.BorderSizePixel = 0
    contentZone.ScrollBarThickness = 6
    contentZone.AutomaticCanvasSize = Enum.AutomaticSize.Y
    contentZone.CanvasSize = UDim2.new(0, 0, 0, 0)
    contentZone.ScrollingDirection = Enum.ScrollingDirection.Y
    Instance.new("UICorner", contentZone).CornerRadius = UDim.new(0, 6)

    local contentLayout = Instance.new("UIListLayout", contentZone)
    contentLayout.Padding = UDim.new(0, 10)
    contentLayout.SortOrder = Enum.SortOrder.LayoutOrder

    local bottomBar = Instance.new("Frame", mainFrame)
    bottomBar.Size = UDim2.new(1, -2 * zoneGap, 0, bottomHeight)
    bottomBar.Position = UDim2.new(0, zoneGap, 1, -(bottomHeight + zoneGap))
    bottomBar.BackgroundColor3 = Config.Colors.MediumGray
    bottomBar.BorderSizePixel = 0
    Instance.new("UICorner", bottomBar).CornerRadius = UDim.new(0, 6)

    local resizeHandle = Instance.new("Frame", bottomBar)
    resizeHandle.Size = UDim2.new(0, 20, 0, 20)
    resizeHandle.Position = UDim2.new(1, -20, 0, 0)
    resizeHandle.BackgroundColor3 = Config.Colors.LightGray
    resizeHandle.BorderSizePixel = 0
    Instance.new("UICorner", resizeHandle).CornerRadius = UDim.new(0, 4)

    table.insert(guiElements, mainFrame)
    table.insert(guiElements, titleBar)
    table.insert(guiElements, tabPanel)
    table.insert(guiElements, contentZone)
    table.insert(guiElements, bottomBar)

    Core.Gui = gui
    Core.MainFrame = mainFrame
    Core.TitleBar = titleBar
    Core.TabPanel = tabPanel
    Core.ContentZone = contentZone
    Core.ContentLayout = contentLayout
    Core.TabLayout = tabLayout
    Core.BottomBar = bottomBar
    Core.ResizeHandle = resizeHandle

    Core._setupDrag()
    Core._setupResize()
    Core._setupWindowButtons()

    return Core
end

-- ==================== Layout ====================

function Core.UpdateLayout()
    RunService.Heartbeat:Wait()
    local mainFrame = Core.MainFrame
    local mainW, mainH = mainFrame.AbsoluteSize.X, mainFrame.AbsoluteSize.Y
    local leftOffset = tabPanelWidth + zoneGap * 2
    local contentWidth = math.max(0, mainW - leftOffset - zoneGap)
    local contentHeight = math.max(0, mainH - (titleHeight + bottomHeight + zoneGap * 4))

    Core.TabPanel.Size = UDim2.new(0, tabPanelWidth, 0, contentHeight)
    Core.TabPanel.Position = UDim2.new(0, zoneGap, 0, titleHeight + zoneGap * 2)

    Core.ContentZone.Position = UDim2.new(0, leftOffset, 0, titleHeight + zoneGap * 2)
    Core.ContentZone.Size = UDim2.new(0, contentWidth, 0, contentHeight)
    Core.ContentZone.CanvasSize = UDim2.new(0, 0, 0, Core.ContentLayout.AbsoluteContentSize.Y + 20)
    Core.TabPanel.CanvasSize = UDim2.new(0, 0, 0, Core.TabLayout.AbsoluteContentSize.Y + 12)
end

-- ==================== Drag / Resize / Minimize / Maximize ====================

function Core._setupDrag()
    local dragging, dragStart, startPos
    Core.TitleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = Core.MainFrame.Position
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            Core.MainFrame.Position = UDim2.new(
                startPos.X.Scale, startPos.X.Offset + delta.X,
                startPos.Y.Scale, startPos.Y.Offset + delta.Y
            )
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
end

function Core._setupResize()
    local resizing = false
    Core.ResizeHandle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            resizing = true
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            resizing = false
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if resizing and input.UserInputType == Enum.UserInputType.MouseMovement then
            local mouse = UserInputService:GetMouseLocation()
            local inset = GuiService:GetGuiInset()
            local newWidth = math.clamp(mouse.X - Core.MainFrame.AbsolutePosition.X, 300, 1000)
            local newHeight = math.clamp(mouse.Y - Core.MainFrame.AbsolutePosition.Y - inset.Y, 200, 800)
            Core.MainFrame.Size = UDim2.new(0, newWidth, 0, newHeight)
            Core.UpdateLayout()
        end
    end)

    Core.MainFrame:GetPropertyChangedSignal("AbsoluteSize"):Connect(Core.UpdateLayout)
    Core.TabPanel:GetPropertyChangedSignal("AbsoluteSize"):Connect(Core.UpdateLayout)
end

function Core._setupWindowButtons()
    local function createTitleButton(txt, offset, callback)
        local btn = Instance.new("TextButton", Core.TitleBar)
        btn.Size = UDim2.new(0, 30, 0, 30)
        btn.Position = UDim2.new(1, -offset, 0, 5)
        btn.BackgroundColor3 = Config.Colors.LightGray
        btn.Text = txt
        btn.Font = Enum.Font.GothamBold
        btn.TextSize = 18
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.BorderSizePixel = 0
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 4)
        btn.MouseButton1Click:Connect(callback)
        return btn
    end

    -- Плавающая кнопка восстановления после сворачивания
    local restoreGui = Instance.new("ScreenGui")
    restoreGui.ResetOnSpawn = false
    restoreGui.Name = Core.Gui.Name .. "_Restore"
    restoreGui.DisplayOrder = 1000
    restoreGui.Enabled = false
    restoreGui.Parent = player:WaitForChild("PlayerGui")

    local restoreButton = Instance.new("TextButton", restoreGui)
    restoreButton.Size = UDim2.new(0, 100, 0, 40)
    restoreButton.Position = UDim2.new(0, 20, 1, -60)
    restoreButton.BackgroundColor3 = Color3.fromRGB(255, 200, 40)
    restoreButton.Text = "Открыть GUI"
    restoreButton.Font = Enum.Font.GothamBold
    restoreButton.TextSize = 16
    restoreButton.TextColor3 = Color3.fromRGB(0, 0, 0)
    restoreButton.BorderSizePixel = 0
    Instance.new("UICorner", restoreButton).CornerRadius = UDim.new(0, 6)

    restoreButton.MouseButton1Click:Connect(function()
        Core.MainFrame.Visible = true
        restoreGui.Enabled = false
    end)

    local isMaximized = false
    local prevSize, prevPos = Core.MainFrame.Size, Core.MainFrame.Position

    createTitleButton("_", 100, function()
        Core.MainFrame.Visible = false
        restoreGui.Enabled = true
    end)

    createTitleButton("□", 65, function()
        if not isMaximized then
            prevSize, prevPos = Core.MainFrame.Size, Core.MainFrame.Position
            Core.MainFrame.Size = UDim2.new(1, -40, 1, -40)
            Core.MainFrame.Position = UDim2.new(0, 20, 0, 20)
            isMaximized = true
        else
            Core.MainFrame.Size = prevSize
            Core.MainFrame.Position = prevPos
            isMaximized = false
        end
        Core.UpdateLayout()
    end)

    createTitleButton("X", 30, function()
        Core.Gui:Destroy()
        restoreGui:Destroy()
    end)

    Core.RestoreGui = restoreGui
end

-- ==================== Вкладки ====================

-- Полностью показывает выбранную вкладку и прячет остальные
local function selectTab(targetName)
    for _, t in ipairs(tabs) do
        t.container.Visible = (t.name == targetName)
    end
    Core.UpdateLayout()
end

-- name: заголовок вкладки
-- icon: emoji/иконка перед текстом
-- position: (опционально) порядок в списке; "Settings" всегда уходит вниз
function Core.NewTab(name, icon, position)
    local order
    if name == "Settings" then
        order = SETTINGS_ORDER
    elseif position then
        order = position
    else
        tabOrder = tabOrder + 1
        order = tabOrder
    end

    local btn = Instance.new("TextButton", Core.TabPanel)
    btn.Text = (icon and (icon .. " ") or "") .. name
    btn.Size = UDim2.new(1, 0, 0, 28)
    btn.LayoutOrder = order
    btn.BackgroundColor3 = Config.Colors.LightGray
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 16
    btn.BorderSizePixel = 0
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 4)
    table.insert(tabButtons, btn)

    local container = Instance.new("Frame", Core.ContentZone)
    container.Size = UDim2.new(1, 0, 0, 0)
    container.BackgroundTransparency = 1
    container.LayoutOrder = order
    container.AutomaticSize = Enum.AutomaticSize.Y
    container.Visible = false

    local containerLayout = Instance.new("UIListLayout", container)
    containerLayout.Padding = UDim.new(0, 10)
    containerLayout.SortOrder = Enum.SortOrder.LayoutOrder

    local tabData = { name = name, icon = icon, order = order, button = btn, container = container }
    table.insert(tabs, tabData)

    if name == "Settings" then
        settingsTab = tabData
    end

    btn.MouseButton1Click:Connect(function()
        selectTab(name)
    end)

    applyColors()
    return container
end

function Core.SelectTab(name)
    selectTab(name)
end

function Core.ShowDefaultTab()
    if settingsTab then
        selectTab(settingsTab.name)
    elseif tabs[1] then
        selectTab(tabs[1].name)
    end
end

return Core
