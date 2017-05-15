--baseClasses.lua

--BASE CLASS - Debug
Debug = Class{
	init = function(self, parent, text)
		self.parent = parent
		self.text = text
		self.active = true

		self.color = {75, 75, 200, 255}
	end
}

--BASE CLASS - Part
Part = Class{
	init = function(self, parent, name)
		self.parent = parent
		self.name = name
		self.active = true
	end
}

function Part:update(dt)
	--specific part updates in child classes
end

function Part:draw()
	--specific part draws in child classes
end

--Other part classes
require("partClasses")


--BASE CLASS - Object
Object = Class{
	init = function(self, name, x, y)
    --add this object to the table
    self.obj_i = #Object.all
		table.insert(Object.all, self)
    
		self.pos = vector.new(x, y)
    self.name = name
		self.debug = Debug(name.." Spawned!".."(Object "..self.obj_i..")")

		--physical body (parent, x, y, type of body, shape, wr, h)
		--self.p_body = PhysicsBody(self, self.pos.x, self.pos.y, "static", "rectangle", self.w, self.h)
		
		--An array for parts
		self.parts = {}
    --an bool to represent if there are parts to be drawn
    self.drawable = false
	end,
	all = {},

	updateAll = function(dt)
		for i = 1, #Object.all do
			local current = Object.all[i]
      
			current:update(dt)
		end
	end,

	
	drawAll = function()
		for i = 1, #Object.all do
			local current = Object.all[i]
			
			if current.drawable then
				current:draw()
			end
		end
	end	
}

function Object:update(dt)
	for i = 1, #self.parts do
		if self.parts[i].active then self.parts[i]:update(dt) end
	end
end

function Object:draw()
	for i = 1, #self.parts do
		if self.parts[i].active then self.parts[i]:draw() end
	end
end

function Object:partSearch(name)
	--slow and shitty way to search
	for i = 1, #self.parts do
		if self.parts[i].name == name then
			return self.parts[i]
		end
	end
	--if nothing is found, error
	return nil
end