require("lib.tile")

-- color list for Tiles
local colors = {
  {1, 1, 1}, -- 1: White
  {1, 0, 0}, -- 2: Red
  {0, 1, 0}, -- 3: Green
  {0, 0, 1}  -- 4: Blue
}

local coll = {
  true,
  true,
  true,
  true
}

Tilemap = {
  x = 0,
  y = 0,
  origin = {},
  width = 1,
  height = 1,
  size = 16,
  map = {}
}

function Tilemap:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  self.origin = {(self.x - (self.size/2)), (self.y - (self.size/2))}
  return o
end

-- implement later for json?? or file.
-- Initializes tilemap and it's variables
function Tilemap:create(_map)
  self.map = _map
  self.width = #self.map[1]
  self.height = #self.map

  -- # symbol gets length of list
  for i=1, #self.map do
    for j=1, #self.map[i] do
      local tile = Tile:new({ --   below accounts for centering of tiles
        x = ((j-1) * self.size) + (self.x - self.size*1.5), -- + self.x/y applies position change
        y = ((i-1) * self.size) + (self.y - self.size*1.5), -- based on the canvas
        size = self.size,
        color = colors[self.map[i][j]] or {0, 0, 0, 0},
        collision = coll[self.map[i][j]] or false
      })
      self.map[i][j] = tile
    end
  end
end

-- collision for bounds detection by x and y values
-- removing " / 2" offsets collisions, but works.
local function inBounds(x, y, tile)
  return (
    x - tile.size/2 < tile.x + tile.size/2 and
    x + tile.size/2 > tile.x - tile.size/2 and
    y - tile.size/2 < tile.y + tile.size/2 and
    y + tile.size/2 > tile.y - tile.size/2
  )
end

-- returns tile at world pos (x,y)
function Tilemap:getTile(x, y)
  for i=1, #self.map do
    for j=1, #self.map[i] do
      if inBounds(x, y, self.map[i][j]) then
        --love.graphics.setColor({0.2, 0.2, 0.9})
        --love.graphics.rectangle("line", self.map[i][j].x, self.map[i][j].y, self.map[i][j].size, self.map[i][j].size)
        return self.map[i][j]
      end
    end
  end
  return nil
end

-- returns tile via tilemap position [x][y]
function Tilemap:getCellTile(x, y)
  local cellTile = self.map[x][y]

  if cellTile then
    return {cellTile.x, cellTile.y}
  end
end

function Tilemap:printCellTile(x, y)
  local cellTile = self.map[x][y]

  if cellTile then
    return
      "x: " .. tostring(cellTile.x) ..
      ", y: " .. tostring(cellTile.y)
  end
end

-- iterates through tiles and calls their draw function (which uses rectangle() to draw)
function Tilemap:draw()
  for i=1, #self.map do
    for j=1, #self.map[i] do
      love.graphics.setColor(self.map[i][j].color)
      self.map[i][j]:draw()
    end
  end
end
