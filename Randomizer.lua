local Randomizer = {}

function Randomizer:new(randomizer)
    randomizer = randomizer or {}
    setmetatable(randomizer, self)
    self.__index = self

    return randomizer
end

function Randomizer:pickImage(type)
    local image
    if type == 'norm' then
        image = love.graphics.newImage('images/default.png')
        return image

    elseif type == 'middle' then
        image = love.graphics.newImage('images/brickMiddleW.png')

    elseif type == 'leftMid' then
        image = love.graphics.newImage('images/brickLeftMiddleW.png')
        
    elseif type == 'rightMid' then
        image = love.graphics.newImage('images/brickRightMiddleW.png')
 
    elseif type == 'topMid' then
        image = love.graphics.newImage('images/brickTopMiddleW.png')

    elseif type == 'botMid' then
        image = love.graphics.newImage('images/brickBottomMiddleW.png')

    elseif type == 'topLeft' then
        image = love.graphics.newImage('images/brickTopLeftW.png')

    elseif type == 'topRight' then
        image = love.graphics.newImage('images/brickTopRightW.png')

    elseif type == 'botLeft' then
        image = love.graphics.newImage('images/brickBottomLeftW.png')

    elseif type == 'botRight' then
        image = love.graphics.newImage('images/brickBottomRightW.png')
    end

    return image
end

return Randomizer