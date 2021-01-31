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
		local Length = math.random(N*0.7,N*1.3)
		return table.create(Length, 1), Length
	end;

	Functions = {
		["table.remove"] = function(Profiler, Array, Length)
			-- Removes in O(n) by removing the element and shifting all subsequent elements
			for Index = Length, 1, -1 do
				table.remove(Array, Index)
			end
		end;

		["unordered remove"] = function(Profiler_, Array, Length)
			-- Removes in O(1) by moving the last element to your remove index (which loses order)
			
			local CurrentLength = Length

			for Index = Length, 1, -1 do
				Array[Index] = Array[CurrentLength]
				Array[CurrentLength] = nil
				CurrentLength -= 1
			end
		end;
	};
}
