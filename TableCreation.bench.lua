--[[

|WARNING| THESE TESTS RUN IN YOUR REAL ENVIRONMENT. |WARNING|

If your tests alter a DataStore, it will actually alter your DataStore.

This is useful in allowing your tests to move Parts around in the workspace or something,
but with great power comes great responsibility. Don't mess up your stuff!

---------------------------------------------------------------------

Documentation and Change Log:
https://devforum.roblox.com/t/benchmarker-plugin-compare-function-speeds-with-graphs-percentiles-and-more/829912/1

--------------------------------------------------------------------]]

local N = 5000

return {

	ParameterGenerator = function()
		return math.random(1000)/10
	end;

	Functions = {
		["table create()"] = function(Profiler,RandomNumber)
			Profiler.Begin("Init")
			local t = table.create(N)
			Profiler.End()
			
			Profiler.Begin("Populate")
			for i=1,N do
				t[i] = RandomNumber
			end
			Profiler.End()
		end;

		["t = {}"] = function(Profiler,RandomNumber)
			Profiler.Begin("Init")
			local t = {}
			Profiler.End()

			Profiler.Begin("Populate")
			for i=1,N do
				t[i] = RandomNumber
			end
			Profiler.End()
		end;
	};

}
