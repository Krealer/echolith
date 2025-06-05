local solin = {
    x = 5,
    y = 5,
    interacted = false
}

-- These go AFTER solin is defined
local dialogueState = require("dialogue_state")
local dialogueTree = require("data.solin_dialogue_tree")

function solin.interact(playerX, playerY)
    -- Only activate if dialogue is not already open
    if dialogueState.active then return end

    -- Check if player is adjacent
    local dx = math.abs(solin.x - playerX)
    local dy = math.abs(solin.y - playerY)
    local adjacent = dx + dy == 1

    if adjacent then
        dialogueState.start(dialogueTree)
    end
end

function solin.draw()
    local px = solin.x * 32 + 16
    local py = solin.y * 32 + 16

    love.graphics.setColor(1, 0.9, 0.6)  -- Pale gold
    love.graphics.circle("fill", px, py, 14)
end


return solin
