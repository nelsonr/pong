score = {}
playerA, playerB = {}, {}

function score.draw()
	local centerX = love.window.getWidth() / 2

	love.graphics.setColor(30, 30, 30)
	love.graphics.print(playerA.score, centerX - 45, 15)
	love.graphics.print(playerB.score, centerX + 30, 15)
end

function score.watch(ball)
	if ball.x < 0 then 
		playerB.score = playerB.score + 1 
		ball.reset()
	end

	if ball.x > love.window.getWidth() then 
		playerA.score = playerA.score + 1 
		ball.reset()
	end
end

function score.load()
	playerA.name = 'Blue'
	playerA.score = 0
	
	playerB.name = 'Red'
	playerB.score = 0
end