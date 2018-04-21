function wait(time, object)
  object.actionTime = love.timer.getTime() + time
  coroutine.yield()
end

function isInRange(tower, enemy)
  --tower category defines its range
  local towerRange = 70
  --enemy category defines its size
  local enemySize = 10

  return circleCollision(tower.getX(), tower.getY(), towerRange, enemy.getX(), enemy.getY(), enemySize)
end

function circleCollision(x, y, radius, x2, y2, radius2)
  local distance = math.sqrt((x - x2)^2 + (y - y2)^2)
  return distance < radius + radius2
end

function dump(o)
   if type(o) == 'table' then
      local s = '{ '
      for k,v in pairs(o) do
         if type(k) ~= 'number' then k = '"'..k..'"' end
         s = s .. '['..k..'] = ' .. dump(v) .. ','
      end
      return s .. '} '
   else
      return tostring(o)
   end
end