local client = mqtt.Client("lages nodemcu", 120)

local button1 = 1
local led1 = 3
local lastPressed = 0

local function post_callback(code, data)
  if (code < 0) then
    print("HTTP request failed :", code)
    client:publish("wifi-notification", "error", 0, 0)
  else
    print(code, data)
    client:publish("wifi-signal", data, 0, 0)
  end
end

local function send_json(json)
  local url = 'https://www.googleapis.com/geolocation/v1/geolocate?key=CHAVE'
  local content_type = 'Content-Type: application/json\r\n'
  http.post(url, content_type, json, post_callback)
end

function get_wifi_info(name, info)
  local string_info = "{"

  local _, s, m, c = string.match(info, ".*(%d+),([%-%d]+),([%w:]+),(%d+).*")

  string_info = string_info .. "\"macAddress\": \"" .. m .. "\","
  string_info = string_info .. "\"signalStrength\": " .. s .. ","
  string_info = string_info .. "\"channel\": "  .. c

  string_info = string_info .. "},\n"
  return string_info
end

function table_to_json(wifi_table)
  local json_array = "{ \n\"wifiAccessPoints\": [\n"

  for k,v in pairs(wifi_table) do
    print(k, v)
    json_array = json_array .. get_wifi_info(k, v)
  end
  json_array = json_array:sub(1, #json_array - 2) -- removing comma

  json_array = json_array .. "\n]\n}"
  print(json_array)
  send_json(json_array)
end

local function button_pressed(_, time)
    if time >= lastPressed + 1000000 then
        lastPressed = time
        print("button pressed")
        client:publish("wifi-notification", "gathering wifi data", 0, 0)
        wifi.sta.getap(table_to_json)
    end
end

local function connected_callback (client)
  print("connected_callback")
end

local function failed_callback(client, reason)
  print("failed_callback(" .. reason .. ")")
end

client:connect("test.mosquitto.org", 1883, 0, connected_callback, failed_callback)

gpio.mode(button1, gpio.INT, gpio.PULLUP)
gpio.trig(button1, "down", button_pressed)
