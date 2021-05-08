-- OptimisticSide
-- 5/8/2021
-- Config manager

local package = script.Parent

local Remote = require(package.Core.Remote)
local defaultConfig = require(script.Default)

local Core = Remote.getCore()

local Config = {}

-- Ensure config's validity with
-- the default settings.
function Config.fixConfig(config)
	for setting, default in pairs(defaultConfig) do
		config[setting] = config[setting] or default
	end
end

-- Get the system's config.
function Config.getConfig()
	-- Return if already stored locally.
	local localConfig = Config.config
	if localConfig then
		return localConfig
	end

	-- Otherwise, get it from core.
	return Core.config
end

return Config
