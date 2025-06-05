-- Base structure, locals + require 

-- settings.lua
local settings = {
    reveal = false
}

function settings.toggleReveal()
    settings.reveal = not settings.reveal
end

return settings
