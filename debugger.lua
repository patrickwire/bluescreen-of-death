DEBUG = false
NO_DEATH=true
COORDINATES=true
function debug_print()
    if (DEBUG) then
        print("touching")
        print(laser.touching)
        print("gameover")
        print(gameover)
    end
end
