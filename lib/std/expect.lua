--- Expect module
-- <br>
-- Used when only certain datatypes are required, useful to make the type system in Lua a bit better.
-- @module expect
-- @alias waffle.expect
-- @author Bowuigi
-- @license GNU GPLv3
local expect = {}

--- Use warnings and errors from the log module
expect.log = require("log")

--- Check for type, can also be called with `expect(expected, got)`
-- <br>
-- On error, the function doesn't return, but it emits an error as if it was a normal lua error.
-- Otherwise, it continues execution normally
-- @param expected Expected type, or the expected value if it isn't of type string
-- @param got Type received or the received value directly if it isn't of type string
function expect.type(expected, got)
	local e = nil
	local g = nil
	if (type(expected) ~= "string") then e=type(expected) end
	if (type(got) ~= "string") then g=type(got) end

	if ((g or got) ~= (e or expected)) then
		expect.log.error("Expect", "Expected type "..(e or expected)..", got type "..(g or got))
	end
end

--- Check for length
-- <br>
-- On error, the function doesn't return, but it emits an error as if it was a normal lua error.
-- Otherwise, it continues execution normally
-- @param expected Expected length, or the expected value if it isn't of type number
-- @param got Length received or the received value directly if it isn't of type number
function expect.length(expected, got)
	local e = nil
	local g = nil
	if (type(expected) ~= "number") then e=#expected end
	if (type(got) ~= "number") then g=#got end

	if ((g or got) ~= (e or expected)) then
		expect.log.error("Expect", "Expected length "..(e or expected)..", got length "..(g or got))
	end
end

setmetatable(expect,{__call=(function(self, expected, got) self.type(expected,got) end)})
return expect
