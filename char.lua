-- char.lua
char = Class{}

function char:init(x, y, width, height)
    self.x = x
    self.y = y
    self.width = width
    self.height = height
    self.dy = 0
    self.dx = 0
    
end

function char:update(dt)
    self.x = self.x + self.dx * dt
    self.y = self.y + self.dy * dt

    -- Ensure the char stays within the window boundaries
    if self.y < 0 then
        self.y = 0
    elseif self.y > vir_height - self.height then
        self.y = vir_height - self.height
    end

    if self.x < 0 then
        self.x = 0
    elseif self.x > vir_width - self.width then
        self.x = vir_width - self.width
    end
end

function char:render()
    love.graphics.draw(witch, self.x,self.y)
end