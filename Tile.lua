local Tile = {}

Randomizer = require 'Randomizer'
--[[ tileX, tileY is Tile Position ]]--

function Tile:new(x, y, type)
    tile = {}
    setmetatable(tile, self)
    tile.x = x
    tile.y = y
    imagePicker = Randomizer:new()
    tile.image = imagePicker:pickImage(type)
    self.__index = self
    tile.relX = x - WIDTH/2 + TILE_PX_SIZEX/2
    tile.relY = y - HEIGHT/2 + TILE_PX_SIZEY/2
    tile.hypot = math.sqrt(math.pow(tile.relX, 2) + math.pow(tile.relY, 2))
    if tile.relY < 0 then 
        tile.deg = math.deg(math.acos(tile.relX/tile.hypot))
    elseif tile.relY > 0 then
        tile.deg = -math.deg(math.acos(tile.relX/tile.hypot))
    elseif tile.relY == 0 and tile.relX > 0 then
        tile.deg = -180
    elseif tile.relY == 0 and tile.relX < 0 then
        tile.deg = 180
    elseif tile.relY == 0 and tile.relX == 0 then
        tile.deg = 180
    end

    tile:setUp()
    
    return tile
end

function Tile:setUp()
    if self.deg == 0 then
        print('My degree is 0!')
    elseif self.deg > 0 then
        self.deg = self.deg + 180
        self.x = math.cos(math.rad(self.deg)) * self.hypot + 400
        self.y = math.sin(math.rad(self.deg)) * self.hypot + 400
    elseif self.deg < 0 then
        self.deg = math.abs(self.deg)
        self.x = math.cos(math.rad(self.deg)) * self.hypot + 400
        self.y = math.sin(math.rad(self.deg)) * self.hypot + 400
    end
end

function Tile:rotate(direction)
    if direction == 'right' then
        self.deg = self.deg + 45
        self.x = math.cos(math.rad(self.deg)) * self.hypot + 400
        self.y = math.sin(math.rad(self.deg)) * self.hypot + 400
    elseif direction == 'left' then
        self.deg = self.deg - 45
        self.x = math.cos(math.rad(self.deg)) * self.hypot + 400
        self.y = math.sin(math.rad(self.deg)) * self.hypot + 400
    end
end

--[[ Draw Tile (Call After tile:generateColor()) ]]--
function Tile:render()
    love.graphics.draw(self.image, self.x, self.y)
end



return Tile