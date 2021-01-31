function create_laser(x, y, distance, world, id)
    local self = {
        public_field = 0,
        touching = 0
    }

    local images = {
        small = love.graphics.newImage("assets/gfx/electricity001_length565_spriteSheet100x565.png"),
        big = love.graphics.newImage("assets/gfx/electricity001_length650_spriteSheet100x650.png")
    }

    animations = {
        small = newAnimation(images.big, 100, 565, 0.08, 0),
        big = newAnimation(images.big, 100, 650, 0.08, 0)
    }

    animations.small:setMode("loop")

    local position = {}
    position.x = x
    position.y = y
    position.d = distance
    position.maxD = distance
    local body = love.physics.newBody(world, position.x + (100 / 2), position.y + 400 / 2, "kinematic")

    local shape = love.physics.newRectangleShape(20, position.d) -- the ball's shape has a radius of 20
    local fixture = love.physics.newFixture(body, shape, 0) -- Attach fixture to body and give it a density of 1.
    fixture:setSensor(true)
    fixture:setUserData({
        type = "laser",
        id = id
    })

    function self.draw()
        love.graphics.setColor(0, 0, 1) -- set the drawing color to red for the ball
        if (self.touching == 0) then
            if(distance<=600) then
            render_local_animation(animations.small, position.x-40, position.y)
            else
                render_local_animation(animations.big, position.x-40, position.y)
            end
            --render_local_box(position.x, position.y, 20, position.d)
        end
        love.graphics.setColor(1, 1, 1) -- set the drawing color to red for the ball
    end

    function self.update(self, dt, b)
        animations.small:update(dt)
        animations.big:update(dt)

    end

    return self
end
