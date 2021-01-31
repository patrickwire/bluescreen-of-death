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
require("spawnStation")
require("enemy")
require("capacitor")
OFFSET_X = 400
OFFSET_Y = 400
Talkies = require("libs/talkies")
gameOver = false
win = false
volume = 0.1
textblock = 0;
function love.load()
    -- love.graphics.setBackgroundColor(0.8, .8, .8)
    love.graphics.setBackgroundColor(1, 1, 1)
    sounds = {
        laser = love.audio.newSource("assets/sfx/laser.mp3", "static"),
        laser_hit = love.audio.newSource("assets/sfx/laser_hit.mp3", "static"),
        pling = love.audio.newSource("assets/sfx/pling.mp3", "static"),
        enemy = love.audio.newSource("assets/sfx/enemy.mp3", "static"),
        move = love.audio.newSource("assets/sfx/move.mp3", "static"),
        music = love.audio.newSource("assets/sfx/music.mp3", "stream")
    }

    sounds.music:play()
    sounds.music:setLooping(true)
    images = {
        player = love.graphics.newImage("assets/gfx/player.png"),
        paper = {love.graphics.newImage("assets/gfx/paperSmall001.png"),
                 love.graphics.newImage("assets/gfx/paperSmall002.png"),
                 love.graphics.newImage("assets/gfx/paperSmall003.png"),
                 love.graphics.newImage("assets/gfx/paperSmall004.png"),
                 love.graphics.newImage("assets/gfx/paperSmall005.png"),
                 love.graphics.newImage("assets/gfx/paperSmall006.png")},
        paper_mid = love.graphics.newImage("assets/gfx/paperMedium001.png"),
        paper_large = love.graphics.newImage("assets/gfx/paperLarge001.png"),
        win = love.graphics.newImage("assets/gfx/screenWinning001.png"),
        lose = love.graphics.newImage("assets/gfx/screenLosing001.png")
    }
    Talkies.font = love.graphics.newFont("iosevka-regular.ttf", 30)
    x = OFFSET_X
    y = OFFSET_Y
    -- game
    love.window.setMode(1000, 1000)

    love.audio.setVolume(volume)

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
    table.insert(walls, create_capacitor(800, 350, capacitorTypes.comp2))
    table.insert(walls, create_capacitor(50, 50, capacitorTypes.comp2))
    table.insert(walls, create_capacitor(500, 50, capacitorTypes.large1))
    table.insert(walls, create_capacitor(-100, 500, capacitorTypes.small))
    table.insert(walls, create_capacitor(200, 600, capacitorTypes.comp1))
    table.insert(walls, create_capacitor(960, 0, capacitorTypes.small))
    table.insert(walls, create_capacitor(1100, 0, capacitorTypes.small))
    table.insert(walls, create_capacitor(1650, 50, capacitorTypes.large1))
    table.insert(walls, create_capacitor(850, -150, capacitorTypes.large2))
    table.insert(walls, create_capacitor(-150, 1100, capacitorTypes.small))
    table.insert(walls, create_capacitor(800, 950, capacitorTypes.comp2))
    -- table.insert(walls, create_capacitor(1500, 250, capacitorTypes.large1))
    table.insert(walls, create_capacitor(1800, 150, capacitorTypes.large2))
    table.insert(walls, create_capacitor(2300, 0, capacitorTypes.comp1))
    table.insert(walls, create_capacitor(1450, 1000, capacitorTypes.large2))
    table.insert(walls, create_capacitor(1500, 1080, capacitorTypes.large2))
    table.insert(walls, create_capacitor(1580, 1240, capacitorTypes.small))
    table.insert(walls, create_capacitor(2200, 850, capacitorTypes.comp1))
    table.insert(walls, create_capacitor(2150, 600, capacitorTypes.comp2))
    table.insert(walls, create_capacitor(2550, 450, capacitorTypes.large2))
    table.insert(walls, create_capacitor(2600, 550, capacitorTypes.large1))
    table.insert(walls, create_capacitor(2000, 1400, capacitorTypes.comp1))
    table.insert(walls, create_capacitor(2600, 1850, capacitorTypes.comp2))
    table.insert(walls, create_capacitor(2700, -1400, capacitorTypes.small))
    table.insert(walls, create_capacitor(2600, -1300, capacitorTypes.comp2))
    table.insert(walls, create_capacitor(1700, 1900, capacitorTypes.comp2))
    table.insert(walls, create_capacitor(1100, 2050, capacitorTypes.small))
    table.insert(walls, create_capacitor(1110, 1540, capacitorTypes.small))
    table.insert(walls, create_capacitor(1100, 1230, capacitorTypes.large2))
    table.insert(walls, create_capacitor(2100, 1900, capacitorTypes.large1))
    table.insert(walls, create_capacitor(2400, 1400, capacitorTypes.large2))
    table.insert(walls, create_capacitor(1650, 1650, capacitorTypes.small))
    table.insert(walls, create_capacitor(1700, 750, capacitorTypes.large1))

    containers = {create_container(600, 800, 100, 100, containerTypes.file),
                  create_container(300, 500, 100, 100, containerTypes.image), create_container(1500, 1700, 100, 100),
                  create_container(500, 1400, 100, 100), create_container(600, 1400, 100, 100),
                  create_container(700, 1400, 100, 100), create_container(900, 1400, 100, 100),
                  create_container(1500, 1800, 100, 100), create_container(1250, 1100, 100, 100, containerTypes.image)}

    objects = {} -- table to hold all our physical objects

    laser = create_laser(1040, -50, 650, world, 1)
    laser2 = create_laser(1040, 1615, 565, world, 2)
    enemies = {create_enemy(-190, 2200, 130, 2200, world), create_enemy(1250, 1400, 1800, 1400, world),
               create_enemy(1900, 400, 2600, 400, world), create_enemy(2000, 600, 2000, 1300, world, true),
               create_enemy(600, 1500, 600, 2100, world, true)}
    laser_activator = create_laser_activator(850, 800, 100, 100, world, 1)
    laser_activator2 = create_laser_activator(850, 1800, 100, 100, world, 2)
    goals = {create_goal(280, 1450, 100, 100, world)}
    spawn = create_spawn(250, 0, 100, 100, world)
    player = create_player(339, 175, world)

    Talkies.font = love.graphics.newFont("iosevka-regular.ttf", 30)
    Talkies.say("Old Robot Jenkins",
        "Hi there, Kid. I'm so sad, I lost my old wedding foto files\nWould you be so kind to push them into the file converter, so we can restore them?\nMy wife will be sooo mad if you don't help me! If there was just a way to get past that laser...\n\n( Press SPACE to close this dialog )")

end

function love.update(dt)
    world:update(dt) -- this puts the world into motion
    player:update(dt)
    for i, v in ipairs(enemies) do
        v:update(dt)
    end
    laser:update(dt, containers)

    if love.keyboard.isDown("escape") then -- press the right arrow key to push the ball to the right
        gameOver = false
        win = false
        love.run()

    end

    if love.keyboard.isDown("space") then
        Talkies.clearMessages()
    end

    for i, v in ipairs(containers) do
        v.update()
    end
    x = player.body:getX()
    y = player.body:getY()
    Talkies.update(dt)
end

function render_local(asset, globalx, globaly)
    love.graphics.draw(asset, OFFSET_X + globalx - x, OFFSET_Y + globaly - y)
end

function render_local_box(globalx, globaly, w, h)
    love.graphics.rectangle("fill", OFFSET_X + globalx - x, OFFSET_Y + globaly - y, w, h)
end

function love.draw()
    -- render_local(images.world, 0, 0)
    -- background()
    laser_activator:draw()
    laser_activator2:draw()
    draw_paper()
    player:draw()

    for i, v in ipairs(walls) do
        v.draw()
    end

    love.graphics.setBlendMode("alpha")
    for i, v in ipairs(containers) do
        v.draw()
    end

    for i, v in ipairs(goals) do
        v.draw()
    end

    laser:draw()
    laser2:draw()
    for i, v in ipairs(enemies) do
        v.draw()
    end

    if (gameOver) then
        love.graphics.setColor(0, 0, 1) -- set the drawing color to red for the ball
        love.graphics.rectangle("fill", 0, 0, width, width)
        love.graphics.setColor(1, 1, 1) -- set the drawing color to red for the ball
        Talkies.nextOption()
        love.graphics
            .draw(images.lose, width / 2 - images.lose:getWidth() / 2, height / 2 - images.lose:getHeight() / 2)

    elseif (win) then
        love.graphics.setColor(158 / 255, 230 / 255, 223 / 255) -- set the drawing color to red for the ball
        love.graphics.rectangle("fill", 0, 0, width, width)
        love.graphics.setColor(1, 1, 1) -- set the drawing color to red for the ball
        -- love.graphics.print("WIN", 400, 300)
        love.graphics.draw(images.win, width / 2 - images.win:getWidth() / 2, height / 2 - images.win:getHeight() / 2)
        -- elseif x < 950 and y < 1100 then
        --    
    else
        Talkies.draw()
    end

    render_local(images.paper_mid, 1150, 1050)
    render_local(images.paper_mid, -22, 1950)

    if x > 950 then
        Talkies.clearMessages()
    end
    spawn.draw()
    if COORDINATES then
        love.graphics.setColor(0, 1, 0)
        love.graphics.print("x: " .. x, 10, 10)
        love.graphics.print("y: " .. y, 10, 50)
        love.graphics.setColor(1, 1, 1)
    end
    debug_print()
end

function draw_paper()
    render_local(images.paper[1], -50, 340)
    render_local(images.paper[2], 71, 1040)
    render_local(images.paper[3], 830, 240)
    render_local(images.paper[5], 830, 240)
    render_local(images.paper[4], 140, 1640)
    render_local(images.paper[5], 2100, 140)
    render_local(images.paper[1], 2100, 140)
    render_local(images.paper[1], 1876, 570)
    render_local(images.paper[6], 2500, 1200)
    render_local(images.paper[4], 1890, 1800)
    render_local(images.paper[4], 1240, 1835)
    render_local(images.paper[3], 1300, 1800)
    render_local(images.paper[1], 440, 1600)
    render_local(images.paper[2], 470, 1630)
    render_local(images.paper[5], 470, 2000)
    render_local(images.paper[6], 785, 1518)
    render_local(images.paper[6], 1300, 800)
    render_local(images.paper[4], 1400, 840)
    render_local(images.paper_large, -150, 1340)

end
