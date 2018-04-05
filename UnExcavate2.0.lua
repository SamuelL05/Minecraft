local function holeFill(layers, xLength, yLength)
     
  if (xLength % 2 == 0) then
  
    xLength = xLength
  else
    xLength = xLength -1
  end
  
  local columns = xLength
  local columnsIndex = 1
  local layersIndex = 0
  local yIndex = 0
  
  getFuel()

  while (layersIndex < layers) do

    if (layersIndex <= (layers -3)) then
             
      turtle.select(2)
      turtle.placeUp()
      turtle.placeDown()
    end
    
    while (columnsIndex <= columns) do
    
      while (yIndex < (yLength -1)) do

        getFuel()          
        turtle.back()
                                                                                                                                                                                                                                         
        local inventory = inventory()      
      
        if (inventory == 2) then
        
          if (layersIndex > (layers -3)) then
          
            turtle.select(2)
            turtle.place()
          
          else
            turtle.select(2)
            turtle.place()
            turtle.placeUp()
            turtle.placeDown()
          end
     
        else 
          print("No blocks in inventory")
          return -1
        end
          
        yIndex = yIndex + 1
      end
      
      if (columnsIndex == columns) then

        if (layersIndex > (layers -3)) then
        
          turtle.up()
          turtle.placeDown()
        
        else        
          turtle.digUp()      
          turtle.up()
          turtle.placeDown()
          turtle.up()
          turtle.placeDown()
          
          if ((layersIndex +3) <= (layers -3)) then
            turtle.up()
          end
        end
        
      elseif (columnsIndex % 2 == 0) then
      
        if (layersIndex > (layers -3)) then      
        
          turtle.turnLeft()
          turtle.back()
          turtle.place()
          turtle.turnLeft()
        
        else
          turtle.turnLeft()
          turtle.back()
          turtle.place()
          turtle.placeUp()
          turtle.placeDown()
          turtle.turnLeft()
        end
      else
      
        if (layersIndex > (layers -3)) then
        
          turtle.turnRight()
          turtle.back()
          turtle.place()
          turtle.turnRight()
        
        else
          turtle.turnRight()
          turtle.back()
          turtle.place()
          turtle.placeUp()
          turtle.placeDown()
          turtle.turnRight()
        end
      end
  
      yIndex = 0
      columnsIndex = columnsIndex + 1          
    end

    restart(xLength)
    columnsIndex = 1
    
    if (layersIndex > (layers -3)) then
    
      layersIndex = layersIndex + 1
    else
    
      layersIndex = layersIndex + 3
    end
  end
 
  print("Hole Filled")
  return 0
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

function restart(xLength)
   
  turtle.turnRight()
  local x = 0
       
  while (x < (xLength -1)) do
  
    turtle.back()
    x = x + 1
  end
  
  turtle.turnRight()
  
end
             
function getFuel() 

  local fuelLvl = turtle.getFuelLevel()
  
  if (fuelLvl < 100) then
  
    turtle.select(1)  
    turtle.refuel(1)
  end
end      

function getInteger()      

  local input = tonumber(io.read())
  local x = 0

  while (input <= 1) do

    print("Please enter a value greater than One: ")
    input = tonumber(io.read())
  end
  
  return input
end

print("Fuel in slot 0")
print("Blocks to place fill remaining inventory")

print("Please enter layers: ")
local layers = getInteger()

print("Using GPS X and y, enter perimeter in blocks")
print("Please enter X length: ")
local xLength = getInteger()
print("Please enter Y length: ")
local yLength = getInteger()
  
holeFill(layers, xLength, yLength)    
