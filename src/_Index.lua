local Index = {
	["BeginnerTemplate.bench"] = {
		LayoutOrder = 1,
		Description = "A bench template with a guide for beginners",
		RunOnInsert = false,
	},
	["Template.bench"] = {
		LayoutOrder = 2,
		Description = "Default bench template",
		RunOnInsert = false,
	},
	["TableCreation.bench"] = {
		LayoutOrder = 3,
		Description = "Compare methods of creating a new table",
		RunOnInsert = true,
	},
	["TableClear.bench"] = {
		LayoutOrder = 4,
		Description = "Compare methods of emptying a table",
		RunOnInsert = true,
	},
	["ArrayClone.bench"] = {
		LayoutOrder = 5,
		Description = "Compare methods of cloning an array",
		RunOnInsert = true,
	},
	["ArrayFill.bench"] = {
		LayoutOrder = 6,
		Description = "Compare methods of filling an array",
		RunOnInsert = true,
	},
	["ArrayRemoval.bench"] = {
		LayoutOrder = 7,
		Description = "Compare methods of removing elements from an array",
		RunOnInsert = true,
	},
	["ArraySearch.bench"] = {
		LayoutOrder = 8,
		Description = "Compare methods of searching for a value in an array",
		RunOnInsert = true,
	},
	["ArrayIteration.bench"] = {
		LayoutOrder = 9,
		Description = "Compare methods of iterating over an array",
		RunOnInsert = true,
	},
	["RandomInt.bench"] = {
		LayoutOrder = 10,
		Description = "Compare methods of generating a random integer",
		RunOnInsert = true,
	},
}

-- Validate index
for _, module in script.Parent:GetChildren() do
	if (module == script) or (not module:IsA("ModuleScript")) then continue end
	if Index[module.Name] == nil then
		warn("BenchmarkerLibrary module '" .. module.Name .. "' is missing an entry in the index")
	end
end

return Index
