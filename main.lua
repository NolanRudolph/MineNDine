-- main.lua

utils = require 'utils'
Hero = require 'Hero'
World = require 'World'
Room = require 'Room'
METER_IN_PX = 64
TILE_PX_SIZEX = 24
TILE_PX_SIZEY = 16
ROOM_TILE_SIZEX = 32
ROOM_TILE_SIZEY = 48


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
    love.graphics.setColor(0, 0, 0)
    love.graphics.print('This is Room {' .. World.currentRoom[1] .. ', ' .. World.currentRoom[2] .. '}', 15, 15)
    love.graphics.setColor(255, 255, 255)
    Hero:renderHero()
end