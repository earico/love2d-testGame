require("love")
require("lib.tilemap")

local sz = 1
local x, y = 500, 500
local screenX = love.graphics.getWidth()
local screenY = love.graphics.getHeight()

-- main code
function love.load()
  -- window settings
  love.window.setMode(800, 800)

  local tiles = {
    {1, 1, 2, 2},
    {4, 1, 3, 1},
    {1, 0, 0, 1},
    {0, 0, 0, 1}
  }

  T1 = Tilemap:new({x = 250, y = 250, size = 64})
  T1:create(tiles)

end

function love.update(dt)
	if love.keyboard.isDown("space") then
		sz = 100 + math.sin(dt) * 100
	end

	if love.keyboard.isDown("left") then
		x = x - 10
	end
end

function love.draw()

  --love.window.setFullscreen(true, "desktop")
	love.graphics.setBackgroundColor(0.3, 0.1, 0)
	love.graphics.setColor({1,1,1})
	love.graphics.circle("fill", x, y, sz)
	love.graphics.setColor(0.1, 0, 0.9)
	love.graphics.line(300, 400, 600, 400)

	--LoadTiles(tiles, 0, 0, 50)
  T1:draw()
end
