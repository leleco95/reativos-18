require "map"
require "general"
local player = require "player"
local enemy = require "enemy"
local projectile = require "projectile"
local spawner = require "spawner"
local towerCategories = require "towerCategory"

function love.load()
  debug = true

  towers = {}
  enemies = {}
  projectiles = {}

  map.generateRectangles()
  spawn = spawner.new()
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
end

function love.update(dt)
  local now = love.timer.getTime()

  if now >= spawn.actionTime then
    spawn:update()
  end

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
  key = tonumber(key)
  if key and key <= #towerCategories.range then
    player.setSelectedTower(key)
  end
end

function love.mousepressed(x, y, button)
  --button == "l" --version < 0.10
  if button == 1 then
    player.createTower(x, y)
  elseif button == 2 then
    player.removeTower(x, y)
  end
end
