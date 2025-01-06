require("love")
require("lib.tilemap")
require("lib.player")

-- main code
function love.load()
  -- global variables
  SCREEN = {1200, 1600}
  SIZE = 32
  TEXT = "collisions: NO"

  -- window settings
  love.window.setTitle("test game")
  love.window.setMode(SCREEN[1], SCREEN[2])
  love.graphics.setBackgroundColor(0.3, 0.1, 0)

  -- tilemap data (will make json parser later for 3rd party software)
  local tiles = {
    {0, 0, 2, 2},
    {4, 0, 3, 0},
    {4, 0, 2, 0},
    {4, 0, 0, 2},
  }

  -- Tilemap initialization
  T1 = Tilemap:new({x = SCREEN[1]/2, y = SCREEN[2]/2, size = SIZE})
  T1:create(tiles)

  -- Player initialization
  P1 = Player:new({size = SIZE, speed = 128})
end

function love.update(dt)
  local currTile = T1:getTile(P1.x, P1.y)

  --[[  if currTile and P1:collision(currTile) then
    TEXT = "YES | " .. tostring(currTile)
  else
    TEXT = "NO"
  end
  ]]

  if P1:mapCollision(T1) then
    TEXT = "YES"
  else
    TEXT = "NO"
    P1:update(dt*2)
  end

  --P1:update(dt * 2)
end

function love.draw()
  T1:draw()
  P1:draw()
  love.graphics.setColor({1,1,1})
  love.graphics.print(
    "collisions: " .. TEXT ..
    " P1 Origin: " .. tostring(math.floor(P1.x)) ..
    ", " .. tostring(math.floor(P1.y)) ..
    " CellPOS: " .. T1:printCellTile(4,4) ..
    " Tile: " .. tostring(T1.map[4][4]) ..
    " Tile: " .. tostring(T1.map[3][3])
  )

  local file = io.open("tiledata.txt", "w")

  if file then
    for i=1, #T1.map do
      for j=1, #T1.map[i] do
        file:write("Tile: " .. tostring(T1.map[i][j]) .. ", ")
      end
      file:write("\n")
    end

    file:close()
  end

end
