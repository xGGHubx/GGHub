repeat task.wait() until game:IsLoaded()
local function detectExecutor()
    local execName = "Unknown"
    pcall(function()
        if getexecutorname then
            execName = getexecutorname()
        elseif identifyexecutor then
            execName = identifyexecutor()
        end
    end)
    return execName
end
local function isBlacklisted(name)
    local blacklist = { "xeno", "jjsploit" }
    for _, bad in ipairs(blacklist) do
        if name:lower():find(bad) then
            return true
        end
    end
    return false
end
local ScriptManager = {
    Registry = {
        [994732206]  = "Blox%20Fruits/Main.luau",
    },
    GitBase = "https://raw.githubusercontent.com/xGGHubx/GGHubScripts/main/"
}
function ScriptManager:LoadFor(gameId)
    local path = self.Registry[gameId]
    if not path then
        warn("[GGHub] Game not supported:", gameId)
        return
    end
    local fullURL = self.GitBase .. path
    local ok, err = pcall(function()
        loadstring(game:HttpGet(fullURL))()
    end)
    if not ok then
        warn("[GGHub] Failed to load:", err)
    end
end
local exec = detectExecutor()
if isBlacklisted(exec) then
    game.Players.LocalPlayer:Kick(("\n\nExecutor '%s' is not supported."):format(exec))
    return
end
ScriptManager:LoadFor(game.GameId)
