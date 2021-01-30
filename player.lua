function create_player(x, y, world)
    local player = {}
    player.w = 64
    player.h = 64
    player.body = love.physics.newBody(world, x - player.w / 2, y - player.h / 2, "dynamic") -- place the body in the center of the world and make it dynamic, so it can move around
    player.body:setLinearDamping(10) -- place the body in the center of the world and make it dynamic, so it can move around
    player.shape = love.physics.newRectangleShape(player.w, player.h) -- the ball's shape has a radius of 20
    player.fixture = love.physics.newFixture(player.body, player.shape, 1) -- Attach fixture to body and give it a density of 1.
    player.fixture:setRestitution(0) -- let the ball bounce
    player.fixture:setUserData("player")
    player.direction = "down"

    local images = {
        left = love.graphics.newImage("assets/gfx/playerRobotDummyLeft.png"),
        right = love.graphics.newImage("assets/gfx/playerRobotDummyRight.png"),
        up = love.graphics.newImage("assets/gfx/playerRobotDummyBack.png"),
        down = love.graphics.newImage("assets/gfx/playerRobotDummyFront.png")
    }

    function player.update(dt)
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
        -- render_local_box(self.body:getX() - self.w / 2, self.body:getY() - self.h / 2, self.w, self.h)
        if player.direction == "right" then
            love.graphics.draw(images.right, x - player.w, y - player.h)
        elseif player.direction == "left" then
            love.graphics.draw(images.left, x - player.w, y - player.h)
        elseif player.direction == "up" then
            love.graphics.draw(images.up, x - player.w, y - player.h)
        elseif player.direction == "down" then
            love.graphics.draw(images.down, x - player.w, y - player.h)
        end
    end

    return player
end
