function wait(time, object)
  object.actionTime = love.timer.getTime() + time
  coroutine.yield()
end

function checkHit(towerX, towerY, towerCategory, enemyX, enemyY, enemyCategory)
  --tower category defines its range
  local towerRange = towerCategory
  --enemy category defines its size
  local enemySize = enemyCategory
  circleCollision(towerX, towerY, towerRange, enemyX, enemyY, enemySize)
end

function circleCollision(circleOneX, circleOneY, circleOneR, circleTwoX, circleTwoY, circleTwoR)
  local distance = math.sqrt( (circleOneX - circleTwoX)^2 + (circleOneY - circleTwoY)^2)
  return distance < circleOneR + circleTwoR
end