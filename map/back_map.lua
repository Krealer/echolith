-- map/back_map.lua
local back_map = {}

-- Constants
local tileSize = 32
back_map.width = 20
back_map.height = 20
back_map.tiles = {}

-- Doors and object decorators
local door1 = require("map.door.back_map_door1")

-- For player interaction logic
back_map.door1X = 2   -- Update to match door1's actual position
back_map.door1Y = 2

-- Chest coordinates (interactable, blocked)
back_map.chestX = 10
back_map.chestY = 15

function back_map.load()
    for y = 1, back_map.height do
        back_map.tiles[y] = {}
        for x = 1, back_map.width do
            back_map.tiles[y][x] = { visited = false }
        end
    end

    -- 🟨 Chest tile at (10, 15), also acts as a blocker
    local chestTile = back_map.tiles[back_map.chestY][back_map.chestX]
    chestTile.chest = true
    chestTile.blocked = true

    -- 🚪 Decorate door tiles after grid setup
    door1.decorate(back_map.tiles)
end

function back_map.draw()
    local tileSize = 32

    for y = 1, back_map.height do
        for x = 1, back_map.width do
            local tile = back_map.tiles[y][x]

            -- Default floor
            love.graphics.setColor(0.15, 0.15, 0.2)
            love.graphics.rectangle("fill", (x - 1) * tileSize, (y - 1) * tileSize, tileSize, tileSize)

            -- Visited overlay
            if tile.visited then
                love.graphics.setColor(0.5, 0.5, 0.5, 0.2)
                love.graphics.rectangle("fill", (x - 1) * tileSize, (y - 1) * tileSize, tileSize, tileSize)
            end

            -- Door tile
            if tile.door then
                love.graphics.setColor(0, 0, 0)
                love.graphics.rectangle("fill", (x - 1) * tileSize, (y - 1) * tileSize, tileSize, tileSize)
            end

            -- Chest tile
            if tile.chest then
                local chestSize = 20
                local offset = (tileSize - chestSize) / 2
                love.graphics.setColor(1, 1, 0) -- Bright yellow
                love.graphics.rectangle("fill", (x - 1) * tileSize + offset, (y - 1) * tileSize + offset, chestSize, chestSize)
            end
        end
    end

    -- Debug overlay
    local mapManager = require("map_manager")
    if mapManager.debugGrid then
        love.graphics.setColor(1, 1, 1, 0.2)
        for y = 1, back_map.height do
            for x = 1, back_map.width do
                love.graphics.rectangle("line", (x - 1) * tileSize, (y - 1) * tileSize, tileSize, tileSize)
            end
        end
    end
end

function back_map.isBlocked(x, y)
    local tile = back_map.tiles[y] and back_map.tiles[y][x]
    if not tile then return true end

    return tile.blocked or false
end


function back_map.interact(x, y, inventory)
    -- Interact with door to return to map1
    if math.abs(x - 2) + math.abs(y - 2) == 1 then
        return "switch_back"
    end

    -- Interact with chest (from adjacent tile)
    if math.abs(x - back_map.chestX) + math.abs(y - back_map.chestY) == 1 then
        return "chest"
    end

    return nil
end

return back_map
