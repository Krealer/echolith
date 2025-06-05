local inventory = require("inventory")

local tree = {
    speaker = "Latch",
    text = "You walked right up to me.\nYou must trust easily.",
    choices = {
        {
            label = "I don't know you.",
            response = {
                speaker = "Latch",
                text = "Then why stop walking?",
                choices = {
                    {
                        label = "Curiosity.",
                        response = {
                            speaker = "Latch",
                            text = "Curiosity is how most things die."
                        }
                    },
                    {
                        label = "I thought I should.",
                        response = {
                            speaker = "Latch",
                            text = "Obligation is a soft chain, isn’t it?"
                        }
                    }
                }
            }
        },
        {
            label = "Should I trust you?",
            response = {
                speaker = "Latch",
                text = "Only if you want something broken.",
                choices = {
                    {
                        label = "What’s broken?",
                        response = {
                            speaker = "Latch",
                            text = "A lens.\nFrom the thing that watched too much.",
                            action = function()
                                inventory.add("Broken Eye Lens")
                            end
                        }
                    },
                    {
                        label = "Not me.",
                        response = {
                            speaker = "Latch",
                            text = "Then why did you answer?"
                        }
                    }
                }
            }
        },
        {
            label = "What are you?",
            response = {
                speaker = "Latch",
                text = "A door that opens inward.\nBut never for me.",
                choices = {
                    {
                        label = "What’s inside?",
                        response = {
                            speaker = "Latch",
                            text = "It echoes.\nLike you do."
                        }
                    },
                    {
                        label = "Can I open it?",
                        response = {
                            speaker = "Latch",
                            text = "Only if you never close it again."
                        }
                    }
                }
            }
        }
    }
}

return tree
