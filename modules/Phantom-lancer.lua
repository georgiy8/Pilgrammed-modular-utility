--========================================================--
-- Phantom Lancer Module (Debug)
--========================================================--

return function(Window)
    local Visual = Window:CreateTab({
        Name = "Phantom Lancer",
        Icon = "⚔️"
    })
    
    local Preview = Visual:CreateSection({
        Name = "Preview"
    })
    
    local path = "assets/phantom.png"
    
    local asset = getcustomasset(path)
    
    -- Прямое создание
    local ImageLabel = Instance.new("ImageLabel")
    ImageLabel.Name = "PhantomImage"
    ImageLabel.Size = UDim2.new(1, -20, 0, 320)
    ImageLabel.BackgroundTransparency = 1
    ImageLabel.ScaleType = Enum.ScaleType.Fit
    ImageLabel.Image = asset
    ImageLabel.Parent = Preview.Container or Preview.Instance  -- Важно!
    
    Instance.new("UICorner", ImageLabel).CornerRadius = UDim.new(0, 8)
    
    Preview:AddLabel({ Text = "Прямая ImageLabel" })
    Preview:AddLabel({ Text = "Asset: " .. tostring(asset) })
end
