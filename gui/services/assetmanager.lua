--========================================================--
-- Pilgrammed GUI Library
-- Asset Manager
--========================================================--

local AssetManager = {}

------------------------------------------------------------
-- Repository
------------------------------------------------------------

local REPO = "https://raw.githubusercontent.com/georgiy8/Pilgrammed-modular-utility/main/assets/"

------------------------------------------------------------
-- Registered Assets
------------------------------------------------------------

AssetManager.Assets = {

    "phantom.png",
    "click.wav",

}

------------------------------------------------------------
-- Create Assets Folder
------------------------------------------------------------

function AssetManager:CreateFolder()

    if not isfolder("assets") then

        makefolder("assets")

        print("[AssetManager] Created assets folder.")

    end

end

------------------------------------------------------------
-- Download Asset
------------------------------------------------------------

function AssetManager:Download(FileName)

    local Url = REPO .. FileName

    local Path = "assets/" .. FileName

    print("[AssetManager] Downloading:", FileName)

    local Success, Data = pcall(function()

        return game:HttpGet(Url)

    end)

    if not Success then

        warn("[AssetManager] Failed to download:", FileName)

        return false

    end

    local WriteSuccess = pcall(function()

        writefile(Path, Data)

    end)

    if not WriteSuccess then

        warn("[AssetManager] Failed to save:", FileName)

        return false

    end

    print("[AssetManager] Saved:", FileName)

    return true

end

------------------------------------------------------------
-- Check Asset
------------------------------------------------------------

function AssetManager:Check(FileName)

    local Path = "assets/" .. FileName

    if isfile(Path) then

        return true

    end

    return self:Download(FileName)

end

------------------------------------------------------------
-- Check All Assets
------------------------------------------------------------

function AssetManager:CheckAll()

    self:CreateFolder()

    for _, FileName in ipairs(self.Assets) do

        self:Check(FileName)

    end

end

------------------------------------------------------------
-- Register Asset
------------------------------------------------------------

function AssetManager:Register(FileName)

    table.insert(self.Assets, FileName)

end

------------------------------------------------------------
-- Get Asset
------------------------------------------------------------

function AssetManager:Get(FileName)

    if self:Check(FileName) then

        return getcustomasset("assets/" .. FileName)

    end

    return nil

end

------------------------------------------------------------
-- Initialize
------------------------------------------------------------

function AssetManager:Init()

    self:CheckAll()

    print("[AssetManager] Ready.")

end

------------------------------------------------------------

return AssetManager
