local enemy = require "enemy"

local function new()
  local maxEnemies = 10
  local round = 1
  
  local function spawnEnemies(self)
    for i=1, maxEnemies do
      table.insert(enemies, enemy.new(round))
      wait(0.5, self)
    end
  end
  
  local function waitEnemiesDie(self)
    while #enemies > 0 do
      wait(0, self)
    end
  end
  
  local function update(self)
    while true do
      wait(10, self)
      spawnEnemies(self)
      waitEnemiesDie(self)
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