local Tile = {

}


Randomizer = require 'Randomizer'

function Tile:new(x, y, cycle)
    tile = {}
    setmetatable(tile, self)
    self.__index = self
    tile.x = x
    tile.y = y
    tile.cycle = cycle

    --[[ So shit gets messed up if you don't do this. ]]--
    tile.relX = tile.x - WIDTH/2 + TILE_PX_SIZEX/2
    tile.relY = tile.y - HEIGHT/2 + TILE_PX_SIZEY/2
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

    tile.count = 0
    tile:setUp()
    return tile
end

--[[ Shit also gets messed up if you don't do this, due to shit up there ^]]--
function Tile:setUp()
    if self.deg > 0 then
        self.deg = self.deg + 180
        self.x = math.cos(math.rad(self.deg)) * self.hypot + 400
        self.y = math.sin(math.rad(self.deg)) * self.hypot + 400
    elseif self.deg < 0 then
        self.deg = math.abs(self.deg)
        self.x = math.cos(math.rad(self.deg)) * self.hypot + 400
        self.y = math.sin(math.rad(self.deg)) * self.hypot + 400
    end
end

--[[ Rotates Tiles ]]--
--[[
    If any memory leaks occur, look here first. self.deg increases forever.
    This isn't a big deal because I've tested it and normally it would
    require 724 45 degree turns in the same direction (2^15) but I tested
    it and it went past 724 turns. But still be weary.
]]
function Tile:rotate(direction)
    if direction == 'right' then
        self.deg = self.deg + 45
        self.x = math.cos(math.rad(self.deg)) * self.hypot + 400
        self.y = math.sin(math.rad(self.deg)) * self.hypot + 400
        self.count = self.count + 1
        if self.cycle == 17 then
            self.cycle = 18
        elseif self.cycle == 18 then
            self.cycle = 17
        elseif self.cycle == 15 then
            self.cycle = 1
        elseif self.cycle == 16 then
            self.cycle = 2
        else
            self.cycle = self.cycle + 2
        end
    elseif direction == 'left' then
        self.deg = self.deg - 45
        self.x = math.cos(math.rad(self.deg)) * self.hypot + 400
        self.y = math.sin(math.rad(self.deg)) * self.hypot + 400
        if self.cycle == 17 then
            self.cycle = 18
        elseif self.cycle == 18 then
            self.cycle = 17
        elseif self.cycle == 1 then
            self.cycle = 15
        elseif self.cycle == 2 then
            self.cycle = 16
        else
            self.cycle = self.cycle - 2
        end
    end
end

--[[ Draw Tile (Call After EVERYTHING_ELSE()) ]]--
function Tile:render()
    love.graphics.draw(TILE_CYCLE[self.cycle], self.x + HALF_TILEX, self.y + HALF_TILEY)  
    -- + HALF_TILEX / + HALF_TILEY cuz self.hypot

end



return Tile