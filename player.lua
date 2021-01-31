function create_player(x, y, world)
    local player = {}
    player.w = 87
    player.h = 87
    player.body = love.physics.newBody(world, x - player.w / 2, y - player.h / 2, "dynamic") -- place the body in the center of the world and make it dynamic, so it can move around
    player.body:setLinearDamping(10) -- place the body in the center of the world and make it dynamic, so it can move around
    player.body:setFixedRotation(true)
    player.shape = love.physics.newRectangleShape(player.w, player.h) -- the ball's shape has a radius of 20
    player.fixture = love.physics.newFixture(player.body, player.shape, 0.5) -- Attach fixture to body and give it a density of 1.
    player.fixture:setRestitution(0) -- let the ball bounce
    player.fixture:setUserData("player")
    player.direction = "down"

    local images = {
        left = love.graphics.newImage("assets/gfx/playerRobotWalkLeft_spriteSheet_180x180.png"),
        right = love.graphics.newImage("assets/gfx/playerRobotWalkRight_spriteSheet_180x180.png"),
        up = love.graphics.newImage("assets/gfx/playerRobotWalkBack_spriteSheet_180x180.png"),
        down = love.graphics.newImage("assets/gfx/playerRobotWalkFront_spriteSheet_180x180.png")
    }

    local animations = {
        left = newAnimation(images.left, 180, 180, 0.08, 0),
        right = newAnimation(images.right, 180, 180, 0.08, 0),
        up = newAnimation(images.up, 180, 180, 0.08, 0),
        down = newAnimation(images.down, 180, 180, 0.08, 0)
    }

    animations.left:setMode("loop")
    animations.right:setMode("loop")
    animations.up:setMode("loop")
    animations.down:setMode("loop")

    function player.update(self, dt)
        -- Update animations

        local velocityX, velocityY = player.body:getLinearVelocity()

        if math.abs(velocityX) > 1 or math.abs(velocityY) > 1 then
            sounds.move:play()
            animations.left:update(dt)
            animations.right:update(dt)
            animations.up:update(dt)
            animations.down:update(dt)
        else
            sounds.move:pause()
        end

        -- Keyboard Navigation
        if love.keyboard.isDown("right") then -- press the right arrow key to push the ball to the right
            player.body:applyForce(10000, 0)
            player.direction = "right"
        elseif love.keyboard.isDown("left") then -- press the left arrow key to push the ball to the left
            player.body:applyForce(-10000, 0)
            player.direction = "left"
        end

        if love.keyboard.isDown("up") then -- press the right arrow key to push the ball to the right
            player.body:applyForce(0, -10000)
            player.direction = "up"
        elseif love.keyboard.isDown("down") then -- press the left arrow key to push the ball to the left
            player.body:applyForce(0, 10000)
            player.direction = "down"
        end
        player.body:setAngle(0)

    end

    function player.draw()
        love.graphics.setColor(1, 1, 1)
        if player.direction == "right" then
            render_local_animation(animations.right, player.body:getX() - 90, player.body:getY() - 90)
        elseif player.direction == "left" then
            render_local_animation(animations.left, player.body:getX() - 90, player.body:getY() - 90)
        elseif player.direction == "up" then
            render_local_animation(animations.up, player.body:getX() - 90, player.body:getY() - 90)
        elseif player.direction == "down" then
            render_local_animation(animations.down, player.body:getX() - 90, player.body:getY() - 90)
        end
        -- render_local_box(player.body:getX() - player.w / 2, player.body:getY() - player.h / 2, player.w, player.h)
    end

    return player
end

function render_local_animation(animation, globalX, globalY)
    animation:draw(300 + globalX - x, 200 + globalY - y, 0, 1, 1)
end
