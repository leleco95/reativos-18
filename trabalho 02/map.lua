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
