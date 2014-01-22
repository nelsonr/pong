pad = {}
padLeft, padRight = {}, {}

local function move_up(pad, dt)
	pad.y = pad.y - (pad.speed * dt)
	
	-- set top boundary
	if pad.y < 0 then pad.y = 0 end
end

local function move_down(pad, dt)
	pad.y = pad.y + (pad.speed * dt)

	-- set bottom boundary
	if (pad.y + pad.height) > love.window.getHeight() then
		pad.y = love.window.getHeight() - pad.height		
	end
end

function pad.draw(pad)
	-- pad zone
	love.graphics.setColor(240, 240, 240)
	love.graphics.rectangle('fill', pad.x, 0, pad.width, love.window.getHeight())

	-- pad
	love.graphics.setColor(pad.color.r, pad.color.g, pad.color.b)
	love.graphics.rectangle('fill', pad.x, pad.y, pad.width, pad.height)
end

function pad.move(pad, dt)
	if love.keyboard.isDown(pad.upKey) then move_up(pad, dt) end
	if love.keyboard.isDown(pad.downKey) then move_down(pad, dt) end	

	return pad
end

function pad.ai(pad, ball, dt)
	if ball.x < love.window.getWidth() / 2 and ball.xDirection == -1 then
		if ball.y < pad.y then 
			move_up(pad, dt)		
		end	

		if ball.y + ball.height > pad.y + pad.height then
			move_down(pad, dt)
		end
	end
end

function pad.create()
	local pad = {}

	pad.width = 15
	pad.height = 70
	pad.x = 0
	pad.y = 0
	pad.speed = 200
	pad.bounceDirection = 1
	pad.color = {r=255, g=255, b=255}
	pad.upKey = 'up'
	pad.downKey = 'down'

	return pad
end

function pad.load()
	padLeft, padRight = pad.setup()

	-- set initial positions
	padLeft.y = (love.graphics.getHeight() / 2) - (padLeft.height / 2)
	padRight.x = (love.graphics.getWidth()) - padRight.width
	padRight.y = (love.graphics.getHeight() / 2) - (padRight.height / 2)
end

function pad.setup()
	local left, right

	-- left pad
	left = pad.create()
	left.color = {r=75, g=75, b=255} -- blue
	left.upKey = 'w'
	left.downKey = 's'

	-- right pad
	right = pad.create()
	right.bounceDirection = -1
	right.color = {r=255, g=75, b=75} -- red

	return left, right
end