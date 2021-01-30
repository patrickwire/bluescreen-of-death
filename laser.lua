function create_laser(x, y, distance, world)
    local self = {
        public_field = 0,
        touching = {}
    }

    local position = {}
    position.x = x
    position.y = y
    position.d = distance
    position.maxD = distance
    local body = love.physics.newBody(world, position.x - (20 / 2), position.y - position.d / 2, "kinematic")

    local shape = love.physics.newRectangleShape(20, position.d) -- the ball's shape has a radius of 20
    local fixture = love.physics.newFixture(body, shape, 0) -- Attach fixture to body and give it a density of 1.
    fixture:setSensor(true)
    fixture:setUserData("laser")

    function self.draw()
        render_local_box(position.x, position.y, 20, position.d)
    end

    function self.update(self, dt, b)

        position.d = position.maxD
        for i, v in ipairs(b) do
            for j, t in ipairs(self.touching) do
                if (t == v.fixture:getUserData()) then
                    d = x - v.body:getX() + v.h / 2
                    print(d)
                    if (position.d > d and d > 0) then
                        position.d = d
                        body:setX(position.x - (20 / 2))
                        body:setY(position.y - position.d / 2)

                    end
                end
            end
        end

    end

    return self
end
