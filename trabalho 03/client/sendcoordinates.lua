local function post_callback(code, data)
  print("post_callback")
  print(code, data)

  if (code < 0) then
    client:publish(topic_to_notify, "error", 0, 0)
  else
    client:publish(topic_to_signal, data, 0, 0)
  end
end

local function send_json(json)
  local url = 'https://www.googleapis.com/geolocation/v1/geolocate?key=SUACHAVE'
  local content_type = 'Content-Type: application/json\r\n'
  http.post(url, content_type, json, post_callback)
end

local function get_wifi_info(name, info)
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
