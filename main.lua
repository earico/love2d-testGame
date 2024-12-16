require("love")
require("lib.tilemap")
require("lib.player")

-- main code
function love.load()
  -- window settings
  love.window.setTitle("test game")
  love.window.setMode(800, 800)
  love.graphics.setBackgroundColor(0.3, 0.1, 0)

  -- global variables
  SCREEN = {love.graphics.getWidth(), love.graphics.getHeight()}
  SIZE = 64
  TEXT = "collisions: NO"

  local tiles = {
    {1, 1, 2, 2},
    {4, 1, 3, 1},
    {1, 0, 0, 1},
    {0, 0, 0, 1}
  }

  -- Tilemap initialization
  T1 = Tilemap:new({x = 250, y = 250, size = SIZE})
  T1:create(tiles)

  -- Player initialization
  P1 = Player:new({size = SIZE, speed = 128})
end

function love.update(dt)
  local currTile = T1:getTile(P1.x, P1.y)

  if currTile and P1:collision(currTile) then
    TEXT = "YES"
  else
    TEXT = "NO"
  end

  P1:update(dt)
end

function love.draw()
  T1:draw()
  P1:draw()
  love.graphics.print(
    "collisions: " .. TEXT ..
    " P1 Origin: " .. tostring(math.floor(P1.x)) ..
    ", " .. tostring(math.floor(P1.y)) ..
    " SZ: " .. tostring(P1.size)
  )
end
