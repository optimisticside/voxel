-- OptimisticSide
-- 5/7/2021
-- System loader

function loader()
	local config = require(script.Config)
	local bootstrap = require(config.module)

	-- Run bootstrap and retrieve core.
	-- After this, the core will have initialized
	local Core = bootstrap({
		config = config,
		routine = loader
	})

	return Core
end

-- In case we're a module
-- being required.
return loader()
