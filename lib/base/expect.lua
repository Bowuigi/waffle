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
-- @usage
-- -- This expects a string, but gets a number, so it throws an error
-- expect("string", type(1))
-- -- This expects either a string or a table, but gets a function, so it throws an error
-- expect({"string","table"},type(print))
-- @tparam string/table expected Expected type, or table containing any of the expected types
-- @param got Type received, must be a string and the result of the `type()` function
function expect.type(expected, got)

	if (type(got)~="string" or (type(expected)~="string" and type(expected)~="table")) then
		expect.log.error("Expect", "Expected types (table|string, string) for the expect call")
	end

	if (type(expected) == "string") then
		if (expected ~= got) then expect.log.error("Expect", "Expected type "..expected..", got type "..got) end
	elseif (type(expected) == "table") then
		for _, t in ipairs(expected) do

			if (type(t)~="string") then expect.log.error("Expect", "Expected a table of strings or just a string for the expect call") end

			if (t ~= got) then
				local types = ""
				for k,v in ipairs(expected) do
					if (k~=1) then types=types..", " end
					types=types..v
				end
				expect.log.error("Expect", "Expected any of {"..types.."}, got "..got)
			else
				return true
			end

		end
	end
	return true
end

--- Check for length
-- <br>
-- On error, the function doesn't return, but it emits an error as if it was a normal lua error.
-- Otherwise, it continues execution normally
-- @usage expect.length(3,#("hello")) -- Expect an object of length 3, but gets an object of length 5, so it throws an error
-- @param expected Expected length, must be a number, otherwise, an error is thrown
-- @param got Length received, must be a number, otherwise, an error is thrown
function expect.length(expected, got)
	if (type(expected)~="number" or type(got)~="number") then
		expect.log.error("Expect", "Expected two numbers as arguments of the length function")
	end

	expect.log.error("Expect", "Expected length "..expected..", got length "..got)
end

setmetatable(expect,{__call=(function(self, expected, got) self.type(expected,got) end)})
return expect
