-- main.lua

conf = require 'conf'
utils = require 'utils'
Hero = require 'Hero'
World = require 'World'
Room = require 'Room'
METER_IN_PX = 64
TILE_PX_SIZEX = 32
TILE_PX_SIZEY = 12
TILE_OFFSET = 16
ROOM_TILE_SIZEX = 24
ROOM_TILE_SIZEY = 62


function love.load()
    world = love.physics.newWorld(0, 0, true)  --create a world for the bodies to exist in with horizontal gravity of 0 and vertical gravity of 9.81
    
    --[[ Loading Physics ]]--

    love.physics.setMeter(METER_IN_PX)  --the height of a meter our worlds will be 64px
    enemies = {}

    --[[ Loading Hero ]]--
    math.randomseed(os.time())
    Hero:newHero(400, 400, 50, 80)
    table.insert(World.rooms, Room:new(_, 0, 0, World:getIndex()))   -- Start (1)
    World.rooms[1]:initTiles()
end

function love.update(dt)  -- Updates Every dt (Delta Time)
    world:update(dt)  --this puts the world into motion
    Hero:update()

    if Hero.roomCooldown > 0 then
        Hero.roomCooldown = Hero.roomCooldown - 1000 * dt
    end

    --[[--[[  SCREEN SHIFTING ]]--]]--

    local xComp = Hero.body:getX()
    local yComp = Hero.body:getY()
    --[[ Changing Left ]]--
    if xComp > -60 and xComp < -50 then
        if Hero.roomCooldown > 0 then
            print("You can't leave just yet!")
            Hero.body:setX(0)
            return
        end
        -- this is a comment nolan is awesome
        World.currentRoom[1] = World.currentRoom[1] - 1  -- Decrease World's RoomX
        print('{' .. World.currentRoom[1] .. ', ' .. World.currentRoom[2] .. '}')
        World:checkEntries()
        Hero.roomCooldown = 1000
        Hero.body:setX(810)

    --[[ Changing Right ]]--
    elseif xComp > 850 and xComp < 860 then
        if Hero.roomCooldown > 0 then
            print("You can't leave just yet!")
            Hero.body:setX(850)
            return
        end
        World.currentRoom[1] = World.currentRoom[1] + 1  -- Decrease World's RoomX
        print('{' .. World.currentRoom[1] .. ', ' .. World.currentRoom[2] .. '}')
        World:checkEntries()
        Hero.roomCooldown = 1000
        Hero.body:setX(-60)

    --[[ Changing Up ]]--
    elseif yComp < -80 and xComp > -90 then
        if Hero.roomCooldown > 0 then
            print("You can't leave just yet!")
            Hero.body:setY(0)
            return
        end
        World.currentRoom[2] = World.currentRoom[2] + 1  -- Decrease World's RoomX
        print('{' .. World.currentRoom[1] .. ', ' .. World.currentRoom[2] .. '}')
        World:checkEntries()
        Hero.roomCooldown = 1000
        Hero.body:setY(810)

    --[[ Changing Down ]]--
    elseif yComp > 800 and yComp < 810 then
        if Hero.roomCooldown > 0 then
            print("You can't leave just yet!")
            Hero.body:setY(720)
            return
        end
        World.currentRoom[2] = World.currentRoom[2] - 1  -- Decrease World's RoomX
        print('{' .. World.currentRoom[1] .. ', ' .. World.currentRoom[2] .. '}')
        World:checkEntries()
        Hero.roomCooldown = 1000
        Hero.body:setY(-90)

    end

end


function love.keydown(key)

end


function love.draw()  -- Updates Every Frame
    World.rooms[World.currentIndex]:renderTiles()
    love.graphics.setColor(255, 255, 255)
    -- love.graphics.print('This is Room {' .. World.currentRoom[1] .. ', ' .. World.currentRoom[2] .. '}', 15, 15)
    Hero:renderHero()

    --[[ TROUBLE SHOOTING ]]--

    local tempX = 0
    local tempY = 0
    local offSet = 0
    local count = 1
    local tempCount0 = 1
    local tempCount24 = 1
    while tempY < love.graphics.getHeight() do
        tempX = 0
        while tempX <= love.graphics.getWidth() do
            if count == 1 then
                love.graphics.print(tempCount0, tempX + 3, 0)
                tempCount0 = tempCount0 + 1
            end
            if count == 23 then
                love.graphics.print(tempCount24, tempX + 3, love.graphics.getHeight() - TILE_PX_SIZEY * 2)
                tempCount24 = tempCount24 + 1
            end
            if offSet % 2 == 0 then
                love.graphics.rectangle('fill', tempX, tempY, 1, TILE_PX_SIZEY)
            else
                love.graphics.rectangle('fill', tempX - TILE_OFFSET, tempY, 1, TILE_PX_SIZEY)
            end
            tempX = tempX + TILE_PX_SIZEX
        end
        love.graphics.print(count, 0, tempY - 1)
        love.graphics.print(count, love.graphics.getWidth() - TILE_PX_SIZEY - 3, tempY - 1)
        love.graphics.rectangle('fill', 0, tempY, 1000, 1)
        tempY = tempY + TILE_PX_SIZEY
        count = count + 1
        offSet = offSet + 1
    end
end