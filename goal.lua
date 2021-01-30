function create_goal(x, y, w, h, world)
    local self = {
        public_field = 0,
        touching = {}
    }

    local position = {}
    position.x = x
    position.y = y
    position.x = x
    position.y = y
    local body = love.physics.newBody(world, position.x - (h / 2), position.y - w / 2, "kinematic")

    local shape = love.physics.newRectangleShape(w, h) -- the ball's shape has a radius of 20
    local fixture = love.physics.newFixture(body, shape, 0) -- Attach fixture to body and give it a density of 1.
    fixture:setSensor(true)
    fixture:setUserData("goal")

    function self.draw()
        love.graphics.setColor(0, 1, 1, 0.3) -- set the drawing color to red for the ball
        render_local_box(position.x, position.y, w, h)
        love.graphics.setColor(1, 1, 1, 1) -- set the drawing color to red for the ball
    end

    function self.update(self, dt, b)

    end

    return self
end
