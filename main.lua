require("love")
require("lib.tilemap")
require("lib.player")

-- main code
function love.load()
  -- window settings
  love.window.setTitle("testGame")
  love.window.setMode(800, 800)
	love.graphics.setBackgroundColor(0.3, 0.1, 0)

  -- global variables
  SCREEN = {love.graphics.getWidth(), love.graphics.getHeight()}
  SIZE = 64

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
  P1 = Player:new({size = SIZE, speed = 3})
end

function love.update(dt)
  P1:update(dt)
end

function love.draw()
  T1:draw()
  P1:draw()
end
