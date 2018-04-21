require "general"

local function new(x, y, category)

  local function attack(self)
    for _, enemy in pairs(enemies) do
      isInRange(self, enemy)
    end
  end

  local function update(self)
    while true do
      if hit(x, y, category) then
        wait(category/2, self)
      else
        wait(0, self)
      end
      coroutine.yield()
    end
  end

  local function draw()
    love.graphics.setColor(255, 0, 0)
    love.graphics.circle("fill", x, y, 10)
    love.graphics.setColor(255, 255, 255)
  end

  return {
    update = coroutine.wrap(update),
    draw = draw,
  }
end

return {
  new = new
}
