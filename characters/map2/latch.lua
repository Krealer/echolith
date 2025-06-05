local dialogueState = require("dialogue_state")
local dialogueTree = require("data.latch_dialogue_tree")

local latch = {
    x = 12,
    y = 14,
    hidden = false
}


function latch.draw()
    if latch.hidden then return end

    local tileSize = 32
    local cx = (latch.x - 1) * tileSize + tileSize / 2
    local cy = (latch.y - 1) * tileSize + tileSize / 2
    local size = 12

    love.graphics.setColor(0.6, 0.4, 0.7) -- Mysterious violet
    love.graphics.polygon("fill", 
        cx, cy - size,        -- Top
        cx - size, cy + size, -- Bottom left
        cx + size, cy + size  -- Bottom right
    )
end


function latch.interact(playerX, playerY)
    if latch.hidden then return end

    local dx = math.abs(latch.x - playerX)
    local dy = math.abs(latch.y - playerY)
    local adjacent = (dx + dy == 1)

    if adjacent and not dialogueState.active then
        dialogueState.start(dialogueTree)
    end
end


return latch
