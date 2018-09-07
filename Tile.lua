local Tile = {}

Randomizer = require 'Randomizer'
--[[ tileX, tileY is Tile Position ]]--

function Tile:new(tile, x, y)
    tile = tile or {}
    setmetatable(tile, self)
    tile.x = x
    tile.y = y
    imagePicker = Randomizer:new()
    tile.image = imagePicker:pickImage()
    self.__index = self
    
    return tile
end

--[[ Draw Tile (Call After tile:generateColor()) ]]--
function Tile:render()
    love.graphics.draw(self.image, self.x, self.y)
end

return Tile