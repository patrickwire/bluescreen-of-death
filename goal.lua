function create_goal(x, y, w, h, world)
    local self = {
        public_field = 0,
        touching = {}
    }
    local asset= love.graphics.newImage("assets/gfx/receiverStationBase001.png")
    local position = {}
    position.x = x
    position.y = y
    position.x = x
    position.y = y
    local body = love.physics.newBody(world, position.x + (h / 2), position.y + w / 2, "kinematic")

    local shape = love.physics.newRectangleShape(w, h) -- the ball's shape has a radius of 20
    local fixture = love.physics.newFixture(body, shape, 0) -- Attach fixture to body and give it a density of 1.
    fixture:setSensor(true)
    fixture:setUserData("goal")
    local wall1=gen_blocker(x+100,y-100,85,245,world)
    local wall2=gen_blocker(x-100,y-100,85,245,world)
    function self.draw()
        love.graphics.setColor(0, 1, 1, 0.3) -- set the drawing color to red for the ball
        render_local_box(position.x, position.y, w, h)
        love.graphics.setColor(1, 1, 1, 1) -- set the drawing color to red for the ball
        render_local(asset,position.x-90, position.y-100)
       wall1.draw()
       wall2.draw()
    end

    function self.update(self, dt, b,world)

    end

    return self
end

function gen_blocker(x,y,w,h,world)
    local obstacle = {}
    obstacle.x = x
    obstacle.y = y
    obstacle.w = w
    obstacle.h = h
    obstacle.body = love.physics.newBody(world, x + w / 2, y + h / 2, "static") -- remember, the shape (the rectangle we create next) anchors to the body from its center, so we have to move it to (650/2, 650-50/2)
    obstacle.shape = love.physics.newRectangleShape(w, h) -- make a rectangle with a width of 650 and a height of 50
    obstacle.fixture = love.physics.newFixture(obstacle.body, obstacle.shape) -- attach shape to body
    function obstacle.draw()
        render_local_box(x,y,w,h)
    end
    return obstacle
end