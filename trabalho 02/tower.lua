projectile = require "projectile"

local function new(x, y, category)
  local radius = 10

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
        --change tower attack speed
        wait(category/2, self)
      else
        wait(0, self)
      end
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
