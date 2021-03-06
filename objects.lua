--objects.lua

--a custom part just for the player
--deals with input and moving the player physics
PlayerControl = Class{__includes = Part, 
	init = function(self, parent, name, physics_part, move_force, jump_force)
		Part.init(self, parent, name)
		--physics part borrowed from the player
		self.physics = physics_part
    --jump variable
    self.canJump = true 
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
  
  if love.keyboard.isDown('up') and self.canJump then
    self.canJump = false
    self.physics.body:setGravityScale(2)
    print("player jumped!")
    dy = -1
  end
  
  self:jump(dt, dy)
  self:move(dt, dx)
end

function PlayerControl:move(dt, dx)
	local garbage, oldVel = self.physics.body:getLinearVelocity()
	self.physics.body:setLinearVelocity(dx * self.move_force * (dt * 100), oldVel)
	
	local newPx, newPy = self.physics.body:getPosition()
	newPx = math.floor(newPx)
	newPy = math.floor(newPy)

	self.parent.pos = vector.new(newPx, newPy)
end

function PlayerControl:jump(dt, dy)
  local oldVel = self.physics.body:getLinearVelocity()
	self.physics.body:applyLinearImpulse(0, dy * self.jump_force * (dt * 100))
  
	local newPx, newPy = self.physics.body:getPosition()
	newPx = math.floor(newPx)
	newPy = math.floor(newPy)

	self.parent.pos = vector.new(newPx, newPy)
end

--[[function PlayerControl:draw()
  local vx, vy = self.physics.body:getLinearVelocity()
  love.graphics.print("Player Velocity: "..vx..", "..vy, 20, 20)
end]]

function PlayerControl:resetJump()
  self.canJump = true
end

Player = Class{__includes = Object,
	init = function(self, x, y)
		Object.init(self, "player", x, y)

		--create parts
		--physics
		self.parts[1] = Physics(self, "pBodypart", "rectangle", "dynamic", 32, 64, layers.player)
		--image
		self.parts[2] = Image(self, "img_idle", "Assets/player_idle.png") 
		--playercontrol
		self.parts[3] = PlayerControl(self, "playerControlpart", self.parts[1], Player.speed, Player.jump)
		--self.parts[2] = DebugBox(self, "box1", 32, 64)
    
    --define new onCollide function
    self.parts[1].onCollide = function (self, otherFixture, contact)
      --local nx, ny = contact:getNormal()
      if otherFixture:getUserData().parent.name == "platform" then
        print("Jump returned!")
        self.parent.parts[3].canJump = true end
    end
	end,
  speed = 75, jump = 100
}

Platform = Class{__includes = Object,
  init = function(self, x, y, w, h, imgpath)
    Object.init(self, "platform", x, y)
    
    --create parts
		--physics
		self.parts[1] = Physics(self, "pBodypart", "rectangle", "static", w, h, layers.platform, layers.platform)
		--image
		--self.parts[2] = Image(
		self.parts[2] = DebugBox(self, "box1part", w, h)
  end
}

Background = Class{__includes = Object,
  init = function(self, tiledata, imgpath)
    --create with x and y as center
    Object.init(self, "BG", (128 * #tiledata)/2, 544/2)
    
    self.tiledata = tiledata
    self.parts[1] = BgImage(self, "BGpart", imgpath, tiledata)
  end
}