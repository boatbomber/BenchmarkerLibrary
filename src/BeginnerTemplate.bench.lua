--[[
This file is for use by Benchmarker (https://boatbomber.itch.io/benchmarker)

|WARNING| THIS RUNS IN YOUR REAL ENVIRONMENT. |WARNING|
You may alter workspace, DataStores, etc. This is useful for testing
the performance of functions that interact with the game environment,
but be careful!
--]]

return {
	ParameterGenerator = function()
		-- This function is called before running your function (outside the timer)
		-- and the return(s) are passed into your function arguments (after the Profiler). This sample
		-- will pass the function a random number, but you can make it pass
		-- arrays, Vector3s, or anything else you want to test your function on.
		return math.random(1000) / 10
	end,

	-- This is called once, before running all your functions
	BeforeAll = function() end,
	-- This is called once, after running all your functions
	AfterAll = function() end,
	-- This is called right before your function, each time the function is called
	BeforeEach = function() end,
	-- This is called right after your function, each time the function is called
	AfterEach = function() end,

	Functions = {
		["Function A"] = function(Profiler, RandomNumber) -- You can change "Function A" to a descriptive name for your function

			-- The first argument passed is always our Profiler tool, so you can put
			-- Profiler.Begin("UNIQUE_LABEL_NAME") ... Profiler.End() around portions of your code
			-- to break your function into labels that are viewable under the results
			-- histogram graph to see what parts of your function take the most time.

			-- Your code here
		end,

		["Function B"] = function(Profiler, RandomNumber) end,

		-- You can add as many functions as you like!
	},
}
