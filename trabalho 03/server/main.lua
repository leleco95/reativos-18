socket = require("socket")
local mqtt = require("mqtt_library")
local json = require "json"
require "util"

local messages = {}
local notifications = {}

function new_message (topic, message)
  local topicSplit = string.split(topic, '|')
  topic = topicSplit[1]
  local sender = topicSplit[2]
  if topic == "wifi-signal" then
    local content = json.parse(message)
    if not content.error then
      table.insert(messages, {sender = sender, content = json.parse(message), expireTimer = love.timer.getTime() + 60})
    end
  elseif topic == "wifi-notification" then
    table.insert(notifications, {sender = sender, content = message, expireTimer = love.timer.getTime() + 10})
  end
end

function love.load()
  mqtt_client = mqtt.client.create("test.mosquitto.org", 1883, new_message)
  mqtt_client:connect("lages server")
  for i=0, 9 do
    mqtt_client:subscribe({"wifi-signal|"..i, "wifi-notification|"..i})
  end
end

function love.update(dt)
  mqtt_client:handler()
  local now = love.timer.getTime()

  for i = #messages, 1, -1 do
    if now > messages[i].expireTimer then
      table.remove(messages, i)
    end
  end

  for i = #notifications, 1, -1 do
    if now > notifications[i].expireTimer then
      table.remove(notifications, i)
    end
  end
end

function love.draw()
  local now = love.timer.getTime()
  love.graphics.print("press the number of the client if you wish to ask for its location", 0, 0)

  for index,msg in ipairs(messages) do
    local latitude = msg.content.location.lat
    local longitude = msg.content.location.lng
    local accuracy = msg.content.accuracy
    love.graphics.print("sender: " .. msg.sender .. "\nlatitude: " .. latitude .. "\tlongitude: " .. longitude .. "\naccuracy: " .. accuracy .. "\nexpires in: " .. string.format("%d", msg.expireTimer - now), 0, 60*index)
  end
  for index,msg in ipairs(notifications) do
    love.graphics.print("sender: " .. msg.sender .. "\ncontent: " .. msg.content .. "\nexpires in: " .. string.format("%d", msg.expireTimer - now), 400, 45*index)
  end
end

function love.keypressed(key)
  if tonumber(key) then
    mqtt_client:publish("wifi-request", key)
  end
end
