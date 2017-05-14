--partClasses.lua
Image = Class{__includes = Part,
	init = function(self, parent, name, filepath, offx, offy, w, h)
		Part.init(self, parent, name)
		self.image = love.graphics.newImage(filepath)
		
		self.r = 0
		self.sx = 1
		self.sy = 1

		--[[
		self.offx = offx or 0
		self.offy = offy or 0
		--]]
		--if there is an offset or different size, make a quad
		if offx ~= 0 or offy ~= 0 or w ~= 0 or h ~= 0 then
			self.quad = love.graphics.newQuad(self.offx, self.offy, w, h, self.image:getDimensions())
		end
    
    --the parent is drawable since this part is drawable
    self.parent.drawable = true
	end
}

function Image:draw()
	if self.quad then
		love.graphics.draw(self.image, self.quad, self.parent.pos.x, self.parent.pos.y, self.r, self.sx, self.sy)
	else
		love.graphics.draw(self.image, self.parent.pos.x, self.parent.pos.y, self.r, self.sx, self.sy)
	end
end

DebugBox = Class{__includes = Part,
	init = function(self, parent, name, w, h, color)
		Part.init(self, parent, name)
		self.w = w
		self.h = h
		self.color = color or {100, 200, 100}
    
    --the parent is drawable since this part is drawable
    self.parent.drawable = true
	end
}

function DebugBox:draw()
  love.graphics.setColor(self.color)
	love.graphics.rectangle("line", self.parent.pos.x - (self.w/2), self.parent.pos.y - (self.h/2), self.w, self.h)
  love.graphics.setColor(255, 255, 255)
end

--COLLISION LAYERS
layers = {}

--string array for layers
layers.strings = {"Player", "Boundry", "Platform"}

--define layers
layers.player = 1

layers.boundry = 2

layers.platform = 3


Physics = Class{__includes = Part,
	init = function(self, parent, name, shape, type, w, h, layer, mask)
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
		if layer then self.fixture:setCategory(layer) end
		if mask then self.fixture:setMask(mask) end
	end
}