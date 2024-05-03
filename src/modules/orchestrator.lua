local Orchestrator = {}

Orchestrator.__TOWER_INDEX__ = 0

Orchestrator.getNextTowerIndex = function()

    return Orchestrator.__TOWER_INDEX__ + 1

end

Orchestrator.setTowerIndex = function(index)

    Orchestrator.__TOWER_INDEX__ = index
    return index

end

return Orchestrator