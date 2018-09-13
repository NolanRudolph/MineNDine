local Room = {}

Tile = require 'Tile'
nextRoomID = 0
TILE_PX_SIZEX = 32
TILE_PX_SIZEY = 32
X_HALF = WIDTH/2
X_ADJUST = (WIDTH/TILE_PX_SIZEX)/2
PATH_X = {HEIGHT/8 + 3 * (HEIGHT/8), HEIGHT/8 + 4 * (HEIGHT/8)}
Y_ADJUST = (HEIGHT/TILE_PX_SIZEY)/2
TILE_OFFSET = 16


function Room:new(room, IDX, IDY, index)
    room = room or {}
    setmetatable(room, self)
    room.tiles = {}
    room.IDX = IDX
    room.IDY = IDY
    room.index = index
    self.__index = self
    return room
end

--[[ To Use in main.lua love.draw() ]]--
function Room:initTiles()
    local tileY = 0
    local offset = 0
    for tileY = 0, HEIGHT/TILE_PX_SIZEY do
        local actualY = (tileY - Y_ADJUST) * TILE_PX_SIZEY
        local tileX = 0
        for tileX = 0, WIDTH/TILE_PX_SIZEX do
            local isOffset = offset % 2
            local y = tileY * TILE_PX_SIZEY
            local image
            local actualX = (tileX - X_ADJUST) * TILE_PX_SIZEX
            local hypot = math.sqrt(math.pow(actualX, 2) + math.pow(actualY, 2))
            local deg = (180/math.pi) * math.acos(actualX/hypot)
            local newX
            if isOffset == 0 then
                newX = tileX * TILE_PX_SIZEX
            elseif isOffset == 1 then
                newX = tileX * TILE_PX_SIZEX - TILE_OFFSET
            end
            if hypot <= 370 then
                if hypot <= 150 then
                    table.insert(self.tiles, Tile:new(newX, y, 'middle'))
                elseif deg >= 25 and deg <= 65 then
                    if tileY < Y_ADJUST then
                        table.insert(self.tiles, Tile:new(newX, y, 'topRight'))
                    else
                        table.insert(self.tiles, Tile:new(newX, y, 'botRight'))
                    end
                elseif deg >= 65 and deg <= 115 then
                    if tileY < Y_ADJUST then
                        table.insert(self.tiles, Tile:new(newX, y, 'topMid'))
                    else
                        table.insert(self.tiles, Tile:new(newX, y, 'botMid'))
                    end
                elseif deg >= 115 and deg <= 155 then
                    if tileY < Y_ADJUST then
                        table.insert(self.tiles, Tile:new(newX, y, 'topLeft'))
                    else
                        table.insert(self.tiles, Tile:new(newX, y, 'botLeft'))
                    end
                else
                    if tileX < X_ADJUST then
                        table.insert(self.tiles, Tile:new(newX, y, 'leftMid'))
                    else
                        table.insert(self.tiles, Tile:new(newX, y, 'rightMid'))
                    end
                end
            elseif tileX >= 9 and tileX <= 16 then  -- Proportionality tileX >= 10
                if tileX < X_ADJUST then
                    table.insert(self.tiles, Tile:new(newX, y, 'topMid'))
                else
                    table.insert(self.tiles, Tile:new(newX, y, 'botMid'))
                end
            elseif tileY >= 25 and tileY <= 39 then
                if tileX < Y_ADJUST then
                    table.insert(self.tiles, Tile:new(newX, y, 'leftMid'))
                else
                    table.insert(self.tiles, Tile:new(newX, y, 'rightMid'))
                end
            end
        end
        offset = offset + 1
    end
end

function Room:renderTiles()
    for i = 1, #self.tiles do
        self.tiles[i]:render()
    end
end

return Room