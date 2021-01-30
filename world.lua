function beginCallback(fixture1, fixture2, contact)
    if fixture1:getUserData() == "laser" or fixture2:getUserData() == "laser" then
        print(laser.touching.insert)
        table.insert(laser.touching, 0, (string.gsub(fixture2:getUserData() .. fixture1:getUserData(), "laser", "")))
    end
    if fixture1:getUserData() == "laser" and fixture2:getUserData() == "player" then
        -- gameOver = true
    end
    if fixture1:getUserData() == "player" and fixture2:getUserData() == "laser" then
        -- gameOver = true
    end

    for i, v in ipairs(laser.touching) do
        print(v)
    end
end

function endCallback(fixture1, fixture2, contact)
    if fixture1:getUserData() == "laser" or fixture2:getUserData() == "laser" then
        -- laser.touching = laser.touching - 1
    end

    -- The contact handling in 0.8.0 is buggy. Do a full garbage collection to prevent some nasty crash.
    contact = nil
    collectgarbage()
end

function background()

    for i = 0, 100, 1 do
        for j = 0, 100, 1 do
            c = 1 - (j % 2 * i % 2 + (j % 2 - 1) * (i % 2 - 1)) * 0.1
            love.graphics.setColor(c, c, c) -- set the drawing color to red for the ball
            if c < 1 then
                render_local_box(i * 100, j * 100, 100, 100)
            end
        end
    end
    love.graphics.setColor(1, 1, 1) -- set the drawing color to red for the ball

end
