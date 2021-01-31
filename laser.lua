function create_laser(x, y, distance, world, id)
    local self = {
        public_field = 0,
        touching = 0
    }

    images = {
        small = love.graphics.newImage("assets/gfx/electricity001_length400_spriteSheet100x400.png"),
        big = love.graphics.newImage("assets/gfx/electricity001_length600_spriteSheet100x600.png")
    }

    animations = {
        small = newAnimation(images.big, 100, 600, 0.08, 0)
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
            render_local_animation(animations.small, position.x, position.y)
            render_local_box(position.x, position.y, 20, position.d)
        end
        love.graphics.setColor(1, 1, 1) -- set the drawing color to red for the ball
    end

    function self.update(self, dt, b)
        animations.small:update(dt)

    end

    return self
end
