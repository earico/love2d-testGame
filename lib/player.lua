Player = {
  x = 0,
  y = 0,
  size = 16,
  speed = 16
}

function Player:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o
end

function Player:update(dt)
  if love.keyboard.isDown("left") then
      self.x = self.x - self.speed
    end

    if love.keyboard.isDown("right") then
      self.x = self.x + self.speed
    end

    if love.keyboard.isDown("up") then
      self.y = self.y - self.speed
    end

    if love.keyboard.isDown("down") then
      self.y = self.y + self.speed
    end
end

function Player:draw()
  love.graphics.setColor({1, 1, 1})
  love.graphics.rectangle("fill", self.x, self.y, self.size, self.size)
end
