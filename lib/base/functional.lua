--- A collection of functions from functional programming
-- @module functional
-- @alias waffle.functional
-- @author Bowuigi
-- @license GNU GPLv3
local functional = {}
functional.expect = require("expect")

-- Simple list ops

--- Get the first element of a list (doesn't make much sense in Lua, but it is here anyway)
-- @tparam table list List to operate on
-- @return First element of the list
function functional.head(list)
	functional.expect("table", type(list))
	return list[1]
end

--- first is the same as `head`
functional.first = functional.head

--- Get every element other than the first and build a table with it
-- <br>
-- Note: It will only work with index k,v pairs, like `{1,2,3,4}`, but not on tables like `{bob = 1, anna = 2}`
-- @usage
-- tail({1,2,3,4}) -- {2,3,4}
--
-- @tparam table list List to operate on
-- @treturn table Table with every element of a list except the first
function functional.tail(list)
	functional.expect("table", type(list))
	local tmp = {}

	for i=2, #list do
		tmp[i-1] = list[i]
	end

	return tmp
end

--- rest is the same as `tail`
functional.rest = functional.tail

--- Get the last element of a list (again this doesn't make much sense in Lua, but here it is)
-- @tparam table list List to operate on
-- @return Last element of the table (with a numeric k,v index pair)
function functional.last(list)
	functional.expect("table", type(list))
	return list[#list]
end

-- Function composition

--- Create a function that runs `func1(func2(param))` when called with a parameter
-- @usage
-- compose(math.sin, math.abs)(-5) -- Get the sin of the absolute of -5, AKA math.sin(math.abs(-5)) or math.sin(5)
--
-- @tparam function func1 First function in the nested call
-- @tparam function func2 Second function in the nested call
-- @treturn function Function returning a nested call in form of `function(x) return func1(func2(x)) end`
function functional.compose(func1, func2)
	functional.expect("function", type(func1))
	functional.expect("function", type(func2))

	return (function(x) return func1(func2(x)) end)
end

--- Expand a function into multiple ones and execute them
-- @usage
-- -- This is how you would get an index of a linked list, but on Lua (this shouldn't be done, it is just an example)
-- expand({1,2,3,4,5}, 3, tail) -- tail(tail(tail({1,2,3,4,5}))) or in it's more readable form, ({1,2,3,4,5}):tail():tail():tail() which resembles UNIX shell pipes
-- -- This results in {4,5}, so we just apply head to it
-- head(expand({1,2,3,4,5}, 3, tail)) -- This gives us 4
--
-- @param param Parameter to pass to the functions
-- @tparam number times How much times to nest the function
-- @tparam function func Function to use on expansion
-- @return Result of the expansion
function functional.expand(param, times, func)
	local current = param

	for _=1, times do
		current = func(current)
	end

	return current
end

-- Complex list manipulation

--- Fold a list, similar to expand
-- @usage
-- ({1,2,3}):fold(0, sum) -- 0 | sum 1 | sum 2 | sum 3 // sum(sum(sum(0,1),2),3)
--
-- @tparam table sequence List of items to use as secondary parameters sequentially
-- @param initial Initial value for the first argument
-- @tparam function func Function to execute
-- @return Result of the expansion
function functional.fold(sequence, initial, func)
	functional.expect("table", type(sequence))
	functional.expect("function", type(func))

	local current = initial

	for i=1, #sequence do
		current = func(current, sequence[i])
	end

	return current
end

--- foldl is the same as `fold`
functional.foldl = functional.fold

--- lfold is the same as `fold` and `foldl`
functional.lfold = functional.fold

--- Perform a `fold`, but in reverse
-- @usage
-- ({1,2,3}):foldr(4,sum) -- sum(1,sum(2,sum(3,4)))
-- @tparam table sequence List of items to use as primary parameters sequentially (but in reverse)
-- @param initial Initial value for the second argument
-- @tparam function func Function to execute
-- @return Result of the expansion
function functional.foldr(sequence, initial, func)
	functional.expect("table", type(sequence))
	functional.expect("function", type(func))

	local current = initial

	for i=#sequence, 1, -1 do
		current = func(sequence[i], current)
	end

	return current
end

--- rfold is the same as `foldr`
functional.rfold = functional.foldr

--- Reduce a list, equivalent to `list:fold(head(list), tail(list))`
-- <br>
-- The first value of the list acts as the initial value, the rest is the table to operate on
-- @usage
-- ({1,2,3}):reduce(sum) -- fold(1,{2,3}) // sum(sum(1,2),3)
--
-- @tparam table list List to reduce
-- @tparam function func Function to apply
-- @return Result of the expansion
function functional.reduce(list, func)
	functional.expect("table", type(list))
	functional.expect("function", type(func))

	local current = functional.head(list)
	local seq = functional.tail(list)

	for i=1, #seq do
		current = func(current, seq[i])
	end

	return current
end

--- Combine both lists into one of the form {{list[1], list2[1]}, {list[2], list2[2]}...}
-- @usage
-- zip({1,2,3}, {4,5,6}) -- {{1,4},{2,5},{3,6}}
-- @tparam table list1 First list, takes the first place on the resulting list
-- @tparam table list2 Second list, takes the second place on the resulting list
-- @treturn table List on the form of {{list[1], list2[1]}, {list[2], list2[2]}...}
function functional.zip(list1, list2)
	functional.expect("table", type(list1))
	functional.expect("table", type(list2))

	local tmp = {}

	for i=1, math.min(#list1, #list2) do
		tmp[i] = {list1[i], list2[i]}
	end

	return tmp
end

--- Filter a list by passing it into a function
-- @usage
-- ({1,2,"e",3,"hi",{}}):filter(isnumber) -- {1,2,3}
-- @tparam table list List to filter
-- @tparam function func Function to filter with
-- @treturn table Filtered list
function functional.filter(list, func)
	functional.expect("table", type(list))
	functional.expect("function", type(func))

	local tmp = {}

	for i=1, #list do
		if (func(list[i])==true) then
			tmp[#tmp+1] = list[i]
		end
	end

	return tmp
end

-- Variations of the 'each' function

--- Run a function for each element on the list without storing the result
-- @tparam table list List to loop
-- @tparam function func Function to call on each element in the form of `func(list_value)`
function functional.each(list, func)
	functional.expect("table", type(list))
	functional.expect("function", type(func))

	for _, v in pairs(list) do
		func(v)
	end
end

--- Run a function for each integer key element on the list without storing the result
-- @tparam table list List to loop
-- @tparam function func Function to call on each element in the form of `func(list_value)`
function functional.eachi(list, func)
	functional.expect("table", type(list))
	functional.expect("function", type(func))

	for _,v in ipairs(list) do
		func(v)
	end
end

--- Run a function for each element on the list without storing the result
-- @tparam table list List to loop
-- @tparam function func Function to call on each element in the form of `func(list_key, list_value)`
function functional.eachk(list, func)
	functional.expect("table", type(list))
	functional.expect("function", type(func))

	for k,v in pairs(list) do
		func(k,v)
	end
end

--- Run a function for each integer key element on the list without storing the result
-- @tparam table list List to loop
-- @tparam function func Function to call on each element in the form of `func(list_key, list_value)`
function functional.eachki(list, func)
	functional.expect("table", type(list))
	functional.expect("function", type(func))

	for k,v in ipairs(list) do
		func(k,v)
	end
end

-- Variations of the 'map' function

--- Run a function for each element on the list and store the result
-- @tparam table list List to loop
-- @tparam function func Function to call on each element in the form of `func(list_value)`
function functional.map(list, func)
	functional.expect("table", type(list))
	functional.expect("function", type(func))

	local tmp = {}
	for k, v in pairs(list) do
		tmp[k] = func(v)
	end
	return tmp
end

--- Run a function for each integer key element on the list and store the result
-- @tparam table list List to loop
-- @tparam function func Function to call on each element in the form of `func(list_value)`
function functional.mapi(list, func)
	functional.expect("table", type(list))
	functional.expect("function", type(func))

	local tmp = {}
	for k,v in ipairs(list) do
		tmp[k] = func(v)
	end
	return tmp
end

--- Run a function for each element on the list and store the result
-- @tparam table list List to loop
-- @tparam function func Function to call on each element in the form of `func(list_key, list_value)`
function functional.mapk(list, func)
	functional.expect("table", type(list))
	functional.expect("function", type(func))

	local tmp = {}
	for k,v in pairs(list) do
		tmp[k] = func(k,v)
	end
	return tmp
end

--- Run a function for each integer key element on the list and store the result
-- @tparam table list List to loop
-- @tparam function func Function to call on each element in the form of `func(list_key, list_value)`
function functional.mapki(list, func)
	functional.expect("table", type(list))
	functional.expect("function", type(func))

	local tmp = {}
	for k,v in ipairs(list) do
		tmp[k] = func(k,v)
	end
	return tmp
end

return functional
