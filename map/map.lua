-- map/map.lua
local map = {}

local tileSize = 32
map.width = 20
map.height = 20
map.tiles = {}

-- Require map-specific decorators
local door1 = require("map.door.map1_door1")

-- You can add more decorators here if needed later
-- local chestLogic = require("map.chest_logic") -- Optional for future

function map.load()
    for y = 1, map.height do
        map.tiles[y] = {}
        for x = 1, map.width do
            map.tiles[y][x] = { visited = false }
        end
    end

    -- Apply door layout and others
    door1.decorate(map.tiles)
end


function map.draw()
    local tileSize = 32

    for y = 1, map.height do
        for x = 1, map.width do
            local tile = map.tiles[y][x]

            -- Default floor
            love.graphics.setColor(0.2, 0.2, 0.25)
            love.graphics.rectangle("fill", (x - 1) * tileSize, (y - 1) * tileSize, tileSize, tileSize)

            -- Visited overlay
            if tile.visited then
                love.graphics.setColor(0.5, 0.5, 0.5, 0.2)
                love.graphics.rectangle("fill", (x - 1) * tileSize, (y - 1) * tileSize, tileSize, tileSize)
            end

            -- Door
            if tile.door then
                love.graphics.setColor(0, 0, 0)
                love.graphics.rectangle("fill", (x - 1) * tileSize, (y - 1) * tileSize, tileSize, tileSize)
            end

            -- Chest
            if tile.chest then
                love.graphics.setColor(1, 1, 0.4)
                love.graphics.rectangle("fill", (x - 1) * tileSize + 8, (y - 1) * tileSize + 8, 16, 16)
            end
        end
    end

    -- Optional debug grid
    local mapManager = require("map_manager")
    if mapManager.debugGrid then
        love.graphics.setColor(1, 1, 1, 0.2)
        for y = 1, map.height do
            for x = 1, map.width do
                love.graphics.rectangle("line", (x - 1) * tileSize, (y - 1) * tileSize, tileSize, tileSize)
            end
        end
    end
end


function map.isBlocked(x, y)
    local tile = map.tiles[y] and map.tiles[y][x]
    if not tile then return true end

    return tile.blocked or false
end



function map.interact(x, y, inventory)
    local tile = map.tiles[y] and map.tiles[y][x]
    if not tile then return nil end

    -- Interact with chest (optional)
    if tile.chest then
        return "chest"
    end

    -- Interact with door at (10,10)
    if math.abs(x - 10) + math.abs(y - 10) == 1 then
        if inventory:has("door1 key") then
            return "switch"
        else
            return "locked"
        end
    end

    -- Switch back tile at (2,2)
    if math.abs(x - 2) + math.abs(y - 2) == 1 then
        return "switch_back"
    end

    return nil
end


return map
