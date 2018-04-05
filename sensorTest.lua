os.loadAPI("ocs/apis/sensor")
local sense = sensor.wrap("top")
local targets = sense.getTargets()
local player
local playerPos = {x, y, z}

for k,v in pairs(targets) do

  if (tostring(k) == "321ba1") then
  
    print("Got you")
  end
  
  print(tostring(k))
  
end  

local index = 0

while (index < 3) do

  targets = sense.getTargets()  
  playerPos.x = math.floor(targets[player].Position.X)
  playerPos.y = math.floor(targets[player].Position.Y)
  playerPos.z = math.floor(targets[player].Position.Z)
  
  print("X: ", playerPos.x)
  print("Y: ", playerPos.y)
  print("Z: ", playerPos.z)
  print()

  os.sleep(2) 
  index = index + 1
end
  
  
  
  
  
  
  

