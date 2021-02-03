require("laser")
require("player")
require("laser")
require("world")
require("debugger")
require("box")
gameOver = false

function love.load()
    images = {
        player = love.graphics.newImage("assets/gfx/player.png"),
        world = love.graphics.newImage("assets/gfx/world.png")
    }
    x = 300
    y = 200
    -- game
    width = love.graphics.getWidth()
    height = love.graphics.getHeight()
    speed = 100
    w = images.player:getWidth()
    h = images.player:getHeight()
    world = love.physics.newWorld(0, 0, true)
    world:setCallbacks(beginCallback, endCallback)
    walls = {create_obstacle(0, 0, 100, 100)}
    boxes = {create_box(600, 500, 100, 100)}

    objects = {} -- table to hold all our physical objects
    laser = create_laser(300, 0, 200, world)
    player = create_player(x, y, world)

end

function create_obstacle(x, y, w, h)
    -- let's create the ground
    object = {}
    object.x = x
    object.y = y
    object.w = w
    object.h = h
    object.body = love.physics.newBody(world, x, y) -- remember, the shape (the rectangle we create next) anchors to the body from its center, so we have to move it to (650/2, 650-50/2)
    object.shape = love.physics.newRectangleShape(w, h) -- make a rectangle with a width of 650 and a height of 50
    object.fixture = love.physics.newFixture(object.body, object.shape) -- attach shape to body
    return object
end

function love.update(dt)
    world:update(dt) -- this puts the world into motion
    player:update(dt)
    laser:update(dt, blocks)

    if love.keyboard.isDown("escape") then -- press the right arrow key to push the ball to the right
        gameOver = false
        love.run()

    end

    x = player.body:getX() + 16
    y = player.body:getY() + 16
end

function render_local(asset, globalx, globaly)
    love.graphics.draw(asset, 300 + globalx - x, 200 + globaly - y)
end

function render_local_box(globalx, globaly, w, h)
    love.graphics.rectangle("fill", 300 + globalx - x, 200 + globaly - y, w, h)
end

function love.draw()
    render_local(images.world, 100, 100)

    for i, v in ipairs(walls) do
        render_local_box(v.body:getX(), v.body:getY(), v.w, v.h)
    end

    for i, v in ipairs(boxes) do
        v.draw()
    end

    player:draw()
    laser:draw()

    if (gameOver) then
        love.graphics.setColor(0, 0, 1) -- set the drawing color to red for the ball
        love.graphics.rectangle("fill", 0, 0, width, width)
        love.graphics.setColor(1, 1, 1) -- set the drawing color to red for the ball
        love.graphics.print("BLUE SCREEN", 400, 300)
    end
    debug_print()
end
