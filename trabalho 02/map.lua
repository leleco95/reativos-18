map = {}
map.startX = 0
map.startY = 300
map.width = 25
map.height = 25
map.destinations = {
  {x = 200, y = 300},
  {x = 200, y = 200},
  {x = 100, y = 200},
  {x = 100, y = 300},
  {x = 400, y = 300},
  {x = 400, y = 200},
  {x = 300, y = 200},
  {x = 300, y = 300},
  {x = 600, y = 300},
  {x = 600, y = 200},
  {x = 500, y = 200},
  {x = 500, y = 300},
  {x = love.graphics.getWidth(), y = 300},
}

function map.generateRectangles()
  map.rectangles = {}

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

    table.insert(map.rectangles, {x = x, y = y, width = width, height = height})

    x = map.destinations[i].x
    y = map.destinations[i].y
  end
end

function map.draw()
  for _,v in ipairs(map.rectangles) do
    love.graphics.rectangle("fill", v.x, v.y, v.width, v.height)
  end
end

function map.checkCollision(x, y, radius)

  for _,v in ipairs(map.rectangles) do
    local pointX = math.max(v.x, x)
    pointX = math.min(v.x + v.width, pointX)

    local pointY = math.max(v.y, y)
    pointY = math.min(v.y + v.height, pointY)

    if circleCollision(pointX, pointY, 1, x, y, radius) then
      return true
    end
  end

  return false
end
