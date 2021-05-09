local length = 100_000

return {
	ParameterGenerator = function()
		return table.create(length, 1)
	end;

	Functions = {
		["ipairs"] = function(Profiler, tbl)
			local sum = 0
			for i, value in ipairs(tbl) do
				sum += value
			end
		end;
		
		["pairs"] = function(Profiler, tbl)
			local sum = 0
			for i, value in pairs(tbl) do
				sum += value
			end
		end;
		
		["next"] = function(Profiler, tbl)
			local sum = 0
			for i, value in next, tbl do
				sum += value
			end
		end,

		["numeric loop"] = function(Profiler, tbl)
			local sum = 0
			for i = 1, length, 1 do
				local value = tbl[i]
				sum += value
			end
		end;
	};
}
