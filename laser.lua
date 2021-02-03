function create_laser(x, y, distance, world)
    local self = {
        public_field = 0
    }

    local position = {}
    position.x = x
    position.y = y
    position.d = distance
    local body = love.physics.newBody(world, position.x, position.y, "kinematic")

    function self.draw()
        render_local_box(position.x, position.y, 20, position.d)
    end

    function self.update(dt, objects)

    end

    return self
end
