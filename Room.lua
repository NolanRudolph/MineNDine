local Room = {}

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

    for putY = 0, ROOM_TILE_SIZEY do
        isOffset = switch % 2
        for putX = 0, ROOM_TILE_SIZEX do

            local hypot = math.pow(xAdjust*2.7+putX*2.7, 2) + 
            math.pow(yAdjust+putY, 2)

            if putX >= 9 and putX <= 14 or putY >= 23 and putY <= 37 then
                if hypot <= 200 then  -- Should this be a Middle brick?
                    if isOffset == 0 then
                        table.insert(self.tiles, Tile:new(
                            _, putX * TILE_PX_SIZEX, putY * TILE_PX_SIZEY, 'middle'
                        ))
                    else
                        table.insert(self.tiles, Tile:new(
                            _, putX * TILE_PX_SIZEX - TILE_OFFSET, putY * TILE_PX_SIZEY, 'middle'
                        ))
                    end
                elseif putY <= 22 then  -- Should this be a Top Middle Brick?
                    if isOffset == 0 then
                        table.insert(self.tiles, Tile:new(
                            _, putX * TILE_PX_SIZEX, putY * TILE_PX_SIZEY, 'topMid'
                        ))
                    else
                        table.insert(self.tiles, Tile:new(
                            _, putX * TILE_PX_SIZEX - TILE_OFFSET, putY * TILE_PX_SIZEY, 'topMid'
                        ))
                    end
                elseif putY >= 39 then  -- Should this be a Bottom Middle Brick?
                    if isOffset == 0 then
                        table.insert(self.tiles, Tile:new(
                            _, putX * TILE_PX_SIZEX, putY * TILE_PX_SIZEY, 'botMid'
                        ))
                    else
                        table.insert(self.tiles, Tile:new(
                            _, putX * TILE_PX_SIZEX - TILE_OFFSET, putY * TILE_PX_SIZEY, 'botMid'
                        ))
                    end
                elseif putX >= 15 then  -- Should this be a Right Middle Brick?
                    if isOffset == 0 then
                        table.insert(self.tiles, Tile:new(
                            _, putX * TILE_PX_SIZEX, putY * TILE_PX_SIZEY, 'rightMid'
                        ))
                    else
                        table.insert(self.tiles, Tile:new(
                            _, putX * TILE_PX_SIZEX - TILE_OFFSET, putY * TILE_PX_SIZEY, 'rightMid'
                        ))
                    end
                elseif putX <= 8 then  -- Should this be a Left Middle Brick?
                    if isOffset == 0 then
                        table.insert(self.tiles, Tile:new(
                            _, putX * TILE_PX_SIZEX, putY * TILE_PX_SIZEY, 'leftMid'
                        ))
                    else
                        table.insert(self.tiles, Tile:new(
                            _, putX * TILE_PX_SIZEX - TILE_OFFSET, putY * TILE_PX_SIZEY, 'leftMid'
                        ))
                    end
                else
                    -- Quick Path
                    if isOffset == 0 then
                        table.insert(self.tiles, Tile:new(
                            _, putX * TILE_PX_SIZEX, putY * TILE_PX_SIZEY, 'norm'
                        ))
                    else  -- isOffset == 1
                        table.insert(self.tiles, Tile:new(
                            _, putX * TILE_PX_SIZEX - TILE_OFFSET, putY * TILE_PX_SIZEY, 'norm'
                        ))
                    end
                end

            else  -- Circle
                -- if hypot > 700 and hypot <= 775 9-9-2018 start here
                if hypot <= 700 then  -- Is hypotenuse in the circle?
                    if putX >= 14 and putY <= 24 then  -- Top Right of Circle?
                        if isOffset == 0 then
                            table.insert(self.tiles, Tile:new(
                                _, putX * TILE_PX_SIZEX, putY * TILE_PX_SIZEY, 'topRight'
                            ))
                        else
                            table.insert(self.tiles, Tile:new(
                                _, putX * TILE_PX_SIZEX - TILE_OFFSET, putY * TILE_PX_SIZEY, 'topRight'
                            ))
                        end
                    elseif putX <= 8 and putY <= 24 then  -- Top Left of Circle?
                        if isOffset == 0 then
                            table.insert(self.tiles, Tile:new(
                                _, putX * TILE_PX_SIZEX, putY * TILE_PX_SIZEY, 'topLeft'
                            ))
                        else
                            table.insert(self.tiles, Tile:new(
                                _, putX * TILE_PX_SIZEX - TILE_OFFSET, putY * TILE_PX_SIZEY, 'topLeft'
                            ))
                        end
                    elseif putX <= 9 and putY >= 38 then  -- Bottom Left of Circle?
                        if isOffset == 0 then
                            table.insert(self.tiles, Tile:new(
                                _, putX * TILE_PX_SIZEX, putY * TILE_PX_SIZEY, 'botLeft'
                            ))
                        else
                            table.insert(self.tiles, Tile:new(
                                _, putX * TILE_PX_SIZEX - TILE_OFFSET, putY * TILE_PX_SIZEY, 'botLeft'
                            ))
                        end
                    elseif putX >= 14 and putY >= 38 then  -- Bottom Right of Circle?
                        if isOffset == 0 then
                            table.insert(self.tiles, Tile:new(
                                _, putX * TILE_PX_SIZEX, putY * TILE_PX_SIZEY, 'botRight'
                            ))
                        else
                            table.insert(self.tiles, Tile:new(
                                _, putX * TILE_PX_SIZEX - TILE_OFFSET, putY * TILE_PX_SIZEY, 'botRight'
                            ))
                        end    
                    else
                        if isOffset == 0 then
                            table.insert(self.tiles, Tile:new(
                                _, putX * TILE_PX_SIZEX, putY * TILE_PX_SIZEY, 'norm'
                            ))
                        else
                            table.insert(self.tiles, Tile:new(
                                _, putX * TILE_PX_SIZEX - TILE_OFFSET, putY * TILE_PX_SIZEY, 'norm'
                            ))
                        end
                    end
                end
            end

        end
        switch = switch + 1
    end
end

function Room:renderTiles()
    for i = 1, #self.tiles do
        self.tiles[i]:render()
    end
end

return Room