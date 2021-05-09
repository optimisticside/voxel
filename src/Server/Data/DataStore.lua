-- OptimisticSide
-- 5/8/2021
-- Data store wrapper

local DataStoreService = game:GetService("DataStoreService")

local DataStore = {}
DataStore.__index = DataStore

-- Create a default entry based on
-- template.
function DataStore:createDefault()
	local deepCopy
	deepCopy = function(from, to)
		for index, value in pairs(from) do
			to[index] = typeof(value) == "table" and deepCopy(value) or value
		end
	end

	-- Create a deep copy of
	-- the given template.
	return self.template and deepCopy(self.template)
end

-- Default entry validation procedure.
function DataStore:validate(new, old)
	-- This is just a placeholder function.
	-- You should redefine this function
	-- with whatever you need to do here.
	return new
end

-- Cache an entry in the data store.
function DataStore:cache(key, value)
	self.entries[key] = {
		value = value,
		updated = false
	}
end

-- Forces the update of a cached entry.
function DataStore:save(key)
	-- Ensure entry is existent
	-- and has been updated.
	local entry = self.entries[key]
	if not entry or not entry.updated then
		return
	end

	-- Update the entry.
	self.dataStore:UpdateAsync(function(old)
		return self:validate(entry.value, old)
	end)
end

-- Retrieve an entry in the data store.
function DataStore:retrieve(key)
	-- If entry already cached, return that.
	local cached = self.entries[key]
	if cached then
		return cached.value
	end

	-- Load data from data store.
	local data = self.dataStore:GetAsync(key) or self:createDefault()
	return self:cacheEntry(key, data)
end

-- Update an entry.
-- If not cached, load it from data store.
function DataStore:update(key, value)
	-- Retrieve entry and update it.
	local entry = self:retrieve(key)
	entry.value = self:validate(value, entry.level)
end

-- Remove an entry.
function DataStore:remove(key)
	-- Removals are pushed to data store
	-- immediately.
	self.entries[key] = nil
	self.dataStore:RemoveAsync(key)
end

-- Create datastore object.
function DataStore.new(name)
	local self = {}
	setmetatable(self, DataStore)

	self.name = name
	self.dataStore = DataStoreService:GetDataStore(name)
	self.entries = {}
	self.template = nil

	return self
end

return DataStore
