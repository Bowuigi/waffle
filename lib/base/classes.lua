--- Basic classes
-- @module class
-- @alias waffle.class
-- @author Bowuigi
-- @license GNU GPLv3
local classes = {}

--- Requires `object`, `expect` and `log`
classes.object= require("object")
classes.expect= require("expect")
classes.log   = require("log")

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

--- Make a copy of a Vector2, useful for functions
-- @treturn Vector2 The same Vector, but copied
function classes.Vector2:copy()
	return classes.Vector2(self.x, self.y)
end

--- A simple three dimensional Vector for storing coordinates
-- @type Vector3
classes.Vector3 = classes.object:extend()

--- Create a Vector3
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

--- Make a copy of a Vector3, useful for functions
-- @treturn Vector3 The same Vector, but copied
function classes.Vector3:copy()
	return classes.Vector3(self.x, self.y, self.z)
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

--- A Point that contains position, rotation and more physics information
-- @type Point
classes.Point = classes.Base:extend()

--- Create a new Point
-- <br>
-- Do not call this function directly, use `Point(position, rotation, speed, mass)`
-- @tparam Vector2 position Coordinates of the Point
-- @tparam number rotation Rotation of the Point (in radians)
-- @tparam Vector2 speed Speed at which the point moves (in px/s)
-- @tparam number mass Mass of the Point (in grams)
function classes.Point:new(position, rotation, speed, mass)
	if not (position:is(classes.Vector2) and speed:is(classes.Vector2) and type(rotation)=="number" and type(mass)=="number") then
		classes.log.error("Point", "Failed to create point, expected {Vector2, number, Vector2, number}")
	end

	self.position = position:copy()
	self.rotation = rotation
	self.speed = speed:copy()
	self.mass = mass
end

--- Set the speed of a Point
-- @tparam Vector2 speed Speed at which the point moves (in px/s)
function classes.Point:setSpeed(speed)
	if not (speed:is(classes.Vector2)) then
		classes.log.error("Point", "Failed to set speed of point, expected {number}")
	end

	self.speed = speed:copy()
end

--- Set the position of a Point
-- @tparam Vector2 position Position of the point
function classes.Point:setPosition(position)
	if not (position:is(classes.Vector2)) then
		classes.log.error("Point", "Failed to set position of point, expected {number}")
	end

	self.position = position:copy()
end

return classes
