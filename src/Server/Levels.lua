-- OptimisticSide
-- 5/9/2021
-- Player permission level system

local CREATOR_LEVEL = math.huge
local PLAYER_LEVEL = 0

local GroupService = game:GetService("GroupService")

local server = script.Parent
local Remote = require(server.Core.Remote)

local Manager = Remote.getManager()
local Data = Manager.getModule("Data")
local Utils = Manager.getModule("Utils")
local Config = Manager.getModule("Config")

local Levels = {}

-- Retrieve the level of a player.
function Levels.getLevel(player)
	local level = PLAYER_LEVEL

	-- Ensure "player" is a
	-- user id.
	player = Utils.getUserId(player)
	if not player then
		return
	end

	-- Retrieve cached level.
	local cached = Levels.cache[player]
	if cached and cached > level then
		level = cached
	end

	-- Retrive stored data for player.
	local stored = Data.playerStore:get(player.UserId)
	if stored and stored.level > level then
		level = stored.level
	end

	-- Handle the player being the game's owner.
	if game.CreatorType == Enum.CreatorType.Group then
		local groupInfo = GroupService:GetGroupInfoAsync(game.CreatorId)
		if groupInfo.Owner.Id == player then
			level = CREATOR_LEVEL
		end
	else
		if game.CreatorId == player then
			level = CREATOR_LEVEL
		end
	end

	return level
end

-- Updates the level of a player.
function Levels.setLevel(player, level, shouldSave)
	player = Utils.getUserId(player)
	if not player then
		return
	end
	
	Levels.cache[player] = level
	
	-- Update data store if should save.
	local config = Config.getConfig()
	if shouldSave and config.saveLevels then
		Data.playerStore:update(player, { level = level })
	end
end

-- Get a level's name from it's number.
function Levels.getNameFromLevel(level)
	if level == CREATOR_LEVEL then
		return "Creator"
	elseif level == PLAYER_LEVEL then
		return "Player"
	end

	local config = Config.getConfig()
	for _, levelInfo in ipairs(config.levels) do
		if levelInfo[1] == level then
			return levelInfo[2]
		end
	end
end

-- Get a level form its name.
function Levels.getLevelFromName(name)
	-- Level names are not case-sensitive.
	name = string.lower(name)

	if name == "creator" then
		return CREATOR_LEVEL
	elseif name == "player" then
		return PLAYER_LEVEL
	end

	local config = Config.getConfig()
	for _, levelInfo in ipairs(config.levels) do
		if string.lower(levelInfo[2]) == name then
			return levelInfo[1]
		end
	end
end

return Levels
