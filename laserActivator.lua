function create_laser_activator(x, y, w, h, world, id)
    local self = {
        public_field = 0,
        touching = {}
    }
  
    local assets = {
        pressed = love.graphics.newImage("assets/gfx/button001pressed.png"),
        default = love.graphics.newImage("assets/gfx/button001default.png")
    }
    local position = {}
    position.x = x
    position.y = y
    position.x = x
    position.y = y
    local body = love.physics.newBody(world, position.x + (h / 2), position.y + w / 2, "kinematic")

    local shape = love.physics.newRectangleShape(w, h) -- the ball's shape has a radius of 20
    local fixture = love.physics.newFixture(body, shape, 0) -- Attach fixture to body and give it a density of 1.
    fixture:setSensor(true)
    fixture:setUserData({
        type = "laseractivator",
        id = id
    })

    function self.draw()
        love.graphics.setColor(0, 0, 1, 0.3) -- set the drawing color to red for the ball
        --render_local_box(position.x, position.y, w, h)
        love.graphics.setColor(1, 1, 1, 1) -- set the drawing color to red for the ball
        pressed=(id==1 and laser.touching>0) or (id==2 and laser2.touching>0)
        if pressed then
            render_local(assets.default,position.x-4, position.y-2)
        else
            render_local(assets.pressed,position.x-4, position.y-2)
        end
    end

    function self.update(self, dt, b)

    end

    return self
end
