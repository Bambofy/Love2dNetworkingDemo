require 'libs/console'
require 'libs/math'

require 'libs/LUBE'
require 'libs/TSerial'

HC = require 'libs/HC'

players = {}
player_bodys = {}

-- NETWORKING --

function onConnect(id)
	-- we use two different tables for the body and coords, the voords one is what is sent back to the client, the player_bodys is for the serverside Collision detection
	player_bodys[id] = Collider:addRectangle(1,1, 32,32)
	players[id] = { x = 1, y = 1, name = "Anon"}
end

function onReceive(data, id)
	if data == 'left' then
		player_bodys[id]:move( -1, 0 )
	elseif data == 'right' then
		player_bodys[id]:move( 1, 0 )
	end

	if data == 'up' then
		player_bodys[id]:move( 0, -1 )
	elseif data == 'down' then
		player_bodys[id]:move( 0, 1 )
	end

	if data == 'quit' then
		player_bodys[id] = nil
		players[id] = nil
	end
end

function onDisconnect(id)
end



-- COLLISION DETECTION --
function on_collision(dt, shape_one, shape_two, mtv_x, mtv_y)
    shape_one:move(mtv_x/2, mtv_y/2)
    shape_two:move(-mtv_x/2, -mtv_y/2)
end

function love.load()
	Collider = HC( 100, on_collision )
	love.graphics.setBackgroundColor( 50, 50, 50 )

	server = lube.server(18025)
	server:setCallback(onReceive, onConnect, onDisconnect)
	server:setHandshake("chillout")
end

function love.draw()
	drawMessages()
end

function love.update( dt )
	Collider:update( dt )
	server:update(dt)

	-- update the values to be sent across the network, we do this so the collision detection system is seperate :D
	for k, v in pairs( players ) do
		v.x,v.y = player_bodys[k]:center()
	end

	server:send( TSerial.pack( players ) )
end

function love.keypressed( key )
end

function love.keyreleased( key )
end

function love.mousepressed( x, y, key )
end