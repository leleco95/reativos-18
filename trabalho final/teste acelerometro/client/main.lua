socket = require("socket")
local mqtt = require("mqtt_library")
local res = require("res")

function mqttcb(topic, message)
  --[[if topic == "lages_game_new_player" then
    mqtt_client:publish(message, new_player_id)
  end]]
  controle = not controle
end

function love.mousepressed(x, y, button)
  if state == "new_connection" then
    mqtt_client:publish("lages_game_new_player", id)
    state = "connected"
  elseif state == "connected" then
    x = res.gamePosition(x, y)
    if x < 400 then
      mqtt_client:publish(id .. "_communication", "l")
    else
      mqtt_client:publish(id .. "_communication", "r")
    end
  end
end

function love.load()
  id = "lages_game_client_1"
  state = "new_connection"

  controle = false
  apertou = false
  next_message_time = 0

  mqtt_client = mqtt.client.create("test.mosquitto.org", 1883, mqttcb)
  mqtt_client:connect(id)
  mqtt_client:subscribe({id})

  local joysticks = love.joystick.getJoysticks()
  for i, joystick in ipairs(joysticks) do
      if joystick:getName() == "Android Accelerometer" then
        accelerometer = joystick
      end
  end

  love.window.setMode(800, 600, {resizable=true})
  gameWidth = 800
  gameHeight = 600
  screenWidth = love.graphics.getWidth()
  screenHeight = love.graphics.getHeight()
  res.set("fit", gameWidth, gameHeight, screenWidth, screenHeight)

  local function send_movement()
    while true do
      mqtt_client:publish(id .. "_movement", accelerometer:getAxis(1) or "0.0000001")
      next_message_time = love.timer.getTime() + 0.2
      coroutine.yield()
    end
  end

  sendMovement = coroutine.wrap(send_movement)
end

function love.resize(w, h)
  screenWidth = w
  screenHeight = h
  res.set("fit", gameWidth, gameHeight, screenWidth, screenHeight)
end

function love.draw()
  res.render(draw)
end

function draw()
  local x, y, z = accelerometer:getAxes()
  love.graphics.print(x, 0, 0)
  love.graphics.print(y, 0, 10)
  love.graphics.print(z, 0, 20)
end

function love.update(dt)
  local now = love.timer.getTime()
  mqtt_client:handler()
  if state == "connected" and now >= next_message_time then
    sendMovement()
  end
end
