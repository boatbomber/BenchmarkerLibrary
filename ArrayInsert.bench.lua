--[[

|WARNING| THESE TESTS RUN IN YOUR REAL ENVIRONMENT. |WARNING|

If your tests alter a DataStore, it will actually alter your DataStore.

This is useful in allowing your tests to move Parts around in the workspace or something,
but with great power comes great responsibility. Don't mess up your stuff!

---------------------------------------------------------------------

Documentation and Change Log:
https://devforum.roblox.com/t/benchmarker-plugin-compare-function-speeds-with-graphs-percentiles-and-more/829912/1

--------------------------------------------------------------------]]

local N = 500

return {

	ParameterGenerator = function()
		-- This function is called before running your function (outside the timer)
		-- and the return(s) are passed into your function arguments. This sample
		-- will pass the function a random number, but you can make it pass
		-- arrays, Vector3s, or anything else you want to test your function on.
		return math.random(1000)/10
	end;

	Functions = {
		["table.insert(t)"] = function(Profiler, RandomNumber)
			Profiler.Begin("Table Init")
			local t = {}
			Profiler.End()

			Profiler.Begin("Insertion Loop")
			for i=1,N do
				table.insert(t, RandomNumber)
			end
			Profiler.End()
		end;

		["t[#t+1]"] = function(Profiler, RandomNumber)
			Profiler.Begin("Table Init")
			local t = {}
			Profiler.End()

			Profiler.Begin("Insertion Loop")
			for i=1,N do
				t[#t+1] = RandomNumber
			end
			Profiler.End()
		end;

		["length"] = function(Profiler, RandomNumber)
			Profiler.Begin("Table Init")
			local t = {}
			Profiler.End()

			local Length = 0

			Profiler.Begin("Insertion Loop")
			for i=1,N do
				Length += 1
				t[Length] = RandomNumber
			end
			Profiler.End()
		end;
	};

}
