function create_player(x, y, world)
    local self = {}
    self.w = 64
    self.h = 64
    self.body = love.physics.newBody(world, x - self.w / 2, y - self.h / 2, "dynamic") -- place the body in the center of the world and make it dynamic, so it can move around
    self.body:setLinearDamping(10) -- place the body in the center of the world and make it dynamic, so it can move around
    self.shape = love.physics.newRectangleShape(self.w, self.h) -- the ball's shape has a radius of 20
    self.fixture = love.physics.newFixture(self.body, self.shape, 1) -- Attach fixture to body and give it a density of 1.
    self.fixture:setRestitution(0) -- let the ball bounce
    self.fixture:setUserData("player")
    self.direction = "down"

    local images = {
        left = love.graphics.newImage("assets/gfx/playerRobotDummyLeft.png"),
        right = love.graphics.newImage("assets/gfx/playerRobotDummyRight.png"),
        up = love.graphics.newImage("assets/gfx/playerRobotDummyBack.png"),
        down = love.graphics.newImage("assets/gfx/playerRobotDummyFront.png")
    }

    function self.update(dt)
        -- Keyboard Navigation
        if love.keyboard.isDown("right") then -- press the right arrow key to push the ball to the right
            self.body:applyForce(10000, 0)
            self.direction = "right"
        elseif love.keyboard.isDown("left") then -- press the left arrow key to push the ball to the left
            self.body:applyForce(-10000, 0)
            self.direction = "left"
        end

        if love.keyboard.isDown("up") then -- press the right arrow key to push the ball to the right
            self.body:applyForce(0, -10000)
            self.direction = "up"
        elseif love.keyboard.isDown("down") then -- press the left arrow key to push the ball to the left
            self.body:applyForce(0, 10000)
            self.direction = "down"
        end

    end

    function self.draw()
        love.graphics.setColor(1, 1, 1)
        -- love.graphics.rectangle("fill", 300, 200, self.w, self.h)
        if self.direction == "right" then
            love.graphics.draw(images.right, x - self.w, y - self.h)
        elseif self.direction == "left" then
            love.graphics.draw(images.left, x - self.w, y - self.h)
        elseif self.direction == "up" then
            love.graphics.draw(images.up, x - self.w, y - self.h)
        elseif self.direction == "down" then
            love.graphics.draw(images.down, x - self.w, y - self.h)
        end
    end

    return self
end
