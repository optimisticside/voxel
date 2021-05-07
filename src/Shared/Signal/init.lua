-- OptimisticSide
-- 5/7/2021
-- Signals that mimic Roblox's script signal system

local Connection = require(script.Connection)

local Signal = {}
Signal.__index = Signal

-- Connect to the signal.
function Signal:Connect(func)
	return Connection.new(self, func)
end

-- Wait for signal to fire,
-- and return arguments.
function Signal:Wait()
	self.bindable:Wait()
	return table.unpack(self.arguments)
end

-- Destroys the signal and
-- remove any connections.
-- Used for maid compatability.
function Signal:destroy()
	for _, connection in ipairs(self.connections) do
		connection:destroy()
	end
end

-- Create a signal object.
function Signal.new()
	local self = {}
	setmetatable(self, Signal)

	self.connections = {}
	self.arguments = {}

	return self
end

return Signal
