socket = require("socket")
local mqtt = require("mqtt_library")
local res = require("res")

function mqttcb(topic, message)
   print("Received from topic: " .. topic .. " - message:" .. message)
   controle = not controle
end

function love.mousepressed(x, y, button)
  if button == 1 or button == 'l' then
    mqtt_client:publish("apertou-tecla", "a")
    apertou = not apertou
  end
end

function love.load()
  controle = false
  apertou = false
  mqtt_client = mqtt.client.create("test.mosquitto.org", 1883, mqttcb)
  mqtt_client:connect("cliente love 1")
  mqtt_client:subscribe({"apertou-tecla"})

  love.window.setMode(800, 600, {resizable=true}) 
  
  gameWidth = 800
  gameHeight = 600
  screenWidth = love.graphics.getWidth()
  screenHeight = love.graphics.getHeight()
  res.set("fit", gameWidth, gameHeight, screenWidth, screenHeight)
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
   if controle then
     love.graphics.rectangle("line", 10, 10, 200, 150)
   end
   if apertou then
      love.graphics.print("apertou", 0, 0)
   end
end

function love.update(dt)
  mqtt_client:handler()
end
  