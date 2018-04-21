local function draw()
  love.graphics.rectangle("fill", 400, 0, 50, love.graphics.getHeight())
end

return {
  draw = draw
}
