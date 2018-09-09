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
        image = love.graphics.newImage('images/brickNoLight.png')
        return image
    elseif type == 'topRight' then
        image = love.graphics.newImage('images/brickTopRight.png')
        return image
    elseif type == 'topLeft' then
        image = love.graphics.newImage('images/brickTopLeft.png')
        return image
    elseif type == 'botLeft' then
        image = love.graphics.newImage('images/brickBottomLeft.png')
        return image
    elseif type == 'botRight' then
        image = love.graphics.newImage('images/brickBottomRight.png')
        return image
    end
end

return Randomizer