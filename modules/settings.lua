-- modules/settings.lua

local Settings = {}

local Colors = {
    Red = Color3.fromRGB(255, 80, 80),
    Orange = Color3.fromRGB(255, 165, 0),
    Yellow = Color3.fromRGB(255, 255, 0),
    Green = Color3.fromRGB(80, 255, 80),
    Cyan = Color3.fromRGB(0, 255, 255),
    Blue = Color3.fromRGB(80, 120, 255),
    Purple = Color3.fromRGB(180, 80, 255),
    Pink = Color3.fromRGB(255, 105, 180),
    White = Color3.fromRGB(255, 255, 255)
}

local ColorNames = {}
for name in pairs(Colors) do
    table.insert(ColorNames, name)
end

function Settings.Init(Core, Config)
    Config.CurrentSettings = Config.CurrentSettings or {
        color1 = "Blue",
        color2 = "Purple",
        gradientEnabled = false
    }

    Core.CreateTab("Settings", function()
        local title = Core.CreateSection("🎨 Color Settings")

        local function applyTheme()
            local primary = Colors[Config.CurrentSettings.color1]
            local secondary = Colors[Config.CurrentSettings.color2]

            Core.Colors.Accent = primary

            if Config.CurrentSettings.gradientEnabled then
                Core.Colors.Secondary = secondary
            end

            Core.ApplyColors()
        end

        Core.CreateSection("Primary Color")

        for _, colorName in ipairs(ColorNames) do
            Core.CreateButton(colorName, function()
                Config.CurrentSettings.color1 = colorName
                applyTheme()
            end)
        end

        Core.CreateSection("Secondary Color")

        for _, colorName in ipairs(ColorNames) do
            Core.CreateButton(colorName, function()
                Config.CurrentSettings.color2 = colorName
                applyTheme()
            end)
        end

        Core.CreateToggle(
            "Gradient Mode",
            Config.CurrentSettings.gradientEnabled,
            function(state)
                Config.CurrentSettings.gradientEnabled = state
                applyTheme()
            end
        )

        applyTheme()
    end)
end

return Settings
