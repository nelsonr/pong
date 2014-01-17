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
	ball.xDirection = 1
	ball.yDirection = -1
	ball.image = love.graphics.newImage('images/puck.png')
end

function ball.move(delta)
	ball.x = ball.x + (ball.speed * delta) * ball.xDirection
	ball.y = ball.y + (ball.speed * delta) * ball.yDirection

	-- invert direction when reaches boundaries
	if (ball.y + ball.height) > love.window.getHeight() then
		ball.yDirection = -1
	end

	if ball.y < 0 then
		ball.yDirection = 1
	end

	return ball
end