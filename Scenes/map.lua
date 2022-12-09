local map = {}
require "player/player"
require 'mobile/touchPl'
sti = require 'extensions/sti'

function map.load()
  Map = sti("Scenes/testRoom/mapTest.lua", {"box2d"})
  World = love.physics.newWorld(0, 0, true)
  love.physics.setMeter(64)
  World:setCallbacks(beginContact, endContact)
  Map:box2d_init(World)
  Map.layers.solid.visible = false
  Camera = require 'extensions/Camera'
  camera = Camera(player.x, player.y)
  
  player.load()
  camera:zoom(1.0)
  camera.smoother = Camera.smooth.linear(100)
end
  
function map.update(dt)
  World:update(dt)
  player.update(dt)
  camera:lockX(player.x, Camera.smooth.linear(1050))
  camera:lockY(player.y, Camera.smooth.linear(1050))
 --1050
 --touchPl.update(dt)
 
 
  local w = love.graphics.getWidth()
  local h = love.graphics.getHeight()
 
  if camera.x < w/2 then 
        camera.x = w/2
  end
  
  if camera.y < h/2 then 
        camera.y = h/2
  end
  
  local mapW = Map.width * Map.tilewidth
  local mapH = Map.height * Map.tileheight
  
  --right border
  if camera.x > (mapW - w/2) then 
        camera.x = (mapW - w/2)
  end
  
  --bottom border
  if camera.y > (mapH - h/2) then 
        camera.y = (mapH - h/2)
  end
 
end

function map.draw()
    
   -- love.graphics.setBackgroundColor(0.43, 0.56, 1)
   camera:attach()
      Map:drawLayer(Map.layers["Tile"])
      player.draw()
   camera:detach()
   love.graphics.print("carregou", 230, 65)
   touchPl.draw()
end

function beginContact(a, b, collision)
	player:beginContact(a, b, collision)
end

function endContact(a, b, collision)
	player:endContact(a, b, collision)
end

return map