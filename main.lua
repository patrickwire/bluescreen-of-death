require("AnAL")
require("laser")
require("player")
require("laser")
require("laserActivator")
require("level")
require("world")
require("debugger")
require("container")
require("roadblock")
require("helper")
require("goal")
require("enemy")
gameOver = false
win = false
function love.load()
    -- love.graphics.setBackgroundColor(0.8, .8, .8)
    love.graphics.setBackgroundColor(1, 1, 1)

    images = {
        player = love.graphics.newImage("assets/gfx/player.png"),
        world = love.graphics.newImage("assets/gfx/world.png")
    }
    x = 300
    y = 200
    -- game
    love.window.setMode( 1000, 1000)
    width = love.graphics.getWidth()
    height = love.graphics.getHeight()
    speed = 100
    w = images.player:getWidth()
    h = images.player:getHeight()
    world = love.physics.newWorld(0, 0, true)
    world:setCallbacks(beginCallback, endCallback)
    walls = {}
    for i, v in ipairs(obstaclelist) do
        table.insert(walls, create_obstacle(v.x, v.y, 100, 100))
    end
    containers = {create_container(600, 500, 100, 100)}

    objects = {} -- table to hold all our physical objects
    -- laser = create_laser(150, 400, 400, world)
    -- enemy = create_enemy(250, 400, 800, 800, world)
    -- laser_activator = create_laser_activator(300, 0, 100, 100, world)
    -- goals = {create_goal(800, 500, 100, 100, world)}
    player = create_player(x + 100, y + 100, world)

end

function love.update(dt)
    world:update(dt) -- this puts the world into motion
    player:update(dt)
    -- enemy:update(dt)
    -- laser:update(dt, containers)

    if love.keyboard.isDown("escape") then -- press the right arrow key to push the ball to the right
        gameOver = false
        win = false
        love.run()

    end
    for i, v in ipairs(containers) do
        v.update()
    end
    x = player.body:getX()
    y = player.body:getY()
end

function render_local(asset, globalx, globaly)
    love.graphics.draw(asset, 300 + globalx - x, 200 + globaly - y)
end

function render_local(asset, globalx, globaly, r)
    love.graphics.draw(asset, 300 + globalx - x, 200 + globaly - y, r)
end

function render_local_box(globalx, globaly, w, h)
    love.graphics.rectangle("fill", 300 + globalx - x, 200 + globaly - y, w, h)
end

function love.draw()
    -- render_local(images.world, 0, 0)
    background()

    player:draw()

    for i, v in ipairs(walls) do
        v.draw()
    end

    love.graphics.setBlendMode("alpha")
    for i, v in ipairs(containers) do
        v.draw()
    end

    -- for i, v in ipairs(goals) do
    --     v.draw()
    -- end

    -- laser:draw()
    -- enemy:draw()
    -- laser_activator:draw()

    if (gameOver) then
        love.graphics.setColor(0, 0, 1) -- set the drawing color to red for the ball
        love.graphics.rectangle("fill", 0, 0, width, width)
        love.graphics.setColor(1, 1, 1) -- set the drawing color to red for the ball
        love.graphics.print("BLUE SCREEN", 400, 300)
    end
    if (win) then
        love.graphics.setColor(0, 1, 0) -- set the drawing color to red for the ball
        love.graphics.rectangle("fill", 0, 0, width, width)
        love.graphics.setColor(1, 1, 1) -- set the drawing color to red for the ball
        love.graphics.print("WIN", 400, 300)
    end
    debug_print()
end
