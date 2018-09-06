local Room = {
    tiles = {},
    ID = nil,
    up = nil,
    down = nil,
    left = nil,
    right = nil,
}

Tile = require 'Tile'

TILE_PX_SIZE = 32
ROOM_TILE_SIZE = 25
nextRoomID = 0

function Room:new(room)
    room = room or {}
    setmetatable(room, self)
    room.tiles = {}
    self.__index = self
    return o
end

--[[ Always Return Unique ID ]]--
function Room:getRoomID()
    self.nextRoomID = self.nextRoomID + 1
    return self.nextRoomID
end

--[[ To Use in main.lua love.draw() ]]--
function Room:initTiles()
    table.insert(self.tiles, Tile:new(_, 250, 250))
    table.insert(self.tiles, Tile:new(_, 500, 500))
    print(self.tiles[1].color)
    print(self.tiles[1].x)
    print(self.tiles[2].color)
    print(self.tiles[2].x)
    -- for putY = 0, ROOM_TILE_SIZE do
    --     for putX = 0, ROOM_TILE_SIZE do
    --         math.randomseed(os.time())
    --         table.insert(self.tiles, Tile:new(_, putX * ROOM_TILE_SIZE, putY * ROOM_TILE_SIZE))
    --     end
    -- end
end

function Room:renderTiles()
    for i = 1, #self.tiles do
        self.tiles[i]:render()
    end
end


return Room