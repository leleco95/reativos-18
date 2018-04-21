map = {}
map.startX = 425
map.startY = 0
map.width = 25
map.height = 25
map.destinations = {
  {x = 425, y = 300},
  {x = 500, y = 300},
  {x = 500, y = love.graphics.getHeight()},
}

function map.draw()
  local x = map.startX
  local y = map.startY

  for i=1, #map.destinations-1 do
    local width = x - map.destinations[i].x
    local height = y - map.destinations[i].y
    love.graphics.rectangle("fill", x - map.width, y - map.height, width, height)

    x = map.destinations[i+1].x
    y = map.destinations[i+1].y
  end

  -- love.graphics.rectangle("fill", map.startX - 25, map.startY, 50, love.graphics.getHeight())
end

function map.checkCollision(x, y, radius)

  -- for i=1,#destinations do
    local pointX = math.max(400, x)
    pointX = math.min(450, pointX)

    local pointY = math.max(0, y)
    pointY = math.min(love.graphics.getHeight(), pointY)

    if circleCollision(pointX, pointY, 1, x, y, radius) then
      return true
    end
  -- end

  return false
end
