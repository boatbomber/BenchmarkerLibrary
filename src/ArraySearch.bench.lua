--[[
This file is for use by Benchmarker (https://boatbomber.itch.io/benchmarker)

|WARNING| THIS RUNS IN YOUR REAL ENVIRONMENT. |WARNING|
--]]

local N = 1000

local function BinarySearch(Array, Value)
	local Low = 1
	local High = #Array

	while Low <= High do
		local Middle = Low + math.floor((High - Low) / 2)
		local MiddleValue = Array[Middle]

		if Value < MiddleValue then
			High = Middle - 1
		elseif MiddleValue < Value then
			Low = Middle + 1
		else
			while Middle >= 1 and not (Array[Middle] < Value or Value < Array[Middle]) do
				Middle -= 1
			end

			return Middle + 1
		end
	end

	return nil
end

return {
	ParameterGenerator = function()
		local Length = math.random(N * 0.7, N * 1.3)
		local Array = table.create(Length)
		for Index = 1, Length do
			Array[Index] = Index
		end

		return Array, math.random(Length)
	end,

	Functions = {
		["binary search"] = function(Profiler, Array, Index)
			for i = 1, 100 do
				BinarySearch(Array, Index)
			end
		end,

		["table.find"] = function(Profiler, Array, Index)
			for i = 1, 100 do
				table.find(Array, Index)
			end
		end,
	},
}
