-- inventory.lua

local inventory = {
    items = {},
    open = false,
    maxSize = 5
}

function inventory.add(item)
    if inventory:has(item) then
        return false -- Item already in inventory
    end

    if #inventory.items < inventory.maxSize then
        table.insert(inventory.items, item)
        return true
    end

    return false -- Inventory full
end


function inventory.toggle()
    inventory.open = not inventory.open
end

function inventory.draw()
    if not inventory.open then return end

    love.graphics.setColor(0, 0, 0, 0.8)
    love.graphics.rectangle("fill", 100, 100, 500, 300)

    love.graphics.setColor(1, 1, 1)
    love.graphics.printf("Inventory", 100, 110, 500, "center")

    for i, item in ipairs(inventory.items) do
        love.graphics.printf("- " .. item, 120, 120 + i * 25, 460, "left")
    end
end

function inventory.keypressed(key)
    if key == "q" then
        inventory.toggle()
    end
end

function inventory:has(item)
    for _, v in ipairs(self.items) do
        if v == item then return true end
    end
    return false
end


return inventory
