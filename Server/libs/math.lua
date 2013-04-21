function math.dist(x1,y1, x2,y2) return ((x2-x1)^2+(y2-y1)^2)^0.5 end

function math.dir(x,y, x2,y2)
	local dirX = x - x2
	local dirY = y - y2

	local hyp = math.sqrt(dirX*dirX + dirY*dirY)
	dirX = dirX / hyp
	dirY = dirY / hyp

	return dirX, dirY
end

function math.rsign() return math.random(2) == 2 and 1 or -1 end