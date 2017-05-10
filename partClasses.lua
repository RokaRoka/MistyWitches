--partClasses.lua
Image = Class{__includes = Part,
	init = function(self, parent, name, filepath, offx, offy, w, h)
		Part.init(self, parent, name)
		self.image = love.graphics.newImage("filepath")
		
		self.r = 0
		self.sx = 1
		self.sy = 1

		--[[
		self.offx = offx or 0
		self.offy = offy or 0
		--]]
		--if there is an offset or different size, make a quad
		if offx ~= 0 or offy ~= 0 or w ~= 0 or h ~= 0 then
			self.quad = (self.offx, self.offy, w, h, self.image:get)
		end
	end
}

function Image:draw()
	if self.quad then
		love.graphics.draw(self.image, self.quad, self.parent.pos.x, self.parent.pos.y, self.r, self.sx, self.sy)
	else
		love.graphics.draw(self.image, self.parent.pos.x, self.parent.pos.y, self.r, self.sx, self.sy)
	end
end

Physics = Class{__includes = Part,
	init = function(self, parent, name, shape, type, w, h, layers, masks)
		Part.init(self, parent, name)

		--Set Physics base
		self.body = love.physics.newBody(world, self.parent.pos.x, self.parent.pos.y, type)
		if shape == "rectangle" then
			self.shape = love.physics.newRectangleShape(w, h)
		elseif shape == "square" then
			self.shape = love.physics.newRectangleShape(w, w)
		elseif shape == "circle" then
			self.shape = love.physics.newCircleShape(w)
		end
		self.fixture = love.physics.newFixture(self.body, self.shape)

		--set collision layers
		self.fixture:setCategory(layers)
		self.fixture:setMask(masks)
	end
}