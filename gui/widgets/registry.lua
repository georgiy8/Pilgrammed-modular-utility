--========================================================--
-- Pilgrammed GUI Library
-- Widgets Registry
--========================================================--

local REPO = "https://raw.githubusercontent.com/georgiy8/Pilgrammed-modular-utility/main/"

local function Import(path)

    local Success, Result = pcall(function()

        return loadstring(game:HttpGet(REPO .. path))()

    end)

    if not Success then
        error(Result)
    end

    return Result

end

------------------------------------------------------------

local Widgets = {}

------------------------------------------------------------
-- Register Widgets
------------------------------------------------------------

Widgets.label = Import("gui/widgets/label.lua")

Widgets.button = Import("gui/widgets/button.lua")

Widgets.toggle = Import("gui/widgets/toggle.lua")

Widgets.slider = Import("gui/widgets/slider.lua")

Widgets.dropdown = Import("gui/widgets/dropdown.lua")

Widgets.textbox = Import("gui/widgets/textbox.lua")

Widgets.separator = Import("gui/widgets/separator.lua")

Widgets.keybind = Import("gui/widgets/keybind.lua")

Widgets.image = Import("gui/widgets/image.lua")

Widgets.sound = Import("gui/widgets/sound.lua")

------------------------------------------------------------

return Widgets
