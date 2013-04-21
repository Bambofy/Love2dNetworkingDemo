players = {}

function onReceive(data)
	players = TSerial.unpack( data )
end

function load( ip, name )
	-- Collider = HC( 100, on_collision )
	cam = camera(vector(256, 208), 1)
	love.graphics.setBackgroundColor( 50, 50, 50 )

	client = lube.client()
	client:setHandshake("chillout")
	client:setCallback(onReceive)
	client:connect(ip, 18025)		--82.24.82.156 marks

	client:send( "name" .. name)
end

function love.draw()
	cam:attach()

	for k, v in pairs(players) do
		love.graphics.rectangle('fill', v.x, v.y, 32, 32)
		love.graphics.print(v.name, v.x-10, v.y-20)
	end

	cam:detach()

	-- debug
	drawMessages()
	love.graphics.print( love.timer.getFPS(), 10, 10 )
end

function love.update( dt )
	-- Collider:update( dt )
	client:update(dt)

	if love.keyboard.isDown('a') or love.keyboard.isDown('left') then
		client:send('left')
	elseif love.keyboard.isDown('d') or love.keyboard.isDown('right') then
		client:send('right')
	end

	if love.keyboard.isDown('w') or love.keyboard.isDown('up') then
		client:send('up')
	elseif love.keyboard.isDown('s') or love.keyboard.isDown('down') then
		client:send('down')
	end
end

function love.keypressed( key )
end

function love.keyreleased( key )
end

function love.mousepressed( x, y, key )
end

function love.quit()
	client:send('quit')
end