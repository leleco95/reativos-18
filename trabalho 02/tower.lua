projectile = require "projectile"

local function new(x, y, category)
  local radius = 10
  local range = 70

  local function findEnemyInRange()
    for _, enemy in pairs(enemies) do
      if circleCollision(x, y, range, enemy.getX(), enemy.getY(), enemy.radius) then
        return enemy
      end
    end
    return nil
  end

  local function attack(self, enemy)
    if enemy then
      table.insert(projectiles, projectile.new(x, y, enemy))
      wait(category/2, self)
    else
      wait(0, self)
    end
  end

  local function update(self)
    while true do
      enemy = findEnemyInRange()
      self:attack(enemy)
    end
  end

  local function draw()
    if(debug) then
      love.graphics.setColor(255, 0, 0, 0.3)
      --love.graphics.setColor(255, 0, 0, 100) --version < 11.0
      love.graphics.circle("fill", x, y, 70)
    end

    love.graphics.setColor(255, 0, 0)
    love.graphics.circle("fill", x, y, radius)
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
    radius = radius,
    range = range,
    actionTime = 0,
    findEnemyInRange = findEnemyInRange,
    attack = attack,
    update = coroutine.wrap(update),
    draw = draw,
  }
end

return {
  new = new
}
