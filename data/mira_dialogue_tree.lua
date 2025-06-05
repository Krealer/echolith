local inventory = require("inventory")

local tree = {
    speaker = "Mira",
    text = "Did the silence bring you here... or did you bring the silence?",
    choices = {
        {
            label = "I was searching.",
            response = {
                speaker = "Mira",
                text = "I searched once.\nFound only echoes.",
                choices = {
                    {
                        label = "What did you lose?",
                        response = {
                            speaker = "Mira",
                            text = "A name.\nMaybe it was mine.",
                        }
                    },
                    {
                        label = "Were you afraid?",
                        response = {
                            speaker = "Mira",
                            text = "Yes.\nBut fear is quiet too."
                        }
                    },
                    {
                        label = "I kept listening.",
                        response = {
                            speaker = "Mira",
                            text = "You stayed. That’s enough.\nTake this fragment — it remembers.",
                            action = function()
                                inventory.add("Pale Mirror Fragment")
                            end
                        }
                    }
                }
            }
        },
        {
            label = "It followed me.",
            response = {
                speaker = "Mira",
                text = "Then we’re both haunted.",
                choices = {
                    {
                        label = "By what?",
                        response = {
                            speaker = "Mira",
                            text = "A question I couldn’t answer.\nSo I stopped asking."
                        }
                    },
                    {
                        label = "How do you escape it?",
                        response = {
                            speaker = "Mira",
                            text = "I tried to speak louder than it.\nIt won."
                        }
                    }
                }
            }
        },
        {
            label = "I don’t know.",
            response = {
                speaker = "Mira",
                text = "Then maybe it found you first.",
                choices = {
                    {
                        label = "Does it ever leave?",
                        response = {
                            speaker = "Mira",
                            text = "Sometimes.\nBut only to return as something else."
                        }
                    },
                    {
                        label = "What if I forget why I came?",
                        response = {
                            speaker = "Mira",
                            text = "Then your footsteps become the memory."
                        }
                    },
                    {
                        label = "I feel lost.",
                        response = {
                            speaker = "Mira",
                            text = "Not knowing... sometimes feels like drowning, doesn’t it?"
                        }
                    }
                }
            }
        }
    }
}

return tree
