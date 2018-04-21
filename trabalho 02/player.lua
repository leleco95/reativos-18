local tower = require "tower"

local function collideAgainstOthersTowers(tower)
  for i=1, #towers do
    local collision = circleCollision(tower.getX(), tower.getY(), tower.radius, towers[i].getX(), towers[i].getY(), towers[i].radius)
    if collision then
      return true
    end
  end

  return false
end

local function collideWithMap(tower)
  return map.checkCollision2(tower.getX(), tower.getY(), tower.radius)
end

local function createTower(x, y)
  newTower = tower.new(x, y, 1)

  if(collideAgainstOthersTowers(newTower) or collideWithMap(newTower)) then
    return
  end

  table.insert(towers, tower.new(x, y, 1))
end

return {
  createTower = createTower
}
