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

	-- draw gameover message
	if gamestate == 'gameover' then
		if playerA.score == 10 then score.gameover(playerA) end
		if playerB.score == 10 then score.gameover(playerB) end
	end
end

function love.update(dt)
	if gamestate == 'playing' then
		-- update pads
		pad.ai(padLeft, ball, dt)
		pad.move(padRight, dt)

		-- update ball
		ball.move(dt)

		-- test for collisions
		collision(ball, padLeft)
		collision(ball, padRight)

		-- watch score
		score.watch(ball)
	end

	if gamestate == 'gameover' then
		-- start new game
		if love.keyboard.isDown('return') then
			love.load()
		end
	end
	
	if playerA.score == 10 or playerB.score == 10  then
		gamestate = 'gameover'
	end
end

function love.load()
	love.window.setTitle('Super Master Pong')
	love.window.setMode(640, 480)

	love.graphics.setFont(love.graphics.newFont(30))

	field.load()
	pad.load()
	ball.load()
	score.load()

	gamestate = 'playing'
end