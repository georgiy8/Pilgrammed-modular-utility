local guiSystem = UI.CreateMainGui()
print("✅ GUI создан успешно")

-- ТЕСТОВАЯ ВКЛАДКА ПРЯМО ЗДЕСЬ
local testTab = guiSystem.CreateTab("Test Tab", "🧪", 1)

local label = Instance.new("TextLabel")
label.Size = UDim2.new(1, -40, 0, 100)
label.Position = UDim2.new(0, 20, 0, 20)
label.BackgroundTransparency = 1
label.Text = "Если ты это видишь — CreateTab работает!\n\nSettings модуль загружен, но вкладка не появляется."
label.TextColor3 = Color3.fromRGB(0, 255, 100)
label.TextSize = 18
label.Font = Enum.Font.GothamBold
label.TextWrapped = true
label.Parent = testTab.Container

print("✅ Тестовая вкладка добавлена")
