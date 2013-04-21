local text= {}

function mPrint( message )
	text[#text+1] = string.format(message)
end

function drawMessages()
	for i=1, #text do
		love.graphics.setColor(255,255,255, 255 - (i-1) * 6)
        love.graphics.print(text[#text - (i-1)], 10, i * 15)
	end

	love.graphics.setColor( 255, 255, 255, 255 )
end