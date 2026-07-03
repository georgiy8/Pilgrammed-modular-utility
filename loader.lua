-- loader.lua
local Players = game:GetService("Players")
local player = Players.LocalPlayer

print("🔄 Pilgrammed Utility Modular Loader")

-- Config
local successConfig, Config = pcall(function()
    return loadstring(game:HttpGet("https://raw.githubusercontent.com/georgiy8/Pilgrammed-modular-utility/main/config.lua", true))()
end)

if not successConfig then
    warn("❌ Ошибка загрузки config.lua")
end

-- UI
local successUI, UI = pcall(function()
    return loadstring(game:HttpGet("https://raw.githubusercontent.com/georgiy8/Pilgrammed-modular-utility/main/utils/ui.lua", true))()
end)

if not successUI then
    warn("❌ Ошибка загрузки ui.lua")
    return
end

local guiSystem = UI.CreateMainGui()
print("✅ GUI создан успешно")

-- Модули
local modules = {"settings"}

for _, moduleName in ipairs(modules) do
    local success, err = pcall(function()
        local url = "https://raw.githubusercontent.com/georgiy8/Pilgrammed-modular-utility/main/modules/" .. moduleName .. ".lua"
        local moduleCode = game:HttpGet(url, true)
        local func = loadstring(moduleCode)
        func(guiSystem)
    end)
    
    if success then
        print("✅ Module loaded: " .. moduleName)
    else
        warn("❌ Failed to load " .. moduleName .. " | Error: " .. tostring(err))
    end
end

print("🎉 Loader finished!")

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
