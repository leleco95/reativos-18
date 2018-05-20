local button1 = 1
local led1 = 3
local lastPressed = 0

local function button_pressed(_, time)
  print("button pressed(_, " .. time .. ")")

  if time >= lastPressed + 1000000 then
      lastPressed = time
      client:publish(topic_to_notify, "gathering wifi data", 0, 0)
      wifi.sta.getap(table_to_json)
  end
end

gpio.mode(button1, gpio.INT, gpio.PULLUP)
gpio.trig(button1, "down", button_pressed)
