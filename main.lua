require("laser")
require("player")
require("laser")
require("world")
require("debugger")
<<<<<<< HEAD
require("box")
require("helper")
=======
require("container")
require("roadblock")
>>>>>>> 01af15c23910c9b5e2fdcbd81131da87fc233329
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
<<<<<<< HEAD
    boxes = {create_box(400, 0, 100, 100)}

    objects = {} -- table to hold all our physical objects
    laser = create_laser(300, 0, 200, world)
    player = create_player(x, y, world)
=======
    containers = {create_container(600, 500, 100, 100)}

    objects = {} -- table to hold all our physical objects
>>>>>>> 01af15c23910c9b5e2fdcbd81131da87fc233329
    laser = create_laser(300, 0, 200, world)
    player = create_player(x, y, world)

end

function love.update(dt)
    world:update(dt) -- this puts the world into motion
    player:update(dt)
    laser:update(dt, boxes)

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
    render_local(images.world, 0, 0)

    for i, v in ipairs(walls) do
        v.draw()
    end

    for i, v in ipairs(containers) do
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
