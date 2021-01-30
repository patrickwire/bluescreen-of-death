function beginCallback(fixture1, fixture2, contact)
    if fixture1:getUserData() == "laser" or fixture2:getUserData() == "laser" then
      
    end
    if fixture1:getUserData() == "laser" and fixture2:getUserData() == "player" then
      gameOver=true
    end
    if fixture1:getUserData() == "player" and fixture2:getUserData() == "laser" then
      gameOver=true
    end
end

function endCallback(fixture1, fixture2, contact)
    if fixture1:getUserData() == "laser" or fixture2:getUserData() == "laser" then
        laser.touching = laser.touching - 1
    end

    -- The contact handling in 0.8.0 is buggy. Do a full garbage collection to prevent some nasty crash.
    contact = nil
    collectgarbage()
end
