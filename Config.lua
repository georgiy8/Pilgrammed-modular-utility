-- config.lua
local Config = {}

Config.Version = "4.0 Modular"

Config.Colors = {
    DarkGray = Color3.fromRGB(35, 35, 35),
    MediumGray = Color3.fromRGB(50, 50, 50),
    LightGray = Color3.fromRGB(60, 60, 60),
    Red = Color3.fromRGB(255, 0, 0),
    Green = Color3.fromRGB(0, 255, 0),
    Blue = Color3.fromRGB(0, 100, 255),
    Yellow = Color3.fromRGB(255, 255, 0),
    Purple = Color3.fromRGB(128, 0, 128),
    Orange = Color3.fromRGB(255, 165, 0),
    Pink = Color3.fromRGB(255, 105, 180),
    Cyan = Color3.fromRGB(0, 255, 255),
}

Config.DefaultSettings = {
    color1 = "DarkGray",
    color2 = "Blue",
    gradientEnabled = false,
    gradientRotation = 90,
    guiKey = Enum.KeyCode.RightShift, -- Клавиша для скрытия/показа GUI
}

-- Глобальная переменная для настроек
shared.PilgrammedConfig = Config

return Config
