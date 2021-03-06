--partClasses.lua
Image = Class{__includes = Part,
	init = function(self, parent, name, filepath, offx, offy, qw, qh)
		Part.init(self, parent, name)
		self.image = love.graphics.newImage(filepath)
		
		self.r = 0
		self.sx = 1
		self.sy = 1
    
    local imgw, imgh = self.image:getDimensions()
    self.qw = qw or imgw
    self.qh = qh or imgh
		self.offx = offx or 0
		self.offy = offy or 0

		--if there is an offset or different size, make a quad
		if self.offx ~= 0 or self.offy ~= 0 or {qw, qh} ~= self.image:getDimensions() then
			self.quad = love.graphics.newQuad(self.offx, self.offy, self.qw, self.qh, self.image:getDimensions())
		end
    
    --the parent is drawable since this part is drawable
    self.parent.drawable = true
	end
}

function Image:draw()
	if self.quad then
		love.graphics.draw(self.image, self.quad, self.parent.pos.x - (self.qw/2), self.parent.pos.y - (self.qh/2), self.r, self.sx, self.sy)
	else
		love.graphics.draw(self.image, self.parent.pos.x - (self.qw/2), self.parent.pos.y - (self.qh/2), self.r, self.sx, self.sy)
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

BgImage = Class{__includes = Part,
  init = function(self, parent, name, filepath, tiledata)
    Part.init(self, parent, name)
    self.image = love.graphics.newImage(filepath)
  
    --initialize tilebatch
    self.batch = love.graphics.newSpriteBatch(self.image, #tiledata, "static")
    --sprBat:clear()
    
    --co-ordinates for first background, second, etc.
    local bgtextures = {}
    --with dark and light dots
    bgtextures[1] = love.graphics.newQuad(0, 0, 128, 544, self.image:getDimensions())
    --with cave
    bgtextures[2] = love.graphics.newQuad(128, 0, 128, 544, self.image:getDimensions())
    --with dark dots
    bgtextures[3] = love.graphics.newQuad(256, 0, 128, 544, self.image:getDimensions())
    --with light dots
    bgtextures[4] = love.graphics.newQuad(384, 0, 128, 544, self.image:getDimensions())
    
    self.handles = {}
  for i = 1, #tiledata do
    --add BG tile based on data
    self.handles[i] = self.batch:add(bgtextures[tiledata[i]], (i * 128) - 128, 0)
  end
    --the parent is drawable since this part is drawable
    self.parent.drawable = true
  end
}

function BgImage:draw()
  love.graphics.draw(self.batch, 0, 0)
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

    --set userdata to self for collisions
    self.fixture:setUserData(self)

		--set collision layers
		if layer then self.fixture:setCategory(layer) end
		if mask then self.fixture:setMask(mask) end
	end
}

function Physics:onCollide(outerFixture, contact)
  --to be written for each object
end

function Physics:endCollide(outerFixture, contact)
  --to be written for each object
end