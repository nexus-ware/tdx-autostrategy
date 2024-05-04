local ReplicatedStorage = game:GetService('ReplicatedStorage')

---@type Folder
local BaseFolder = ReplicatedStorage:WaitForChild('Remotes')

local Remotes = {}

if getgenv().__IS_LOBBY then
    Remotes = {}
else
    Remotes = {
        Tower = {
            ---@type RemoteFunction
            Place = BaseFolder:WaitForChild('PlaceTower'),
            ---@type RemoteEvent
            Upgrade = BaseFolder:WaitForChild('TowerUpgradeRequest'),
            ---@type RemoteEvent
            Sell = BaseFolder:WaitForChild('SellTower'),
            ---@type RemoteFunction
            UseAbility = BaseFolder:WaitForChild('TowerUseAbilityRequest'),
            ---@type RemoteEvent
            ChangeTarget = BaseFolder:WaitForChild('ChangeQueryType')
        },
        Interface = {
            ---@type RemoteEvent
            ToggleSpeedup = BaseFolder:WaitForChild('ToggleSpeedupTier1'),
            ---@type RemoteEvent
            SkipWave = BaseFolder:WaitForChild('SkipWaveVoteCast'),
            ---@type RemoteEvent
            DifficultyVote = BaseFolder:WaitForChild('DifficultyVoteCast'),
            ---@type RemoteEvent
            CastReady = BaseFolder:WaitForChild('DifficultyVoteReady')
        }
    }
end

return Remotes