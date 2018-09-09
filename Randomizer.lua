local Randomizer = {}

function Randomizer:new(randomizer)
    randomizer = randomizer or {}
    setmetatable(randomizer, self)
    self.__index = self

    return randomizer
end

function Randomizer:pickImage(type)
    randNum = math.random(1, 3)
    local image
    if type == 'norm' then
        image = love.graphics.newImage('images/default.png')
        return image

    elseif type == 'middle' then
        if randNum == 1 then
            image = love.graphics.newImage('images/brickMiddle.png')
        elseif randNum == 2 then
            image = love.graphics.newImage('images/brickMiddle2.png')
        elseif randNum == 3 then
            image = love.graphics.newImage('images/brickMiddle3.png')
        end
        

    elseif type == 'leftMid' then
        if randNum == 1 then
            image = love.graphics.newImage('images/brickLeftMiddle.png')
        elseif randNum == 2 then
            image = love.graphics.newImage('images/brickLeftMiddle2.png')
        elseif randNum == 3 then
            image = love.graphics.newImage('images/brickLeftMiddle3.png')
        end
        

    elseif type == 'rightMid' then
        if randNum == 1 then
            image = love.graphics.newImage('images/brickRightMiddle.png')
        elseif randNum == 2 then
            image = love.graphics.newImage('images/brickRightMiddle2.png')
        elseif randNum == 3 then
            image = love.graphics.newImage('images/brickRightMiddle3.png')
        end

    elseif type == 'topMid' then
        if randNum == 1 then
            image = love.graphics.newImage('images/brickTopMiddle.png')
        elseif randNum == 2 then
            image = love.graphics.newImage('images/brickTopMiddle2.png')
        elseif randNum == 3 then
            image = love.graphics.newImage('images/brickTopMiddle3.png')
        end

    elseif type == 'botMid' then
        if randNum == 1 then
            image = love.graphics.newImage('images/brickBottomMiddle.png')
        elseif randNum == 2 then
            image = love.graphics.newImage('images/brickBottomMiddle2.png')
        elseif randNum == 3 then
            image = love.graphics.newImage('images/brickBottomMiddle3.png')
        end

    elseif type == 'topLeft' then
        if randNum == 1 then
            image = love.graphics.newImage('images/brickTopLeft.png')
        elseif randNum == 2 then
            image = love.graphics.newImage('images/brickTopLeft2.png')
        elseif randNum == 3 then
            image = love.graphics.newImage('images/brickTopLeft3.png')
        end

    elseif type == 'topRight' then
        if randNum == 1 then
            image = love.graphics.newImage('images/brickTopRight.png')
        elseif randNum == 2 then
            image = love.graphics.newImage('images/brickTopRight2.png')
        elseif randNum == 3 then
            image = love.graphics.newImage('images/brickTopRight3.png')
        end

    elseif type == 'botLeft' then
        if randNum == 1 then
            image = love.graphics.newImage('images/brickBottomLeft.png')
        elseif randNum == 2 then
            image = love.graphics.newImage('images/brickBottomLeft2.png')
        elseif randNum == 3 then
            image = love.graphics.newImage('images/brickBottomLeft3.png')
        end

    elseif type == 'botRight' then
        if randNum == 1 then
            image = love.graphics.newImage('images/brickBottomRight.png')
        elseif randNum == 2 then
            image = love.graphics.newImage('images/brickBottomRight2.png')
        elseif randNum == 3 then
            image = love.graphics.newImage('images/brickBottomRight3.png')
        end
    end

    return image
end

return Randomizer