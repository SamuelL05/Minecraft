
function tunnel(length, width, yLvl, targetLvl) 

    local exitCode = refuel()
    local indexL = 0 
    local indexW = 0
    local complete = false  
    
    descend(yLvl, targetLvl)

    while (complete == false) do
        
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

        if (indexW + 1 == width) then
            complete = true
        end

        turtle.turnLeft()
        turtle.dig()
        turtle.forward()
        turtle.digUp()
        turtle.digDown()
        turtle.turnLeft()

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

    returnHome(width)
    return 0
end

function descend(yLvl, targetLvl) 

    local destination = 0
    local blocks = yLvl - targetLvl
    local slot = 2
    local item = 0
    
    turtle.digDown()
    turtle.down()
    blocks = blocks - 1

    while (destination < blocks) do

        turtle.digDown()
        turtle.down()

        item = turtle.getItemDetail(slot)
        while (slot < 8 or item.name ~= "Dirt" or item.name ~= "Sand" or item.name ~= "Cobblestone" or item.name ~= "Basalt") do

            item = turtle.getItemDetail(slot)
            slot = slot + 1
        end

        slot = 2
        turtle.select(slot)
        turtle.placeUp()
        destination = destination + 1
    end
end


function inventoryControl() 

    local index = 2
    local item = 0

    while (index < 8) do

        item = turtle.select(index)

        if (item.name == "Cobblestone" or item.name == "Dirt" or item.name == "Sand" or item.name == "Basalt") then
            turtle.drop(item.count)
        end

        index = index + 1
    end

    if (turtle.getItemCount(8) > 0) then
        return 1
    end
end

function returnHome(width, yLvl, targetLvl)

    local index = 0

    turtle.turnRight()

    while (index < width) do

        if (turtle.forward() == false) then
            print("Unable to correctly return home..")
        end
        
        index = index + 1 
    end

    ascend(yLvl, targetLvl)
end

function refuel() 

    local fuelLvl = turtle.getFuelLevel()
    local index = 2
    local item = 0

    if (fuelLvl < 500) then

        if (turtle.getItemCount(1) < 2) then

            while (index < 9 and turtle.getItemCount(1) < 2) do
                item = turtle.getItemDetail(index)

                if (item.name == "Coal" or item.name == "Charcoal") then
                    turtle.select(index)
                    
                    while (turtle.getItemCount(index) > 0 and turtle.getFuelLevel() < 1000) do
                        turtle.refuel(1)     
                    end 

                    while (turle.getItemCount(1) < 64 and turtle.getItemCount(index) > 0) do
                        turtle.transferTo(1, 1)
                    end
                end

                if (index == 8 and turtle.getFuelLevel < 500) then
                    return -1
                end

                index = index + 1
            end
        end
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

print("Enter an Even Width for the Tunnel.. ")
width = getInt()

print("Enter the current Y level.. ")
yLvl = getInt()

print("Enter the target level.. ")
targetLvl = getInt()

while (width % 2 ~= 0) do
    print("Even numbers only..")
    width = getInt()
end

exitCode = tunnel(length, width, yLvl, targetLvl)

if (exitCode == 0) then
    print("Successfully completed task with inventory space remaining...")

elseif (exitCode == -1) then
    print("Critical fuel level reached, task abandoned...")

elseif (exitCode == 1) then
    print("Task aborted due to inventory control...")

else
    print("This shouldn't print...")
end
