--mainArea.lua
main_area = {}

function main_area:init()
	--set physics meter to 32 pixels
  love.physics.setMeter(32)
  --create world
	world = love.physics.newWorld(0, 64)
	--set callbacks
	world:setCallbacks(beginContact, endContact)
  --check is main area is created
  print("Main area initialized!")
end

function main_area:enter(previous, player_pos)
  --create background
   local map = {2, 2, 3, 3, 3, 4, 4}
  currentBG = Background(map, "Assets/BG_outside.png")
	--create player with player_pos
	player = Player(player_pos.x, player_pos.y)
	--create world objects
  platforms = {}
  platforms[1] = Platform(80, 608 - 96, 160, 64)
  platforms[2] = Platform(320, 608 - 96, 160, 64)
  platforms[3] = Platform(480, 608 - 96, 160, 64)
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
  fixtureA:getUserData():onCollide(fixtureB, contact)
end

function endContact(fixtureA, fixtureB, contact)
  --test if there if fixtureA has a reaction to fixtureB
  fixtureA:getUserData():endCollide(fixtureA, contact)
end