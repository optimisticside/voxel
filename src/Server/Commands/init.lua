-- OptimisticSide
-- 5/9/2021
-- Command manager

local REVOKE_PREFIX = "un"

local Commands = {}

-- Find a command.
function Commands.findCommand(call)
	-- Commands are not case-sensitive.
	call = string.lower(call)

	-- Handle reverse commands.
	local procedure = "invoke"
	if string.sub(call, 1, #REVOKE_PREFIX) == REVOKE_PREFIX then
		procedure = "revoke"
	end

	for _, command in ipairs(Commands.cache) do
		-- Check if command's name matches.
		if string.lower(command.name) == call then
			return command, procedure
		end

		-- Check command's aliases.
		for _, aliase in ipairs(command.aliases or {}) do
			if string.lower(aliase) == call then
				return command, procedure
			end
		end

		-- Check for special opposites.
		for _, opposite in ipairs(command.opposites or {}) do
			if string.lower(opposite) == call then
				procedure = "revoke"
				return command, procedure
			end
		end
	end
end

return Commands
