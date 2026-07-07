#Pilgrammed GUI Library

#Модульная GUI-библиотека для Roblox.

#Структура проекта
gui/

├── init.lua
├── core.lua
├── theme.lua

├── services/
│   ├── drag.lua
│   └── resize.lua

└── widgets/
    ├── registry.lua
    ├── section.lua
    ├── label.lua
    ├── button.lua
    ├── toggle.lua
    ├── slider.lua
    ├── dropdown.lua
    ├── textbox.lua
    ├── separator.lua
    └── keybind.lua
#Подключение библиотеки
local Library = loadstring(game:HttpGet(...))()

local GUI = Library.new()
Создание окна
local Window = GUI:CreateWindow({

    Title = "Pilgrammed Utility"

})

#Доступные параметры

Title
Width
Height

Пример

local Window = GUI:CreateWindow({

    Title = "Pilgrammed Utility",

    Width = 650,

    Height = 420

})
#Создание вкладки
local Main = Window:CreateTab({

    Name = "Main"

})

или

local Combat = Window:CreateTab({

    Name = "Combat"

})

Параметры

Name
Icon (будет использоваться позже)
Создание секции
local Combat = Main:CreateSection({

    Name = "Combat"

})
Виджеты

#Все виджеты добавляются только в Section.

Section:Add...
Label
Combat:AddLabel({

    Text = "Pilgrammed Utility"

})

Параметры

Text
Button
Combat:AddButton({

    Text = "Kill Aura",

    Callback = function()

        print("Clicked")

    end

})

Параметры

Text
Callback
Toggle
Combat:AddToggle({

    Text = "Kill Aura",

    Default = false,

    Callback = function(State)

    end

})

Параметры

Text
Default
Callback

Callback получает

true

или

false
Slider
Combat:AddSlider({

    Text = "Range",

    Min = 0,

    Max = 100,

    Default = 25,

    Increment = 1,

    Callback = function(Value)

    end

})

Параметры

Text
Min
Max
Default
Increment
Callback
Dropdown
Combat:AddDropdown({

    Text = "Target",

    Values = {

        "Head",

        "Torso",

        "Root"

    },

    Default = "Head",

    Callback = function(Value)

    end

})

Параметры

Text
Values
Default
Callback
Textbox
Combat:AddTextbox({

    Text = "Player",

    Placeholder = "Username",

    Callback = function(Text)

    end

})

Параметры

Text
Placeholder
Default
Callback
Separator
Combat:AddSeparator({

    Text = "Visual"

})

или

Combat:AddSeparator()
Keybind
Combat:AddKeybind({

    Text = "Open GUI",

    Default = Enum.KeyCode.RightShift,

    Callback = function()

    end

})

Параметры

Text
Default
Callback
Window API

Скрыть окно

Window:Hide()

Показать окно

Window:Show()

Изменить заголовок

Window:SetTitle("Pilgrammed Utility")

Изменить размер

Window:SetSize(700,500)

Закрыть окно

Window:Close()

Свернуть

Window:Minimize()

Развернуть

Window:Maximize()

Переключить сворачивание

Window:ToggleMinimize()

Полноэкранный режим

Window:ToggleFullscreen()
Создание собственного виджета

Любой виджет находится в

gui/widgets/

#Каждый файл должен возвращать таблицу

local Widget = {}

function Widget.Create(Parent, Settings)

    ...

end

return Widget

После создания файла зарегистрируйте его в

gui/widgets/registry.lua

Например

Widgets.ColorPicker = Import("gui/widgets/colorpicker.lua")

Затем добавьте его в core.lua:

local WidgetMethods = {

    ...

    "ColorPicker"

}

После этого он станет доступен как

Section:AddColorPicker({

})
Полный пример
local Library = loadstring(game:HttpGet(...))()

local GUI = Library.new()

local Window = GUI:CreateWindow({

    Title = "Pilgrammed Utility"

})

local Main = Window:CreateTab({

    Name = "Main"

})

local Combat = Main:CreateSection({

    Name = "Combat"

})

Combat:AddLabel({

    Text = "Pilgrammed Utility"

})

Combat:AddButton({

    Text = "Click",

    Callback = function()

        print("Hello")

    end

})

Combat:AddToggle({

    Text = "Enabled",

    Default = false

})

Combat:AddSlider({

    Text = "Range",

    Min = 0,

    Max = 100,

    Default = 50

})

Combat:AddDropdown({

    Text = "Mode",

    Values = {

        "A",

        "B",

        "C"

    }

})

Combat:AddTextbox({

    Text = "Player"

})

Combat:AddSeparator({

    Text = "Misc"

})

Combat:AddKeybind({

    Text = "Open",

    Default = Enum.KeyCode.RightShift

})
