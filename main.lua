require 'ball'
require 'pad'
require 'collision'
require 'field'
require 'score'

function love.draw()
	-- draw field
	field.draw()

	-- draw score
	score.draw()
	
	-- draw pads
	pad.draw(padLeft, padLeft.color)
	pad.draw(padRight, padRight.color)

	-- draw ball
	ball.draw()
end

function love.update(dt)
	-- update pads
	pad.move(padLeft, dt)
	pad.move(padRight, dt)

	-- update ball
	collision(collision(ball.move(dt), padLeft), padRight)

	-- watch score
	score.watch(ball)
end

function love.load()
	love.window.setTitle('Super Master Pong')
	love.window.setMode(640, 480)

	love.graphics.setFont(love.graphics.newFont(30))

	field.load()
	pad.load()
	ball.load()
	score.load()
end