-- gui/ui.lua
-- Готовые UI-компоненты поверх Core: кнопки, тоггл-кнопки, лейблы, панели.
-- Модули функций (fishing/mining/floating/...) собирают свои вкладки из этих кубиков.

local Config = require(script.Parent.Parent.config)
local Core = require(script.Parent.core)

local UI = {}

-- ---------- базовые элементы ----------

-- Заголовок вкладки/секции
function UI.CreateSectionTitle(parent, text, layoutOrder)
    local label = Instance.new("TextLabel", parent)
    label.Size = UDim2.new(1, -20, 0, 30)
    label.BackgroundTransparency = 1
    label.Text = text
    label.Font = Enum.Font.GothamBold
    label.TextSize = 20
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.LayoutOrder = layoutOrder or 0
    return label
end

-- Обычный лейбл с текстом (например, для строки статуса/информации)
function UI.CreateLabel(parent, text, layoutOrder)
    local label = Instance.new("TextLabel", parent)
    label.Size = UDim2.new(1, -20, 0, 25)
    label.BackgroundTransparency = 1
    label.Text = text
    label.Font = Enum.Font.Gotham
    label.TextSize = 14
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.LayoutOrder = layoutOrder or 0
    return label
end

-- Панель-контейнер с закруглёнными углами (для группировки контролов)
function UI.CreatePanel(parent, height, layoutOrder)
    local frame = Instance.new("Frame", parent)
    frame.Size = UDim2.new(1, -20, 0, height or 100)
    frame.BackgroundColor3 = Config.Colors.MediumGray
    frame.BorderSizePixel = 0
    frame.LayoutOrder = layoutOrder or 0
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 6)
    return frame
end

-- Простая кнопка с колбэком
function UI.CreateButton(parent, text, layoutOrder, onClick)
    local btn = Instance.new("TextButton", parent)
    btn.Size = UDim2.new(1, -20, 0, 40)
    btn.BackgroundColor3 = Config.Colors.LightGray
    btn.Text = text
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 16
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.BorderSizePixel = 0
    btn.LayoutOrder = layoutOrder or 0
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    if onClick then
        btn.MouseButton1Click:Connect(onClick)
    end
    return btn
end

-- Кнопка-переключатель (ON/OFF), сама следит за своим состоянием и красится.
-- onLabel/offLabel — текст в состоянии вкл/выкл, onToggle(state) вызывается при клике.
function UI.CreateToggleButton(parent, offLabel, onLabel, layoutOrder, onToggle)
    local state = false
    local btn = Instance.new("TextButton", parent)
    btn.Size = UDim2.new(1, -20, 0, 40)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 16
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.BorderSizePixel = 0
    btn.LayoutOrder = layoutOrder or 0
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)

    local function render()
        btn.Text = state and ("🟢 " .. onLabel) or ("🔴 " .. offLabel)
        btn.BackgroundColor3 = state and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(200, 50, 50)
    end
    render()

    btn.MouseButton1Click:Connect(function()
        state = not state
        render()
        if onToggle then
            onToggle(state)
        end
    end)

    return btn, function(newState) -- второй возврат: программно выставить состояние
        state = newState
        render()
    end
end

-- ---------- Панель настроек темы (цвет/градиент) ----------
-- Строит содержимое вкладки "Settings" целиком. Возвращает контейнер.
function UI.CreateSettingsTab()
    local container = Core.NewTab("Settings", "⚙️")
    local padding = Instance.new("UIPadding", container)
    padding.PaddingLeft = UDim.new(0, 10)
    padding.PaddingRight = UDim.new(0, 10)
    padding.PaddingTop = UDim.new(0, 10)

    UI.CreateSectionTitle(container, "🎨 Color Settings", 1)

    local function buildColorPanel(title, settingKey, layoutOrder, onPick)
        local panel = UI.CreatePanel(container, 200, layoutOrder)

        local panelTitle = Instance.new("TextLabel", panel)
        panelTitle.Size = UDim2.new(1, -20, 0, 25)
        panelTitle.Position = UDim2.new(0, 10, 0, 10)
        panelTitle.BackgroundTransparency = 1
        panelTitle.Text = title
        panelTitle.Font = Enum.Font.GothamBold
        panelTitle.TextSize = 16
        panelTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
        panelTitle.TextXAlignment = Enum.TextXAlignment.Left

        local grid = Instance.new("Frame", panel)
        grid.Size = UDim2.new(1, -20, 0, 155)
        grid.Position = UDim2.new(0, 10, 0, 40)
        grid.BackgroundTransparency = 1

        local gridLayout = Instance.new("UIGridLayout", grid)
        gridLayout.CellSize = UDim2.new(0, 45, 0, 45)
        gridLayout.CellPadding = UDim2.new(0, 5, 0, 5)

        local swatches = {}
        for _, colorName in ipairs(Config.ColorNames) do
            local swatch = Instance.new("TextButton", grid)
            swatch.BackgroundColor3 = Config.Colors[colorName]
            swatch.Text = ""
            swatch.BorderSizePixel = (Core.Settings[settingKey] == colorName) and 4 or 2
            swatch.BorderColor3 = Color3.fromRGB(255, 255, 255)
            swatch.BorderMode = Enum.BorderMode.Inset
            Instance.new("UICorner", swatch).CornerRadius = UDim.new(0, 6)
            swatches[colorName] = swatch

            swatch.MouseButton1Click:Connect(function()
                for _, s in pairs(swatches) do s.BorderSizePixel = 2 end
                swatch.BorderSizePixel = 4
                Core.Settings[settingKey] = colorName
                if onPick then onPick() end
            end)
        end

        return panel
    end

    buildColorPanel("Primary Color", "color1", 2, function()
        Core.ApplyColors()
    end)

    buildColorPanel("Secondary Color (Gradient)", "color2", 3, function()
        if Core.Settings.gradientEnabled then
            Core.ApplyColors()
        end
    end)

    UI.CreateToggleButton(container, "Gradient Mode: OFF", "Gradient Mode: ON", 4, function(state)
        Core.Settings.gradientEnabled = state
        Core.ApplyColors()
    end)

    return container
end

return UI
