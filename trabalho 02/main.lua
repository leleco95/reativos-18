local player = require "player"
local enemy = require "enemy"
local tower = require "tower"
local projectile = require "projectile"
local map = require "map"

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
    v:draw()
  end

  for i=1, #projectiles do
    projectiles[i].draw()
  end
  -- for k,v in pairs(projectiles) do
  --   v:draw()
  -- end
end

function love.update(dt)
  --enemy.spawner()
  for k,v in pairs(enemies) do
    v:update()
  end

  for i=#projectiles, 1, -1 do
    projectiles[i].update(i)
  end

end

function love.keypressed(key)
  if key == '1' then
    table.insert(enemies, enemy.new(100))
  end
  if key == '2' then
    local asdf = enemy.new(100)
    table.insert(enemies, asdf)
    table.insert(projectiles, projectile.new(50, 50, asdf))
  end
end

function love.mousepressed(x, y, button)
  if button == 1 then
    table.insert(towers, tower.new(x, y, 1))
  end
end

function hit(x, y, category)
  for k,v in pairs(enemies) do
    checkHit(x, y, category, v.x, v.y, v.category)
  end
end
