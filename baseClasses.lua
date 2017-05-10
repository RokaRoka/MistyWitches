--baseClasses.lua

--BASE CLASS - Debug
--STATUS - INCOMPLETE
Debug = Class{
	init = function(self, parent, text)
		self.parent = parent
		self.text = text
		self.active = true

		self.color = {75, 75, 200, 255}
	end
}

--BASE CLASS - Part
--STATUS - INCOMPLETE
Part = Class{
	init = function(self, parent, name)
		self.parent = parent
		self.name = name
		self.active = true
	end
}

function Part:update()
	--specific part updates in child classes
end

function Part:draw()
	--specific part draws in child classes
end

--Other part classes
require("partClasses")


--BASE CLASS - Object
--STATUS - INCOMPLETE
Object = Class{
	init = function(self, name, x, y)
		self.pos = vector.new(x, y)
		self.debug = Debug(name.." Spawned!".."(Object "..self.obj_i..")")

		--physical body (parent, x, y, type of body, shape, wr, h)
		--self.p_body = PhysicsBody(self, self.pos.x, self.pos.y, "static", "rectangle", self.w, self.h)
		
		--An array for parts
		self.parts = {}
		self.part_i = 1

		self.obj_i = Object.obj_i + 1
		Object.all[self.obj_i] = self
		Object.obj_i = self.obj_i
	end,
	all = {}, obj_i = 0,

	updateAll = function(dt)
		for i = 1, Object.obj_i do
			local current = Object.all[i]
			current:update(dt)
		end
	end,

	--[[
	drawAll = function()
		for i = 1, Object.obj_i do
			local current = Object.all[i]
			
			if current. then
				current:draw()
			end
			if current.debug.drawable then
				love.graphics.setColor(current.debug.color)
				love.graphics.rectangle("line", current.pos.x - (current.w/2), current.pos.y - (current.h/2), current.w, current.h)
				love.graphics.setColor(255, 255, 255)
			end
		end
	end
	--]]
}

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