map = {}

function map.draw()
  love.graphics.rectangle("fill", 400, 0, 50, love.graphics.getHeight())
end

function map.checkCollision(x, y, radius)
  return circleCollision(425, y, 25, x, y, radius)
end
