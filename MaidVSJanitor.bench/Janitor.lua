-- Janitor
-- Original by Validark
-- Modifications by pobammer
-- roblox-ts support by OverHash and Validark

local IndicesReference = newproxy(true)
getmetatable(IndicesReference).__tostring = function()
	return "IndicesReference"
end

local LinkToInstanceIndex = newproxy(true)
getmetatable(LinkToInstanceIndex).__tostring = function()
	return "LinkToInstanceIndex"
end

local METHOD_NOT_FOUND_ERROR = "Object %s doesn't have method %s, are you sure you want to add it? Traceback: %s"

local Janitor = {
	ClassName = "Janitor";
	__index = {
		CurrentlyCleaning = true;
		[IndicesReference] = nil;
	};
}

local TypeDefaults = {
	["function"] = true;
	RBXScriptConnection = "Disconnect";
}

--[[**
	Instantiates a new Janitor object.
	@returns [Janitor]
**--]]
function Janitor.new()
	return setmetatable({
		CurrentlyCleaning = false;
		[IndicesReference] = nil;
	}, Janitor)
end

--[[**
	Determines if the passed object is a Janitor.
	@param [any] Object The object you are checking.
	@returns [boolean] Whether or not the object is a Janitor.
**--]]
function Janitor.Is(Object)
	return type(Object) == "table" and getmetatable(Object) == Janitor
end

--[[**
	Adds an `Object` to Janitor for later cleanup, where `MethodName` is the key of the method within `Object` which should be called at cleanup time. If the `MethodName` is `true` the `Object` itself will be called instead. If passed an index it will occupy a namespace which can be `Remove()`d or overwritten. Returns the `Object`.
	@param [any] Object The object you want to clean up.
	@param [string | true?] MethodName The name of the method that will be used to clean up. If not passed, it will first check if the object's type exists in TypeDefaults, and if that doesn't exist, it assumes `Destroy`.
	@param [any?] Index The index that can be used to clean up the object manually.
	@returns [any] The object that was passed.
**--]]
function Janitor.__index:Add(Object, MethodName, Index)
	if Index then
		self:Remove(Index)

		local This = self[IndicesReference]
		if not This then
			This = {}
			self[IndicesReference] = This
		end

		This[Index] = Object
	end

	MethodName = MethodName or TypeDefaults[typeof(Object)] or "Destroy"
	if type(Object) ~= "function" and not Object[MethodName] then
		warn(string.format(METHOD_NOT_FOUND_ERROR, tostring(Object), MethodName, debug.traceback(nil, 2)))
	end

	self[Object] = MethodName
	return Object
end

--[[**
	Cleans up whatever `Object` was set to this namespace by the 3rd parameter of `:Add()`.
	@param [any] Index The index you want to remove.
	@returns [Janitor] The same janitor, for chaining reasons.
**--]]
function Janitor.__index:Remove(Index)
	local This = self[IndicesReference]

	if This then
		local Object = This[Index]

		if Object then
			local MethodName = self[Object]

			if MethodName then
				if MethodName == true then
					Object()
				else
					local ObjectMethod = Object[MethodName]
					if ObjectMethod then
						ObjectMethod(Object)
					end
				end

				self[Object] = nil
			end

			This[Index] = nil
		end
	end

	return self
end

--[[**
	Gets whatever object is stored with the given index, if it exists. This was added since Maid allows getting the task using `__index`.
	@param [any] Index The index that the object is stored under.
	@returns [any?] This will return the object if it is found, but it won't return anything if it doesn't exist.
**--]]
function Janitor.__index:Get(Index)
	local This = self[IndicesReference]
	if This then
		return This[Index]
	end
end

--[[**
	Calls each Object's `MethodName` (or calls the Object if `MethodName == true`) and removes them from the Janitor. Also clears the namespace. This function is also called when you call a Janitor Object (so it can be used as a destructor callback).
	@returns [void]
**--]]
function Janitor.__index:Cleanup()
	if not self.CurrentlyCleaning then
		self.CurrentlyCleaning = nil
		for Object, MethodName in next, self do
			if Object == IndicesReference then
				continue
			end

			if MethodName == true then
				Object()
			else
				local ObjectMethod = Object[MethodName]
				if ObjectMethod then
					ObjectMethod(Object)
				end
			end

			self[Object] = nil
		end

		local This = self[IndicesReference]
		if This then
			for Index in next, This do
				This[Index] = nil
			end

			self[IndicesReference] = {}
		end

		self.CurrentlyCleaning = false
	end
end

--[[**
	Calls `:Cleanup()` and renders the Janitor unusable.
	@returns [void]
**--]]
function Janitor.__index:Destroy()
	self:Cleanup()
	table.clear(self)
	setmetatable(self, nil)
end

Janitor.__call = Janitor.__index.Cleanup

return Janitor
