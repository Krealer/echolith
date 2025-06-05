-- map_manager.lua

local mapManager = {}

-- Track current map and ID
mapManager.current = nil
mapManager.currentID = nil

-- Optional debug toggle
mapManager.debugGrid = false

-- Toggle debug grid overlay
function mapManager.toggleDebugGrid()
    mapManager.debugGrid = not mapManager.debugGrid
end

-- Required maps
local map1 = require("map.map")
local map2 = require("map.map2")
local backMap = require("map.back_map")
-- Optional future maps
-- local map3 = require("map.map3")

-- Inventory reference for doors and logic
local inventory = require("inventory")

-- Rest of your functions...
function mapManager.toggleDebugGrid()
    mapManager.debugGrid = not mapManager.debugGrid
end


function mapManager.load()
    -- Load all maps
    map1.load()
    map2.load()
    backMap.load()

    -- Set the starting map
    mapManager.current = map1
    mapManager.currentID = "map1"
end



function mapManager.draw()
    if not mapManager.current then return end
    local screenW, screenH = love.graphics.getWidth(), love.graphics.getHeight()
    local tileSize = 32
    local mapW = mapManager.current.width * tileSize
    local mapH = mapManager.current.height * tileSize
    local offsetX = math.floor((screenW - mapW) / 2)
    local offsetY = math.floor((screenH - mapH) / 2)

    love.graphics.push()
    love.graphics.translate(offsetX, offsetY)

    -- Draw current map
    mapManager.current.draw()

    -- Draw characters conditionally based on current map
    if mapManager.isMap("map1") then
        local solin = require("characters.solin")
        if not solin.hidden then solin.draw() end
    elseif mapManager.isMap("map2") then
        require("characters.map2.mira").draw()
        require("characters.map2.latch").draw()
    end

    -- Always draw player
    local player = require("player")
    player.draw()

    love.graphics.pop()
end

function mapManager.isBlocked(x, y)
    if mapManager.current and mapManager.current.isBlocked then
        return mapManager.current.isBlocked(x, y)
    end
    return false
end


function mapManager.interact(x, y)
    local result = mapManager.current.interact(x, y, inventory)

    if result == "switch" then
        mapManager.current = require("map.map2")
        mapManager.currentID = "map2"
    elseif result == "switch_back" then
        mapManager.current = require("map.map")
        mapManager.currentID = "map1"
    elseif result == "back_map" then
        mapManager.current = require("map.back_map")
        mapManager.currentID = "back_map"
    elseif result == "map3" then
        mapManager.current = require("map.map3") -- 🔧 map3 must exist!
        mapManager.currentID = "map3"
    end

    return result
end


function mapManager.isMap(id)
    return mapManager.currentID == id
end

return mapManager
