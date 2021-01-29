--[[

|WARNING| THESE TESTS RUN IN YOUR REAL ENVIRONMENT. |WARNING|

If your tests alter a DataStore, it will actually alter your DataStore.

This is useful in allowing your tests to move Parts around in the workspace or something,
but with great power comes great responsibility. Don't mess up your stuff!

---------------------------------------------------------------------

Documentation and Change Log:
https://devforum.roblox.com/t/benchmarker-plugin-compare-function-speeds-with-graphs-percentiles-and-more/829912/1

--------------------------------------------------------------------]]

local N = 1000
local SEED = 10
math.randomseed(SEED)
local math_random = math.random

local RandomLib = Random.new(SEED)
local NextInteger = RandomLib.NextInteger

local LengthPlusOne = N + 1
return {
	ParameterGenerator = function() end;

	Functions = {
		["Random:NextInteger"] = function(Profiler)
			for Index = 1, N do
				RandomLib:NextInteger(Index, LengthPlusOne)
			end
		end;

		["local NextInteger"] = function(Profiler)
			for Index = 1, N do
				NextInteger(RandomLib, Index, LengthPlusOne)
			end
		end;

		["math.random"] = function(Profiler)
			for Index = 1, N do
				math.random(Index, LengthPlusOne)
			end
		end;
		
		["local math_random"] = function(Profiler)
			for Index = 1, N do
				math_random(Index, LengthPlusOne)
			end
		end;
	};
}
