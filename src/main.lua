local version = "1.0.0"

---@description - Checks if the version of the script is outdated.
---@return boolean
function checkIfOutdated()
    local remoteVersionResponse = request({
        Url = "https://raw.githubusercontent.com/nexus-ware/tdx-autostrategy/master/version.txt",
        Method = "GET"
    })

    local remoteVersion = remoteVersionResponse.Body:gsub('[.]', '')
    local localVersion = version:gsub('[.]', '')

    local MB_ICON_INFO = 0x00000040
    local MB_OK = 0x00000000

    if tonumber(remoteVersion) and tonumber(localVersion) then
        if tonumber(remoteVersion) > tonumber(version) then
            messagebox(
                "Nexus Ware\n Your version of TDX Autostrategy is out of date.",
                "Out of Date", bit32.bor(MB_ICON_INFO, MB_OK))
            return true
        else
            return false
        end
    end
end

