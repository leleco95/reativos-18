local function new(x, y, target, damage)
  local speedX = 7
  local speedY = 7
  local radius = 3

  local function move()

    local directionX = 0
    if(x < target.getX()) then
      directionX = 1
    elseif(x > target.getX()) then
      directionX = -1
    end

    local distance = math.abs(target.getX() - x)
    if speedX > distance then
      x = x + distance * directionX
    else
      x = x + speedX * directionX
    end

    local directionY = 0
    if(y < target.getY()) then
      directionY = 1
    elseif(y > target.getY()) then
      directionY = -1
    end

    distance = math.abs(target.getY() - y)
    if speedY > distance then
      y = y + distance * directionY
    else
      y = y + speedY * directionY
    end
  end

  local function checkCollision(index)
    if(circleCollision(x, y, radius, target.getX(), target.getY(), target.radius)) then
      table.remove(projectiles, index)
      target.takeDamage(damage)
    end
  end

  local function update()
    while true do
      local index = coroutine.yield()
      checkCollision(index)
      move()
    end
  end

  local function draw()
    love.graphics.setColor(0, 1, 0)
    love.graphics.circle("fill", x, y, radius)
    love.graphics.setColor(1, 1, 1)
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
    update = coroutine.wrap(update),
    draw = draw
  }
end

return {
  new = new
}
