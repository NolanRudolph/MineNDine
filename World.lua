local World = {
    rooms = {}
}
world = love.physics.newWorld(0, 0, true)  --create a world for the bodies to exist in with horizontal gravity of 0 and vertical gravity of 9.81
TILE_PX_SIZE = 32
ROOM_TILE_SIZE = 25
nextRoomID = 0

function World:makeRoom()
    
    newRoom = {
        tiles = {},
        ID = self.getRoomID(),
        up = nil,
        down = nil,
        left = nil,
        right = nil
    }

    newRoom.tiles.insert(World:makeTile(0, 0))


    self.rooms[newRoom.ID] = newRoom
end

--[[ Always Return Unique ID ]]--
function World:getRoomID()
    nextRoomID = nextRoomID + 1
    return nextRoomID
end

--[[ x, y is Tile Position ]]--
function World:makeTile(x, y)
    newTile = {}
    newTile.body = love.physics.newBody(world, x/2-TILE_PX_SIZE/2, y/2-TILE_PX_SIZE/2, "static")
    newTile.shape = love.physics.newRectangleShape(TILE_PX_SIZE, TILE_PX_SIZE)
    newTile.fixture = love.physics.newFixture(newTile.body, newTile.shape)
    return newTile
end





return World