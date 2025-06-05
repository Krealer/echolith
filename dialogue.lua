-- dialogue.lua

local dialogue = {
    active = false,
    text = ""
}

function dialogue.show(text)
    dialogue.text = text
    dialogue.active = true
end

function dialogue.draw()
    if dialogue.active then
        love.graphics.setColor(0, 0, 0, 0.8)
        love.graphics.rectangle("fill", 20, 640, 660, 40)
        love.graphics.setColor(1, 1, 1)
        love.graphics.printf(dialogue.text, 30, 650, 640, "center")
    end
end

function dialogue.keypressed(key)
    if key == "space" and dialogue.active then
        dialogue.active = false
    end
end

return dialogue
