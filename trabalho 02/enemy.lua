local enemy = {}

function enemy.newEnemy(category)

  local function update(self)
    while true do
      self.y = self.y + 2
      if self.y > 600 then
        self.y = 0
      end
      coroutine.yield()
    end
  end

  local function draw(self)
    love.graphics.setColor(0, 0, 255)
    love.graphics.circle("fill", self.x, self.y, 10)
    love.graphics.setColor(255, 255, 255)
  end

  return {
    x = 425,
    y = 0,
    category = category,
    update = coroutine.wrap(update),
    draw = draw,
  }
end

enemy.spawner = coroutine.wrap(
  function()
    while true do
      --todo
    end
  end
)

return enemy
