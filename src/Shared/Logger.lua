-- OptimisticSide
-- 5/7/2021
-- Log manager

local Logger = {}

-- Prints a message and
-- does nothing else.
function Logger.print(message)
	print(message)
end

-- Adds a log to a local table.
function Logger.addLog(message, timestamp)
	Logger.logs[#logger.logs+1] = {
		message = message,
		timestamp = timestamp
	}
end

-- Main logging routine.
function Logger.log(message)
	Logger.addLog(message, time())
	Logger.print("Voxel - " .. message)
end

-- Formats and prints a log.
-- Similar to printf in C.
function Logger.logf(format, ...)
	local formatted = string.format(format, ...)
	Logger.log(formatted)
end

return Logger
