-- main.lua

WIDTH = love.graphics.getWidth()
HEIGHT = love.graphics.getHeight()

conf = require 'conf'
troubleShoot = require 'troubleShoot'
utils = require 'utils'
Hero = require 'Hero'
World = require 'World'
Room = require 'Room'

TILE_CYCLE = {
    love.graphics.newImage('images/brickTopRightW.png'),     -- 1 ^>
    love.graphics.newImage('images/brickRightMiddleW.png'),  -- 2 >
    love.graphics.newImage('images/brickBottomRightW.png'),  -- 3 .>
    love.graphics.newImage('images/brickBottomMiddleW.png'),     -- 4 .
    love.graphics.newImage('images/brickBottomLeftW.png'),       -- 5 <.
    love.graphics.newImage('images/brickLeftMiddleW.png'),       -- 6 <
    love.graphics.newImage('images/brickTopLeftW.png'),           -- 7 <^
    love.graphics.newImage('images/brickTopMiddleW.png'),    -- 8 ^
    love.graphics.newImage('images/brickMiddleW.png'),
}
METER_IN_PX = 64
BUFFER = 0

local shader_code = [[

/* PHONG SHADING ALROGITHM */

#define NUM_LIGHTS 32

struct Light {
    vec2 position;
    vec3 diffuse;
    float power;
};

extern Light lights[NUM_LIGHTS];
extern int num_lights;
extern vec2 screen;

const float constant = 1.0;
const float linear = 0.09;
const float quadratic = 0.032;


vec4 effect(vec4 color, Image image, vec2 uvs, vec2 screen_coords)
{
    vec4 pixel = Texel(image, uvs);

    vec2 norm_screen = screen_coords / screen;
    vec3 diffuse = vec3(0);
    int i;
    for (i = 0; i < num_lights; i++)
    {
        Light light = lights[i];
        vec2 norm_pos = light.position / screen;

        float distance = length(norm_pos - norm_screen) * light.power;
        float attenuation = 1.0 / (constant + linear * distance * 
                                   quadratic * (distance * distance));

        diffuse += light.diffuse * attenuation;
    }

    diffuse = clamp(diffuse, 0.0, 1.0);

    return pixel * vec4(diffuse, 1.0);
}

]]

COUNTER = 0
function love.load()
    shader = love.graphics.newShader(shader_code)
    world = love.physics.newWorld(0, 0, true)  --create a world for the bodies to exist in with horizontal gravity of 0 and vertical gravity of 9.81
    
    --[[ Loading Physics ]]--

    love.physics.setMeter(METER_IN_PX)  --the height of a meter our worlds will be 64px
    -- enemies = {}

    --[[ Loading Hero ]]--
    math.randomseed(os.time())
    Hero:newHero(400, 400, 50, 80)
    table.insert(World.rooms, Room:new(_, 0, 0, World:getIndex()))   -- Start (1)
    World.rooms[1]:initTiles()
end

function love.keypressed(key)
    if key == 'q' then
        World.rooms[World.currentIndex]:turnTiles('left')

    elseif key == 'e' then
        World.rooms[World.currentIndex]:turnTiles('right')
    end
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
        Hero.body:setLinearVelocity(0, 0)
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
        Hero.body:setLinearVelocity(0, 0)
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
        Hero.body:setLinearVelocity(0, 0)
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
        Hero.body:setLinearVelocity(0, 0)
        World:checkEntries()
        Hero.roomCooldown = 1000
        Hero.body:setY(-90)

    end
end


function love.draw()  -- Updates Every Frame

    --[[ Shader Commands ]]--
    love.graphics.setShader(shader)

    shader:send("screen", {
        love.graphics.getWidth(),
        love.graphics.getHeight()
    })
    shader:send("num_lights", 1)
    shader:send("lights[0].position", {
        WIDTH / 2, HEIGHT / 2
    })
    shader:send("lights[0].diffuse", {
        1, 1, 1
    })
    shader:send("lights[0].power", 15)


    World.rooms[World.currentIndex]:renderTiles()
    love.graphics.setColor(255, 255, 255)
    love.graphics.print('This is Room {' .. World.currentRoom[1] .. ', ' .. World.currentRoom[2] .. '}', 15, 15)
    Hero:renderHero()
    love.graphics.setShader()

end