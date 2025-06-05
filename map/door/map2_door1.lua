-- map/door/map2_door1.lua

local map2_door1 = {}

-- Decorates the map with door1 and sets its coordinates on the map object
function map2_door1.decorate(tiles, map)
    local x, y = 2, 2  -- Position of the door on map2

    tiles[y][x] = tiles[y][x] or {}
    tiles[y][x].door = true
    tiles[y][x].blocked = true

    map.door1X = x
    map.door1Y = y
end

return map2_door1
