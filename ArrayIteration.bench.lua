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

local __ipairs = ipairs
local __pairs = pairs
local __next = next

return {
	ParameterGenerator = function()
		local Length = math.random(N*0.7, N*1.3)
		return table.create(Length, math.random(10)), Length
	end;

	Functions = {
		["ipairs"] = function(Profiler, Array)
			for Index, Value in ipairs(Array) do
				local _ = Index + Value
			end
		end;
		
		["local ipairs"] = function(Profiler, Array)
			for Index, Value in __ipairs(Array) do
				local _ = Index + Value
			end
		end;

		["pairs"] = function(Profiler, Array)
			for Index, Value in pairs(Array) do
				local _ = Index + Value
			end	
		end;
		
		["local pairs"] = function(Profiler, Array)
			for Index, Value in __pairs(Array) do
				local _ = Index + Value
			end
		end;

		["next"] = function(Profiler, Array)
			for Index, Value in next, Array do
				local _ = Index + Value
			end
		end;
		
		["local next"] = function(Profiler, Array)
			for Index, Value in __next, Array do
				local _ = Index + Value
			end
		end;

		["numeric #length"] = function(Profiler, Array)
			for Index = 1, #Array do
				local Value = Array[Index]
				local _ = Index + Value
			end
		end;
		
		["numeric given Length"] = function(Profiler, Array, Length)
			for Index = 1, Length do
				local Value = Array[Index]
				local _ = Index + Value
			end
		end;
	};
}
