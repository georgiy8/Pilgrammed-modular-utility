--========================================================--
-- Pilgrammed GUI Library
-- Sound Widget
--========================================================--

local Sound = {}
Sound.__index = Sound

function Sound.Create(Parent, Settings)
    Settings = Settings or {}
    local self = setmetatable({}, Sound)
    
    self.Sound = Instance.new("Sound")
    self.Sound.SoundId = Settings.SoundId or ""
    self.Sound.Volume = Settings.Volume or 0.5
    self.Sound.PlaybackSpeed = Settings.Speed or 1
    self.Sound.Looped = Settings.Looped or false
    self.Sound.Parent = game:GetService("SoundService")
    
    self.IsPlaying = false
    
    return self
end

function Sound:Play()
    if self.Sound then
        self.Sound:Play()
        self.IsPlaying = true
    end
end

function Sound:Pause()
    if self.Sound then
        self.Sound:Pause()
        self.IsPlaying = false
    end
end

function Sound:Stop()
    if self.Sound then
        self.Sound:Stop()
        self.IsPlaying = false
    end
end

function Sound:SetVolume(Volume)
    if self.Sound then
        self.Sound.Volume = Volume
    end
end

function Sound:SetPlaybackSpeed(Speed)
    if self.Sound then
        self.Sound.PlaybackSpeed = Speed
    end
end

function Sound:SetLooped(Looped)
    if self.Sound then
        self.Sound.Looped = Looped
    end
end

function Sound:Destroy()
    if self.Sound then
        self.Sound:Destroy()
    end
end

return Sound
