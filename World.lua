local World = {
    rooms = {},
    nextRoomIDX = 0,
    nextRoomIDY = 0,
    currentRoom = {0, 0}
}

Room = require 'Room'

--[[ Always Return Unique ID ]]--

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

function World:getRoomX(direction)
    if direction == 'left' then
        self.nextRoomIDX = self.nextRoomIDX - 1
    elseif direction == 'right' then
        self.nextRoomIDX = self.nextRoomIDX + 1
    elseif direction == 'start' then
        return self.nextRoomIDX
    end
    return self.nextRoomIDX
end

function World:getRoomY(direction)
    if direction == 'down' then
        self.nextRoomIDY = self.nextRoomIDY - 1
    elseif direction == 'up' then
        self.nextRoomIDY = self.nextRoomIDY + 1
    elseif direction == 'start' then
        return self.nextRoomIDY
    end
    return self.nextRoomIDY
end

function World:makeRoom()
    -- Room:newRoom(700,700)
    -- self.rooms[newRoom.ID] = Room:newRoom(700, 700)
end

return World