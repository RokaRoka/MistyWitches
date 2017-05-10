--main.lua
--load HUMP
Class = require("hump.class")
Gamestate = require("hump.gamestate")
vector = require("hump.vector")
Signal = require("hump.signal")

--main classes
require("baseClasses")

function love.load()
	--load main area
	require("mainArea")
end

function love.keypressed(key, scan, isRepeat)
	if key == 'escape' then
		love.event.quit()
	end
end