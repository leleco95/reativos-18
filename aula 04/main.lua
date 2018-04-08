function retangulo(x, y, width, height)
  local originalx, originaly = x, y
  
  return {
    draw = function()
      love.graphics.rectangle("line", x, y, width, height)
    end,
    keypressed = function(key)
      local mx, my = love.mouse.getPosition() 
      if key == 'b' and naimagem (mx,my, x, y, width, height) then
        x = originalx
        y = originaly
      elseif key == "down" and naimagem (mx,my, x, y, width, height) then
        y = y + 10
      elseif key == "right" and naimagem (mx,my, x, y, width, height) then
        x = x + 10
      elseif key == "left" and naimagem (mx,my, x, y, width, height) then
        x = x - 10
      elseif key == "up" and naimagem (mx,my, x, y, width, height) then
        y = y - 10
      end
    end
  }
end

function love.load()
  retangulos = {retangulo(50, 200, 200, 150), retangulo(300, 200, 200, 150)}
end

function naimagem (mx, my, x, y, w, h) 
  return (mx>x) and (mx<x+w) and (my>y) and (my<y+h)
end

function love.keypressed(key)
  for i,v in pairs(retangulos) do
    v.keypressed(key)
  end
end

function love.update (dt)
end

function love.draw ()
  for i,v in pairs(retangulos) do
    v.draw()
  end
end

