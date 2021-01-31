function beginCallback(fixture1, fixture2, contact)
    local id
    if (fixture1:getUserData() and fixture1:getUserData().type == "laseractivator") or
        (fixture2:getUserData() and fixture2:getUserData().type == "laseractivator") then

        if (fixture2:getUserData() and fixture2:getUserData().id) then
            id = fixture2:getUserData().id
        end
        if (fixture1:getUserData() and fixture1:getUserData().id) then
            id = fixture1:getUserData().id
        end
        sounds.laser:play()
        if (id == 1) then

            laser.touching = laser.touching + 1
            laser_activator.touching = laser.touching + 1
        else
            laser2.touching = laser2.touching + 1
            laser_activator2.touching = laser2.touching + 1
        end
    end
    if (fixture1:getUserData() and fixture1:getUserData().type == "laser" and fixture2:getUserData() == "player") or
        (fixture1:getUserData() == "player" and fixture2:getUserData() and fixture2:getUserData().type == "laser") then
        if (fixture2:getUserData() and fixture2:getUserData().id) then
            id = fixture2:getUserData().id
        end
        if (fixture1:getUserData() and fixture1:getUserData().id) then
            id = fixture1:getUserData().id
        end
        if (laser.touching == 0 and id == 1) or (laser2.touching == 0 and id == 2) then
            print("laser" .. id)
            gameOver = true
            sounds.laser_hit:play()
        end
    end
    if (fixture1:getUserData() == "enemy" and fixture2:getUserData() == "player") or
        (fixture1:getUserData() == "player" and fixture2:getUserData() == "enemy") then
        print("enemy")
        sounds.enemy:play()
        gameOver = true
    end
    if (fixture1:getUserData()) then
        print(fixture1:getUserData())
    end
    if (fixture2:getUserData()) then
        print(fixture2:getUserData())
    end
    if (fixture1:getUserData() == "goal" and fixture2:getUserData() == "image") or
        (fixture1:getUserData() == "image" and fixture2:getUserData() == "goal") then
        sounds.pling:play()
        win = true
    elseif (fixture1:getUserData() == "goal" and fixture2:getUserData() ~= "image") or
        (fixture1:getUserData() ~= "image" and fixture2:getUserData() == "goal") then
        Talkies.font = love.graphics.newFont("iosevka-regular.ttf", 30)
        Talkies.say("Old Robot Jenkins", "That's not the box with my wedding fotos!")
    end
    if NO_DEATH then
        gameOver = false
    end

end

function endCallback(fixture1, fixture2, contact)
    local id
    if (fixture1:getUserData() and fixture1:getUserData().type == "laseractivator") or
        (fixture2:getUserData() and fixture2:getUserData().type == "laseractivator") then
        if (fixture2:getUserData() and fixture2:getUserData().id) then
            id = fixture2:getUserData().id
        end
        if (fixture1:getUserData() and fixture1:getUserData().id) then
            id = fixture1:getUserData().id
        end
        if (id == 1) then
            laser.touching = laser.touching - 1
            laser_activator.touching = laser.touching - 1
        else
            laser2.touching = laser2.touching - 1
            laser_activator2.touching = laser2.touching - 1
        end
    end

    -- The contact handling in 0.8.0 is buggy. Do a full garbage collection to prevent some nasty crash.
    contact = nil
    collectgarbage()
end

function background()

    for i = -1, 10, 1 do
        for j = -1, 10, 1 do
            c = 1 - (j % 2 * i % 2 + (j % 2 - 1) * (i % 2 - 1)) * 0.1
            --love.graphics.setColor(c, c, c) -- set the drawing color to red for the ball
            if c < 1 then
              --  render_local(images.floor,i * 1000, j * 1000)
            end
            render_local(images.floor,i * 1000, j * 1000)
        end
    end
    love.graphics.setColor(1, 1, 1) -- set the drawing color to red for the ball

end
