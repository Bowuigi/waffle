--- Tilemap module
-- @classmod tilemap
-- @alias waffle.tilemap
-- @author Bowuigi
-- @license GNU GPLv3

--- Include Object, make an alias for math.floor
local Object = require("object")
local floor = math.floor

local tilemap = Object:extend()

--- Inherits the logging functions
tilemap.log = require("log")

--- Create a new tilemap
-- <br>
-- Do not call this function directly, use `tilemap(w,h,fill)` instead.
-- @tparam number w Width of the tilemap
-- @tparam number h Height of the tilemap
-- @param fill Fill the tilemap with this value
function tilemap:new(w,h,fill)
	self.width = floor(w) or 1
	self.height = floor(h) or 1
	self.tilemap = {}

	for y=1, self.height do
		self.tilemap[y]={}
		for x=1, self.width do
			self.tilemap[y][x]=fill
		end
	end
end

--- Get a string representation of the tilemap
-- <br>
-- Do not call this function directly, use `tostring(tilemap)` or `print(tilemap)` instead.
-- @treturn string String representation of the tilemap
function tilemap:__tostring()
	local s = "tilemap "

	s = s.."["..self.width..", "..self.height.."]"

	s = s.." {\n"

	for y=1, self.height do
		s = s.."\t"
		for x=1, self.width do
			s = s..tostring(self.tilemap[y][x]).." "
		end
		s = s.."\n"
	end

	s = s.."}"

	return s
end

--- Copy a tilemap to another one.
-- <br>
-- Be aware that this creates a tilemap that gets returned
-- @treturn tilemap Copy of the tilemap
function tilemap:copy()
	local tmp = tilemap(self.width, self.height, nil)

	for y=1, self.height do
		for x=1, self.width do
			tmp.tilemap[y][x] = self.tilemap[y][x]
		end
	end

	return tmp
end

function tilemap:tileExists(x, y)
	return (self.tilemap[floor(y)][floor(x)] ~= nil)
end

function tilemap:tileOnBounds(x, y)
	local tx = floor(x)
	local ty = floor(y)
	return (tx > 0 and tx <= self.width) and (ty > 0 and ty <= self.height)
end

function tilemap:getTile(x, y)
	local tx = floor(x)
	local ty = floor(y)

	if (self:tileOnBounds(tx,ty)) then
		return self.tilemap[ty][tx]
	end

	self.log.warning("Tilemap", "Tile ["..tx..","..ty.."] is not on bounds!")
	return nil
end

function tilemap:setTile(x, y, tile)
	local tx = floor(x)
	local ty = floor(y)

	if (self:tileOnBounds(tx,ty)) then
		self.tilemap[ty][tx] = tile
		return true
	end

	print(tx,ty, self.tilemap[ty][tx])

	self.log.warning("Tilemap", "Tile ["..tx..","..ty.."] is not on bounds!")
	return false
end

function tilemap:fillTiles(startX, startY, endX, endY, fill)
	local sX = floor(startX)
	local eX = floor(endY)
	local sY = floor(startX)
	local eY = floor(endY)

	for y=sY, eY do
		for x=sX, eX do
			if (self:tileOnBounds(x,y)) then
				self[y][x]=fill
			else
				self.log.warning("Tilemap", "Tile ["..x..","..y.."] is not on bounds!")
			end
		end
	end
end

return tilemap
