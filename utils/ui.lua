-- utils/ui.lua
local UI = {}

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local GuiService = game:GetService("GuiService")

local player = Players.LocalPlayer
local tabs = {}

function UI.CreateMainGui()
    local gui = Instance.new("ScreenGui")
    gui.ResetOnSpawn = false
    gui.Name = "PilgrammedUtility"
    gui.Parent = player:WaitForChild("PlayerGui")

    local mainFrame = Instance.new("Frame", gui)
    mainFrame.Size = UDim2.new(0, 600, 0, 460)
    mainFrame.Position = UDim2.new(0.5, -300, 0.5, -230)
    mainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    mainFrame.BorderSizePixel = 0
    Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 10)

    local titleBar = Instance.new("Frame", mainFrame)
    titleBar.Size = UDim2.new(1, -20, 0, 45)
    titleBar.Position = UDim2.new(0, 10, 0, 10)
    titleBar.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    titleBar.Active = true
    Instance.new("UICorner", titleBar).CornerRadius = UDim.new(0, 8)

    local titleLabel = Instance.new("TextLabel", titleBar)
    titleLabel.Size = UDim2.new(1, -230, 1, 0)
    titleLabel.Position = UDim2.new(0, 15, 0, 0)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = "🛠️ Pilgrammed Utility"
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextSize = 20
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)

    -- Buttons
    local function btn(text, x, callback)
        local b = Instance.new("TextButton", titleBar)
        b.Size = UDim2.new(0, 38, 0, 38)
        b.Position = UDim2.new(1, x, 0, 3)
        b.BackgroundColor3 = Color3.fromRGB(65, 65, 65)
        b.Text = text
        b.TextSize = 22
        b.Font = Enum.Font.GothamBold
        b.TextColor3 = Color3.fromRGB(255, 255, 255)
        Instance.new("UICorner", b).CornerRadius = UDim.new(0, 8)
        b.MouseButton1Click:Connect(callback)
    end

    btn("🔽", -122, function() mainFrame.Visible = false end)
    btn("⛶", -82, function() print("Maximize clicked") end)
    btn("❌", -42, function() gui:Destroy() end)

    local tabPanel = Instance.new("ScrollingFrame", mainFrame)
    tabPanel.Position = UDim2.new(0, 10, 0, 63)
    tabPanel.Size = UDim2.new(0, 140, 1, -80)
    tabPanel.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    Instance.new("UICorner", tabPanel).CornerRadius = UDim.new(0, 8)

    local contentZone = Instance.new("ScrollingFrame", mainFrame)
    contentZone.Position = UDim2.new(0, 160, 0, 63)
    contentZone.Size = UDim2.new(1, -170, 1, -80)
    contentZone.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    Instance.new("UICorner", contentZone).CornerRadius = UDim.new(0, 8)

    UI.MainFrame = mainFrame
    UI.TabPanel = tabPanel
    UI.ContentZone = contentZone
    UI.Tabs = tabs

    print("✅ Simple UI loaded")
    return UI
end

function UI.CreateTab(name, icon, order)
    print("Создаю вкладку: " .. name)
    
    local btn = Instance.new("TextButton", UI.TabPanel)
    btn.Size = UDim2.new(1, 0, 0, 38)
    btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    btn.Text = (icon or "") .. " " .. name
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamSemibold
    btn.TextSize = 16
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)

    local container = Instance.new("Frame", UI.ContentZone)
    container.Size = UDim2.new(1, 0, 0, 0)
    container.BackgroundTransparency = 1
    container.AutomaticSize = Enum.AutomaticSize.Y
    container.Visible = false

    local layout = Instance.new("UIListLayout", container)
    layout.Padding = UDim.new(0, 10)

    btn.MouseButton1Click:Connect(function()
        for _, tab in pairs(UI.Tabs) do
            tab.Container.Visible = false
        end
        container.Visible = true
    end)

    table.insert(UI.Tabs, {Button = btn, Container = container})

    if #UI.Tabs == 1 then
        container.Visible = true
    end

    print("✅ Вкладка " .. name .. " создана")
    return container
end

return UI
