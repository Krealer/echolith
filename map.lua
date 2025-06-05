-- map.lua

local map = {}
map.tiles = {}

function map.load()
    for y = 1, 20 do
        map.tiles[y] = {}
        for x = 1, 20 do
            local tile = { wasVisited = false }

            if x == 10 and y == 10 then
                tile.type = "door"
            else
                tile.type = "floor"
            end

            map.tiles[y][x] = tile
        end
    end
end



function map.draw()
    for y = 1, 20 do
        for x = 1, 20 do
            local tile = map.tiles[y][x]
            local tx = x * 32
            local ty = y * 32

            -- Draw tile type
            if tile.type == "door" then
                love.graphics.setColor(0, 0, 0)  -- Solid black door
                love.graphics.rectangle("fill", tx, ty, 30, 30)
            else
                love.graphics.setColor(0.2, 0.2, 0.2)  -- Normal floor
                love.graphics.rectangle("fill", tx, ty, 30, 30)
            end

            -- Optional: overlay if tile was visited (for future use)
            if tile.wasVisited then
                love.graphics.setColor(0.5, 0.5, 0.5, 0.2)
                love.graphics.rectangle("fill", tx, ty, 30, 30)
            end
        end
    end
end


return map
