local field = {}

function field.draw()
    love.graphics.setColor(255,255,255)
    love.graphics.draw(field.bg, 0, 0)
end

function field.load()
    field.bg = love.graphics.newImage('images/bg.png')
end

return field