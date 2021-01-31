function create_laser(x, y, distance, world)
    local self = {
        public_field = 0,
        touching = 0
    }

    local position = {}
    position.x = x
    position.y = y
    position.d = distance
    position.maxD = distance
    local body = love.physics.newBody(world, position.x + (20 / 2), position.y + position.d / 2, "kinematic")

    local shape = love.physics.newRectangleShape(20, position.d) -- the ball's shape has a radius of 20
    local fixture = love.physics.newFixture(body, shape, 0) -- Attach fixture to body and give it a density of 1.
    fixture:setSensor(true)
    fixture:setUserData("laser")

    function self.draw()
        love.graphics.setColor(0, 0, 1) -- set the drawing color to red for the ball
        if (self.touching == 0) then
            render_local_box(position.x, position.y, 20, position.d)
        end
        love.graphics.setColor(1, 1, 1) -- set the drawing color to red for the ball
    end

    function self.update(self, dt, b)

    end

    return self
end
