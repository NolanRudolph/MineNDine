local troubleShoot = {}

function troubleShoot:render()
    local tempY = 0
    local offSet = 0
    local count = 1
    local totCountX = 1
    local totCountY = 1
    local rightY = 1
    local tempCount0 = 0
    local tempCount24 = 0
    while tempY < love.graphics.getHeight() do
        local tempX = 0
        while tempX <= love.graphics.getWidth() do
            if count == 1 then
                love.graphics.print(tempCount0, tempX + 3, 0)
                love.graphics.print(tempCount0, tempX + 3, love.graphics.getHeight() - TILE_PX_SIZEY)
                if totCountX == 12 then
                elseif totCountX > 11 then
                    tempCount0 = tempCount0 - 1
                else
                    tempCount0 = tempCount0 + 1
                end
            end
            if offSet % 2 == 0 then
                love.graphics.rectangle('fill', tempX, tempY, 1, TILE_PX_SIZEY)
            else
                love.graphics.rectangle('fill', tempX - TILE_OFFSET, tempY, 1, TILE_PX_SIZEY)
            end
            totCountX = totCountX + 1
            tempX = tempX + TILE_PX_SIZEX
        end

        if totCountY >= 32 then
            rightY = rightY - 1
        else
            rightY = rightY + 1
        end

        love.graphics.print(rightY, 0, tempY - 1)
        love.graphics.print(rightY, love.graphics.getWidth() - TILE_PX_SIZEY - 3, tempY - 1)
        love.graphics.rectangle('fill', 0, tempY, 1000, 1)
        count = count + 1
        totCountY = totCountY + 1
        tempY = tempY + TILE_PX_SIZEY
        offSet = offSet + 1
        love.graphics.rectangle('fill', love.graphics.getWidth()/2, 0, 1, 1000)
    end
end

return troubleShoot