-- map/map2.lua
local map2 = {}

local tileSize = 32
map2.width = 20
map2.height = 20
map2.tiles = {}

-- Door modules (enter + exit)
local door1 = require("map.door.map2_door1")
local door2 = require("map.door.map2_door2")

-- Characters in this map
local mira = require("characters.map2.mira")
local latch = require("characters.map2.latch")

-- Exit back to map1
map2.exitX = 1
map2.exitY = 1

function map2.load()
    for y = 1, map2.height do
        map2.tiles[y] = {}
        for x = 1, map2.width do
            map2.tiles[y][x] = { visited = false }
        end
    end

    -- Apply door layouts
    door1.decorate(map2.tiles, map2)
    door2.decorate(map2.tiles)

    -- Set door interaction coordinates (must match door1/door2 decorators)
    map2.door1X = 2
    map2.door1Y = 2

    map2.door2X = 18
    map2.door2Y = 10

    -- Block tiles where characters stand
    map2.tiles[mira.y][mira.x].blocked = true
    map2.tiles[latch.y][latch.x].blocked = true
end



function map2.draw()
    local tileSize = 32

    for y = 1, map2.height do
        for x = 1, map2.width do
            local tile = map2.tiles[y][x]

            -- Base tile color
            love.graphics.setColor(0.18, 0.18, 0.22)
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

            -- Switch or special tiles (e.g., future puzzles)
            if tile.switch then
                love.graphics.setColor(1, 1, 0)
                love.graphics.rectangle("fill", (x - 1) * tileSize + 10, (y - 1) * tileSize + 10, 12, 12)
            end
        end
    end

    -- Characters
    mira.draw()
    latch.draw()

    -- Debug overlay
    local mapManager = require("map_manager")
    if mapManager.debugGrid then
        love.graphics.setColor(1, 1, 1, 0.2)
        for y = 1, map2.height do
            for x = 1, map2.width do
                love.graphics.rectangle("line", (x - 1) * tileSize, (y - 1) * tileSize, tileSize, tileSize)
            end
        end
    end
end

function map2.isBlocked(x, y)
    if (x == mira.x and y == mira.y) or (x == latch.x and y == latch.y) then
        return true
    end

    local tile = map2.tiles[y] and map2.tiles[y][x]
    if tile and tile.blocked then
        return true
    end

    return false
end

function map2.interact(x, y, _)
    -- Door1 interaction (to back-map)
    if math.abs(x - map2.door1X) + math.abs(y - map2.door1Y) == 1 then
        return "back_map"
    end

    -- Door2 interaction (to map3)
    if math.abs(x - map2.door2X) + math.abs(y - map2.door2Y) == 1 then
        return "map3"
    end

    -- Character interaction
    mira.interact(x, y)
    latch.interact(x, y)

    return nil
end

return map2
