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
        image = love.graphics.newImage('images/brickMiddle.png')

    elseif type == 'leftMid' then
        image = love.graphics.newImage('images/brickLeftMiddle.png')
        
    elseif type == 'rightMid' then
        image = love.graphics.newImage('images/brickRightMiddle.png')
 
    elseif type == 'topMid' then
        image = love.graphics.newImage('images/brickTopMiddle.png')

    elseif type == 'botMid' then
        image = love.graphics.newImage('images/brickBottomMiddle.png')

    elseif type == 'topLeft' then
        image = love.graphics.newImage('images/brickTopLeft.png')

    elseif type == 'topRight' then
        image = love.graphics.newImage('images/brickTopRight.png')

    elseif type == 'botLeft' then
        image = love.graphics.newImage('images/brickBottomLeft.png')

    elseif type == 'botRight' then
        image = love.graphics.newImage('images/brickBottomRight.png')
    end

    return image
end

return Randomizer