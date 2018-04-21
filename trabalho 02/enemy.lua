local function new(category)
  local x = 425
  local y = 0
  local speedX = 0
  local speedY = 2
  local radius = 10
  
  local health = 3
  local alive = true

  local function move()
    y = y + speedY
    x = x + speedX

    if y > love.graphics.getHeight() then
      y = 0
    end
  end
  
  local function checkAlive(index)
    if not alive then
      table.remove(enemies, index)
    end
  end

  local function update()
    while true do
      move()
      index = coroutine.yield()
      checkAlive(index)
    end
  end

  local function draw()
    love.graphics.setColor(0, 0, 255)
    love.graphics.circle("fill", x, y, radius)
    love.graphics.setColor(255, 255, 255)
  end

  local function getX()
    return x
  end

  local function getY()
    return y
  end
  
  local function takeDamage(damage)
    health = health - damage
    if health <= 0 then
      alive = false
    end
  end

  return {
    getX = getX,
    getY = getY,
    radius = radius,
    category = category,
    update = coroutine.wrap(update),
    draw = draw,
    takeDamage = takeDamage,
  }
end

local function spawner()
  while true do
    --todo
  end
end

return {
  new = new,
  spawner = coroutine.wrap(spawner)
}
