local FILE_VERSION = "0.0.1"
local BASE_URL =
    "https://raw.githubusercontent.com/nexus-ware/tdx-autostrategy/master/"

---@description - Checks if the version of the script is outdated.
---@return boolean
function checkIfOutdated()
    local remoteVersionResponse = request({
        Url = BASE_URL .. "version.txt",
        Method = "GET"
    })

    local remoteVersion = remoteVersionResponse.Body:gsub('[.]', '')
    local localVersion = FILE_VERSION:gsub('[.]', '')

    local MB_ICON_INFO = 0x00000040
    local MB_OK = 0x00000000

    if tonumber(remoteVersion) and tonumber(localVersion) then
        if tonumber(remoteVersion) > tonumber(FILE_VERSION) then
            return true
        else
            return false
        end
    end
end

---@description Sends a request to get a file.
function getFile(file)
    local response = request({Url = BASE_URL .. file, Method = "GET"})

    return response.Body

end

-- #region Imports
local sendRequest = loadstring(getFile('util/send-request.lua'))()
local orchestrator = loadstring(getFile('modules/orchestrator.lua'))()
local remotes = loadstring(getFile('enums/remotes.lua'))()
local tower = loadstring(getFile('modules/tower.lua'))()
local clientInterfaceBindings = loadstring(getFile(
                                               'enums/client-interface-bindings.lua'))()
local signals = loadstring(getFile('modules/signals.lua'))()

-- #endregion

-- #region Constants

-- Define all globally used variables.

getgenv().__IS_LOBBY = game.PlaceId ~= 11739766412

getgenv().__IS_LOADED = false
getgenv().__ORCHESTRATOR = orchestrator
getgenv().__REMOTES = remotes
getgenv().__UTILS = {SEND_REQUEST = sendRequest}
getgenv().__CLIENT_INTERFACE = clientInterfaceBindings
getgenv().__SIGNALS = signals

-- #endregion

return {Tower = tower}
