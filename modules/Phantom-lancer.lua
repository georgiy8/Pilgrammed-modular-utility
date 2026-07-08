return function(Window)
    local Tab = Window:CreateTab({
        Name = "Asset Test",
        Icon = "🖼️"
    })
    
    local Section = Tab:CreateSection({
        Name = "PNG Test"
    })
   
    local path = "assets/Phantom-lancer/Images/phantom.png"
    local AssetId = getcustomasset(path)
   
    Section:AddLabel({
        Text = "Path: " .. path
    })
    Section:AddLabel({
        Text = "AssetId: " .. tostring(AssetId)
    })
   
    if AssetId then
        Section:AddImage({
            Image = AssetId,
            Height = 320,
            AspectRatio = 16/9
        })
        Section:AddLabel({ Text = "✅ Image should appear above" })
    else
        Section:AddLabel({ Text = "❌ getcustomasset returned nil" })
    end

    --------------------------------------------------------
    -- Auto Play Sound when Tab is opened
    --------------------------------------------------------
    local SoundPath = "assets/Phantom-lancer/Sounds/Plance_lasthit_03_ru.mp3"
    
    task.spawn(function()
        task.wait(0.5) -- небольшая задержка
        local sound = Instance.new("Sound")
        sound.SoundId = getcustomasset(SoundPath)
        sound.Volume = 0.7
        sound.Parent = game:GetService("SoundService")
        sound:Play()
        
        print("Auto played sound on tab open")
    end)
end
