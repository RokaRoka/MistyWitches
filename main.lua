--main.lua
--load HUMP
Class = require("hump.class")
Gamestate = require("hump.gamestate")
vector = require("hump.vector")
Signal = require("hump.signal")

--main classes
require("baseClasses")

function love.load()
  print("LOVE2D loaded!")
	--load objects
	require("objects")
	--load main area
	require("mainArea")

  Gamestate.registerEvents()
	Gamestate.switch(main_area, vector.new(48, 350))
end

function love.keypressed(key, scan, isRepeat)
	if key == 'escape' then
		love.event.quit()
	end
end