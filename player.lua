-- player.lua

local player = {}
local tileSize = 32

player.x = 5
player.y = 5

local mapManager = require("map_manager")
local dialogue = require("dialogue_state")
local solin = require("characters.solin")
local inventory = require("inventory")

function player.load(startX, startY)
    player.x = startX or 5
    player.y = startY or 5
end



function player.update(dt)
    if not mapManager.current or not mapManager.current.tiles then return end

    local tileX, tileY = player.x, player.y
    local tiles = mapManager.current.tiles

    if tiles[tileY] and tiles[tileY][tileX] then
        tiles[tileY][tileX].visited = true
    end

    solin.hidden = not mapManager.isMap("map1")
end


function player.draw()
    local tileSize = 32
    local centerX = (player.x - 1) * tileSize + tileSize / 2
    local centerY = (player.y - 1) * tileSize + tileSize / 2

    -- Shadow base (optional)
    love.graphics.setColor(0, 0, 0, 0.1)
    love.graphics.circle("fill", centerX, centerY + 4, 8)

    -- Glowing aura
    local glow = 6 + math.sin(love.timer.getTime() * 2) * 2
    love.graphics.setColor(1, 1, 1, 0.2)
    love.graphics.circle("fill", centerX, centerY, glow)

    -- Player core
    love.graphics.setColor(1, 1, 1)
    love.graphics.circle("fill", centerX, centerY, 10)
end


function player.keypressed(key)
    local dx, dy = 0, 0

    -- Movement input
    if key == "up" or key == "w" then dy = -1
    elseif key == "down" or key == "s" then dy = 1
    elseif key == "left" or key == "a" then dx = -1
    elseif key == "right" or key == "d" then dx = 1
    end

    -- Attempt movement
    local newX, newY = player.x + dx, player.y + dy
    if not mapManager.isBlocked(newX, newY) then
        player.x = newX
        player.y = newY
    end

    -- Interaction input
    if key == "return" or key == "space" then
        local mapID = mapManager.currentID

        if mapID == "map1" then
            solin.interact(player.x, player.y)
        elseif mapID == "map2" then
            require("characters.map2.mira").interact(player.x, player.y)
            require("characters.map2.latch").interact(player.x, player.y)
        end

        local result = mapManager.interact(player.x, player.y)

        if result == "locked" then
            dialogue.start(require("data.map1_door1_dialogue_tree"))

        elseif result == "switch" then
            player.x, player.y = 2, 2

        elseif result == "switch_back" then
            player.x, player.y = 9, 10

        elseif result == "back_map" then
            player.x, player.y = 10, 10

        elseif result == "map3" then
            player.x, player.y = 2, 2
        end
    end
end

return player
