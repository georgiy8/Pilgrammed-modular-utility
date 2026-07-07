--========================================================--
-- Phantom Lancer Visual Module
--========================================================--

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
    -- Preload & Show Image
    --------------------------------------------------------
    local AssetPath = "assets/phantom.png"
    
    local success, err = pcall(function()
        local asset = getcustomasset(AssetPath)
        
        Images:AddImage({
            Image = asset,
            Height = 240,
            AspectRatio = 16/9,
            BackgroundTransparency = 0,
            BackgroundColor = Color3.fromRGB(20, 20, 20)
        })
    end)
    
    if success then
        Images:AddLabel({
            Text = "✅ Phantom Lancer loaded successfully"
        })
    else
        Images:AddLabel({
            Text = "❌ Failed to load image"
        })
        Images:AddLabel({
            Text = "Path: " .. AssetPath
        })
        warn("[Phantom Lancer] Asset Error:", err)
    end
    
    --------------------------------------------------------
    -- Info
    --------------------------------------------------------
    local Info = Visual:CreateSection({
        Name = "Info"
    })
    
    Info:AddLabel({ Text = "Make sure phantom.png is in assets folder" })
    Info:AddLabel({ Text = "Use simple filename without spaces or special chars" })
    
end
