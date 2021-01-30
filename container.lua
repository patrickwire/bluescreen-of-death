function create_container(x, y, w, h, type)
    -- let's create the ground
    type = type or containerTypes.emtpy
    local images = {
        container = love.graphics.newImage("assets/gfx/container001.png")
    }

    local container = {}
    container.x = x
    container.y = y
    container.w = w
    container.h = h
    container.body = love.physics.newBody(world, x - w / 2, y - h / 2, "dynamic") -- remember, the shape (the rectangle we create next) anchors to the body from its center, so we have to move it to (650/2, 650-50/2)
    container.body:setLinearDamping(3) -- place the body in the center of the world and make it dynamic, so it can move around
    container.shape = love.physics.newRectangleShape(w, h) -- make a rectangle with a width of 650 and a height of 50
    container.fixture = love.physics.newFixture(container.body, container.shape) -- attach shape to body
    container.fixture:setRestitution(0.5) -- let the ball bounce
    container.fixture:setUserData(RandomString(32)) -- let the ball bounce

    function container.update(dt)

        container.body:setAngle(0)
    end

    function container.draw()
        ---render_local_box(container.body:getX(), container.body:getY(), container.w, container.h)
        render_local(images.container, container.body:getX(), container.body:getY(), container.body:getAngle())
    end

    return container

end

containerTypes = {
    emtpy = 0,
    image = 1
}
