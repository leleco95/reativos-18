socket = require("socket")
local mqtt = require("mqtt_library")

local messages = {}
local notifications = {}

function new_message (topic, message)
  if topic == "wifi-signal" then
    table.insert(messages, {number = #messages+1, content = message})
  elseif topic == "wifi-notification" then
    table.insert(notifications, {number = #messages+1, content = message})
  end
end

function love.load()
  mqtt_client = mqtt.client.create("test.mosquitto.org", 1883, new_message)
  mqtt_client:connect("lages server")
  mqtt_client:subscribe({"wifi-signal", "wifi-notification"})
end

function love.update(dt)
  mqtt_client:handler()
end

function love.draw()
  for index,msg in ipairs(messages) do
    love.graphics.print("msg: " .. msg.number .. "\tcontent: " .. msg.content, 0, 15*index)
  end
  for index,msg in ipairs(notifications) do
    love.graphics.print("msg: " .. msg.number .. "\tcontent: " .. msg.content, 400, 15*index)
  end
end