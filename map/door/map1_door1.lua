-- map/map1_door1.lua

local map1_door1 = {}

-- Add custom features to map1's tile grid
function map1_door1.decorate(tiles)
    -- 🗝️ Door 1 at tile (10, 10)
    tiles[10][10] = tiles[10][10] or {}
    tiles[10][10].door = true
    tiles[10][10].blocked = true
end

return map1_door1
