--[[
WARNING: THESE TESTS RUN IN YOUR REAL ENVIRONMENT.
If your tests alter a DataStore, it will actually alter your DataStore.

This is useful in allowing your tests to move Parts around in the workspace or something,
but with great power comes great responsibility. Don't mess up your stuff!
--]]

local __tick = tick
local os_clock = os.clock

return {
	ParameterGenerator = function() end; -- No need for parameters in this test

	Functions = {
		["os.clock"] = function(Profiler)
			for i=1,1000 do
				local x = os.clock()
			end
		end;

		["local os.clock"] = function(Profiler)
			for i=1,1000 do
				local x = os_clock()
			end
		end;

		["tick"] = function(Profiler)
			for i=1,1000 do
				local x = tick()
			end
		end;

		["local tick"] = function(Profiler)
			for i=1,1000 do
				local x = __tick()
			end
		end;
	};
}
