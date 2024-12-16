Tile = {
  x = 0,
  y = 0,
  size = 16,
  origin = {},
  color = {}
}

function Tile:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  self.origin = {(self.x + (self.size/2)), (self.y + (self.size/2))}
  return o
end

function Tile:PrintTileData()
  return("x: " .. self.x .. ", y: " .. ", color: " .. self.color)
end

function Tile:GetTilePos()
  return self.origin
end

function Tile:draw()
  love.graphics.rectangle("fill", self.x, self.y, self.size, self.size)
end
