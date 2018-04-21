projectile = require "projectile"
require "general"

local function new(x, y, category)

  local function findEnemyInRange(self)
    for _, enemy in pairs(enemies) do
      if isInRange(self, enemy) then
        return enemy
      end
    end
    return nil
  end

  local function attack(enemy)
    table.insert(projectiles, projectile.new(x, y, enemy))
  end

  local function update(self)
    while true do
      enemy = self:findEnemyInRange()
      if enemy then
        self.attack(enemy)
        wait(category/2, self)
      else
        wait(0, self)
      end
    end
  end

  local function draw()
    love.graphics.setColor(255, 0, 0, 100)
    love.graphics.circle("fill", x, y, 70)
    love.graphics.setColor(255, 0, 0)
    love.graphics.circle("fill", x, y, 10)
    love.graphics.setColor(255, 255, 255)
  end

  local function getX()
    return x
  end

  local function getY()
    return y
  end

  return {
    getX = getX,
    getY = getY,
    findEnemyInRange = findEnemyInRange,
    attack = attack,
    update = coroutine.wrap(update),
    draw = draw,
  }
end

return {
  new = new
}
