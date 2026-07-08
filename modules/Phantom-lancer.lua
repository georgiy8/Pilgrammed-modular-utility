--========================================================--
-- Asset Test Module
--========================================================--

return function(Window)

    local Assets = Window.Library.AssetManager

    local Tab = Window:CreateTab({
        Name = "Asset Test",
        Icon = "🖼️"
    })

    local Section = Tab:CreateSection({
        Name = "PNG Test"
    })

    --------------------------------------------------------
    -- Получаем Custom Asset
    --------------------------------------------------------

    local Asset = Assets:Get("phantom.png")

    Section:AddLabel({
        Text = "Asset: " .. tostring(Asset)
    })

    --------------------------------------------------------
    -- Проверяем
    --------------------------------------------------------

    if Asset then

        Section:AddLabel({
            Text = "✅ Asset loaded successfully"
        })

        Section:AddImage({

            Image = Asset,

            Height = 320,

            ScaleType = Enum.ScaleType.Fit

        })

    else

        Section:AddLabel({
            Text = "❌ Failed to load asset"
        })

    end

end
