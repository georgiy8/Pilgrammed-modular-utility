--========================================================--
-- MP3 Player Module
--========================================================--

return function(Window)
    local Tab = Window:CreateTab({
        Name = "MP3 Player",
        Icon = "🎵"
    })
    
    local PlayerSection = Tab:CreateSection({
        Name = "Player"
    })
    
    -- Текущий звук
    local CurrentSound = nil
    
    PlayerSection:AddButton({
        Text = "Play Music",
        Callback = function()
            if CurrentSound then
                CurrentSound:Stop()
            end
            
            CurrentSound = Instance.new("Sound")
            CurrentSound.SoundId = getcustomasset("assets\Phantom-lancer\Sounds\Plance_lasthit_03_ru.mp3.mpeg") -- замени на свой файл
            CurrentSound.Volume = 0.6
            CurrentSound.Looped = true
            CurrentSound.Parent = game:GetService("SoundService")
            CurrentSound:Play()
            
            print("Music started")
        end
    })
    
    PlayerSection:AddButton({
        Text = "Pause",
        Callback = function()
            if CurrentSound then
                CurrentSound:Pause()
            end
        end
    })
    
    PlayerSection:AddButton({
        Text = "Stop",
        Callback = function()
            if CurrentSound then
                CurrentSound:Stop()
            end
        end
    })
    
    PlayerSection:AddSlider({
        Text = "Volume",
        Min = 0,
        Max = 1,
        Default = 0.6,
        Increment = 0.05,
        Callback = function(Value)
            if CurrentSound then
                CurrentSound.Volume = Value
            end
        end
    })
    
    PlayerSection:AddToggle({
        Text = "Loop",
        Default = true,
        Callback = function(State)
            if CurrentSound then
                CurrentSound.Looped = State
            end
        end
    })
end
