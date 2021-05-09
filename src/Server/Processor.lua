-- OptimisticSide
-- 5/8/2021
-- Command processor

local server = script.Parent
local Remote = require(server.Core.Remote)

local Core = Remote.getCore()
local Manager = Remote.getManager()

local Arguments = Manager.getModule("Arguments")
local Parser = Manager.getModule("Parser")
local Users = Manager.getModule("Users")

local Processor = {}

-- Handles a sent message.
function Processor.handleMessage(player, message)
	if not Processor.isCommand(message) then return end
	-- TODO: Finish working on this.
end

-- Initializes processor and sets up
-- event connections.
function Processor.init()
	Users.userLoaded:Connect(function(player)
		player.Chatted:Connect(function(message)
			Processor.handleMessage(player, message)
		end)
	end)
end

return Processor
