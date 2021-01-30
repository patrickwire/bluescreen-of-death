function create_laser(x, y, distance, world)
    local self = {
        public_field = 0,
        touching = 0
    }

    local position = {}
    position.x = x
    position.y = y
    position.d = distance
    local body = love.physics.newBody(world, position.x, position.y, "kinematic")

    local shape = love.physics.newRectangleShape(2, position.d) -- the ball's shape has a radius of 20
    local fixture = love.physics.newFixture(body, shape, 0) -- Attach fixture to body and give it a density of 1.
    fixture:setSensor(true)
    fixture:setUserData("laser")

    function self.draw()
        render_local_box(position.x, position.y, 20, position.d)
    end

    function self.update(dt, player)

    end

    return self
end
