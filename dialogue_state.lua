-- dialogue_state.lua

local dialogue = {}

dialogue.active = false
dialogue.current = nil
dialogue.selected = 1

function dialogue.start(tree)
    dialogue.tree = tree
    dialogue.current = tree
    dialogue.selected = 1
    dialogue.active = true
end

function dialogue.draw()
    if not dialogue.active or not dialogue.current then return end

    -- Dim background
    love.graphics.setColor(0, 0, 0, 0.7)
    love.graphics.rectangle("fill", 0, 0, 700, 700)

    -- Player circle (always)
    love.graphics.setColor(1, 1, 1)
    love.graphics.circle("fill", 200, 350, 40)

    -- Determine speaker style
    local speaker = dialogue.current.speaker or ""
    local isObject = (speaker == "Door")

    -- Set color based on speaker
    if speaker == "Solin" then
        love.graphics.setColor(1, 0.9, 0.6) -- Solin: gold
    elseif speaker == "Door" then
        love.graphics.setColor(0.1, 0.1, 0.1) -- Door: black tile
    else
        love.graphics.setColor(0.6, 0.6, 0.6) -- Default soft gray
    end

    -- Draw speaker symbol: square for object, circle for people
    if isObject then
        love.graphics.rectangle("fill", 460, 310, 80, 80)  -- square for door
    else
        love.graphics.circle("fill", 500, 350, 40) -- circle for characters
    end

    -- Dialogue text
    love.graphics.setColor(1, 1, 1)
    love.graphics.printf(dialogue.current.text, 100, 80, 500, "center")

    -- Choices
    if dialogue.current.choices then
        for i, choice in ipairs(dialogue.current.choices) do
            if i == dialogue.selected then
                love.graphics.setColor(1, 1, 1)
            else
                love.graphics.setColor(0.6, 0.6, 0.6)
            end
            love.graphics.printf("[" .. i .. "] " .. choice.label, 200, 420 + i * 30, 300, "center")
        end
    end
end



function dialogue.keypressed(key)
    if not dialogue.active or not dialogue.current then return end

    -- Navigation
    if dialogue.current.choices then
        local count = #dialogue.current.choices

        if key == "up" or key == "w" then
            dialogue.selected = (dialogue.selected - 2) % count + 1
        elseif key == "down" or key == "s" then
            dialogue.selected = (dialogue.selected) % count + 1

        elseif key == "return" or key == "space" then
            local chosen = dialogue.current.choices[dialogue.selected]
            if chosen and chosen.response then
                -- ✅ Support functional responses
                local response = chosen.response
                if type(response) == "function" then
                    response = response()
                end

                dialogue.current = response
                dialogue.selected = 1

                -- ✅ Run action if present
                if dialogue.current.action then
                    dialogue.current.action()
                end
            else
                -- No valid response — exit dialogue
                dialogue.active = false
            end
        end

    else
        -- No choices: any confirm key exits
        if key == "return" or key == "space" then
            dialogue.active = false
        end
    end
end



return dialogue
