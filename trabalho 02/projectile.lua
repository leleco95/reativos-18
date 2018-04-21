local function new(x, y, target)
  local speedX = 3
  local speedY = 3
  local radius = 2

  local function move()
    print(x, y, target.getX(), target.getY())

    if(x < target.getX()) then
      x = x + speedX
    elseif(x > target.getX()) then
      x = x - speedX
    end

    if(y < target.getY()) then
      y = y + speedY
    elseif(y > target.getY()) then
      y = y - speedY
    end
  end

  local function checkCollision(index)
    if(circleCollision(x, y, radius, target.getX(), target.getY(), target.radius)) then
      table.remove(projectiles, index)
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
    love.graphics.setColor(0, 255, 0)
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
    update = coroutine.wrap(update),
    draw = draw
  }
end

return {
  new = new
}
