local categories = require "category"

local function new(category)
  local x = map.startX
  local y = map.startY
  local speedX = categories.speedX[category] or categories.speedX[#categories.speedX]
  local speedY = categories.speedY[category] or categories.speedY[#categories.speedY]
  local radius = categories.radius[category] or categories.radius[#categories.radius]

  local health = categories.health[category] or categories.health[#categories.health]
  local alive = true
  local destinationIndex = 1

  local function move(index)
    local destination = map.destinations[destinationIndex]

    local directionX = 0
    if(x < destination.x) then
      directionX = 1
    elseif(x > destination.x) then
      directionX = -1
    end

    local distance = math.abs(destination.x - x)
    if speedX > distance then
      x = x + distance * directionX
    else
      x = x + speedX * directionX
    end

    local directionY = 0
    if(y < destination.y) then
      directionY = 1
    elseif(y > destination.y) then
      directionY = -1
    end

    distance = math.abs(destination.y - y)
    if speedY > distance then
      y = y + distance * directionY
    else
      y = y + speedY * directionY
    end

    if circleCollision(x, y, 1, destination.x, destination.y, 1) then
      destinationIndex = destinationIndex + 1
      if destinationIndex > #map.destinations then
        table.remove(enemies, index)
      end
    end
  end

  local function checkAlive(index)
    if not alive then
      table.remove(enemies, index)
    end
  end

  local function update()
    local index = nil
    while true do
      move(index)
      index = coroutine.yield()
      checkAlive(index)
    end
  end

  local function draw()
    local red = categories.red[category] or categories.red[#categories.red]
    local green = categories.green[category] or categories.green[#categories.green]
    local blue = categories.blue[category] or categories.blue[#categories.blue]

    love.graphics.setColor(red, green, blue)
    love.graphics.circle("fill", x, y, radius)
    love.graphics.setColor(1, 1, 1)
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

return {
  new = new,
}
