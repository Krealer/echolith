local dialogueState = require("dialogue_state")
local dialogueTree = require("data.mira_dialogue_tree")

local mira = {
    x = 8,
    y = 10,
    hidden = false
}

function mira.draw()
    if mira.hidden then return end

    local tileSize = 32
    local cx = (mira.x - 1) * tileSize + tileSize / 2
    local cy = (mira.y - 1) * tileSize + tileSize / 2

    -- Mira is soft cyan, not glowing
    love.graphics.setColor(0.8, 1, 1)
    love.graphics.circle("fill", cx, cy, 10)
end


function mira.interact(playerX, playerY)
    if mira.hidden then return end

    local dx = math.abs(mira.x - playerX)
    local dy = math.abs(mira.y - playerY)
    local adjacent = (dx + dy == 1)

    if adjacent and not dialogueState.active then
        dialogueState.start(dialogueTree)
    end
end


return mira
