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
		return table.create(N,math.random(10))
	end;

	Functions = {
		["table.clear()"] = function(Profiler,Table)
			table.clear(Table)
		end;

		["t[key] = nil"] = function(Profiler,Table)
			for key in pairs(Table) do
				Table[key] = nil
			end
		end;
		
		["numeric nil"] = function(Profiler,Table)
			-- Only works on arrays
			for i=#Table,1,-1 do
				Table[i] = nil
			end
		end;
	};

}