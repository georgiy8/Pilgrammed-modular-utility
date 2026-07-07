local Module = {}

Module.Name = "Phantom Lancer"
Module.Version = "1.0"
Module.Author = "Legend True"

function Module:Load(UI)

    local Section = UI:AddSection({
        Name = "Phantom Lancer"
    })


    -- Картинка модуля
    Section:AddImage({

        Image = getcustomasset("assets/phantom_lancer.png"),

        Height = 180,

        AspectRatio = 16/9

    })


    -- Описание
    Section:AddLabel({
        Text = "Phantom Lancer module"
    })


    -- Основной переключатель
    Section:AddToggle({

        Name = "Enable Phantom Lancer",

        Default = false,

        Callback = function(value)

            Module.Enabled = value

            if value then
                print("[Phantom Lancer] Enabled")
            else
                print("[Phantom Lancer] Disabled")
            end

        end

    })


    -- Дополнительные настройки
    Section:AddToggle({

        Name = "Auto Mode",

        Default = false,

        Callback = function(value)

            Module.AutoMode = value

        end

    })


    Section:AddSlider({

        Name = "Delay",

        Min = 0,

        Max = 100,

        Default = 10,

        Callback = function(value)

            Module.Delay = value

        end

    })


end


function Module:Unload()

    print("[Phantom Lancer] Unloaded")

end


return Module
