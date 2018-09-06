-- main.lua

utils = require 'utils'
Hero = require 'Hero'
World = require 'World'
Room = require 'Room'
METER_IN_PX = 64
TILE_PX_SIZE = 32

function love.load()
    world = love.physics.newWorld(0, 0, true)  --create a world for the bodies to exist in with horizontal gravity of 0 and vertical gravity of 9.81
    
    --[[ Loading Physics ]]--

    love.physics.setMeter(METER_IN_PX)  --the height of a meter our worlds will be 64px
    enemies = {}

    --[[ Loading Hero ]]--

    Hero:newHero(250, 250, 50, 80)
    Room:new()
    Room:initTiles()

end

function love.update(dt)  -- Updates Every dt (Delta Time)
    world:update(dt)  --this puts the world into motion
    Hero:update()
end

function love.keydown(key)

end


function love.draw()  -- Updates Every Frame
    love.graphics.setColor(255, 255, 255)
    Room:renderTiles()
    Hero:renderHero()
end