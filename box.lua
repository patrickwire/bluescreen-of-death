function create_box(x, y, w, h, asset)
    -- let's create the ground

    local images = {
        box = love.graphics.newImage(asset)
    }

    self = {}
    self.x = x
    self.y = y
    self.w = w
    self.h = h
    self.body = love.physics.newBody(world, x, y, "dynamic") -- remember, the shape (the rectangle we create next) anchors to the body from its center, so we have to move it to (650/2, 650-50/2)
    self.body:setLinearDamping(3) -- place the body in the center of the world and make it dynamic, so it can move around
    self.shape = love.physics.newRectangleShape(w, h) -- make a rectangle with a width of 650 and a height of 50
    self.fixture = love.physics.newFixture(self.body, self.shape) -- attach shape to body
    self.fixture:setRestitution(0.5) -- let the ball bounce

    function self.update(dt)
    end

    function self.draw()
        love.graphics.setColor(0.76, 0.18, 0.05) -- set the drawing color to red for the ball
        render_local_box(self.body:getX(), self.body:getY(), self.w, self.h)
        love.graphics.setColor(1, 1, 1) -- set the drawing color to red for the ball
    end

    return self

end

