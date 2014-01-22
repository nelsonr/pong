ball = {}

function ball.draw()
	love.graphics.draw(ball.image, ball.x, ball.y)
end

function ball.reset()
	ball.x = (love.window.getWidth() / 2) - (ball.width / 2)
	ball.y = (love.window.getHeight() / 2) - (ball.height / 2)
end

function ball.load()
	ball.width = 15
	ball.height = 15
	ball.x = (love.window.getWidth() / 2) - (ball.width / 2)
	ball.y = (love.window.getHeight() / 2) - (ball.height / 2)
	ball.speed = 200
	ball.yVelocity = ball.speed
	ball.xDirection = 1
	ball.image = love.graphics.newImage('images/puck.png')
end

function ball.move(dt)
	ball.x = ball.x + (ball.speed * dt) * ball.xDirection
	ball.y = ball.y + (ball.yVelocity * dt)

	-- invert direction when reaches boundaries
	if ball.y < 0 or (ball.y + ball.height) > love.window.getHeight() then
		ball.yVelocity = -ball.yVelocity
	end

	return ball
end