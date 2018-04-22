local tower = require "tower"

local selectedTower = 1

local function collideAgainstOthersTowers(x, y, radius)
  for i=1, #towers do
    local collision = circleCollision(x, y, radius, towers[i].getX(), towers[i].getY(), towers[i].radius)
    if collision then
      return true, i
    end
  end

  return false, nil
end

local function collideWithMap(tower)
  return map.checkCollision(tower.getX(), tower.getY(), tower.radius)
end

local function createTower(x, y)
  local newTower = tower.new(x, y, selectedTower)
  
  if(collideAgainstOthersTowers(x, y, newTower.radius) or collideWithMap(newTower)) then
    return
  end

  table.insert(towers, newTower)
end

local function removeTower(x, y)
  local collide, index = collideAgainstOthersTowers(x, y, 1)

  if(collide) then
    table.remove(towers, index)
  end
end

local function setSelectedTower(newSelection)
  selectedTower = newSelection
end

return {
  setSelectedTower = setSelectedTower,
  createTower = createTower,
  removeTower = removeTower,
}
