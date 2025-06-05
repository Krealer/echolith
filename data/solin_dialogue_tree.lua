-- solin_dialogue_tree.lua

local inventory = require("inventory")

local tree = {
    speaker = "Solin",
    text = "Let me ask plainly.\nWhat brought you here?",
    choices = {
        {
            label = "Curiosity",
            response = {
                speaker = "Solin",
                text = "Then you'll learn — if you lean.",
                choices = {
                    {
                        label = "A dream",
                        response = {
                            speaker = "Solin",
                            text = "You’re still in it. But dreaming isn’t sleeping.",
                            choices = {
                                {
                                    label = "The thing.",
                                    response = {
                                        speaker = "Solin",
                                        text = "Things can be replaced.\nBut the memory of them?",
                                        choices = {
                                            {
                                                label = "It fades.",
                                                response = {
                                                    speaker = "Solin",
                                                    text = "Then keep this — before it disappears.",
                                                    action = function()
                                                        inventory.add("ancient golden coin")
                                                    end
                                                }
                                            },
                                            {
                                                label = "It drives me.",
                                                response = {
                                                    speaker = "Solin",
                                                    text = "Then don't stop moving."
                                                }
                                            }
                                        }
                                    }
                                },
                                {
                                    label = "The feeling.",
                                    response = {
                                        speaker = "Solin",
                                        text = "Feelings are maps made of mist.\nBut not all are accurate."
                                    }
                                }
                            }
                        }
                    },
                    {
                        label = "Something I lost",
                        response = {
                            speaker = "Solin",
                            text = "Loss often leads to search.\nBut is it the thing — or the feeling?",
                            choices = {
                                {
                                    label = "The thing.",
                                    response = {
                                        speaker = "Solin",
                                        text = "Things can be replaced.\nBut the memory?",
                                        choices = {
                                            {
                                                label = "It haunts me.",
                                                response = {
                                                    speaker = "Solin",
                                                    text = "Then let the haunting open something.",
                                                    action = function()
                                                        inventory.add("door1 key")
                                                    end
                                                }
                                            },
                                            {
                                                label = "It drives me.",
                                                response = {
                                                    speaker = "Solin",
                                                    text = "Then you're already through the first door."
                                                }
                                            }
                                        }
                                    }
                                },
                                {
                                    label = "The feeling.",
                                    response = {
                                        speaker = "Solin",
                                        text = "Feelings don’t return things. But they echo.\nSometimes in useful ways."
                                    }
                                }
                            }
                        }
                    },
                    {
                        label = "I wanted silence",
                        response = {
                            speaker = "Solin",
                            text = "Then speak no more, and listen to what remains."
                        }
                    }
                }
            }
        },
        {
            label = "A dream",
            response = {
                speaker = "Solin",
                text = "You’re still in it.\nBut dreaming isn’t sleeping.",
                choices = {
                    {
                        label = "I’m fine.",
                        response = {
                            speaker = "Solin",
                            text = "Then listen to the silence, and move forward."
                        }
                    },
                    {
                        label = "This place is strange.",
                        response = {
                            speaker = "Solin",
                            text = "Strange is only unfamiliar. Not wrong."
                        }
                    },
                    {
                        label = "Why are you here?",
                        response = {
                            speaker = "Solin",
                            text = "To ask what no one else does. And to wait."
                        }
                    }
                }
            }
        },
        {
            label = "Something I lost",
            response = {
                speaker = "Solin",
                text = "Loss often leads to search.\nBut is it the thing — or the feeling?",
                choices = {
                    {
                        label = "The feeling.",
                        response = {
                            speaker = "Solin",
                            text = "Some feelings never stop echoing.\nLet that echo guide you."
                        }
                    },
                    {
                        label = "It was both.",
                        response = {
                            speaker = "Solin",
                            text = "Then your burden is doubled, but so is your purpose."
                        }
                    }
                }
            }
        }
    }
}

return tree
