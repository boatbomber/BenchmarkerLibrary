--[[
WARNING: THESE TESTS RUN IN YOUR REAL ENVIRONMENT.
If your tests alter a DataStore, it will actually alter your DataStore.

This is useful in allowing your tests to move Parts around in the workspace or something,
but with great power comes great responsibility. Don't mess up your stuff!
--]]

local Janitor = require(script.Janitor)
local Maid = require(script.Maid)

local Noop = function() end

return {
	ParameterGenerator = function()
	end;

	Functions = {
		["Janitor"] = function(Profiler)
			Profiler.Begin("Creation")
			local GarbageCollection = Janitor.new()
			Profiler.End()

			Profiler.Begin("Add")
			local Part = GarbageCollection:Add(Instance.new("Part"), "Destroy")
			GarbageCollection:Add(Instance.new("Part"), "Destroy")
			Profiler.End()

			Profiler.Begin("Indexed Add")
			GarbageCollection:Add(Part.Touched:Connect(Noop), "Disconnect", "Connection")
			Profiler.End()

			Profiler.Begin("Remove")
			GarbageCollection:Remove("Connection")
			Profiler.End()

			Profiler.Begin("Clean")
			GarbageCollection:Destroy()
			Profiler.End()
		end;

		["Maid"] = function(Profiler)
			Profiler.Begin("Creation")
			local GarbageCollection = Maid.new()
			Profiler.End()

			Profiler.Begin("Add")
			local Part = Instance.new("Part")
			GarbageCollection:GiveTask(Part)
			GarbageCollection:GiveTask(Instance.new("Part"))
			Profiler.End()

			Profiler.Begin("Indexed Add")
			GarbageCollection.Connection = Part.Touched:Connect(Noop)
			Profiler.End()

			Profiler.Begin("Remove")
			GarbageCollection.Connection = nil
			Profiler.End()

			Profiler.Begin("Clean")
			GarbageCollection:Destroy()
			Profiler.End()
		end;
	};
}