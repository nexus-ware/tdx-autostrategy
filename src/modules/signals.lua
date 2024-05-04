local Players = game:GetService('Players')

local Signals = {}

---Yields a callback until a client has the required cash.
---`gameonly`
---`🔺yields🔺`
---@param cash number required
---@param callback function optional
Signals.WaitForCash = function(cash, callback)

    ---@type NumberValue
    local PlayerCash = Players.LocalPlayer:WaitForChild('leaderstats')
                           :WaitForChild('Cash')

    repeat task.wait(0.1) until PlayerCash.Value >= cash

    if callback then callback() end

end

---Yields a callback until an enemey is added to the workspace.
---`gameonly`
---`🔺yields🔺`
---@param enemyName string required
---@param callback function(childInstance) optional
Signals.WaitForEnemyAdded = function(enemyName, callback)

    ---@type Folder
    local Enemies = workspace:WaitForChild('Enemies')

    Enemies.ChildAdded:Once(function(child)
        if child.Name == enemyName then
            if callback then callback(child) end
        end
    end)
end

---Yields a callback until an enemy uses an ability.
---`gameonly`
---`🔺yields🔺`
---@param enemyInstance Instance required
---@param callback function(animationId) optional
Signals.WaitForEnemyUseAbility = function(enemyInstance, callback)

    ---@type Animator
    local Animator = enemyInstance:WaitForChild(enemyInstance.Name)
                         :WaitForChild('AnimationController')
                         :WaitForChild('Animator')

    repeat task.wait(0.1) until #Animator:GetPlayingAnimationTracks() > 1

    if callback then callback() end

end

---Yields a callback until the current wave changes.
---`gameonly`
---`🔺yields🔺`
---@param callback function optional
Signals.WaitForWaveChange = function(callback)

    ---@type TextLabel
    local Wave = getgenv().__CLIENT_INTERFACE.GameInfoBar.Wave

    Wave:GetPropertyChangedSignal('Text'):Once(callback)
end

---Yields a callback until the current time equals the desired time.
---**Will return instantaneously on infinite duration waves!**
---`gameonly`
---`🔺yields🔺`
---@param time string 00:00
---@param callback function optional
Signals.WaitForTimeRemaining = function(time, callback)

    ---@type TextLabel
    local Time = getgenv().__CLIENT_INTERFACE.GameInfoBar.Time

    local desiredTime = time:gsub("[:]", "")

    Time:GetPropertyChangedSignal('Text'):Once(function()
        local text = Time.Text
        local filteredText = text:gsub("[:]", "")

        if tonumber(filteredText) then

            if tonumber(filteredText) <= tonumber(desiredTime) then

                if callback then callback() end

            end

        end
    end)

end

return Signals
