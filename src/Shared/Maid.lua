-- OptimisticSide
-- 5/7/2021
-- Garbage collector (similar to Quenty's Maid)

local Maid = {}
Maid.__index = Maid

-- Destroy any objects given prior.
function Maid:doCleaning()
	for _, object in ipairs(self.data) do
		local objectType = typeof(object)

		if objectType == "Instance" then
			object:Destroy()
		if objectType == "RBXScriptConnection" then
			object:Disconnect()
		else
			-- Assume this is a custom object
			-- given to maid for a reason.
			object:destroy()
		end
	end
end

-- Give maid an object to
-- be removed upon cleaning.
function Maid:giveTask(object)
	self.data[#self.data+1] = object
end

-- Create a maid object.
function Maid.new()
	local self = {}
	setmetatable(self, Maid)

	self.data = {}
	return self
end

return Maid
