local ball = require 'ball'

title = {}

local function draw_title()
	local x = (love.window.getWidth() / 2) - (title.logo:getWidth() / 2)
	love.graphics.draw(title.logo, x, 120)
end

-- Move around the screen
local function move_around(dt)
	ball.x = ball.x + (ball.speed * dt) * ball.xDirection
	ball.y = ball.y + (ball.yVelocity * dt)

	-- invert direction when reaches boundaries
	if ball.y < 0 then
		ball.yVelocity = math.abs(ball.yVelocity)
	end

	if (ball.y + ball.height) >= love.window.getHeight() then
		ball.yVelocity = -math.abs(ball.yVelocity)
	end

	if ball.x < 0 then ball.xDirection = 1 end
	if ball.x + ball.width >= love.window.getWidth() then ball.xDirection = -1 end

	return ball
end

function title.draw()
	ball.draw()
	draw_title()
end

function title.update(dt)
	move_around(dt)
end

function title.load()
	title.logo = love.graphics.newImage('images/logo.png')
end