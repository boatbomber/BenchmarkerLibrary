--[[
This file is for use by Benchmarker (https://boatbomber.itch.io/benchmarker)

|WARNING| THIS RUNS IN YOUR REAL ENVIRONMENT. |WARNING|
--]]

local LENGTH = 50_000

return {
	ParameterGenerator = function()
		return table.create(LENGTH, 1.5)
	end,

	Functions = {
		["ipairs"] = function(Profiler, tbl)
			local sum = 0
			for _, v in ipairs(tbl) do
				sum += v
			end
		end,

		["pairs"] = function(Profiler, tbl)
			local sum = 0
			for _, v in pairs(tbl) do
				sum += v
			end
		end,

		["next"] = function(Profiler, tbl)
			local sum = 0
			for i, value in next, tbl do
				sum += value
			end
		end,

		["numeric loop"] = function(Profiler, tbl)
			local sum = 0
			for i = 1, LENGTH do
				local value = tbl[i]
				sum += value
			end
		end,

		["gen iter"] = function(Profiler, tbl)
			local sum = 0
			for _, v in tbl do
				sum += v
			end
		end,
	},
}
