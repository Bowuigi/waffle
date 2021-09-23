--- A collection of extras for easier development
-- @module extras
-- @alias waffle.extras
-- @author Bowuigi
-- @license GNU GPLv3
local extras = {}

--- Iterate over each item on a loop, calling a function with the key and the current item, like `func(key,item)`
-- @tparam function func Function to call
-- @tparam table items Items to loop on
function extras.each(func, items)
	for key, item in pairs(items) do
		func(key,item)
	end
end

--- Similar to the `extras.each` function, but only iterates on the numeric indexes and it doesn't call the function using the key, instead it does `func(item)`
-- @tparam function func Function to call
-- @tparam table items Items to loop on
function extras.eachi(func, items)
	for _, item in ipairs(items) do
		func(item)
	end
end

--- Similar to the `extras.each` function, but returns a table containing the results of each call, the table uses the same key as in the table, so `results[key] = func(key,item)`
-- @tparam function func Function to call
-- @tparam table items Items to loop on
-- @treturn table Return values of each call to the function
function extras.map(func, items)
	local results = {}
	for key, item in pairs(items) do
		results[key]=func(key,item)
	end
	return results
end

--- Similar to the `extras.map` function, but acts on numerical indexes only like `extras.eachi`
-- @tparam function func Function to call
-- @tparam table items Items to loop on
-- @treturn table Return values of each call to the function
function extras.mapi(func, items)
	local results = {}
	for key, item in pairs(items) do
		results[key]=func(item)
	end
	return results
end

--- Evaluate every item on a table that looks like this
-- @usage
-- {
--  	-- Expression, return value
--  	{(a==0), "A is equal to 0"}
--  	{(b==0), "B is equal to 0"}
--  	{(c==0), "C is equal to 0"}
--  	{true  , "Default return value"}
-- }
-- @tparam table expr Expressions to evaluate
-- @return Return value of the first expression that evaluated to true
function extras.select(expr)
	for i=1, #expr do
		if expr[i][1] == true then
			return expr[i][2]
		end
	end
	return nil
end

--- Switch statement that executes the function based on the value given, the table must have the following structure:
-- @usage
-- {
--  	a = (function() print("Case a!") end)
--  	b = (function() print("Case b!") end)
--  	c = (function() print("Case c!") end)
--  	default = (function() print("Default case!") end) -- Default function not required, but recommended
-- }
-- @param expr Expression to evaluate
-- @tparam table cases Cases for the switch/case statement
-- @return Return value of the selected function
function extras.switch(expr, cases)
	return (cases[expr] or cases["default"] or (function() end))()
end

--- Case is the same as switch
extras.case = extras.switch

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
