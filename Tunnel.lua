
function tunnel(length, width, yLvl, targetLvl) 

    local exitCode = refuel()
    local indexL = 0 
    local indexW = 0
    local complete = false  
    
    descend(yLvl, targetLvl)

    while (indexW < width) do
        
        indexL = 0       
        while (indexL < length) do

            turtle.dig()
            turtle.forward()
            turtle.digUp()
            turtle.digDown()
            indexL = indexL + 1
        end

        turtle.turnRight()
        turtle.dig()
        turtle.forward()
        turtle.digUp()
        turtle.digDown()
        turtle.turnRight()
        indexW = indexW + 1

        indexL = 0
        while (indexL < length) do

            turtle.dig()
            turtle.forward()
            turtle.digUp()
            turtle.digDown()
            indexL = indexL + 1
        end

        if (indexW + 1 < width) then
            turtle.turnLeft()
            turtle.dig()
            turtle.forward()
            turtle.digUp()
            turtle.digDown()
            turtle.turnLeft()
        end

        exitCode = refuel()
        if (exitCode == -1) then
            returnHome(indexW, yLvl, targetLvl)
            return -1
        end

        exitCode = inventoryControl()
        if (exitCode == 1) then
            returnHome(indexW, yLvl, targetLvl)
            return 1
        end

        indexW = indexW + 1
    end

    returnHome(width, yLvl, targetLvl)
    return 0
end


function ascend(yLvl, targetLvl)

    turtle.select(1)
    local current = 0
    local finish = yLvl - targetLvl
    local slot = 1
    local item = 0
    local count = 0
    
    turtle.digUp()
    turtle.up()
    current = current + 1

    while (current < finish) do

        slot = 1
        turtle.digUp()
        turtle.up()

        while (slot < 17) do

            count = turtle.getItemCount(slot)
            if (count > 0) then

                item = turtle.getItemDetail(slot)
                if (item.name == "engineer's toolbox:limestone" or item.name == "minecraft:gravel" or item.name == "minecraft:cobblestone"
                 or item.name == "minecraft:dirt" or item.name == "minecraft:sand" or item.name == "minecraft:basalt") then
                    turtle.select(slot)
                    turtle.placeDown()
                    slot = 17
                end
            else
                slot = 17
            end

            slot = slot + 1
        end      

        current = current + 1
    end

    turtle.turnRight()
    turtle.placeDown()
end


function descend(yLvl, targetLvl) 

    turtle.select(1)
    local current = 0
    local finish = yLvl - targetLvl
    local slot = 1
    local item = 0
    local count = 0
    
    turtle.digDown()
    turtle.down()
    current = current + 1

    while (current < finish) do

        slot = 1
        turtle.digDown()
        turtle.down()

        while (slot < 17) do

            count = turtle.getItemCount(slot)
            if (count > 0) then

                item = turtle.getItemDetail(slot)
                if (item.name == "engineer's toolbox:limestone" or item.name == "minecraft:gravel" or item.name == "minecraft:cobblestone"
                 or item.name == "minecraft:dirt" or item.name == "minecraft:sand" or item.name == "minecraft:basalt") then
                    turtle.select(slot)
                    turtle.placeUp()
                    slot = 17
                end
            else
                slot = 17
            end
    
            slot = slot + 1
        end      

        current = current + 1
    end
end


function inventoryControl() 

    turtle.select(1)
    local slot = 1
    local item = 0

    while (slot < 17) do

        if (turtle.getItemCount(slot) > 0) then
            item = turtle.getItemDetail(slot)

            if (item.name == "engineer's toolbox:limestone" or item.name == "minecraft:gravel" or item.name == "minecraft:cobblestone"
            or item.name == "minecraft:dirt" or item.name == "minecraft:sand" or item.name == "minecraft:basalt") then
                turtle.select(slot)
                turtle.drop(item.count)
            end
        else
            slot = 17
        end
        slot = slot + 1
    end

    if (turtle.getItemCount(16) > 0) then
        return 1
    end
end


function returnHome(width, yLvl, targetLvl)

    local current = 0

    turtle.turnLeft()

    while (current < width) do

        if (turtle.forward() == false) then
            print("Unable to correctly return home..")
        end
        
        current = current + 1 
    end

    ascend(yLvl, targetLvl)
end


function refuel() 

    turtle.select(1)
    local fuelLvl = turtle.getFuelLevel()
    local slot = 1
    local item = 0
    local count = 0

    while (fuelLvl < 50 and slot < 17) do

        count = turtle.getItemCount(1)
        if (count == 0) then

            while (slot < 17 and turtle.getFuelLevel() < 50) do

                count = turtle.getItemCount(slot)

                if (count > 0) then

                    item = turtle.getItemDetail(slot)
          
                    if (item.name == "minecraft:coal" or item.name == "minecraft:charcoal") then

                        turtle.select(slot)

                        while (fuelLvl < 50 and count > 0) do

                            turtle.refuel(1)
                            count = turtle.getItemCount(slot)
                            fuelLvl = turtle.getFuelLevel()                            
                        end
                    end
                end

                fuelLvl = turtle.getFuelLevel()  
                if (slot == 16 and fuelLvl < 50) then
                    return -1
                end

                slot = slot + 1
            end

        else
            turtle.select(1)
            turtle.refuel(1)
        end

        fuelLvl = turtle.getFuelLevel()
    end
end


function getInt() 

    local input = tonumber(io.read())

    while (input <= 3) do
        print("Enter an integer that is greater than three..")
        input = tonumber(io.read())
    end

    return input
end



local length, width, yLvl, targetLvl, exitCode

print("Enter Length of Tunnel.. ")
length = getInt()

print("Enter a multiple of 4 for width.. ")
width = getInt()

print("Enter the current Y level.. ")
yLvl = getInt()

print("Enter the target level.. ")
targetLvl = getInt()

while (width % 4 ~= 0) do
    print("Enter a multiple of 4..")
    width = getInt()
end

exitCode = tunnel(length, width, yLvl, targetLvl)

if (exitCode == 1) then

    local index = 0
    local item = 0

    while (exitCode == 1) do 

        print("Empting inventory...")
        turtle.turnRight()
        turlte.turnRight()
    
        while (index < 17) do

            turtle.select(index)
            item.getItemDetail(index)

            if (item.name ~= "minecraft:coal" and item.name ~= "minecraft:charcoal") then
                turtle.drop(item.count)
            end
            
            index = index + 1     
        end

        index = 0
        targetLvl = targetLvl - 3

        if (targetLvl == 8) then
            print("Maximum mining depth reached, terminating program...")
            exitCode = 0
        end

        exitCode = tunnel(length, width, yLvl, targetLvl)
    end

elseif (exitCode == 0) then
    turtle.turnRight()
    turtle.turnRight()
    print("Successfully completed task...")

elseif (exitCode == -1) then
    print("Critical fuel level reached, task abandoned...")
    
else
    print("This shouldn't print...")
end
