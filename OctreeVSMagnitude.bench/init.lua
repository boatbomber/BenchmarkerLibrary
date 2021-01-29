--[[

|WARNING| THESE TESTS RUN IN YOUR REAL ENVIRONMENT. |WARNING|

If your tests alter a DataStore, it will actually alter your DataStore.

This is useful in allowing your tests to move Parts around in the workspace or something,
but with great power comes great responsibility. Don't mess up your stuff!

---------------------------------------------------------------------

Documentation and Change Log:
https://devforum.roblox.com/t/benchmarker-plugin-compare-function-speeds-with-graphs-percentiles-and-more/829912/1

--------------------------------------------------------------------]]

local R = 10 -- The search radius
local N = 1500 -- How many points are in the world
local P = 100 -- How many positions to search against

-- Create a table to ensure each functions checks the same P positions for fairness 
local PosTable = table.create(P)
for i=1, P do
	PosTable[i] = Vector3.new(math.random(-5000,5000)*0.1,math.random(-5000,5000)*0.1,math.random(-5000,5000)*0.1)
end

local Octree = require(script.Octree)

return {

	ParameterGenerator = function()
		local Array = table.create(N)
		for i=1,N do
			Array[i] = Vector3.new(math.random(-5000,5000)*0.1,math.random(-5000,5000)*0.1,math.random(-5000,5000)*0.1)
		end
		return Array
	end;

	Functions = {
		["Magnitude"] = function(Profiler, VectorsArray)
		
			for _, GetPos in ipairs(PosTable) do
				local NearbyNodes = {}
				local NumNearby = 0 -- use this for faster inserting
				
				for _, vec in ipairs(VectorsArray) do
					if (GetPos-vec).Magnitude <= R then
						NumNearby += 1
						NearbyNodes[NumNearby] = GetPos
					end
				end
				
			end
			
		end;

		["Octree"] = function(Profiler, VectorsArray)
			
			Profiler.Begin("Generate")
			local tree = Octree.new()
			for _, vec in ipairs(VectorsArray) do
				tree:CreateNode(vec,vec)
			end
			Profiler.End()
			
			Profiler.Begin("Search")
			for _, GetPos in ipairs(PosTable) do
				local NearbyNodes = tree:RadiusSearch(GetPos, R)
			end
			Profiler.End()
			
		end;

	};

}