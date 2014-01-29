local ball = {}
ball.effects = {}

local function get_center_ball_x()
	return (love.window.getWidth() / 2) - (ball.width / 2)
end

local function get_center_ball_y()
	return (love.window.getHeight() / 2) - (ball.height / 2)
end

-- ball effects

function ball.effects.grow(factor, dt)
	ball.scale = ball.scale + (factor * dt)
end

function ball.effects.shrink(dt)
	ball.scale = ball.scale - (ball.scale * dt)

	if ball.scale < 1 then ball.scale = 1 end
end

--

function ball.draw()
	love.graphics.draw(
		ball.image, 
		ball.x, ball.y, 
		0, -- rotation (radians)
		ball.scale
	)
end

function ball.reset()
	ball.yVelocity = ball.speed * (0.02 * math.random(20, -20))
	ball.x = get_center_ball_x()
	ball.y = get_center_ball_y()
end

function ball.load()
	ball.width = 15
	ball.height = 15
	ball.x = get_center_ball_x()
	ball.y = get_center_ball_y()
	ball.speed = 320
	ball.yVelocity = ball.speed / 2
	ball.xDirection = 1
	ball.scale = 1
	ball.image = love.graphics.newImage('images/puck.png')
end

function ball.move(dt)
	ball.x = ball.x + (ball.speed * dt) * ball.xDirection
	ball.y = ball.y + (ball.yVelocity * dt)

	-- invert direction when reaches boundaries
	if ball.y < 0 then
		ball.yVelocity = math.abs(ball.yVelocity)
	end

	if (ball.y + ball.height) >= love.window.getHeight() then
		ball.yVelocity = -math.abs(ball.yVelocity)
	end

	return ball
end

function ball.update(dt)
	ball.move(dt)
	ball.effects.shrink(dt)
end

return ball