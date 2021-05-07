-- OptimisticSide
-- 5/7/2021
-- Signal connection that mimics an RBXScriptConnection

local Connection = {}
Connection.__index = Connection

-- Connect the connection to its signal.
function Connection:Connect()
	self.connection = self.signal.bindable:Connect(function()
		self.func(table.unpack(self.signal.arguments))
	end)
	self.Connected = true
end

-- Disconnect the connection from its signal.
function Connection:Disconnect()
	if self.connection then
		self.connection:Disconnect()
		self.Connected = false
	end
end

-- Distroys the signal.
function Connection:destroy()
	self:Disconnect()
end

-- Create a connection object.
function Connection.new(signal, func)
	local self = {}
	setmetatable(self, Connection)

	self.connection = nil
	self.signal = signal
	self.func = func

	self.Connected = false
	self:Connect()
	return self
end

return Connection
