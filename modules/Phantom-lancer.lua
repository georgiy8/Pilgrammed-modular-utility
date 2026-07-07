--========================================================--
-- Phantom Lancer Module
--========================================================--

return function(Window)

    --------------------------------------------------------
    -- Tab
    --------------------------------------------------------

    local Phantom = Window:CreateTab({

        Name = "Phantom Lancer"

    })

    --------------------------------------------------------
    -- Image Section
    --------------------------------------------------------

    local ImageSection = Phantom:CreateSection({

        Name = "Phantom Lancer"

    })


    ImageSection:AddImage({

        Image = "assets/phantom.png",

        AspectRatio = 1

    })

end
