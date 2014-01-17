pad = {}
padLeft, padRight = {}, {}

function pad.draw(pad)
	-- pad zone
	love.graphics.setColor(240, 240, 240)
	love.graphics.rectangle('fill', pad.x, 0, pad.width, love.window.getHeight())

	-- pad
	love.graphics.setColor(pad.color.r, pad.color.g, pad.color.b)
	love.graphics.rectangle('fill', pad.x, pad.y, pad.width, pad.height)
end

function pad.move(pad, delta)
	if love.keyboard.isDown(pad.upKey) then
		pad.y = pad.y - (pad.speed * delta)

		if pad.y < 0 then pad.y = 0 end -- set top boundary
	end

	if love.keyboard.isDown(pad.downKey) then
		pad.y = pad.y + (pad.speed * delta)

		-- set bottom boundary
		if (pad.y + pad.height) > love.window.getHeight() then
			pad.y = love.window.getHeight() - pad.height		
		end
	end	

	return pad
end

function pad.create()
	local pad = {}

	pad.width = 15
	pad.height = 70
	pad.x = 0
	pad.y = 0
	pad.speed = 300
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