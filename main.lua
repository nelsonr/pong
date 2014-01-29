require 'pad'
require 'collision'
require 'field'
require 'score'
require 'title'
require 'menu'

local ball = require 'ball'

-- Game Modes
local game = {
	mode = 'p1_vs_cpu',

	-- Player VS CPU
	p1_vs_cpu = {
		settings = function() end,

		loop = function(dt)
			pad.move(padLeft, dt)
			pad.ai(padRight, ball, dt)
		end
	},

	-- Player VS Player
	p1_vs_p2 = {
		settings = function() end,

		loop = function(dt)
			pad.move(padLeft, dt)
			pad.move(padRight, dt)
		end
	},

	-- CPU VS CPU
	cpu_vs_cpu = {
		settings = function()
			ball.speed = 1200
			padLeft.speed = 800
			padRight.speed = 800
		end,

		loop = function(dt)
			pad.ai(padLeft, ball, dt)
			pad.ai(padRight, ball, dt)
		end
	}
}

-- Game Menus
local title_menu = menu.create('title', {
	{
		label = 'Player vs Player',
		callback = function() 
			game.mode = 'p1_vs_p2' 
			game.start()
		end
	},
	{
		label = 'Player vs CPU',
		callback = function() 
			game.mode = 'p1_vs_cpu' 
			game.start()
		end 
	},
	{
		label = 'CPU vs CPU',
		callback = function() 
			game.mode = 'cpu_vs_cpu'
			game.start()
		end 
	},
	{
		label = 'Exit',
		callback = function() love.event.push('quit') end
	}
})

local gameover_menu = menu.create('gameover', {
	{
		label = 'Play again?', 
		callback = function() game.start() end
	},
	{
		label = 'Back to title', 
		callback = function() love.load() end
	}
})

-- Game Screens
local screen = {}

screen.title = function()
	title.draw()
	menu.draw(title_menu, center_x - 90, 250)
end

screen.playing = function()
	-- score
	score.draw()
	
	-- pads
	pad.draw(padLeft, padLeft.color)
	pad.draw(padRight, padRight.color)

	-- ball
	ball.draw()
end

screen.paused = screen.playing

screen.gameover = function()
	-- score
	score.draw()
	
	-- pads
	pad.draw(padLeft, padLeft.color)
	pad.draw(padRight, padRight.color)

	-- winning message
	if playerA.score == 10 then score.gameover(playerA) end
	if playerB.score == 10 then score.gameover(playerB) end

	-- menu
	menu.draw(gameover_menu, center_x - 90, 250)
end

-- Game start
function game.start()
	pad.load()
	ball.load()
	score.load()

	-- load game mode settings
	game[game.mode].settings()

	gamestate = 'playing'	
end

function love.draw()
	-- field
	field.draw()

	-- gamestate
	screen[gamestate]()
end

function love.update(dt)
	if gamestate == 'playing' then
		-- mode specific updates
		game[game.mode].loop(dt)

		-- update ball
		ball.update(dt)

		-- test for collisions
		collision(ball, padLeft, dt)
		collision(ball, padRight, dt)

		-- watch score
		score.watch(ball)

		if playerA.score == 10 or playerB.score == 10 then
			-- end game
			gamestate = 'gameover'
		end
	end

	if gamestate == 'title' then
		title.update(dt)
	end
end

function love.keypressed(key)
	if gamestate == 'title' then
		menu.keypressed(title_menu, key)
	end

	if gamestate == 'gameover' then
		menu.keypressed(gameover_menu, key)
	end

	if key == 'p' then
		if gamestate == 'playing' then gamestate = 'paused'
		elseif gamestate == 'paused' then gamestate = 'playing'
		end
	end

	if gamestate == 'playing' and key == 'escape' then
		love.load()
	end
end

function love.load()
	love.window.setMode(640, 480)
	love.window.setTitle('Super Hockey Pong')
	love.graphics.setFont(love.graphics.setNewFont(20))

	center_x = love.window.getWidth() / 2
	center_y = love.window.getHeight() / 2

	field.load()
	pad.load()
	ball.load()
	score.load()
	title.load()

	gamestate = 'title'
end