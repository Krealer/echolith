-- main.lua

local player = require("player")
local map = require("map")
local dialogue = require("dialogue_state")
local solin = require("characters.solin")
local inventory = require("inventory")

function love.load()
    love.window.setTitle("ECHOLITH")
    map.load()
    player.load()
end

function love.update(dt)
    player.update(dt)
end

function love.draw()
    map.draw()
    solin.draw()      -- ✅ Draw Solin
    player.draw()
    dialogue.draw()
    inventory.draw()
end

function love.keypressed(key)
    -- Handle Dialogue input
    if dialogue.active then
        dialogue.keypressed(key)
        return
    end

    -- Handle Inventory toggle or lock input if open
    if inventory.open then
        inventory.keypressed(key)
        return
    end

    -- Always allow inventory to toggle even when closed
    if key == "q" then
        inventory.toggle()
        return
    end

    -- Player interaction and movement
    player.keypressed(key)
end

