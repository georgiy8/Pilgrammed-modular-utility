-- config.lua

local Config = {}

------------------------------------------------------------------
-- Services
------------------------------------------------------------------

Config.Services = {
    Players = game:GetService("Players"),
    RunService = game:GetService("RunService"),
    TweenService = game:GetService("TweenService"),
    UserInputService = game:GetService("UserInputService"),
    GuiService = game:GetService("GuiService"),
    TeleportService = game:GetService("TeleportService"),
    VirtualInputManager = game:GetService("VirtualInputManager")
}

------------------------------------------------------------------
-- Player
------------------------------------------------------------------

Config.Player = Config.Services.Players.LocalPlayer

------------------------------------------------------------------
-- Theme
------------------------------------------------------------------

Config.Theme = {
    Background = Color3.fromRGB(20,20,20),
    Secondary = Color3.fromRGB(30,30,30),
    Accent = Color3.fromRGB(70,130,255),
    Text = Color3.fromRGB(255,255,255),
    Border = Color3.fromRGB(60,60,60)
}

------------------------------------------------------------------
-- Settings
------------------------------------------------------------------

Config.CurrentSettings = {
    color1 = "Blue",
    color2 = "Purple",
    gradientEnabled = false
}

------------------------------------------------------------------
-- Fishing
------------------------------------------------------------------

Config.Fishing = {
    AutoFishing = false,
    AutoRod = false,
    SelectedRod = nil,
    FishCaught = 0
}

------------------------------------------------------------------
-- Mining
------------------------------------------------------------------

Config.Mining = {
    AutoMining = false,
    AutoTool = false,
    SelectedTool = nil,
    Mode = "Teleport",
    SelectedOres = {}
}

------------------------------------------------------------------
-- Floating
------------------------------------------------------------------

Config.Floating = {
    SelectedPart = nil,
    RespawnEnabled = false,
    RespawnPosition = nil
}

return Config
