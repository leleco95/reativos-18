local enemy = require "enemy"
local categories = require "category"

local function new()
  local maxEnemies = 10
  local round = 1
  local spawnDelay = categories.spawnDelay[round] or categories.spawnDelay[1]

  local function spawnEnemies(self)
    for i=1, maxEnemies do
      table.insert(enemies, enemy.new(round))
      wait(spawnDelay, self)
    end
  end

  local function waitEnemiesDie(self)
    while #enemies > 0 do
      wait(0, self)
    end
  end

  local function nextRound()
    round = round + 1
    spawnDelay = categories.spawnDelay[round] or categories.spawnDelay[1]
  end

  local function update(self)
    while true do
      wait(2, self)
      spawnEnemies(self)
      waitEnemiesDie(self)
      nextRound()
    end
  end

  return {
    actionTime = 0,
    update = coroutine.wrap(update),
  }
end

return {
  new = new,
}
