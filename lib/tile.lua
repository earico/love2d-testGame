Tile = {
  x = 0,
  y = 0,
  size = 16,
  origin = {},
  color = {},
  collision = true
}

function Tile:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  --self.origin = {(o.x + (o.size/2)), (o.y + (o.size/2))}
  self.x = self.x + self.size/2
  self.y = self.y + self.size/2
  return o
end

function Tile:PrintTileData()
  return("x: " .. self.x .. ", y: " .. ", color: " .. self.color)
end

function Tile:GetTilePos()
  return self.origin
end

-- I believe that rectangle has to be drawn - self.size/2 to account for 
-- love2d's drawing behavior, which is based of top-left coordinate based,
-- instead of center tile based.
function Tile:draw()
  love.graphics.rectangle("fill", self.x - self.size/2, self.y - self.size/2, self.size, self.size)
  --love.graphics.setColor({0, 0, 0})
  --love.graphics.rectangle("line", self.x, self.y, self.size, self.size)
end
