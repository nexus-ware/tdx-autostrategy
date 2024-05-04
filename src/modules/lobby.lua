local Players = game:GetService("Players")

local Lobby = {}

Lobby.inLobbyElevator = false

function Lobby:IsThereMoreThanOnePlayerInLobby(lobbyText)
    local text = lobbyText:gsub("[/4]", "")
    return tonumber(text) > 1
end

local function JoinLobby(lobbyNumber, apcNumber)
    local Player = Players.LocalPlayer.Character
    Player:PivotTo(workspace['APCs' .. apcNumber][lobbyNumber]['APC'].Detector
                       .CFrame)
    Lobby.inLobbyElevator = true
end

Lobby.elevatorText = ""

function Lobby:SearchForGame(mapName, callback)
    local Lobbies = workspace['APCs']:GetChildren()
    local Lobbies2 = workspace['APCs2']:GetChildren()

    repeat
        for i, lobby in pairs(Lobbies) do
            local LobbyScreen =
                lobby['mapdisplay']:WaitForChild('screen')['displayscreen']
            local Map = LobbyScreen['map'].Text
            if Map == mapName and not Lobby:IsThereMoreThanOnePlayerInLobby(
                lobby['mapdisplay']:WaitForChild('screen')['displayscreen']['plrcount']
                    .Text) then JoinLobby(lobby.Name, "") end

            lobby['mapdisplay']:WaitForChild('screen')['displayscreen']['plrcount']:GetPropertyChangedSignal(
                'Text'):Connect(function()
                if Lobby:IsThereMoreThanOnePlayerInLobby(
                    lobby['mapdisplay']:WaitForChild('screen')['displayscreen']['plrcount']
                        .Text) then Lobby:LeaveLobby() end
            end)
        end

        for i, lobby in pairs(Lobbies2) do
            local LobbyScreen =
                lobby['mapdisplay']:WaitForChild('screen')['displayscreen']
            local Map = LobbyScreen['map'].Text

            Lobby.elevatorText =
                lobby['mapdisplay']:WaitForChild('screen')['displayscreen']['plrcount']
                    .Text

            if Map == mapName and not Lobby:IsThereMoreThanOnePlayerInLobby(
                lobby['mapdisplay']:WaitForChild('screen')['displayscreen']['plrcount']
                    .Text) then JoinLobby(lobby.Name, 2) end

            lobby['mapdisplay']:WaitForChild('screen')['displayscreen']['plrcount']:GetPropertyChangedSignal(
                'Text'):Connect(function()
                if Lobby:IsThereMoreThanOnePlayerInLobby(
                    lobby['mapdisplay']:WaitForChild('screen')['displayscreen']['plrcount']
                        .Text) then Lobby:LeaveLobby() end
            end)
        end
        task.wait(5)
    until Lobby.inLobbyElevator

    callback()

end

return Lobby
