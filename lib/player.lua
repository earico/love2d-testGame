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

-- used to iterate through all tiles to check for collision
-- might change later as this was done with AI.
-- could use a list to detect what tiles were touched, or being touuched
-- to use less calculations.
-- tile found -> add to list -> check collision -> out of bounds -> remove from list
function Player:mapCollision(tilemap)
  for i = 1, #tilemap.map do
    for j = 1, #tilemap.map[i] do
      local tile = tilemap.map[i][j]

      if (
        self.x - self.size / 2 < tile.x + tile.size / 2 and
        self.x + self.size / 2 > tile.x - tile.size / 2 and
        self.y - self.size / 2 < tile.y + tile.size / 2 and
        self.y + self.size / 2 > tile.y - tile.size / 2
      ) then
        if (tile.collision) then
          return true
        end
      end

    end
  end
end

-- collision detection for collision response
function Player:collision(o2)
  return (
    self.x - self.size / 2 < o2.x + o2.size / 2 and
    self.x + self.size / 2 > o2.x - o2.size / 2 and
    self.y - self.size / 2 < o2.y + o2.size / 2 and
    self.y + self.size / 2 > o2.y - o2.size / 2 and
    o2.collision
  )
end

function Player:collisionResponse()

end

function Player:update(dt)
  if love.keyboard.isDown("left") then
      self.x = math.floor(self.x - math.floor(self.speed/2 * dt))
    end

    if love.keyboard.isDown("right") then
      self.x = math.floor(self.x + math.floor(self.speed * dt))
    end

    if love.keyboard.isDown("up") then
      self.y = math.floor(self.y - math.floor(self.speed/2 * dt))
    end

    if love.keyboard.isDown("down") then
      self.y = math.floor(self.y + math.floor(self.speed * dt))
    end
end

function Player:draw()
  love.graphics.setColor({1, 1, 1})
  love.graphics.rectangle("fill", self.x - self.origin[1], self.y - self.origin[2], self.size, self.size)
  love.graphics.setColor({1, 0, 0})
  love.graphics.circle("fill", self.x, self.y, 10)
end
