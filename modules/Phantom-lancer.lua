--========================================================--
-- Phantom Lancer Visual Module
--========================================================--

local Players = game:GetService("Players")
local Player = Players.LocalPlayer

return function(Window)
    --------------------------------------------------------
    -- Tab
    --------------------------------------------------------
    local Visual = Window:CreateTab({
        Name = "Phantom Lancer",
        Icon = "⚔️"
    })
    
    --------------------------------------------------------
    -- Images Section
    --------------------------------------------------------
    local Images = Visual:CreateSection({
        Name = "Images"
    })
    
    --------------------------------------------------------
    -- Main Phantom Lancer Image
    --------------------------------------------------------
    Images:AddImage({
        Image = getcustomasset("assets/Phantom-lancer/Images/phantom_lancer_pl.jpg"),
        Height = 220,
        AspectRatio = 16/9,
        BackgroundTransparency = 0,
        BackgroundColor = Color3.fromRGB(25, 25, 25)
    })
    
    --------------------------------------------------------
    -- Info Section
    --------------------------------------------------------
    local Info = Visual:CreateSection({
        Name = "Information"
    })
    
    Info:AddLabel({
        Text = "👤 Phantom Lancer Preview"
    })
    
    Info:AddLabel({
        Text = "✅ Asset loaded from customassets"
    })
    
    Info:AddLabel({
        Text = "Path: assets/Phantom-lancer/Images/phantom_lancer_pl.jpg"
    })
    
end
