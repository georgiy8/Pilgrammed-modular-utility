--========================================================--
-- Phantom Lancer Visual Module
--========================================================--

return function(Window)
    local Visual = Window:CreateTab({
        Name = "Phantom Lancer",
        Icon = "⚔️"
    })
    
    local Images = Visual:CreateSection({ Name = "Images" })
    
    -- Фейковый ID + getcustomasset
    local fakeId = "rbxassetid://0"  -- фейк
    local realAsset = getcustomasset("assets/phantom.png")
    
    Images:AddImage({
        Image = realAsset or fakeId,
        Height = 240,
        AspectRatio = 16/9
    })
    
    Images:AddLabel({ Text = "Trying customasset + fallback" })
end
