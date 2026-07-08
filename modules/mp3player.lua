--========================================================--
-- Sound Test Module
--========================================================--

return function(Window)
    local Tab = Window:CreateTab({
        Name = "Sound Test",
        Icon = "🎵"
    })
    
    local Section = Tab:CreateSection({
        Name = "Phantom Sounds"
    })
    
    local CurrentSound = nil
    
    Section:AddButton({
        Text = "▶ Play Last Hit",
        Callback = function()
            local path = "assets/Phantom-lancer/Sounds/Plance_lasthit_03_ru.mp3"
            
            print("Loading path:", path)
            
            if CurrentSound then
                CurrentSound:Stop()
            end
            
            CurrentSound = Instance.new("Sound")
            CurrentSound.SoundId = getcustomasset(path)
            CurrentSound.Volume = 0.8
            CurrentSound.Parent = game:GetService("SoundService")
            CurrentSound:Play()
            
            print("Playing sound...")
        end
    })
    
    Section:AddButton({
        Text = "Stop",
        Callback = function()
            if CurrentSound then
                CurrentSound:Stop()
            end
        end
    })
end
