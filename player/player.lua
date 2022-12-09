player = {}
 require 'mobile/touchPl'
 anim8 = require 'extensions/anim8'

function player.load()

 -- player settings
player.x = 100
player.y = 500
player.width = 44
player.height = 27
player.speed = 320
player.xVel = 0
player.yVel = 0

player.friction = 30
player.frictionY = 25
player.gravity = 1500
player.jumpAmount = -425

player.graceTime = 0
player.graceDuration = 0.1

player.grounded = false
player.doubleJump = true

player.physics = {}
player.physics.body = love.physics.newBody(World, player.x, player.y, "dynamic")
player.physics.body:setFixedRotation(true)
player.physics.shape = love.physics.newRectangleShape(player.width, player.height)
player.physics.fixture = love.physics.newFixture(player.physics.body, player.physics.shape)
-------------------
 --------------animation----------------

 Sheet = love.graphics.newImage('player/assets/cay.png')
 local g = anim8.newGrid(44, 27, Sheet:getWidth(), Sheet:getHeight() )
 animation = anim8.newAnimation(g('1-1', 1), 0.4)
-------------------

touchPl.load()

end

function player.update(dt)
player.Physics(dt)
player:syncPhysics()
player:decreaseGraceTime(dt)
animation:update(dt)
touchPl.update(dt)
player:applyGravity(dt)

end

function player.draw()

    ---player draw---
love.graphics.rectangle("line", player.x - player.width / 2, player.y - player.height / 2, player.width, player.height)
animation:draw(Sheet, player.x - player.width/ 2, player.y - player.height/ 2, nil, 1, 1)

Sheet:setFilter("nearest","nearest")
    ---player draw---
end

function player:decreaseGraceTime(dt)
   if not player.grounded then
      player.graceTime = player.graceTime - dt
   end
end

function player:applyGravity(dt)
   if not player.grounded then
      player.yVel = player.yVel + player.gravity * dt
   end
end

function player:syncPhysics()
   player.x, player.y = player.physics.body:getPosition() player.physics.body:setLinearVelocity(player.xVel, player.yVel)
end

function player.Physics(dt)
	player.x = player.x + player.xVel * dt
	player.y = player.y + player.yVel * dt
	player.xVel = player.xVel * (1 - math.min(dt*player.friction, 1))
	--player.yVel = player.yVel * (1 - math.min(dt*player.friction, 1))
end

function player:land(collision)
   player.currentGroundCollision = collision
   player.yVel = 0
   player.grounded = true
   player.doubleJump = true
   player.graceTime = player.graceDuration
end

function player:jump()
      if player.grounded or player.graceTime > 0 then
         player.yVel = player.jumpAmount
         player.graceTime = 0
      elseif player.hasDoubleJump then
         player.hasDoubleJump = false
         player.yVel = player.jumpAmount * 0.8
      end
end

function player:beginContact(a, b, collision)
   if player.grounded == true then return end
   local nx, ny = collision:getNormal()
   if a == player.physics.fixture then
      if ny > 0 then
         player:land(collision)
      end
   elseif b == player.physics.fixture then
      if ny < 0 then
         player:land(collision)
      end
   end
end

function player:endContact(a, b, collision)
   if a == player.physics.fixture or b == player.physics.fixture then
      if player.currentGroundCollision == collision then
         player.grounded = false
      end
   end
end