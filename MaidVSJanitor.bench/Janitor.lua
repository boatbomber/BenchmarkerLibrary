-- Janitor
-- pobammer
-- September 10, 2020

local Janitors = setmetatable({}, {__mode = "k"})
local Janitor = {
	ClassName = "Janitor";
	__index = {CurrentlyCleaning = true};
}

local TypeDefaults = {
	["function"] = true;
	RBXScriptConnection = "Disconnect";
}

function Janitor.new()
	return setmetatable({CurrentlyCleaning = false}, Janitor)
end

function Janitor.Is(Object)
	return type(Object) == "table" and getmetatable(Object) == Janitor
end

function Janitor.__index:Add(Object, MethodName, Index)
	if Index then
		self:Remove(Index)

		local This = Janitors[self]

		if not This then
			This = {}
			Janitors[self] = This
		end

		This[Index] = Object
	end

	self[Object] = MethodName or TypeDefaults[typeof(Object)] or "Destroy"
	return Object
end

function Janitor.__index:Remove(Index)
	local This = Janitors[self]

	if This then
		local Object = This[Index]

		if Object then
			local MethodName = self[Object]

			if MethodName then
				if MethodName == true then
					Object()
				else
					Object[MethodName](Object)
				end

				self[Object] = nil
			end

			This[Index] = nil
		end
	end

	return self
end

function Janitor.__index:Get(Index)
	local This = Janitors[self]
	if This then
		return This[Index]
	end
end

function Janitor.__index:Cleanup()
	if not self.CurrentlyCleaning then
		self.CurrentlyCleaning = nil
		for Object, MethodName in next, self do
			if MethodName == true then
				Object()
			else
				Object[MethodName](Object)
			end

			self[Object] = nil
		end

		local This = Janitors[self]
		if This then
			for Index in next, This do
				This[Index] = nil
			end

			Janitors[self] = nil
		end

		self.CurrentlyCleaning = false
	end
end

function Janitor.__index:Destroy()
	self:Cleanup()
	table.clear(self)
	setmetatable(self, nil)
end

Janitor.__call = Janitor.__index.Cleanup

return Janitor
