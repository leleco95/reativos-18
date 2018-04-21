local function draw()
  love.graphics.rectangle("fill", 400, 0, 50, love.graphics.getHeight())
end

local function checkCollision(x, y, radius)
  return circleCollision(425, y, 25, x, y, radius)
end

return {
  draw = draw,
  checkCollision = checkCollision,
}
