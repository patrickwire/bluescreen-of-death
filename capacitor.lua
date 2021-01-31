function create_capacitor(x, y, type)
    -- let's create the ground

    type = type or capacitorTypes.large1

    local images = {
        comp1 = love.graphics.newImage("assets/gfx/capacitorComp001.png"),
        comp2 = love.graphics.newImage("assets/gfx/capacitorComp002.png"),
        large1 = love.graphics.newImage("assets/gfx/capacitorLarge001.png"),
        large2 = love.graphics.newImage("assets/gfx/capacitorLarge002.png"),
        small = love.graphics.newImage("assets/gfx/capacitorSmall001.png")
    }

    local image = images[type]

    local capacitor = {}
    capacitor.x = x
    capacitor.y = y
    capacitor.w = image:getWidth()
    capacitor.h = image:getHeight()
    capacitor.body = love.physics.newBody(world, x + capacitor.w / 2, y + capacitor.h / 2, "static") -- remember, the shape (the rectangle we create next) anchors to the body from its center, so we have to move it to (650/2, 650-50/2)
    capacitor.shape = love.physics.newRectangleShape(capacitor.w, capacitor.h) -- make a rectangle with a width of 650 and a height of 50
    capacitor.fixture = love.physics.newFixture(capacitor.body, capacitor.shape) -- attach shape to body

    function capacitor.draw()
        render_local(image, capacitor.x, capacitor.y)
        -- love.graphics.setColor(1, 1, 1, 0.5)
        -- render_local_box(obstacle.x - w / 2, obstacle.y - h / 2, obstacle.w, obstacle.h)
    end

    return capacitor
end

capacitorTypes = {
    comp1 = "comp1",
    comp2 = "comp2",
    large1 = "large1",
    large2 = "large2",
    small = "small"
}
