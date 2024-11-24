-- Paddle.lua
Paddle = Class{}

function Paddle:init(x, y, width, height)
    self.x = x
    self.y = y
    self.width = width
    self.height = height
    self.dy = 0
    self.dx = 0
    
end

function Paddle:update(dt)
    self.x = self.x + self.dx * dt
    self.y = self.y + self.dy * dt

    -- Ensure the paddle stays within the window boundaries
    if self.y < 0 then
        self.y = 0
    elseif self.y > VIRTUAL_HEIGHT - self.height then
        self.y = VIRTUAL_HEIGHT - self.height
    end

    if self.x < 0 then
        self.x = 0
    elseif self.x > VIRTUAL_WIDTH - self.width then
        self.x = VIRTUAL_WIDTH - self.width
    end
end

function Paddle:render()
    love.graphics.draw(witch, self.x,self.y)
end