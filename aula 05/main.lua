function newblip (vel)
  local x, y = 0, 0
  return {
    waitUntilTime = love.timer.getTime(),
    vel = vel,
    sleepInterval = vel*5,
    sleepTicks = 0,
    update = coroutine.wrap ( function (self)
      local width, height = love.graphics.getDimensions()
      while true do
        x = x+2
        if x > width then
        -- volta para a esquerda da janela
          x = 0
        end
        self.sleepTicks = self.sleepTicks + 1
        wait(1/(2*self.vel), self)
      end
    end),
    affected = function (pos)
      if pos>x and pos<x+10 then
      -- "pegou" o blip
        return true
      else
        return false
      end
    end,
    draw = function ()
      love.graphics.rectangle("line", x, y, 10, 10)
    end
  }
end

function wait(segundos, blip)
  if blip.sleepTicks >= blip.sleepInterval then
    blip.waitUntilTime = love.timer.getTime() + segundos
    blip.sleepTicks = 0
  end
  coroutine.yield()
end

function newplayer ()
  local x, y = 0, 200
  local width, height = love.graphics.getDimensions( )
  return {
  try = function ()
    return x
  end,
  update = function (dt)
    x = x + 0.5
    if x > width then
      x = 0
    end
  end,
  draw = function ()
    love.graphics.rectangle("line", x, y, 30, 10)
  end
  }
end

function love.keypressed(key)
  if key == 'a' then
    pos = player.try()
    for i in ipairs(listabls) do
      local hit = listabls[i].affected(pos)
      if hit then
        table.remove(listabls, i) -- esse blip "morre" 
        return -- assumo que apenas um blip morre
      end
    end
  elseif key == 'b' then
    blsAtivo[1] = not blsAtivo[1]
  end
end

function love.load()
  player =  newplayer()
  listabls = {}
  for i = 1, 5 do
    listabls[i] = newblip(i)
  end
  currentTime = love.timer.getTime()
end

function love.draw()
  player.draw()
  for i = 1,#listabls do
    listabls[i].draw()
    love.graphics.print(tostring(currentTime >= listabls[i].waitUntilTime), 0, 30*i)
    love.graphics.print(tostring(listabls[i].vel), 100, 30*i)
    love.graphics.print(tostring(listabls[i].vel/100), 150, 30*i)
    love.graphics.print(tostring(listabls[i].waitUntilTime), 200, 30*i)
    love.graphics.print(tostring(listabls[i].sleepTicks), 400, 30*i)
  end
end

function love.update(dt)
  player.update(dt)
  currentTime = love.timer.getTime()
  for i = 1,#listabls do
    if currentTime >= listabls[i].waitUntilTime then
      listabls[i]:update(dt)
    --elseif hora >= listabls[i].wait_timer then
      --listabls[i].awake = true
    end
  end
end