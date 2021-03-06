-- OptimisticSide
-- 5/7/2021
-- Main system core

local Core = {}

-- Main initialization routine for system.
-- Calls manager to load and initialize modules.
function Core.init(loader)
	local package = script.Parent.Parent
	local shared = package.Shared
	local server = package.Server

	local Manager = require(shared.Manager)

	-- Move shared folder into replicated storage.
	shared.Parent = game:GetService("ReplicatedStorage")
	shared.Name = "Voxel"

	-- Update fields and set global.
	Core.loader = loader
	Core.manager = Manager
	_G.Voxel = Core

	-- Load and initialize modules.
	Manager.locations = { server, shared }
	Manager.init(Core)
	Manager.loadModules()
	Manager.initModules()
end

return Core
