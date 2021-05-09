-- OptimisticSide
-- 5/7/2021
-- Log manager

local Logger = {}

Logger.systemLogs = {}
Logger.joinLogs = {}
Logger.leaveLogs = {}
Logger.messageLogs = {}
Logger.commandLogs = {}

-- Prints a message and
-- does nothing else.
function Logger.print(message)
	print(message)
end

-- Writes a raw log to the table.
function Logger.writeLog(logTable, data)
	-- Insert timestamp if nonexistent.
	if not data.timestamp then
		data.timestamp = time()
	end
	logTable[#logTable+1] = data
end

-- Adds a log to a local table.
function Logger.addLog(message, timestamp)
	Logger.writeLog(Logger.systemLogs, {
		message = message,
		timestamp = timestamp
	})
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
