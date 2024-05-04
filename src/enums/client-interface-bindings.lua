local Players = game:GetService('Players')

local InterfaceBindings = {Lobby = {}, Game = {}}

if getgenv().__IS_LOBBY then
    InterfaceBindings.Game = {}
else

    local LocalPlayerInterface = Players.LocalPlayer:WaitForChild('Interface')

    InterfaceBindings.Game = {
        SkipWave = LocalPlayerInterface:WaitForChild('TopAreaQueueFrame')
            :WaitForChild('SkipWaveVoteScreen'),
        GameInfoBar = {
            Base = LocalPlayerInterface:WaitForChild('GameInfoBar'),
            Lives = LocalPlayerInterface:WaitForChild('GameInfoBar')
                :WaitForChild('LivesBar'):WaitForChild('LivesText'),
            Wave = LocalPlayerInterface:WaitForChild('GameInfoBar')
                :WaitForChild('Wave'):WaitForChild('WaveText'),
            Time = LocalPlayerInterface:WaitForChild('GameInfoBar')
                :WaitForChild('TimeLeft'):WaitForChild('TimeLeftText')
        },
        GameOverScreen = LocalPlayerInterface:WaitForChild('GameOverScreen'),
        TowerUI = {Base = LocalPlayerInterface:WaitForChild('TowerUI')},
        BottomBar = {
            Base = LocalPlayerInterface:WaitForChild('BottomBar'),
            -- ['TowersBar'] = Interface:WaitForChild('BottomBar'):WaitForChild('TowersBar'),
            Cash = LocalPlayerInterface:WaitForChild('BottomBar'):WaitForChild(
                'CashFrame'):WaitForChild('Text')
        }
    }
end

return InterfaceBindings
