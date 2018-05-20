local client = mqtt.Client("lages nodemcu", 120)

local button1 = 1
local led1 = 3
local lastPressed = 0

local function send_json(json)
    http.post('https://www.googleapis.com/geolocation/v1/geolocate?key=KEY',
    'Content-Type: application/json\r\n',
    json,
    function(code, data)
      if (code < 0) then
        print("HTTP request failed :", code)
        client:publish("wifi-notification", "error", 0, 0)
      else
        print(code, data)
        client:publish("wifi-signal", data, 0, 0)
      end
    end)
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
  local count = 0

  for k,v in pairs(wifi_table) do
    print(k, v)
    json_array = json_array .. get_wifi_info(k, v)
    count = count + 1
    if count > 30 then
        break
    end
  end

  json_array = json_array:sub(1, #json_array - 2) .. "\n]\n}"
  print(json_array)
  send_json(json_array)
end

local function button_pressed(_, time)
    if time >= lastPressed + 200000 then
        lastPressed = time
        print("button pressed")
        --client:publish("wifi-notification", "gathering wifi data", 0, 0)
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
