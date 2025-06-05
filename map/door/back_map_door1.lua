-- map/door/back_map_door1.lua

local back_map_door1 = {}

function back_map_door1.decorate(tiles)
    -- 🔲 Door back to map1 at (2, 2)
    tiles[2][2] = tiles[2][2] or {}
    tiles[2][2].door = true
    tiles[2][2].blocked = true
    tiles[2][2].exit = "map1"
end

return back_map_door1
