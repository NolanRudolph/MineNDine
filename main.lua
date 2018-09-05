-- main.lua

utils = require 'utils'
Hero = require 'Hero'
World = require 'World'
METER_IN_PX = 64

function love.load()

    --[[ Loading Physics ]]--

    love.physics.setMeter(METER_IN_PX)  --the height of a meter our worlds will be 64px
    enemies = {}

    --[[ Loading Hero ]]--

    Hero:newHero(250, 250, 50, 80)
end


function love.update(dt)  -- Updates Every dt (Delta Time)
    world:update(dt)  --this puts the world into motion
    Hero:update()
end


function love.keydown(key)

end


function love.draw()  -- Updates Every Frame
    Hero:renderHero()
end