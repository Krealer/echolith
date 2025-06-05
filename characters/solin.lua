local dialogueState = require("dialogue_state")
local dialogueTree = require("data.solin_dialogue_tree")

local solin = {
    x = 15,
    y = 5,
    hidden = false
}

function solin.interact(playerX, playerY)
    if solin.hidden then return end

    local dx = math.abs(solin.x - playerX)
    local dy = math.abs(solin.y - playerY)
    local adjacent = dx + dy == 1

    if adjacent and not dialogueState.active then
        dialogueState.start(dialogueTree)
    end
end

function solin.draw()
    if solin.hidden then return end

    love.graphics.setColor(1, 0.8, 0) -- Gold/candlelight tone
    love.graphics.circle("fill", (solin.x - 1) * 32 + 16, (solin.y - 1) * 32 + 16, 10)
end

return solin
