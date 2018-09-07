local Randomizer = {}

function Randomizer:new(randomizer)
    randomizer = randomizer or {}
    setmetatable(randomizer, self)
    self.__index = self

    return randomizer
end

function Randomizer:pickImage()

    local image
    local RandNum = math.random(1, 10)
    if RandNum >= 1 and RandNum <= 9 then
        image = love.graphics.newImage('images/brick1.png')
        return image
    elseif RandNum == 10 then
        image = love.graphics.newImage('images/brick2.png')
        return image
    end
end

return Randomizer