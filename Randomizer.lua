local Randomizer = {}

function Randomizer:new(randomizer)
    randomizer = randomizer or {}
    setmetatable(randomizer, self)
    self.__index = self

    return randomizer
end

function Randomizer:pickImage(place)

    local image
    if place == 'middle' then
        image = love.graphics.newImage('images/default.png')
        return image
    end
    local RandNum = math.random(1, 3)
    if RandNum >= 1 then
        image = love.graphics.newImage('images/brickNoLight.png')
        return image
    end
end

return Randomizer