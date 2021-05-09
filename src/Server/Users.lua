-- OptimisticSide
-- 5/8/2021
-- Player handler

local Players = game:GetService("Players")

local server = script.Parent
local Remote = require(server.Core.Remote)

local Manager = Remote.getManager()

local Logger = Manager.getModule("Logger")
local Signal = Manager.getModule("Signal")

local Users = {}

-- Called upon a player joining.
function Users.handleJoin(player)
	Users.userAdded:Fire(player)
	Logger.writeLog(Logger.joinLogs, { player = player })
print(Logger.joinLogs)
	Users.userLoaded:Fire(player)
end

-- Called upon a player leaving.
function Users.handleLeave(player)
	Users.userLeaving:Fire(player)
	Logger.writeLog(Logger.leaveLogs, { player = player })
end

-- Starts listening for players
-- joining and leaving.
function Users.init()
	Players.PlayerAdded:Connect(Users.handleJoin)
	Players.PlayerRemoving:Connect(Users.handleLeave)
print('hi')
	-- Set up any existing players.
	for _, player in ipairs(Players:GetPlayers()) do
		Users.handleJoin(player)
	end

	Users.userAdded = Signal.new()
	Users.userLoaded = Signal.new()
	Users.userLeaving = Signal.new()
end

return Users
