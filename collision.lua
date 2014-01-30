local function collision(ball, pad, dt)
    -- if ball is in the same column of the pad, check for collision
    if ball.x + (ball.width) >= pad.x and ball.x <= pad.x + pad.width then
        if ball.y + ball.height >= pad.y and ball.y <= pad.y + pad.height then
            ball.xDirection = pad.bounceDirection -- bounce back

            -- increase ball speed slightly
            ball.speed = ball.speed + 2

            -- add grow effect
            ball.effects.grow(35, dt)

            local padCenter = pad.y + pad.height / 2
            local ballCenter = ball.y + ball.height / 2

            if ballCenter > padCenter then 
                ball.yVelocity = ball.speed * (0.02 * (ballCenter - padCenter))
            end

            if ballCenter < padCenter then 
                ball.yVelocity = -ball.speed * (0.02 * (padCenter - ballCenter))
            end
        end 
    end

    return ball
end

return collision