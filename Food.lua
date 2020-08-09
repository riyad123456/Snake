Food = Class{}

function Food:init(x,y)
    self.x = x
    self.y = y
    self.width = 5
    self.height = 5    
end
function Food:render()
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end  
