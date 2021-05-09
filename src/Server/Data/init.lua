-- OptimisticSide
-- 5/8/2021
-- Data management system

local DataStore = require(script.DataStore)

local Data = {}

-- Validates a data entry.
function Data.validate(new, old)
	if typeof(old) == "table" and typeof(new) == "table" then
		for index, oldValue in pairs(old) do
			new[index] = new[index] or oldValue
		end
	end
	return new
end

-- Initialize data system
function Data.init()
	Data.playerStore = DataStore.new(Data.validate, {
		level = 0,
		isBanned = false
	})
end

return Data
