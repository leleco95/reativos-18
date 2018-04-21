local player = require "player"
local enemy = require "enemy"
local tower = require "tower"
local projectile = require "projectile"
local map = require "map"
require "general"

function love.conf(t)
  t.console = true
end

function love.load()
  towers = {}
  enemies = {}
  projectiles = {}
end

function love.draw()
  map.draw()

  for k,v in pairs(towers) do
    v.draw()
  end

  for k,v in pairs(enemies) do
    v.draw()
  end

  for i=#projectiles, 1, -1 do
    projectiles[i].draw()
  end
  -- for k,v in pairs(projectiles) do
  --   v:draw()
  -- end
end

function love.update(dt)
  local now = love.timer.getTime()
  
  for k,v in pairs(towers) do
    if now >= v.actionTime then
      v:update()
    end
  end
  
  for k,v in pairs(enemies) do
    v.update(k)
  end

  for i=#projectiles, 1, -1 do
    projectiles[i].update(i)
  end

end

function love.keypressed(key)
  if key == '1' then
    table.insert(enemies, enemy.new(100))
  end
end

function love.mousepressed(x, y, button)
  if button == 1 then
    newTower = tower.new(x, y, 1)
    if not map.checkCollision(x, y, newTower.radius) then
      table.insert(towers, tower.new(x, y, 1))
    end
  end
end
