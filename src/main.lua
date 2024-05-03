local FILE_VERSION = "0.0.1"
local BETA = false
local BASE_URL = if BETA then "https://raw.githubusercontent.com/nexus-ware/tdx-autostrategy/master/" else "https://raw.githubusercontent.com/nexus-ware/tdx-autostrategy/dev"

---@description - Checks if the version of the script is outdated.
---@return boolean
function checkIfOutdated()
    local remoteVersionResponse = request({
        Url = BASE_URL.."version.txt",
        Method = "GET"
    })

    local remoteVersion = remoteVersionResponse.Body:gsub('[.]', '')
    local localVersion = FILE_VERSION:gsub('[.]', '')

    local MB_ICON_INFO = 0x00000040
    local MB_OK = 0x00000000

    if tonumber(remoteVersion) and tonumber(localVersion) then
        if tonumber(remoteVersion) > tonumber(FILE_VERSION) then
            messagebox(
                "Nexus Ware\n Your version of TDX Autostrategy is out of date.",
                "Out of Date", bit32.bor(MB_ICON_INFO, MB_OK))
            return true
        else
            return false
        end
    end
end

---@description Sends a request to get a file.
function getFile(file) 
    local response = request({
        Url = BASE_URL..file,
        Method = "GET"
    })

    return response.Body

end

--#region Imports
local sendRequest = loadstring(getFile('util/send-request.lua'))()
local orchestrator = loadstring(getFile('modules/orchestrator.lua'))()
local remotes = loadstring(getFile('enums/remotes.lua'))()
local tower = loadstring(getFile('modules/tower.lua'))()



--#endregion