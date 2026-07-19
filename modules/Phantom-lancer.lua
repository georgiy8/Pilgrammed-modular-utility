return function(Window)

    local Tab = Window:CreateTab({

        Name = "Asset Test",

        Icon = "🖼️"

    })

    local Section = Tab:CreateSection({

        Name = "Image Button Test"

    })

    local ImageAsset = Assets:GetImage("phantom.png")

    local ClickSound = Assets:GetSound("Plance_lasthit_03_ru.mp3")

    Section:AddLabel({

        Text = "Click the image."

    })

    Section:AddImage({

        Image = ImageAsset,

        Height = 320,

        AspectRatio = 16/9,

        Button = true,

        ClickSound = ClickSound,

        OnClick = function()

            print("Image clicked!")

        end,

        OnHover = function()

            print("Mouse entered.")

        end,

        OnLeave = function()

            print("Mouse left.")

        end

    })

end
