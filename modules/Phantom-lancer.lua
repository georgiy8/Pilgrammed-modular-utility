--========================================================--
-- Phantom Lancer Module
--========================================================--

return function(Window)
    local Visual = Window:CreateTab({
        Name = "Phantom Lancer",
        Icon = "⚔️"
    })
    
    local Preview = Visual:CreateSection({
        Name = "Preview"
    })
    
    local url = "https://raw.githubusercontent.com/georgiy8/Pilgrammed-modular-utility/main/assets/phantom.png"
    
    local success, result = pcall(function()
        return getcustomasset(url)  -- как ты просил
    end)
    
    if success then
        Preview:AddImage({
            Image = result,
            Height = 320,
            AspectRatio = 16/9
        })
    else
        Preview:AddImage({
            Image = url,
            Height = 320,
            AspectRatio = 16/9
        })
    end
end
