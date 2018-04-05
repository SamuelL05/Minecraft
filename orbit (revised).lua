function orbit()

  local sense = sensor.wrap("left")
  local targets = sense.getTargets()
  local k = 0
  local playerPos = {x ,y ,z}
  local turtlePos = {x = 0 ,y = 0 ,z = 0}	--Object Center
  local object = turtlePos 
  local direction = orientation()
  local online = true
  
  if (direction == 0) then	--Failed to acquire direction
  
      return 0
    end
    
	
  for x, v in pairs (targets) do	-- Find player / target
  
    if (tostring(x) == "321ba1") then	--Player name / Target
      k = x
    end
  end
         
     
  while (online == true) do
  
    playerProxCheck()  --Will lock program in slow loop until player in range / Prevents program crash from player moving out of range
    targets = sense.getTargets()
	  getFuel()
                                  
    playerPos.x = math.floor(targets[k].Position.X)	-- For real world environments tofloor will not work.
    playerPos.y = math.floor(targets[k].Position.Y)
    playerPos.z = math.floor(targets[k].Position.Z)

    if ((object.y > (playerPos.y + 2)) or (object.y < (playerPos.y + 2))) then
	
		  direction = playerPosY(direction, playerPos.y, object)
	
	  elseif ((object.x > (playerPos.x + 2)) or (object.x < (playerPos.x - 2))) then
	
		  direction = playerPosX(direction, playerPos.x, object)
		
	  elseif ((object.z > (playerPos.z + 2)) or (object.z < (playerPos.z - 2))) then
		
		  direction = playerPosZ(direction, playerPos.z, object)
	
	  end
  end
end


function playerPosY(direction, playerPos, object)

  if (object.y > (playerPos.y +2)) then
     
      if (turtle.down() == false) then
        direction = reroute(direction)
      end
    
  elseif (object.y < (playerPos.y + 2)) then
      
      if (turtle.up() == false) then
        direction = reroute(direction)
      end
  end
  
  return direction
end


function playerPosX(direction, playerPos, object)

	if (object.x > (playerPos.x +2)) then
                  
      if ((direction > 1) and (direction < 4)) then
        
        while (direction < 4) do
          
           turtle.turnRight()
           direction = direction + 1   
        end
          
      elseif (direction == 1) then
        
        turtle.turnLeft()
        direction = 4 
         
      else
        
        if (turtle.forward() == false) then
          direction = reroute(direction)
        end
      end
    
    elseif (object.x < (playerPos.x -2)) then
    
      if (direction > 2) then
      
        while (direction > 2) do
        
          turtle.turnLeft()
          direction = direction -1
        end
      
      elseif (direction == 1) then
      
        turtle.turnRight()
        direction = 2    
      
      else
      
        if (object.forward() == false) then
          direction = reroute(direction)
        end
      end
	  end
	
	return direction
end

  
function playerPosZ(direction, playerPos, object)
 
    if (object.z > (playerPos.z +2)) then
    
      if ((direction < 4) and (direction > 1)) then
      
        while (direction > 1) do
        
          turtle.turnLeft()
          direction = direction - 1
        end
        
	  elseif (direction == 4) then
      
        turtle.turnRight()
        direction = 1
   
      else
      
        if (turtle.forward() == false) then
          direction = reroute(direction)
        end  
	  end
	  
	elseif (object.z < (playerPos.z -2)) then
    
      if ((direction > 0) and (direction < 3)) then
      
        while (direction < 3) do
        
          turtle.turnRight()
          direction = direction + 1
        end
        
      elseif (direction == 4) then
      
        turtle.turnLeft()
        direction = 3
        
      else
      
        if (turtle.forward() == false) then
          direction = reroute(direction)
        end
      end  
	end
	
	return direction
  end

  
function reroute(direction)

  local index = 0
  
  turtle.back()
  turtle.turnRight()
  direction = direction + 1
  
  if (direction == 5) then
    direction = 1
  end
  
  while (index < 3) do
    
    turtle.forward()
    index = index + 1
  end

  index = 0  
  turtle.turnLeft()
  direction = direction - 1
  
  if (direction == 0) then
    direction = 4
  end
  
  while (index < 3) do
    
    turtle.forward()
    index = index + 1
  end 
  
  return direction
end
  
  
function playerProxCheck()

  local sense = peripheral.wrap("left")
  local inRange = false
  
  while (inRange == false) do
  
    local targets = sense.getTargets()
  
    for k, v in pairs(targets) do
    
      if (tostring(k) == "321ba1") then
          inRange = true
        return
      end
    end
    
    os.sleep(1)
  end
end


function orientation()

  local x, y, z = gps.locate(2)
  local catch
    
  if not x then
  
    print("Failed to Locate")
    return 0
  else
    
    if turtle.forward() then
    
      local x2, y2, z2 = gps.locate(2)
      
      if ((x2 - x) > 0) then
      
        return 2
              
      elseif ((z2 + (z * -1)) < 0) then
      
        return 1
        
      elseif ((x2 + (x * -1)) < 0) then
      
        return 4
        
      elseif ((z2 - z) > 0) then
      
        return 3
        
      else
          
        print("Orientation Error")
      end          
  
    else
    
      turtle.up()
      turtle.back()    
      catch = orientation()
      return catch
    end 
  end
end


function getFuel() 

  local fuelLvl = turtle.getFuelLevel()
  
  if (fuelLvl < 100) then
  
    turtle.select(1)  
    turtle.refuel(1)
  end
end   
   
   
function inventory() 

  local slot = 2
  local itemCount = turtle.getItemCount(slot)
  local empty = false
  local index = 1
      
  if (itemCount < 1) then
          
    while (index < 15) do
    
      slot = slot + 1
      itemCount = turtle.getItemCount(slot)
      
      if (itemCount > 0) then
     
        turtle.select(slot)
        turtle.transferTo(2, turtle.getItemCount(slot))
        return 2

      elseif ((itemCount < 3) and (index == 14)) then
      
        return -1      
                  
      else
          index = index + 1
      end
    end
    
  else
    return 2        
  end
end    
   
   
       
      
os.loadAPI("ocs/apis/sensor")  
turtle.refuel()  
orbit()
  






