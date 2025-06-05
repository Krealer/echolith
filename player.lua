-- player.lua

local pulseTimer = 0
local map = require("map")
local dialogue = require("dialogue")
local solin = require("characters.solin")


local tile = map.tiles[ty] and map.tiles[ty][tx]


local player = {
    x = 2,
    y = 2,
    speed = 1
}

function player.load() end

function player.update(dt)
    pulseTimer = pulseTimer + dt * 2

    -- Auto-hide dialogue if player moves away from the door
    if dialogue.active then
        local nearDoor = false
        for oy = -1, 1 do
            for ox = -1, 1 do
                if math.abs(ox) + math.abs(oy) == 1 then  -- Only cardinal directions
                    local ax = player.x + ox
                    local ay = player.y + oy
                    local tile = map.tiles[ay] and map.tiles[ay][ax]
                    if tile and tile.type == "door" then
                        nearDoor = true
                    end
                end
            end
        end

        if not nearDoor then
            dialogue.active = false
        end
    end
end



function player.draw()
    local px = player.x * 32 + 16
    local py = player.y * 32 + 16

    local glowAlpha = 0.15 + 0.1 * math.sin(pulseTimer * 2)
    local glowRadius = 16 + 2 * math.sin(pulseTimer * 2)

    -- Animated glowing aura
    love.graphics.setColor(1, 1, 1, glowAlpha)
    love.graphics.circle("fill", px, py, glowRadius)

    -- Core player circle
    love.graphics.setColor(1, 1, 1)
    love.graphics.circle("fill", px, py, 14)
end

local map = require("map")
local dialogueState = require("dialogue_state")
local solin = require("characters.solin")

function player.keypressed(key)
    local dx, dy = 0, 0

    -- Movement input
    if key == "up" or key == "w" then dy = -1 end
    if key == "down" or key == "s" then dy = 1 end
    if key == "left" or key == "a" then dx = -1 end
    if key == "right" or key == "d" then dx = 1 end

    local newX = player.x + dx
    local newY = player.y + dy

    -- Stay in bounds and avoid blocked tiles
    if newX >= 1 and newX <= 20 and newY >= 1 and newY <= 20 then
        local destination = map.tiles[newY] and map.tiles[newY][newX]
        local isBlocked = false

        if destination and destination.type == "door" then
            isBlocked = true
        end

        if newX == solin.x and newY == solin.y then
            isBlocked = true
        end

        if not isBlocked then
            player.x = newX
            player.y = newY
        end
    end

    -- Interaction input (space or enter)
    if key == "space" or key == "return" then
        -- Interact with adjacent doors
        for oy = -1, 1 do
            for ox = -1, 1 do
                if math.abs(ox) + math.abs(oy) == 1 then
                    local ax = player.x + ox
                    local ay = player.y + oy
                    local tile = map.tiles[ay] and map.tiles[ay][ax]
                    if tile and tile.type == "door" then
                        dialogueState.start(require("data.door1_dialogue_tree"))
                        return
                    end
                end
            end
        end

        -- Interact with Solin
        solin.interact(player.x, player.y)
    end
end


return player
