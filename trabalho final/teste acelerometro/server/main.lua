socket = require("socket")
local mqtt = require("mqtt_library")

function mqttcb(topic, message)
  if topic == "lages_game_new_player" then
    mqtt_client:publish(message, tostring(new_player_id))
    mqtt_client:subscribe({message .. "_communication", message .. "_movement"})
    table.insert(current_players, message)
  else
    for _, player in ipairs(current_players) do
      if topic == player .. "_communication" then
        if message == "l" then
          controle = not controle
        elseif message == "r" then
          apertou = not apertou
        end
        break
      elseif topic == player .. "_movement" then
        controle_x = controle_x + tonumber(message) * 50
      end
    end
  end
end

function love.load()
  id = "lages_game_server"
  new_player_id = 0
  current_players = {}

  controle = false
  controle_x = 10
  apertou = false

  mqtt_client = mqtt.client.create("test.mosquitto.org", 1883, mqttcb)
  mqtt_client:connect(id)
  mqtt_client:subscribe({"lages_game_new_player"})
end

function love.draw()
 if controle then
   love.graphics.rectangle("line", controle_x, 10, 200, 150)
 end
 if apertou then
    love.graphics.rectangle("line", 300, 10, 200, 150)
 end
end

function love.update(dt)
  mqtt_client:handler()
end
