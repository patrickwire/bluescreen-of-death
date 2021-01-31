function create_enemy(x1, y1, x2, y2, world)
    local self = {
        public_field = 0,
        touching = 0
    }
    local image=love.graphics.newImage("assets/gfx/enemyVoid001_spriteSheet100x100.png")
    local animation=newAnimation(image, 100, 100, 0.08, 0)
    animation:setMode("loop")
    local position = {}
    position.x = x1
    position.y = y1
    position.direction = 1
    w = 100
    h = 100
    local body = love.physics.newBody(world, position.x + (h / 2), position.y + w / 2, "kinematic")

    body:setFixedRotation(true)

    local shape = love.physics.newRectangleShape(w, h) -- the ball's shape has a radius of 20
    local fixture = love.physics.newFixture(body, shape, 0) -- Attach fixture to body and give it a density of 1.
    fixture:setSensor(true)
    fixture:setUserData("enemy")

    function self.draw()
        love.graphics.setColor(1, 0, 0) -- set the drawing color to red for the ball
      
        love.graphics.setColor(1, 1, 1) -- set the drawing color to red for the ball
        render_local_animation(animation, position.x, position.y)
    end

    function self.update(self, dt, b)
        animation:update(dt)
        if (position.x < x1) then
            position.direction = 1
        end
        if (position.x > x2) then
            position.direction = -1
        end
        position.x = position.x + position.direction * dt * 500
        body:setX(position.x)
    end

    return self
end
