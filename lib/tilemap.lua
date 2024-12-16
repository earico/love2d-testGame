require("lib.tile")

-- color list for Tiles
local colors = {
  {1, 1, 1}, -- 1: White
  {1, 0, 0}, -- 2: Red
  {0, 1, 0}, -- 3: Green
  {0, 0, 1}  -- 4: Blue
}

Tilemap = {
  x = 0,
  y = 0,
  width = 1,
  height = 1,
  size = 16,
  map = {}
}

function Tilemap:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
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
      local tile = Tile:new({
        x = (j * self.size) + self.x, -- + self.x/y applies position change
        y = (i * self.size) + self.y, -- based on the canvas
        size = self.size,
        color = colors[self.map[i][j]] or {0, 0, 0, 0}
      })
      self.map[i][j] = tile
    end
  end
end

-- collision for bounds detection by x and y values
-- removing " / 2" offsets collisions, but works.
local function inBounds(x, y, tile)
  return (
    x > tile.x - tile.size / 2 and
    x < tile.x + tile.size / 2 and
    y > tile.y - tile.size / 2 and
    y < tile.y + tile.size / 2
  )
end

-- returns tile at world pos (x,y)
function Tilemap:getTile(x, y)
  for i=1, #self.map do
    for j=1, #self.map[i] do
      if inBounds(x, y, self.map[i][j]) then
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
