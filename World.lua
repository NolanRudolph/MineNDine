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

function World:checkEntries(direction)
    local leftFound = 0
    local rightFound = 0
    local upFound = 0
    local downFound = 0
    local allGood = 0  -- Need 3 to Override Loop
    _compX = self.currentRoom[1] - 1  -- Left
    compX = self.currentRoom[1] + 1  -- Right
    _compY = self.currentRoom[2] - 1  -- Down
    compY = self.currentRoom[2] + 1  -- Up

    for i = 1, #self.rooms do
        iRoom = self.rooms[i]
        roomX = iRoom.IDX
        roomY = iRoom.IDY
        -- Find CurrentIndex To Ease Love.Draw()
        if roomX == self.currentRoom[1] and roomY == self.currentRoom[2] then
            self.currentIndex = iRoom.index
        elseif roomX == _compX and roomY == self.currentRoom[2] then
            leftFound = 1
            allGood = allGood + 1    
            print("Found Left Room!")        
        elseif roomX == compX and roomY == self.currentRoom[2] then
            rightFound = 1
            allGood = allGood + 1
            print("Found Right Room!")     
        elseif roomY == _compY and roomX == self.currentRoom[1] then
            downFound = 1
            allGood = allGood + 1
            print("Found Down Room!")     
        elseif roomY == compY and roomX == self.currentRoom[1] then
            upFound = 1
            allGood = allGood + 1
            print("Found Up Room!")     
        end

        if allGood == 4 then
            return
        end
    end
    if leftFound == 0 then
        local myIndex = World:getIndex()
        table.insert(self.rooms, Room:new(_, self.currentRoom[1] - 1, self.currentRoom[2], myIndex))
        self.rooms[myIndex]:initTiles()
        print("Created: "..myIndex)
    end
    if rightFound == 0 then
        local myIndex = World:getIndex()
        table.insert(self.rooms, Room:new(_, self.currentRoom[1] + 1, self.currentRoom[2], myIndex))
        self.rooms[myIndex]:initTiles()
        print("Created: "..myIndex)
    end
    if upFound == 0 then
        local myIndex = World:getIndex()
        table.insert(self.rooms, Room:new(_, self.currentRoom[1], self.currentRoom[2] + 1, myIndex))
        self.rooms[myIndex]:initTiles()
        print("Created: "..myIndex)
    end
    if downFound == 0 then
        local myIndex = World:getIndex()
        table.insert(self.rooms, Room:new(_, self.currentRoom[1], self.currentRoom[2] - 1, myIndex))
        self.rooms[myIndex]:initTiles()
        print("Created: "..myIndex)
    end
end
            


return World