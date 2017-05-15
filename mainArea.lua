--mainArea.lua
main_area = {}

function main_area:init()
  --check is main area is created
  print("Main area initialized!")
	--set physics meter to 32 pixels
  love.physics.setMeter(32)
  --create world
	world = love.physics.newWorld(0, 64)
	--set callbacks
	world:setCallbacks(beginContact, endContact)
end

function main_area:enter(previous, player_pos)
	--create player with player_pos
	player = Player(player_pos.x, player_pos.y)
	--create world objects
  platforms = {}
  platforms[1] = Platform(100, 600 - 96, 200, 64)
  platforms[2] = Platform(300, 600 - 96, 200, 64)
  platforms[3] = Platform(500, 600 - 96, 200, 64)
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

function beginContact(fixtureA, fixtureB, contact)
  --test if there if fixtureA has a reaction to fixtureB
  fixtureA:getUserData():onCollide(fixtureB)
  --or viceversa
end

function endContact(fixtureA, fixtureB, contact)
  --test if there if fixtureA has a reaction to fixtureB
  fixtureA:getUserData():endCollide(fixtureA)
  --or viceversa
end