local Tile = {
    tileX,
    tileY,
}

TILE_PX_SIZE = 32
--[[ tileX, tileY is Tile Position ]]--

function Tile:new(tile, x, y)
    tile = tile or {}
    setmetatable(tile, self)
    tile.x = x
    tile.y = y
    math.randomseed(os.time())
    tile.color = math.random(1,6)
    self.__index = self
    return tile
end

--[[ Draw Tile (Call After tile:generateColor()) ]]--
function Tile:render()
    if self.color == 1 then
        local image = love.graphics.newImage('images/red.png')
        love.graphics.draw(image, self.x, self.y)
        return
    elseif self.color == 2 then
        local image = love.graphics.newImage('images/orange.png')
        love.graphics.draw(image, self.x, self.y)
        return
    elseif self.color == 3 then
        local image = love.graphics.newImage('images/yellow.png')
        love.graphics.draw(image, self.x, self.y)
        return
    elseif self.color == 4 then
        local image = love.graphics.newImage('images/green.png')
        love.graphics.draw(image, self.x, self.y)
        return
    elseif self.color == 5 then
        local image = love.graphics.newImage('images/blue.png')
        love.graphics.draw(image, self.x, self.y)
        return
    elseif self.color == 6 then
        local image = love.graphics.newImage('images/purple.png')
        love.graphics.draw(image, self.x, self.y)
        return
    end
end

return Tile