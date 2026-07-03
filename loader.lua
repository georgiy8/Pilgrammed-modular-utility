-- loader.lua
print("🔄 Запуск теста...")

local UI = loadstring(game:HttpGet("https://raw.githubusercontent.com/georgiy8/Pilgrammed-modular-utility/main/utils/ui.lua", true))()
local guiSystem = UI.CreateMainGui()

print("✅ GUI создан")

-- Прямой тест settings
pcall(function()
    local url = "https://raw.githubusercontent.com/georgiy8/Pilgrammed-modular-utility/main/modules/settings.lua"
    print("Пытаюсь загрузить: " .. url)
    local code = game:HttpGet(url, true)
    print("Код получен, длина: " .. #code)
    local func = loadstring(code)
    func(guiSystem)
    print("✅ Settings загружен успешно!")
end)

print("Тест завершён")
