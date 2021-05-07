-- OptimisticSide
-- 5/7/2021
-- Main bootstrapper

-- Main bootstarp procedure.
-- Returned upon requiring main module.
local function bootstrap(loader)
	local server = script.Server
	local Core = require(server.Core)

	-- Call core to initialize system.
	Core.init(loader)

	-- Return core in case loader
	-- wants direct access to it.
	return Core
end

return bootstrap
