

----scripts----

function love.load() 
  --load scene 
  changeScene("map")
  --load scene
  
  --screen
  love.window.setMode(1280, 700, {resizable=true})
  --font
  mainFont = love.graphics.newFont("assets/fonts/VT323-Regular.ttf", 20) 

love.graphics.setDefaultFilter( "nearest", "nearest")

end

function love.update(dt) 
    
  if Scene.update then Scene.update(dt) end
  
end

function love.draw()
    --scene
    if Scene.draw then Scene.draw() end
    love.graphics.setFont(mainFont)
    --scene

  
end

function changeScene(nextScene)

    Scene = require("Scenes/"..nextScene)
    
    if Scene.load then Scene.load() end

end


