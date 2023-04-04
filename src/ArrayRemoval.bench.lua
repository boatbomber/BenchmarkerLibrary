--[[
This file is for use by Benchmarker (https://boatbomber.itch.io/benchmarker)

|WARNING| THIS RUNS IN YOUR REAL ENVIRONMENT. |WARNING|
--]]

local N = 5000

return {
	ParameterGenerator = function()
		local Length = math.random(N * 0.7, N * 1.3)
		return table.create(Length, 1), Length
	end,

	Functions = {
		["table.remove"] = function(Profiler, Array, Length)
			-- Removes in O(n) by removing the element and shifting all subsequent elements
			for Index = Length, 1, -1 do
				table.remove(Array, Index)
			end
		end,

		["unordered remove"] = function(Profiler_, Array, Length)
			-- Removes in O(1) by moving the last element to your remove index (which loses order)

			local CurrentLength = Length

			for Index = Length, 1, -1 do
				Array[Index] = Array[CurrentLength]
				Array[CurrentLength] = nil
				CurrentLength -= 1
			end
		end,
	},
}
