--- A collection of extras for easier development
-- @module extras
-- @alias waffle.extras
-- @author Bowuigi
-- @license GNU GPLv3
local extras = {}

--- Iterate over each item on a loop, calling a function with the key and the current item, like `func(key,item)`
-- @tparam table items Items to loop on
-- @tparam function func Function to call
function extras.each(items, func)
	for key, item in pairs(items) do
		func(key,item)
	end
end

--- Similar to the `extras.each` function, but only iterates on the numeric indexes and it doesn't call the function using the key, instead it does `func(item)`
-- @tparam table items Items to loop on
-- @tparam function func Function to call
function extras.eachi(items, func)
	for _, item in ipairs(items) do
		func(item)
	end
end

--- Similar to the `extras.each` function, but returns a table containing the results of each call, the table uses the same key as in the table, so `results[key] = func(key,item)`
-- @tparam table items Items to loop on
-- @tparam function func Function to call
-- @treturn table Return values of each call to the function
function extras.map(items, func)
	local results = {}
	for key, item in pairs(items) do
		results[key]=func(key,item)
	end
	return results
end

--- Similar to the `extras.map` function, but acts on numerical indexes only like `extras.eachi`
-- @tparam table items Items to loop on
-- @tparam function func Function to call
-- @treturn table Return values of each call to the function
function extras.mapi(items, func)
	local results = {}
	for key, item in pairs(items) do
		results[key]=func(item)
	end
	return results
end

--- Increments a copy of the variable by amount or 1 and then returns the result, like `var+=1` or `var++`
-- @tparam number number Numeric variable to increase value from
-- @tparam number amount Optional, increase number by amount given
-- @treturn number The same number, after increment
function extras.inc(number, amount)
	number = number + (amount or 1)
	return number
end

--- Decrements a copy of the variable by amount or 1 and then returns the result, like `var-=1` or `var--`
-- @tparam number number Numeric variable to decrease value from
-- @tparam number number Optional, decrease number by amount given
-- @treturn number The same number, after decrement
function extras.dec(number, amount)
	number = number - (amount or 1)
	return number
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
