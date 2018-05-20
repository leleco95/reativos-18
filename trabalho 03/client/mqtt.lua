local id = 3
topic_to_notify = "wifi-notification|" .. id
topic_to_signal = "wifi-signal|" .. id

client = mqtt.Client("lages nodemcu", 120)

local function mqtt_message_callback(client, topic, message)
  print("mqtt_message_callback")
  print(topic, message)

  if(message == tostring(id)) then
    client:publish(topic_to_notify, "gathering wifi data", 0, 0)
    wifi.sta.getap(table_to_json)
  end
end

local function mqtt_subscribed_callback(client)
  print("mqtt_subscribed_callback")
  client:publish(topic_to_notify, "mqtt subscribed", 0, 0)
  client:on("message", mqtt_message_callback)
end

local function mqtt_connected_callback(client)
  print("mqtt_connected_callback")
  client:publish(topic_to_notify, "mqtt connected", 0, 0)
  client:subscribe("wifi-request", 0, mqtt_subscribed_callback)
end

local function mqtt_failed_callback(client, reason)
  print("mqtt_failed_callback(" .. reason .. ")")
end

client:connect("test.mosquitto.org", 1883, 0, mqtt_connected_callback, mqtt_failed_callback)
