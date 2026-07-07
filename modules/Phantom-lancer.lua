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
    -- Main Image
    --------------------------------------------------------
    local success, err = pcall(function()
        Images:AddImage({
            Image = getcustomasset("assets/phantom.jpg"),
            Height = 220,
            AspectRatio = 16/9,
            BackgroundTransparency = 0,
            BackgroundColor = Color3.fromRGB(25, 25, 25)
        })
    end)
    
    if success then
        Images:AddLabel({
            Text = "✅ Image loaded successfully"
        })
    else
        Images:AddLabel({
            Text = "❌ Failed to load image"
        })
        Images:AddLabel({
            Text = "Path: assets/phantom.jpg"
        })
        warn("Image Error:", err)
    end
end
