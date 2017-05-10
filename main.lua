--main.lua
--load HUMP
Class = require("hump.class")
Gamestate = require("hump.gamestate")
vector = require("hump.vector")
Signal = require("hump.signal")

function love.load()
	--load main area
end

function love.keypressed(key, scan, isRepeat)
	if key == 'escape' then
		love.event.quit()
	end
end