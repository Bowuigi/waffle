--- A fork of rxi/classic with more features
-- @classmod object
-- @alias waffle.object
-- @author Bowuigi
-- @author rxi
-- @license GNU GPLv3
local Object = {}

Object.__index = Object

--- Object new function, should not be called directly
-- <br>
-- The one from object itself is empty.
function Object:new()
end

--- Object extend function, adds inheritance
-- @treturn object Object returned
function Object:extend()
	local cls = {}
	for k, v in pairs(self) do
		if k:find("__") == 1 then
			cls[k] = v
		end
	end
	cls.__index = cls
	cls.super = self
	setmetatable(cls, self)
	return cls
end

--- Mixins implementation
-- @tparam object ... Objects that contain the new functions
function Object:implement(...)
	for _, cls in pairs({...}) do
		for k, v in pairs(cls) do
			if self[k] == nil and type(v) == "function" then
				self[k] = v
			end
		end
	end
end

--- Check if the supplied argument is an instance of a class
-- @tparam object O Object to compare with
-- @treturn boolean True if O shares metatables with the Object
function Object:is(O)
	local mt = getmetatable(self)
	while mt do
		if mt == O then
			return true
		end
		mt = getmetatable(mt)
	end
	return false
end


--- Return a string representation of the object
-- <br>
-- Added as a metamethod to be called automatically when you call `print`
-- @treturn string String representation of the object
function Object:__tostring()
	return "[Object object]"
end

--- Instance a class or an object
-- @param args Arguments to pass to the new function
function Object:instance(...)
  local obj = setmetatable({}, self)
  obj:new(...)
  return obj
end

--- Allow using `Object()` and `Object:instance()`
Object.__call=Object.instance

return Object
