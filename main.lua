push = require 'push'

Class= require 'class'

require 'snake'
require 'Food'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

-- speed at which we will move out paddle; multiplied by dt (deltatime) in update
SNAKE_SPEED = 200

function love.load()
	love.graphics.setDefaultFilter('nearest', 'nearest')

    math.randomseed(os.time())
    Array = {}
    love.window.setTitle('Snake')

    -- more retro-looking fonr object we can use for any text
    smallFont = love.graphics.newFont('font.ttf', 8)

    love.graphics.setFont(smallFont)

    -- initialize our virtual resolution, which will be rendered within
    -- our actual window no matter its dimensions
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })

    snake = snake(100,300)
    Food = Food(400,100)
    gameState = 'start'
end

function love.update(dt)
	if gameState == 'play' then
		
		if snake:collideswithFood(Food) then 
			Food.x = math.random(0,VIRTUAL_WIDTH)
			Food.y = math.random(0,VIRTUAL_HEIGHT)
			if snake.dx == 0 then 
				snake.height = snake.height + 20
			else 
				snake.width = snake.width + 20
		end
		else
			Food = Food
		end 
    if snake.dx == 0 then 
			snake:updatevertically(dt)
	else 
			snake:updatehorizontally(dt)
		end
	end
end 
function love.keypressed(key)
	if key == 'escape' then
        love.event.quit()
    elseif key == 'enter' or key == 'return' then
        if gameState == 'start' then
            gameState = 'play'
        else 
            gameState = 'start'

            snake:reset()
        end
    end

	if key == 'up' and snake.dy == 0 then
        snake.dy = -SNAKE_SPEED
        snake.dx = 0
        temp = snake.width 
        snake.width = 5   	 
    	snake.height = temp
    elseif key == 'down' and snake.dy == 0 then
        snake.dy = SNAKE_SPEED
        snake.dx = 0
        temp = snake.width 
        snake.width = 5 
    	snake.height = temp  
    elseif key == 'left' and snake.dx == 0 then
        snake.dx = -SNAKE_SPEED
        snake.dy = 0
        temp = snake.height 
        snake.height = 5
        snake.width = temp
    elseif key == 'right' and snake.dx == 0 then
        snake.dx = SNAKE_SPEED
        snake.dy = 0
        temp = snake.height 
        snake.height = 5
        snake.width = temp
    
    end
end 
function love.draw()
    push:apply('start')

    -- clear the screen with a specific color; in this case, a color similar
    -- to some versions of the original pong
    love.graphics.clear(40/255, 45/255, 52/255, 1)

    love.graphics.setFont(smallFont);

    if gameState == 'start' then
        love.graphics.printf('Hello Start State!', 0, 20, VIRTUAL_WIDTH, 'center')
    else
        love.graphics.printf('Hello Play State!', 0, 20, VIRTUAL_WIDTH, 'center')
        snake:render()
        Food:render()
    end
    
    push:apply('end')   
end 
