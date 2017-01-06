timerMax = 3
timer = timerMax

sprites = {}

function love.load(arg)
	-- init sprites
	spriteImg = love.graphics.newImage('assets/pink_gem_7.png')
	for i=1,200 do
		randomX = math.random(spriteImg:getWidth()/2, love.graphics.getWidth() - spriteImg:getWidth()/2)
		randomY = math.random(spriteImg:getWidth()/2, love.graphics.getHeight() - spriteImg:getWidth()/2)
		newSprite = { x = randomX, y = randomY, img = spriteImg, dxdt = nil, dydt = nil, x1 = nil, y1 = nil, t = 0, rt = 0 }
		table.insert(sprites, newSprite)
	end
end

function love.update(dt)
	-- test randomly change multiple sprite position every time timer ticks
	timer = timer - dt
	if timer < 0 then
		timer = timerMax

		for i, sprite in ipairs(sprites) do
			sprite.x1 = sprite.x
			sprite.y1 = sprite.y
			sprite.x2 = math.random(sprite.img:getWidth()/2, love.graphics.getWidth() - sprite.img:getWidth()/2)
			sprite.y2 = math.random(sprite.img:getWidth()/2, love.graphics.getHeight() - sprite.img:getWidth()/2)
			sprite.t = math.random(3)
			sprite.rt = sprite.t
		end
	end
	--]]

	-- Move sprites w.r.t remaining time
	for i, sprite in ipairs(sprites) do
		if sprite.rt > 0 then
			dxdt = (sprite.x2 - sprite.x1) * (dt/sprite.t)
			dydt = (sprite.y2 - sprite.y1) * (dt/sprite.t)
			sprite.x = sprite.x + dxdt
			sprite.y = sprite.y + dydt
			sprite.rt = sprite.rt - dt
			if sprite.rt < 0 then
				sprite.rt = 0
			end
		end
	end

	--[[ Test regenerate sprites
	if #sprites < 1 then
		for i=1,100 do
		randomX = math.random(spriteImg:getWidth()/2, love.graphics.getWidth() - spriteImg:getWidth()/2)
		randomY = math.random(spriteImg:getWidth()/2, love.graphics.getHeight() - spriteImg:getWidth()/2)
		newSprite = { x = randomX, y = randomY, img = spriteImg, dxdt = nil, dydt = nil, x1 = nil, y1 = nil, t = 0, rt = 0 }
		table.insert(sprites, newSprite)
		end
	end
	--]]
end

function love.mousepressed(x, y, button, istouch)
	if button == 1 then
		
		for i, sprite in ipairs(sprites) do
			sprite.x1 = sprite.x
			sprite.y1 = sprite.y
			sprite.x2 = x
			sprite.y2 = y
			sprite.t  = math.random(1)
			sprite.rt = sprite.t
		end

		--[[
		for i, sprite in ipairs(sprites) do
			if CheckIfContain(x,y, sprite.x,sprite.y,sprite.img:getWidth(),sprite.img:getHeight()) then
				table.remove(sprites, i)
				return
			end
		end
		--]]
	end
end

function love.draw()
    -- Multiple sprites
    love.graphics.setColor(255, 255, 0)
    for i, sprite in ipairs(sprites) do
		love.graphics.draw(sprite.img, sprite.x-sprite.img:getWidth()/2, sprite.y-sprite.img:getHeight()/2)
	end

	-- Debug FPS
	if debug then
		fps = tostring(love.timer.getFPS())
		love.graphics.print("Current FPS: "..fps, 9, 10)
	end
end