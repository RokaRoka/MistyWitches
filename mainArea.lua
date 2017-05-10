--mainArea.lua
main_area = {}

function main_area:init()
	--create world
	world = love.physics.newWorld(0, 0)
	--set callbacks
	world:setCallbacks(beginContact, endContact)
end

function main_area:enter(previous, player_pos)
	--create player with player_pos

	--create world objects

end

function main_area:update(dt)
	--update physics
	world:update(dt)
	--update all objects
	Object.updateAll(dt)
	--update UI
	--update Window
end

function main_area:draw()
	--draw all objects
	Object.drawAll()
	--draw UI
	--draw Window
end

function main_area:leave()
	--destroy objects
	--destroy all window
	--destroy UI
end