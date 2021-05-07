-- OptimisticSide
-- 5/7/2021
-- Globals retriever

local Remote = {}

-- Retrive core through remote
function Remote.getCore()
	return _G.Voxel
end

-- Retrive manager through core.
function Remote.getManager()
	local Core = Remote.getCore()
	return Core and Core.manager
end

return Remote
