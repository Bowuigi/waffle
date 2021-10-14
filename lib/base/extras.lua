--- A collection of extras for easier development
-- @module extras
-- @alias waffle.extras
-- @author Bowuigi
-- @license GNU GPLv3
local extras = {}

--- Evaluate every item on a table that looks like this
-- @usage
-- print(select {
--  	-- Expression, return value
--  	{ (a==0)    , "A is equal to 0"}
--  	{ (b==0)    , "B is equal to 0"}
--  	{ (c==0)    , "C is equal to 0"}
--  	{ true      , "Default return value"}
--  	{"default"  , "Another default return value"}
-- })
-- @tparam table expr Expressions to evaluate
-- @return Return value of the first expression that evaluated to true
function extras.select(expr)
	for i=1, #expr do
		if (expr[i][1] == true or expr[i][1]=="default") then
			return expr[i][2]
		end
	end
	return nil
end

--- Switch statement that executes the function based on the value given, the table must have the following structure:
-- @usage
-- switch( string.sub("abc", 1, 1) ,{
--  	a = (function() print("Function automatically executed!") end)
--  	b = "We return this!"
--  	c = 1
--  	default = (function() print("Default case!") end) -- Default function not required, but recommended
-- })
-- @param expr Expression to evaluate
-- @tparam table cases Cases for the switch/case statement
-- @return Return value of the selected function
function extras.switch(expr, cases)
	local case = cases[expr] or cases["default"]

	if (type(case) == "function") then
		return case()
	end

	return case
end

--- Case is the same as `switch`
extras.case = extras.switch

--- Match is the same as `switch`
extras.match = extras.switch

-- Get a range of numbers from 'start' to 'finish' or from 1 to 'start' (which would act as 'finish')
-- <br>
-- Similar to the Python function of the same name, but this one returns just a table, not an iterator, for iterating, use `for _,i in ipairs(range(start, end)) do ... end` instead
-- @tparam number start Number to start from, defaults to 1
-- @tparam number finish Number to end the list with (inclusive). If this is not present, the list is made from 1 to start, making start default to 10
function extras.range(start, finish)
	local tmp = {}

	if (finish) then
		for i=(start or 1), finish do
			tmp[#tmp+1] = i
		end
	else
		for i=1, (start or 10) do
			tmp[#tmp+1] = i
		end
	end

	return tmp
end

--- Returns a string representation of a table
-- @tparam table t Table to represent as a string
-- @treturn string String representation of the table
function extras.tableToString(t)
	local s = "table {\n"

	for k,v in pairs(t) do
		s = s.."\t"..tostring(k).." = "..tostring(v)..",\n"
	end

	s = s.."}"
	return s
end

return extras
