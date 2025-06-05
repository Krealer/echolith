local map2_door2 = {}

function map2_door2.decorate(tiles)
    -- 🚪 Door 2 in map2 at (18, 2)
    tiles[2][18] = tiles[2][18] or {}
    tiles[2][18].door = true
    tiles[2][18].blocked = true
    tiles[2][18].exit = "map3"  -- Destination map (placeholder for now)
end

return map2_door2
