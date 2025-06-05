-- door1_dialogue_tree.lua

local inventory = require("inventory")

local tree = {
    speaker = "Door",
    text = "A silent black shape.\n\nWhat do you want to do?",
    choices = {
        {
            label = "Open it",
            response = function()
                if inventory:has("door1 key") then
                    return {
                        speaker = "Door",
                        text = "The key clicks softly.\nThe threshold opens...",
                        action = function()
                            -- Replace this with actual map change when ready
                            print("🌌 Transition to new map triggered!")
                        end
                    }
                else
                    return {
                        speaker = "Door",
                        text = "It's locked."
                    }
                end
            end
        },
        {
            label = "Leave",
            response = {
                speaker = "Door",
                text = "You step back from the threshold."
            }
        }
    }
}

return tree
