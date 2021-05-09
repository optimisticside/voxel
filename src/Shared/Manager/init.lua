-- OptimisticSide
-- 5/7/2021
-- Module management-system

local IGNORE_INDICATOR = "IgnoreModule"

local Manager = {}

Manager.modules = {}
Manager.locations = {}

-- Search all locations for a module.
function Manager.findModule(name)
	for _, location in ipairs(Manager.locations) do
		-- Assume location is a table
		-- unless it's an instance.
		local children = location
		if typeof(location) == "Instance" then
			children = location:GetChildren()
		end

		for _, child in ipairs(children) do
			if child.Name == name then
				return child
			end
		end
	end
end

-- Loads a module by requiring it
-- in a pcall.
function Manager.loadModule(toRequire)
	local success, result = pcall(require, toRequire)

	-- Return only if successful.
	if success then
		return result
	end
end

-- Caches a module in local storage.
function Manager.cacheModule(name, module)
	Manager.modules[name] = {
		name = name,
		module = module
	}
end

-- Gets a module.
-- Main function (used basically everywhere).
function Manager.getModule(name)
	-- Check if module is already cached.
	local cached = Manager.modules[name]
	if cached then
		return cached
	end

	-- Find the module from known
	-- locations.
	local found = Manager.findModule(name)
	if found then
		-- Since module is existent,
		-- load and cache it.
		local module = Manager.loadModule(found)

		if module then
			Manager.cacheModule(name, module)
			return module
		end
	end
end

-- Load all modules.
function Manager.loadModules()
	for _, location in ipairs(Manager.locations) do
		-- Agagin, assume location is a table
		-- unless it's an instance.
		local children = location
		if typeof(location) == "Instance" then
			children = location:GetChildren()
		end

		for _, child in ipairs(children) do
			-- Ignore if module ignore indication
			-- (This is used for this module.)
			if not child:FindFirstChild(IGNORE_INDICATOR) then
				local module = Manager.loadModule(child)
				
				-- Ensure module is existent and
				-- didn't error upon requiring.
				if module then
					Manager.cacheModule(child.Name, module)
				end
			end
		end
	end
end

-- Initialize all modules.
function Manager.initModules()
	for _, cachedModule in pairs(Manager.modules) do
		local module = cachedModule.module
		if typeof(module) == "table" and module.init then
			module:init()
		end
	end
end

-- Initializes the manager.
function Manager.init(Core)
	Manager.core = Core
end

return Manager
