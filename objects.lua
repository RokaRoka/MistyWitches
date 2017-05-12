--objects.lua

--a custom part just for the player
--deals with input and moving the player physics
PlayerControl = Class{__includes = Part, 
	init = function(self, parent, name, physics_part, move_force, jump_force)
		Part.init(self, parent, name)
		--physics part borrowed from the player
		self.physics = physics_part
		--forces to be applied
		self.move_force = move_force
		self.jump_force = jump_force
	end
}

function PlayerControl:update(dt)
	local dx, dy = 0, 0
	if love.keyboard.isDown('left') then
        dx = -1
    elseif love.keyboard.isDown('right') then
        dx = 1
    end

    self:move(dt, dx, dy)
end

function PlayerControl:move(dt, dx, dy)
	local delta = vector(dx, dy)
	
	self.physics.body:setLinearVelocity(delta.x * (dt * 100), delta.y * (dt * 100))
	
	local newPx, newPy = self.physics.body:getPosition()
	newPx = math.floor(newPx)
	newPy = math.floor(newPy)

	self.parent.pos = vector.new(newPx, newPy)
end

Player = Class{__includes = Object,
	init = function(self, x, y)
		Object.init(self, "player", x, y)

		--create parts
		--physics
		self.parts[1] = Physics(self, "pBody", "rectangle", "dynamic", 32, 64, layers.player)
		--image
		--part[2] = Image(
		--playercontrol
		self.parts[3] = PlayerControl(self, "player_control", self.parts[1], 100, 300)
		self.parts[4] = DebugBox(self, "box1", 32, 64)
	end
}