local Players = game:GetService('Players')

---@description Takes in an optional callback which is called when the cash threshold is reached.
---@param cash number
local function yieldUntilCashThreshold(cash, callback)
    ---@type NumberValue
    local CashValue = Players.LocalPlayer:WaitForChild('leaderstats')
                          :WaitForChild('Cash')

    repeat task.wait() until CashValue.Value >= cash
    if callback then callback() end
end

local Tower = {}
Tower.__index = Tower

Tower.new = function(name, position, orchestrator, remotes)

    local newTower = {
        Name = name,
        Position = position,
        Orchestrator = orchestrator,
        Remotes = remotes,
        Index = orchestrator.getNextTowerIndex()
    }

    setmetatable(newTower, Tower)

    return newTower

end

---@description Places the Tower onto the battlefield, this does not account for placement fails.
---@param requiredCash number
---`🔺yields🔺`
function Tower:Place(requiredCash)

    yieldUntilCashThreshold(requiredCash, function()
        self.Remotes.Tower.Place:InvokeServer(unpack({
            0, self.Name, self.Position, 0
        }))
        local nextIndex = self.Orchestrator.getNextTowerIndex()
        self.Orchestrator.setNextTowerIndex(nextIndex)
    end)

end

---@description Upgrades the Tower.
---@param path number
---@param requiredCash number
---`🔺yields🔺`
function Tower:Upgrade(path, requiredCash)
    yieldUntilCashThreshold(requiredCash, function()
        self.Remotes.Tower.Upgrade:FireServer(unpack({self.Index, path}))
        local nextIndex = self.Orchestrator.getNextTowerIndex()
        self.Orchestrator.setNextTowerIndex(nextIndex)
    end)
end

---@description Sells the Tower.
function Tower:Sell() self.Remotes.Tower.Sell:FireServer(self.Index) end

---@description Changes the Tower's query type.
---`1 - First`, `2 - Second`, `3 - Strongest`, `4 - Weakest`, `5 - Random`
---@param queryType number
function Tower:ChangeTarget(queryType)
    self.Remotes.Tower.ChangeTarget:FireServer(unpack({self.Index, queryType}))
end

---@description Activates the Tower's ability.
function Tower:Ability()
    self.Remotes.Tower.UseAbility:InvokeServer(unpack({self.Index, 1}))
end

return Tower
