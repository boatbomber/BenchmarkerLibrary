--[[
WARNING: THESE TESTS RUN IN YOUR REAL ENVIRONMENT.
If your tests alter a DataStore, it will actually alter your DataStore.

This is useful in allowing your tests to move Parts around in the workspace or something,
but with great power comes great responsibility. Don't mess up your stuff!
--]]

local N = 5000

return {

	ParameterGenerator = function()
		local Array = table.create(N)
		for i=1, N do
			Array[i] = math.random(5)
		end
		return Array
	end;

	Functions = {
		["pairs"] = function(Profiler,Array)
			local Copy = table.create(#Array)
			for Key,Value in pairs(Array) do
				Copy[Key] = Value
			end
		end;

		["ipairs"] = function(Profiler,Array)
			local Copy = table.create(#Array)
			for Key,Value in ipairs(Array) do
				Copy[Key] = Value
			end
		end;
		
		["numeric"] = function(Profiler,Array)
			local Length = #Array
			local Copy = table.create(Length)
			for i=1,Length do
				Copy[i] = Array[i]
			end
		end;
		
		["table.unpack"] = function(Profiler,Array)
			local Copy = {table.unpack(Array)}
		end;
		
		["unpack"] = function(Profiler,Array)
			local Copy = {unpack(Array)}
		end;

	};

}
