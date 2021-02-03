function create_player(x, y, world)
    local self = {}
    self.body = love.physics.newBody(world, x, y, "dynamic") -- place the body in the center of the world and make it dynamic, so it can move around
    self.body:setLinearDamping(10) -- place the body in the center of the world and make it dynamic, so it can move around
    self.shape = love.physics.newRectangleShape(30, 30) -- the ball's shape has a radius of 20
    self.fixture = love.physics.newFixture(self.body, self.shape, 4) -- Attach fixture to body and give it a density of 1.
    self.fixture:setRestitution(0) -- let the ball bounce

    function self.update(dt)
        -- Keyboard Navigation
        if love.keyboard.isDown("right") then -- press the right arrow key to push the ball to the right
            self.body:applyForce(10000, 0)
        elseif love.keyboard.isDown("left") then -- press the left arrow key to push the ball to the left
            self.body:applyForce(-10000, 0)
        end

        if love.keyboard.isDown("up") then -- press the right arrow key to push the ball to the right
            self.body:applyForce(0, -10000)
        elseif love.keyboard.isDown("down") then -- press the left arrow key to push the ball to the left
            self.body:applyForce(0, 10000)
        end

    end

    function self.draw()
    end

    return self
end
