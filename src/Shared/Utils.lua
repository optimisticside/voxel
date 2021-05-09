-- OptimisticSide
-- 5/8/2021
-- Simple utility module.

local Players = game:GetService("Players")

local Utils = {}

-- Retrieve a player's user id.
function Utils.getUserId(player)
	if player:IsA("Player") then
		return player.UserId
	elseif typeof(player) == "string" then
		local success, result = pcall(Players.GetUserIdFromNameAsync, Players, player)
		return success and result
	end
end

return Utils
