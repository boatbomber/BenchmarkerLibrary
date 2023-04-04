--[[
This file is for use by Benchmarker (https://boatbomber.itch.io/benchmarker)

|WARNING| THIS RUNS IN YOUR REAL ENVIRONMENT. |WARNING|
--]]

local N = 1000
local SEED = 10
math.randomseed(SEED)

local RandomObj = Random.new(SEED)
local NextInteger = RandomObj.NextInteger
local LocalMathRandom = math.random

local LengthPlusOne = N + 1

return {
	ParameterGenerator = function()
		return
	end,

	Functions = {
		["Random:NextInteger"] = function(Profiler)
			for Index = 1, N do
				RandomObj:NextInteger(Index, LengthPlusOne)
			end
		end,

		["local NextInteger"] = function(Profiler)
			for Index = 1, N do
				NextInteger(RandomObj, Index, LengthPlusOne)
			end
		end,

		["math.random"] = function(Profiler)
			for Index = 1, N do
				math.random(Index, LengthPlusOne)
			end
		end,

		["local math.random"] = function(Profiler)
			for Index = 1, N do
				LocalMathRandom(Index, LengthPlusOne)
			end
		end,
	},
}
