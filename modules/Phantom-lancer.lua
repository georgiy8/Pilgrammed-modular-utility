--========================================================--
-- Phantom Lancer Module (GitHub Assets)
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
    -- Preview Section
    --------------------------------------------------------
    local Preview = Visual:CreateSection({
        Name = "Preview"
    })
    
    --------------------------------------------------------
    -- Image from GitHub
    --------------------------------------------------------
    local ImageUrl = "https://raw.githubusercontent.com/georgiy8/Pilgrammed-modular-utility/main/assets/phantom.png"
    
    local PhantomImage = Preview:AddImage({
        Image = ImageUrl,
        Height = 300,
        AspectRatio = 16/9,
        BackgroundTransparency = 1
    })
    
    --------------------------------------------------------
    -- Info
    --------------------------------------------------------
    local Info = Visual:CreateSection({
        Name = "Information"
    })
    
    Info:AddLabel({
        Text = "🖼️ Loaded from GitHub Repository"
    })
    
    Info:AddLabel({
        Text = "Path: assets/phantom.png"
    })
    
    Info:AddLabel({
        Text = "Make sure the file is uploaded to the repo"
    })
end
