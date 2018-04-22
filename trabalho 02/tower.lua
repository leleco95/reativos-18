projectile = require "projectile"
local categories = require "towerCategory"

local function new(x, y, category)
  local radius = categories.radius[category]
  local range = categories.range[category]

  local attackDelay = categories.attackDelay[category]
  local damage = categories.damage[category]

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
      table.insert(projectiles, projectile.new(x, y, enemy, damage))
      wait(attackDelay, self)
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
    local red = categories.red[category] or categories.red[#categories.red]
    local green = categories.green[category] or categories.green[#categories.green]
    local blue = categories.blue[category] or categories.blue[#categories.blue]

    if(debug) then
      love.graphics.setColor(red, green, blue, 0.3)
      --love.graphics.setColor(255, 0, 0, 100) --version < 11.0
      love.graphics.circle("fill", x, y, range)
    end

    love.graphics.setColor(red, green, blue)
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
