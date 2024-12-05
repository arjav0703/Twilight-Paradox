Ball = Class{}

function Ball:init(x, y, width, height)
    self.x = x
    self.y = y
    self.width = width
    self.height = height
    self.dy = math.random(2) == 1 and -100 or 100
    self.dx = 150
end

function Ball:collides(char)
    local ballLeft = self.x - self.width / 2
    local ballRight = self.x + self.width / 2
    local ballTop = self.y - self.height / 2
    local ballBottom = self.y + self.height / 2

    local charLeft = char.x
    local charRight = char.x + char.width
    local charTop = char.y
    local charBottom = char.y + char.height

    if ballRight < charLeft or charLeft > ballLeft then
        return false
    end

    if ballBottom < charTop or charTop > ballTop then
        return false
    end 

    return true
end

function Ball:reset()
    self.x = vir_width / 2 - 2
    self.y = vir_height / 2 - 2
    self.dy = math.random(2) == 1 and -100 or 100
    self.dx = math.random(-50, 50)
end

function Ball:update(dt)
    self.x = self.x + self.dx * dt
    self.y = self.y + self.dy * dt
end

function Ball:render()
    love.graphics.draw(snitch,self.x,self.y)
end
