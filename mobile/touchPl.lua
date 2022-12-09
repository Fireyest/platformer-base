touchPl = {}

function touchPl.load()
    
end

function touchPl.update(dt)
    speed = 500 * dt
    
end

function touchPl.draw()


    t = love.touch.getTouches()



    iplb = false
    iprb = false
    for id = 1, #t do
        local tx, ty = love.touch.getPosition(t[id])
        love.graphics.print(tostring(id), tx, ty)
        
        if tx > 105 and tx < 155 then
            if ty > 235 and ty < 285 then
              --  player.y = player.y - speed
                --player.yVel = player.yVel - speed
              love.graphics.rectangle("fill", 105,235, 50,50)

             end
        end
        if tx > 105 and tx < 155 then
            if ty > 335 and ty < 385 then
              player.yVel = player.yVel + speed
              love.graphics.rectangle("fill", 105,335, 50,50)

             end
        end
        if tx > 155 and tx < 205 then
            if ty > 285 and ty < 335 then
              --player.physics.body:applyForce(8000, 0)
              player.xVel = player.speed * 1
              love.graphics.rectangle("fill", 155,285, 50,50)

                 end
            end
       -- jump
        if tx > 650 and tx < 700 then
            if ty > 310 and ty < 360 then
                --[[if player.grounded or player.graceTime > 0 then
                  --player.physics.body:applyForce(0, -999990)
                  player.yVel = player.jumpAmount
                  player.grounded = false
                  player.graceTime = 0
                elseif player.doubleJump then
                  player.doubleJump = false
                  player.yVel = player.jumpAmount * 0.8
                end]]
                player:jump()
              love.graphics.rectangle("fill", 650,310, 50,50)

             end
        end
        
        if tx > 55 and tx < 105 then
            if ty > 285 and ty < 335 then
              player.xVel = player.speed * -1
              --player.physics.body:applyForce(-8000, 0)
              love.graphics.rectangle("fill", 55,285, 50,50)
            
            end
            
        end
        
    end
    
    


    love.graphics.rectangle("line", 105,235, 50,50)

    love.graphics.rectangle("line", 105,335, 50,50)

    love.graphics.rectangle("line", 155,285, 50,50)

    love.graphics.rectangle("line", 55,285, 50,50)




    love.graphics.rectangle("line", 650,310, 50,50)

end

function love.touchreleased( id, x, y, dx, dy, pressure )

end

function love.touchpressed( id, x, y, dx, dy, pressure )
    
end

function love.touchmoved( id, x, y, dx, dy, pressure )
    
end