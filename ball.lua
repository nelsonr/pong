ball = {}

local function center_ball_x()
	return (love.window.getWidth() / 2) - (ball.width / 2)
end

local function center_ball_y()
	return (love.window.getHeight() / 2) - (ball.height / 2)
end

function ball.draw()
	love.graphics.draw(ball.image, ball.x, ball.y)
end

function ball.reset()
	ball.yVelocity = ball.speed * (0.02 * math.random(20, -20))
	ball.x = center_ball_x()
	ball.y = center_ball_y()
end

function ball.load()
	ball.width = 15
	ball.height = 15
	ball.x = center_ball_x()
	ball.y = center_ball_y()
	ball.speed = 300
	ball.yVelocity = ball.speed
	ball.xDirection = 1
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