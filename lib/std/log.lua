--- Logging module
-- @module log
-- @alias waffle.log
-- @author Bowuigi
-- @license GNU GPLv3
local log = {}

--- Log settings used to configure the logging functions
log.settings = {
	dieOnWarning=false, -- If this is enabled, the program exits with code 1 if a warning is encountered
	printWarnings=true, -- If this is true, warnings will be printed to the log file
	logFile=io.stderr,  -- File handler to the file to print logs to, standard error by default
}

local logFile=log.settings.logfile or io.stderr

--- Initializes the logging library with the given values (or the default ones if those are nil)
-- @tparam table settings Settings for the log functions
-- @usage log.init()
-- @usage log.init({logFile=fileHandler})
-- @usage log.init(log.settings)
function log.init(settings)
	log.settings = settings or log.settings
	logFile=log.settings.logfile or io.stderr
end

--- Outputs an error to the log file and exits with status code 1
-- @tparam string context Context of the error message
-- @tparam string message Error message
-- @usage log.error("Waffle", "this is a fatal error!")
-- @usage log.error("Logger", "this is another fatal error!")
function log.error(context,message)
	logFile:write((context or "[Unknown context]").." fatal error: "..(message or "[unknown error]").."\n")
	os.exit(1,true)
end

--- Outputs a warning to the log file
-- @tparam string context Context of the warning
-- @tparam string message Warning message
-- @usage log.warning("Waffle", "this is a warning!")
-- @usage log.warning("Logger", "this is another warning!")
function log.warning(context,message)
	if (log.settings.printWarnings) then
		logFile:write((context or "[Unknown context]").." warning: "..(message or "[unknown warning]").."\n")
	end

	if (log.settings.dieOnWarning) then
		os.exit(1)
	end
end

return log
