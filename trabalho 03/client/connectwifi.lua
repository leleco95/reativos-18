local function callback(iptable)
  print("connection made")
  print("ip: ".. iptable.IP)
end

-- this may help: http://nodemcu.readthedocs.io/en/master/en/modules/wifi/#wifistaconfig
wificonf = {
  ssid = "WIFI-NAME",       -- wifi name
  pwd = "WIFI-PASS",        -- wifi password
  got_ip_cb = callback,     -- function to call when get the ip
  save = false,             -- clear the configurations when reset
}

wifi.setmode(wifi.STATION)  -- set to join an existing network
print(wifi.sta.config(wificonf))   -- use this configurations

print("End")
