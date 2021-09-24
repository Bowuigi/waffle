--- Basic classes
-- @module class
-- @alias waffle.class
-- @author Bowuigi
-- @license GNU GPLv3
local classes = {}

--- Requires `object` and `expect`
classes.object=require("object")
classes.expect=require("expect")

--- A simple two dimensional Vector for storing coordinates
-- @type Vector2
classes.Vector2 = classes.object:extend()

--- Create a Vector2
-- <br>
-- Do not call this function directly, use `Vector2(x,y)` instead, which will return a Vector2 instead of just being the constructor
-- @tparam number x X coordinate of the vector
-- @tparam number y Y coordinate of the vector
function classes.Vector2:new(x, y)
	classes.expect("number",type(x))
	classes.expect("number",type(y))

	self.x = x
	self.y = y
end

--- A simple three dimensional Vector for storing coordinates
-- @type Vector3
classes.Vector3 = classes.object:extend()

--- Create a Vector2
-- <br>
-- Do not call this function directly, use `Vector3(x,y)` instead, which will return a Vector3 instead of just being the constructor
-- @tparam number x X coordinate of the vector
-- @tparam number y Y coordinate of the vector
-- @tparam number z Z coordinate of the vector
function classes.Vector3:new(x, y, z)
	classes.expect("number",type(x))
	classes.expect("number",type(y))
	classes.expect("number",type(z))

	self.x = x
	self.y = y
	self.z = z
end

--- Base class for most object in the game
-- <br>
-- Allows for a create and a destroy functions
-- @type Base
classes.Base = classes.object:extend()

--- Create a Base object
-- <br>
-- You usually don't want to do this, but to use `Base:extend()` instead, which is useful to add your own stuff
-- @tparam function onCreate Function to run when the Base object is created
-- @tparam function onDestroy Function to run when the Base object is destroyed
function classes.Base:new(onCreate, onDestroy)
	classes.expect("function",type(onCreate))
	classes.expect("function",type(onDestroy))

	self.onCreate = onCreate
	self.onDestroy = onDestroy

	self:onCreate()
end

--- Destroy a Base object
-- @usage
-- -- Create a base
-- myBase = Base((function() print("Base created") end), (function() print("Base destroyed") end)) -- Prints: "Base created"
--
-- -- Destroy the base
-- myBase = myBase:destroy() -- Prints: "Base destroyed"
-- @treturn nil A nil value so you can assign what used to be the base
function classes.Base:destroy()
	self:onDestroy()
	return nil
end

return classes
