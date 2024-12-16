Player = {
  x = 0,
  y = 0,
  size = 16,
  origin = {},
  speed = 16
}

function Player:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  self.origin = {(o.x + (o.size/2)), (o.y + (o.size/2))}
  self.x = o.origin[1]
  self.y = o.origin[2]
  return o
end

function Player:collision(o2)
  return (
    self.x - self.size / 2 < o2.x + o2.size / 2 and
    self.x + self.size / 2 > o2.x - o2.size / 2 and
    self.y - self.size / 2 < o2.y + o2.size / 2 and
    self.y + self.size / 2 > o2.y - o2.size / 2
  )
end

function Player:update(dt)
  if love.keyboard.isDown("left") then
      self.x = self.x - (self.speed * dt)
    end

    if love.keyboard.isDown("right") then
      self.x = self.x + (self.speed * dt)
    end

    if love.keyboard.isDown("up") then
      self.y = self.y - (self.speed * dt)
    end

    if love.keyboard.isDown("down") then
      self.y = self.y + (self.speed * dt)
    end
end

function Player:draw()
  love.graphics.setColor({1, 1, 1})
  love.graphics.rectangle("fill", self.x - self.origin[1], self.y - self.origin[2], self.size, self.size)
  love.graphics.setColor({1, 0, 0})
  love.graphics.circle("fill", self.x, self.y, 10)
end
