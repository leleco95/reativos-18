map = {}
map.startX = 425
map.startY = 0
map.width = 25
map.height = 25
map.destinations = {
  {x = 425, y = love.graphics.getHeight()-100},
  {x = 600, y = love.graphics.getHeight()-100},
  {x = 600, y = 300},
}

function map.draw()
  local x = map.startX
  local y = map.startY

  for i=1, #map.destinations do
    local width = 0
    local height = 0

    if(x < map.destinations[i].x) then
      x = x - map.width
      width = map.destinations[i].x - x + map.width
    elseif(x > map.destinations[i].x) then
      width = map.destinations[i].x - x
      x = x - map.width + width
      width = map.width*2 - width
    else
      width = map.width * 2
      x = x - map.width
    end

    if(y < map.destinations[i].y) then
      y = y - map.height
      height = map.destinations[i].y - y + map.height
    elseif(y > map.destinations[i].y) then
      height = map.destinations[i].y - y
      y = y - map.height + height
      height = map.height*2 - height
    else
      height = map.height * 2
      y = y - map.height
    end

    love.graphics.rectangle("fill", x, y, width, height)

    x = map.destinations[i].x
    y = map.destinations[i].y
  end

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
