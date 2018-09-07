local Randomizer = {}

function Randomizer:new(randomizer)
    randomizer = randomizer or {}
    setmetatable(randomizer, self)
    self.__index = self

    return randomizer
end

function Randomizer:pickImage()

    local image
    local RandNum = math.random(1, 6)
    if RandNum == 1 then
        image = love.graphics.newImage('images/brick1.png')
        return image
    elseif RandNum == 2 then
        image = love.graphics.newImage('images/brick2.png')
        return image
    elseif RandNum == 3 then
        image = love.graphics.newImage('images/brick3.png')
        return image
    elseif RandNum == 4 then
        image = love.graphics.newImage('images/brick4.png')
        return image
    elseif RandNum == 5 then
        image = love.graphics.newImage('images/brick5.png')
        return image
    elseif RandNum == 6 then
        image = love.graphics.newImage('images/brick6.png')
        return image
    end
end

return Randomizer