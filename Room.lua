local Room = {
    tiles = {},
    IDX = nil,
    IDY = nil,
    up = nil,
    down = nil,
    left = nil,
    right = nil,
}

Tile = require 'Tile'
nextRoomID = 0

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
    local isOffset = 0
    local switch = 0
    local xAdjust = -11.5
    local yAdjust = -30
    local tempCirc

    for putY = 0, ROOM_TILE_SIZEY do
        isOffset = switch % 2
        for putX = 0, ROOM_TILE_SIZEX do
            if putX >= 9 and putX <= 14 or putY >= 23 and putY <= 37 then
                -- Quick Path
                if isOffset == 0 then
                    table.insert(self.tiles, Tile:new(
                        _, putX * TILE_PX_SIZEX, putY * TILE_PX_SIZEY
                    ))
                else  -- isOffset == 1
                    table.insert(self.tiles, Tile:new(
                        _, putX * TILE_PX_SIZEX - TILE_OFFSET, putY * TILE_PX_SIZEY
                    ))
                end
            else
                -- Circle
                tempCirc = math.pow(xAdjust*2.5+putX*2.5, 2) + 
                           math.pow(yAdjust+putY, 2)
                if tempCirc <= 700 then
                    if putX > 25  then
                        if isOffset == 0 then
                            if tempCirc + TILE_PX_SIZEX <= 700 then
                                table.insert(self.tiles, Tile:new(
                                    _, putX * TILE_PX_SIZEX, putY * TILE_PX_SIZEY
                                ))
                            end
                        else
                            if tempCirc + TILE_PX_SIZEX/2 <= 700 then
                                table.insert(self.tiles, Tile:new(
                                    _, putX * TILE_PX_SIZEX - TILE_OFFSET, putY * TILE_PX_SIZEY
                                ))
                            end
                        end
                    else
                        if isOffset == 0 then
                            table.insert(self.tiles, Tile:new(
                                _, putX * TILE_PX_SIZEX, putY * TILE_PX_SIZEY
                            ))
                        else
                            table.insert(self.tiles, Tile:new(
                                _, putX * TILE_PX_SIZEX - TILE_OFFSET, putY * TILE_PX_SIZEY
                            ))
                        end
                    end
                end
            end
        end
        switch = switch + 1
    end
end




--         if switch % 2 == 1 then
--             for putX = 0, ROOM_TILE_SIZEX do
--                 if putX >= 9 and putX <= 15 or putY >= 21 and putY <= 39 then
--                     table.insert(self.tiles, Tile:
--                     new(_, putX * TILE_PX_SIZEX - 16, putY * TILE_PX_SIZEY))
--                 else
--                     tempCirc = math.pow(xAdjust*2.5+putX*2.5, 2) + math.pow(yAdjust+putY, 2)
--                     if tempCirc <= 700 then
--                         if putX > 12 then
--                             if tempCirc + 32 <= 700 then
--                                 table.insert(self.tiles, Tile:
--                                 new(_, putX * TILE_PX_SIZEX - 16, putY * TILE_PX_SIZEY))
--                             end
--                         else
--                             table.insert(self.tiles, Tile:
--                             new(_, putX * TILE_PX_SIZEX - 16, putY * TILE_PX_SIZEY))
--                         end
--                     end
--                 end
--             end
--         else 
--             for putX = 0, ROOM_TILE_SIZEX do
--                 if putX >= 9 and putX <= 15 or putY >= 21 and putY <= 39 then
--                     table.insert(self.tiles, Tile:
--                     new(_, putX * TILE_PX_SIZEX, putY * TILE_PX_SIZEY))
--                 else
--                     tempCirc = math.pow(xAdjust*2.5+putX*2.5, 2) + math.pow(yAdjust+putY, 2)
--                     if tempCirc <= 700 then                 
--                         table.insert(self.tiles, Tile:
--                         new(_, putX * TILE_PX_SIZEX, putY * TILE_PX_SIZEY))
--                     end
--                 end
--             end
--         end
--         switch = switch + 1
--     end
-- end

function Room:renderTiles()
    for i = 1, #self.tiles do
        self.tiles[i]:render()
    end
end


return Room