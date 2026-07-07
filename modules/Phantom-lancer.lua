--========================================================--
-- Phantom Lancer Test Module
--========================================================--

return function(Window)
    local Visual = Window:CreateTab({
        Name = "Phantom Test",
        Icon = "🧪"
    })
    
    local Section = Visual:CreateSection({
        Name = "Test Image"
    })
    
    -- Прямой тест
    Section:AddLabel({ Text = "Testing getcustomasset..." })
    
    local TestImage = Instance.new("ImageLabel")
    TestImage.Size = UDim2.new(1, -20, 0, 250)
    TestImage.BackgroundTransparency = 0.5
    TestImage.BackgroundColor3 = Color3.fromRGB(40,40,40)
    TestImage.ScaleType = Enum.ScaleType.Fit
    TestImage.Image = getcustomasset("assets/phantom.png")
    TestImage.Parent = Section.Instance  -- или Section.Container если есть
    
    Section:AddLabel({ Text = "If you see the image above - success" })
end
