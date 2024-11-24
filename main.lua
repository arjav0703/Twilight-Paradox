push = require 'push'

Class = require 'class'

require 'Paddle'

require 'Ball'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720
VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243
PADDLE_SPEED = 100


function love.load()
    
--LOAD ASSETS    
    witch = love.graphics.newImage('witch.png')
    snitch = love.graphics.newImage('asnitch.png')
    backimg = love.graphics.newImage('background.jpg')

        
    love.window.setTitle('Twilight Paradox')


    math.randomseed(os.time())

    smallFont = love.graphics.newFont('font.ttf', 8)

    scoreFont = love.graphics.newFont('font.ttf', 32)

    love.graphics.setFont(smallFont)

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })

    player1Score = 0
    player2Score = 0

    player1 = Paddle(VIRTUAL_WIDTH - 100, VIRTUAL_HEIGHT - 200, 5, 20)
    player2 = Paddle(VIRTUAL_WIDTH - 100, VIRTUAL_HEIGHT - 100, 5, 20)

    ball = Ball(VIRTUAL_WIDTH / 2 - 2, VIRTUAL_HEIGHT / 2 - 2, 4, 4)

    gameState = 'start'

    sounds = {}
    sounds.wall = love.audio.newSource('sounds/wall_hit.wav', 'static')
    sounds.score = love.audio.newSource('sounds/score.wav','static')
    sounds.background = love.audio.newSource('sounds/horback.mp3','stream')

    sounds.background:setLooping(true)
    sounds.background:play()
    
end

function love.update(dt)
    
    --COLLISION OF BALL WITH EITHER OF THE PLAYERS
    if gameState == 'play' then
        if ball:collides(player1) then
            ball.dx = -ball.dx * 1.1
            ball.x = player1.x + 5
            player1Score = player1Score + 1
            love.audio.play(sounds.score)
            if ball.dy < 0 then
                ball.dy = -math.random(10, 150)
            else
                ball.dy = math.random(10, 150)
            end
        end
        if ball:collides(player2) then
            ball.dx = -ball.dx * 1.1
            ball.x = player2.x - 4
            player2Score = player2Score + 1
            love.audio.play(sounds.score)
            if ball.dy < 0 then
                ball.dy = -math.random(10, 150)
            else
                ball.dy = math.random(10, 150)
            end
        end
-- REFLECTION FROM WALLS

--Y-AXIS
    if ball.y <= 0 then
            ball.y = 0
            ball.dy = -ball.dy
            love.audio.play(sounds.wall)
        end

        if ball.y >= VIRTUAL_HEIGHT - 4 then
            ball.y = VIRTUAL_HEIGHT - 4
            ball.dy = -ball.dy
            love.audio.play(sounds.wall)
        end
    end
--X-AXIS
    if ball.x <= 0 then
        ball.x = 0
        ball.dx = -ball.dx
        love.audio.play(sounds.wall)
    end

    if ball.x >= VIRTUAL_WIDTH then
        ball.x = VIRTUAL_WIDTH - 4
        ball.dx = -ball.dx
        love.audio.play(sounds.wall)
    end
        

--PLAYER MOVEMENT
    if love.keyboard.isDown('w') then
        player1.dy = -PADDLE_SPEED
    
    elseif love.keyboard.isDown('s') then
        player1.dy = PADDLE_SPEED

    else
        player1.dy = 0
    end

    -- Horizontal movement for player 1
    if love.keyboard.isDown('a') then
        player1.dx = -PADDLE_SPEED

    elseif love.keyboard.isDown('d') then
        player1.dx = PADDLE_SPEED

    else
        player1.dx = 0
    end
-- PLAYER 2 MOVEMENT
    if love.keyboard.isDown('up') then

        player2.dy = -PADDLE_SPEED

    elseif love.keyboard.isDown('down') then
        player2.dy = PADDLE_SPEED

    else
        player2.dy = 0
    end

    -- Horizontal movement for player 2
    if love.keyboard.isDown('left') then
        player2.dx = -PADDLE_SPEED

    elseif love.keyboard.isDown('right') then
        player2.dx = PADDLE_SPEED

    else

        player2.dx = 0

    end

    if gameState == 'play' then
        ball:update(dt)
    end

    player1:update(dt)
    player2:update(dt)
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    elseif key == 'enter' or key == 'return' then
        if gameState == 'start' then
            gameState = 'play'
        else
            gameState = 'start'

            ball:reset()
        end
    end
end


function love.draw()
    push:apply('start')
    love.graphics.draw(backimg,0,0)
    
    love.graphics.setFont(smallFont)

    if gameState == 'start' then
        love.graphics.printf('Twilight Paradox!', 0, 220, VIRTUAL_WIDTH, 'center')
    else
        love.graphics.printf('Twilight Paradox!', 0, 220, VIRTUAL_WIDTH, 'center')
    end

    love.graphics.setFont(scoreFont)
    love.graphics.print(tostring(player1Score), VIRTUAL_WIDTH / 2 - 50, 
        VIRTUAL_HEIGHT -60)
    love.graphics.print(tostring(player2Score), VIRTUAL_WIDTH / 2 + 30,
        VIRTUAL_HEIGHT - 60)

    player1:render()
    player2:render()

    ball:render()

    displayFPS()

    push:apply('end')
end

function displayFPS()
    
    love.graphics.setFont(smallFont)
    love.graphics.setColor(0, 255/255, 0, 255/255)
    love.graphics.print('FPS: ' .. tostring(love.timer.getFPS()), 10, 10)
end
