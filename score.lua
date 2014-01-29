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
	playerA.win_image = love.graphics.newImage('images/blue_wins.png')
	playerA.score = 0
	
	playerB.win_image = love.graphics.newImage('images/red_wins.png')
	playerB.score = 0
end

function score.gameover(player)
	local centerX = love.graphics.getWidth() / 2
	local centerY = love.graphics.getHeight() / 2
	local x = (love.window.getWidth() / 2) - (player.win_image:getWidth() / 2)
	
	love.graphics.draw(player.win_image, x, 150)
end