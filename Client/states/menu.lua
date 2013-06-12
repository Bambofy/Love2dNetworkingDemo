local name = ""
local ip = ""
local flag = 1

function love.draw()
	love.graphics.print("ip: " .. ip, 10, 10)
	love.graphics.print("name: " .. name, 10, 30 )
end

function love.keypressed( key )
	if key == 'return' then
		if flag == 1 then
			flag = 2
		elseif flag == 2 then
			playing( ip, name )
		end
	elseif key == 'backspace' then
		if flag == 1 then
			ip = string.sub(ip, 1, string.len( ip ) - 1)
		elseif flag == 2 then
			name = string.sub(name , 1, string.len( name  ) - 1)
		end
	else
		if flag == 1 then
			ip = ip .. key
		elseif flag == 2 then
			name = name .. key
		end
	end
end