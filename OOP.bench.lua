--[[
WARNING: THESE TESTS RUN IN YOUR REAL ENVIRONMENT.
If your tests alter a DataStore, it will actually alter your DataStore.

This is useful in allowing your tests to move Parts around in the workspace or something,
but with great power comes great responsibility. Don't mess up your stuff!
--]]

-- OOP version

local ReturnTrueClass = {}
ReturnTrueClass.__index = ReturnTrueClass

function ReturnTrueClass.new()
	return setmetatable({}, ReturnTrueClass)
end

function ReturnTrueClass:ReturnTrue()
	return true
end

-- Functional version

local function ReturnTrueFunction()
	return function()
		return true
	end
end

local Object = ReturnTrueClass.new()
local Function = ReturnTrueFunction()

------------------------------------------------------------------------------
-- (Note: OOP isn't bad, just don't use it in places where it isn't needed) --
------------------------------------------------------------------------------

local N = 3000
return {
	ParameterGenerator = function() end;

	Functions = {
		["OOP"] = function(Profiler)
			for i=1, N do
				Object:ReturnTrue()
			end
		end;

		["Functional"] = function(Profiler)
			for i=1, N do
				Function()
			end
		end;
	};
}
