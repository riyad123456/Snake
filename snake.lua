snake = Class{}

function snake:init(x,y)
    self.x = x
    self.y = y
    self.width = 30
    self.height = 5 
    self.dx = math.random(2) == 1 and -100 or 100
    self.dy = 0
end
function snake:reset()
    self.x = VIRTUAL_WIDTH / 2 - 2
    self.y = VIRTUAL_HEIGHT / 2 - 2
    self.width = 30
    self.height = 5 
end 
function snake:updatehorizontally(dt)
    self.x = self.x + self.dx * dt
    self.dy = 0    
end
function snake:updatevertically(dt)
    self.y = self.y + self.dy * dt
    self.dx = 0    
end
function snake:render()
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end
function snake:collideswithFood(Food)
    if self.x > Food.x + 5 or Food.x > self.x + self.width then
        return false
    end

    if self.y > Food.y + 5 or Food.y > self.y + self.height then
        return false
    end

    return true
end

