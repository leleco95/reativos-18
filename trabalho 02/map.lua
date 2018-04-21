map = {}
map.startX = 425
map.startY = 0
map.destinations = {
  {x = 425, y = 300},
  {x = 500, y = 300},
  {x = 500, y = love.graphics.getHeight()},
}

function map.draw()
  love.graphics.rectangle("fill", map.startX - 25, map.startY, 50, love.graphics.getHeight())
end

function map.checkCollision(x, y, radius)
  return circleCollision(map.startX, y, 25, x, y, radius)
end

function map.checkCollision2(x, y, radius)

  -- for i=1,#destinations do
    local pointX = math.max(400, x)
    pointX = math.min(450, pointX)

    local pointY = math.max(0, y)
    pointY = math.min(love.graphics.getHeight(), pointY)

    print("===")
    print(x, y)
    print(pointX, pointY)

    if circleCollision(pointX, pointY, 1, x, y, radius) then
      return true
    end
  -- end

  return false
end
