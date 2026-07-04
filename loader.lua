-- loader.lua

local REPO =
"https://raw.githubusercontent.com/georgiy8/Pilgrammed-modular-utility/main"

local function Import(path)

    local success, result = pcall(function()

        return loadstring(
            game:HttpGet(
                REPO .. "/" .. path
            )
        )()
    end)

    if not success then

        warn(
            "[Pilgrammed Utility] Failed loading:",
            path,
            result
        )

        error(result)
    end

    return result
end

------------------------------------------------------------------
-- Core
------------------------------------------------------------------

local Config = Import("config.lua")

local Core = Import("gui/core.lua")

------------------------------------------------------------------
-- Optional
------------------------------------------------------------------

local UI

pcall(function()
    UI = Import("gui/ui.lua")
end)

------------------------------------------------------------------
-- Modules
------------------------------------------------------------------

local Settings =
    Import("modules/settings.lua")

local Main =
    Import("modules/main.lua")

local Floating =
    Import("modules/floating.lua")

local Fishing =
    Import("modules/fishing.lua")

local Mining =
    Import("modules/mining.lua")

------------------------------------------------------------------
-- Init GUI
------------------------------------------------------------------

Core.Init(Config)

------------------------------------------------------------------
-- Init Modules
------------------------------------------------------------------

Settings.Init(Core, Config)

Main.Init(Core, Config)

Floating.Init(Core, Config)

Fishing.Init(Core, Config)

Mining.Init(Core, Config)

------------------------------------------------------------------
-- Default Tab
------------------------------------------------------------------

task.defer(function()

    if Core.SelectTab then

        if Core.Tabs["Main"] then
            Core.SelectTab("Main")
        end
    end
end)

print("[Pilgrammed Utility] Loaded")



