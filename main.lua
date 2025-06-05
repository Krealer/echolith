-- main.lua

local player = require("player")
local mapManager = require("map_manager")
local dialogue = require("dialogue_state")
local solin = require("characters.solin")
local inventory = require("inventory")
local settings = require("settings")


function love.load()
    love.window.setTitle("ECHOLITH")
    mapManager.load()
    player.load()
end

function love.update(dt)
    player.update(dt)
end

function love.draw()
    mapManager.draw()
    dialogue.draw()
    inventory.draw()
end


function love.keypressed(key)
    -- 🔍 Toggle debug grid
    if key == "t" then
        mapManager.toggleDebugGrid()
        return
    end

    -- 📦 Inventory toggle
    if key == "q" then
        inventory.toggle()
        return
    end

    -- 💬 If in dialogue, only handle dialogue keys
    if dialogue.active then
        dialogue.keypressed(key)
        return
    end

    -- 🎮 If inventory is open, allow inventory interaction
    if inventory.open then
        inventory.keypressed(key)
        return
    end

    -- 👣 Normal gameplay controls
    player.keypressed(key)
end