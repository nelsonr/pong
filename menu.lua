local menu = {}

function menu.draw(menu, x, y, font_size)
    local padding = 10
    local width = 180
    local font_size = font_size or 20
    local spacing = font_size
    local height = font_size * 1.6

    love.graphics.setColor(0,0,0)

    for i, item in pairs(menu.body) do
        local item_y = y + ((spacing + (padding * 2)) * (i - 1))
        
        -- draw rectangle   
        love.graphics.setColor(255, 255, 255)
        love.graphics.rectangle('fill', x, item_y, width, height + padding)

        -- set font color
        love.graphics.setColor(0,0,0)

        if i == menu.selected then
            -- set selected color
            love.graphics.setColor(221, 175, 65)
        end

        love.graphics.printf(item.label, x, item_y + padding, width, 'center') 
    end
end

function menu.keypressed(menu, key)
    if key == 'up' then
        menu.selected = menu.selected - 1
        if menu.selected < 1 then menu.selected = 1 end
    end

    if key == 'down' then
        menu.selected = menu.selected + 1
        if menu.selected > #menu.body then menu.selected = #menu.body end
    end

    if key == 'return' then
        menu.body[menu.selected].callback()
    end
end

function menu.create(state, body)
    return {
        selected = 1, -- index of the menu item with focus
        state = state, -- in which gamestate the menu should be visible
        body = body
    }
end

return menu