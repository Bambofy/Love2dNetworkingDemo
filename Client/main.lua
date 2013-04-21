require 'libs/console'
require 'libs/math'

require 'libs/LUBE'
require 'libs/TSerial'

-- HC = require 'libs/HC'
-- class = require 'libs/hump/class'
camera = require 'libs/hump/camera'
vector = require 'libs/hump/vector'

function menu()
	require 'states/menu'
end

function playing( ip, name )
	require 'states/playing'
	load( ip, name )
end

function love.load()
	menu()
end