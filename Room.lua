local Room = {}

Tile = require 'Tile'
nextRoomID = 0
TILE_PX_SIZEX = 32
TILE_PX_SIZEY = 32
X_HALF = WIDTH/2
X_ADJUST = (WIDTH/TILE_PX_SIZEX)/2
PATH_X = {HEIGHT/8 + 3 * (HEIGHT/8), HEIGHT/8 + 4 * (HEIGHT/8)}
Y_ADJUST = (HEIGHT/TILE_PX_SIZEY)/2


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

function Room:initTiles()
    local axisY = 0
    for axisY = 0, HEIGHT/TILE_PX_SIZEY do
        local actualY = (axisY - Y_ADJUST) * TILE_PX_SIZEY
        local axisX = 0
        for axisX = 0, WIDTH/TILE_PX_SIZEX do

            local image
            local actualX = (axisX - X_ADJUST) * TILE_PX_SIZEX
            local hypot = math.sqrt(math.pow(actualX+16, 2) + math.pow(actualY+16, 2))
            local deg = math.deg(math.acos(actualX/hypot)) 
            local newX = axisX * TILE_PX_SIZEX
            local newY = axisY * TILE_PX_SIZEY

            if hypot <= 420 then
                if hypot <= 150 then
                    table.insert(self.tiles, Tile:new(newX, newY, 'middle'))
                elseif deg >= 25 and deg <= 65 then
                    if axisY < Y_ADJUST then
                        table.insert(self.tiles, Tile:new(newX, newY, 'topRight'))
                    else
                        table.insert(self.tiles, Tile:new(newX, newY, 'botRight'))
                    end
                elseif deg >= 65 and deg <= 115 then
                    if axisY < Y_ADJUST then
                        table.insert(self.tiles, Tile:new(newX, newY, 'topMid'))
                    else
                        table.insert(self.tiles, Tile:new(newX, newY, 'botMid'))
                    end
                elseif deg >= 115 and deg <= 155 then
                    if axisY < Y_ADJUST then
                        table.insert(self.tiles, Tile:new(newX, newY, 'topLeft'))
                    else
                        table.insert(self.tiles, Tile:new(newX, newY, 'botLeft'))
                    end
                else
                    if axisX < X_ADJUST then
                        table.insert(self.tiles, Tile:new(newX, newY, 'leftMid'))
                    else
                        table.insert(self.tiles, Tile:new(newX, newY, 'rightMid'))
                    end
                end
            end
        end
    end
end

function Room:turnTiles(direction)
    for i = 1, #self.tiles do
        self.tiles[i]:rotate(direction)
    end
end

function Room:renderTiles()
    for i = 1, #self.tiles do
        self.tiles[i]:render()
    end
end

return Room