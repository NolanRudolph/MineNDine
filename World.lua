local World = {
    rooms = {},
    nextRoomIDX = 0,
    nextRoomIDY = 0,
    currentIndex = 1,
    nextIndex = 0,
    currentRoom = {0, 0}
}

Room = require 'Room'

--[[ Always Return Unique ID ]]--

function World:getIndex()
    self.nextIndex = self.nextIndex + 1
    return self.nextIndex
end


function World:getRoomStartX(direction)
    if direction == 'left' then
        return -1
    elseif direction == 'right' then
        return 1
    else
        return 0
    end
end

function World:getRoomStartY(direction)
    if direction == 'down' then
        return -1
    elseif direction == 'up' then
        return 1
    else
        return 0
    end
end

function World:checkEntries()
    local found = 0
    for i = 1, #self.rooms do
        iRoom = self.rooms[i]
        roomX = iRoom.IDX
        roomY = iRoom.IDY
        if roomX == self.currentRoom[1] and roomY == self.currentRoom[2] then
            found = 1
            self.currentIndex = iRoom.index
            return
        end
    end
    if found == 0 then
        local myIndex = World:getIndex()
        table.insert(self.rooms, Room:new(_, self.currentRoom[1], self.currentRoom[2], myIndex))
        self.rooms[myIndex]:initTiles()
        self.currentIndex = self.rooms[myIndex].index
        if GLOBAL_ANGLE % 2 ~= 0 then
            self.rooms[myIndex]:turnTiles('right')
        end
        print("Made a Room!")
    end
end
            


return World