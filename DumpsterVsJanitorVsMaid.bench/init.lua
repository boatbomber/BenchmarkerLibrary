local Dumpster = require(script.Dumpster)
local Janitor = require(script.Janitor)
local Maid = require(script.Maid)

return {
	ParameterGenerator = function()
		local Object = Instance.new("Model")
		local Function = function() end
		local Connection = Object.ChildAdded:Connect(function() end)
		return Object, Function, Connection
	end;

	Functions = {
		["Dumpster"] = function(Profiler, Object, Function, Connection)
			local Obliterator = Dumpster.new()
			Obliterator:dump(Object)
			Obliterator:dump(Function)
			Obliterator:dump(Connection)
			Obliterator:burn()
		end;

		["Janitor"] = function(Profiler, Object, Function, Connection)
			local Obliterator = Janitor.new()
			Obliterator:Add(Object, "Destroy")
			Obliterator:Add(Function, true)
			Obliterator:Add(Connection, "Disconnect")
			Obliterator:Cleanup()
		end;

		["Maid"] = function(Profiler, Object, Function, Connection)
			local Obliterator = Maid.new()
			Obliterator:GiveTask(Object, "Destroy")
			Obliterator:GiveTask(Function, true)
			Obliterator:GiveTask(Connection, "Disconnect")
			Obliterator:Destroy()
		end;
	};
}