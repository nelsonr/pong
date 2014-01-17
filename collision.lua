function collision(ball, pad)
	-- if ball is in the same column of the pad, check for collision
	if ball.x + (ball.width / 2) >= pad.x and ball.x <= pad.x + pad.width then
		if ball.y + ball.height >= pad.y and ball.y <= pad.y + pad.height then
			ball.xDirection = pad.bounceDirection -- bounce back
		end 
	end

	return ball
end