score = {}
playerA, playerB = {}, {}

function score.draw()
	local centerX = love.window.getWidth() / 2

	love.graphics.setColor(30, 30, 30)
	love.graphics.printf(playerA.score, centerX - 60, 15, 45, 'center')
	love.graphics.print(playerB.score, centerX + 30, 15)
end

function score.watch(ball)
	if ball.x < 0 or ball.x > love.window.getWidth() then 
		if ball.x < 0 then 
			playerB.score = playerB.score + 1 
		end

		if ball.x > love.window.getWidth() then 
			playerA.score = playerA.score + 1 
		end

		ball.reset()
		ball.speed = ball.speed + 10
	end
end

function score.load()
	playerA.name = 'Blue'
	playerA.score = 0
	
	playerB.name = 'Red'
	playerB.score = 0
end

function score.gameover(player)
	local centerX = love.graphics.getWidth() / 2
	local centerY = love.graphics.getHeight() / 2
	local message = player.name .. ' Wins!'

	love.graphics.setColor(30, 30, 30)
	love.graphics.printf(message, centerX - 100, centerY - 25, 200, 'center')
end