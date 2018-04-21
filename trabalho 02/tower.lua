local tower = {}
require "general"

function tower.newTower(x, y, category)
  return {
    fire =
      function(self)
        while true do
          if hit(x, y, category) then
            wait(category/2, self)
          else
            wait(0, self)
          end
        end
      end,
    draw =
      function()
        love.graphics.setColor(255, 0, 0)
        love.graphics.circle("fill", x, y, 10)
        love.graphics.setColor(255, 255, 255)
      end,
  }
end

return tower