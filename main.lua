Class = require 'class'

require 'char'

require 'Ball'

win_width = 1280
win_height = 720
vir_width = 1280
vir_height = 720
character_speed = 200

function love.load()
    
--LOAD ASSETS    
    witch = love.graphics.newImage('witch3.png')
    snitch = love.graphics.newImage('asnitch.png')
    backimg = love.graphics.newImage('backg4.png')

        
    love.window.setTitle('Twilight Paradox')
    love.window.setMode(1280,720)


    math.randomseed(os.time())

    smallFont = love.graphics.newFont('font.ttf', 48)

    scoreFont = love.graphics.newFont('font.ttf', 82)

    love.graphics.setFont(smallFont)

    
    player1Score = 0
    player2Score = 0

    player1 = char(vir_width - 300, vir_height - 400, 5, 20)
    player2 = char(vir_width - 300, vir_height - 200, 5, 20)

    ball = Ball(vir_width / 2 - 2, vir_height / 2 - 2, 4, 4)

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

        if ball.y >= vir_height - 4 then
            ball.y = vir_height - 4
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

    if ball.x >= vir_width then
        ball.x = vir_width - 4
        ball.dx = -ball.dx
        love.audio.play(sounds.wall)
    end
        

--PLAYER MOVEMENT
    if love.keyboard.isDown('w') then
        player1.dy = -character_speed

    elseif love.keyboard.isDown('s') then
        player1.dy = character_speed
    else
        player1.dy = 0
    end

    -- Horizontal movement for player 1
    if love.keyboard.isDown('a') then
        player1.dx = -character_speed
    elseif love.keyboard.isDown('d') then
        player1.dx = character_speed
    else
        player1.dx = 0
    end
-- PLAYER 2 MOVEMENT
    if love.keyboard.isDown('up') then

        player2.dy = -character_speed
    elseif love.keyboard.isDown('down') then
        player2.dy = character_speed
    else
        player2.dy = 0
    end

    -- Horizontal movement for player 2
    if love.keyboard.isDown('left') then
        player2.dx = -character_speed
    elseif love.keyboard.isDown('right') then
        player2.dx = character_speed
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
    
    love.graphics.draw(backimg,0,0)
    
    love.graphics.setFont(smallFont)

    if gameState == 'start' then
        love.graphics.printf('Press enter to start', 0, 220, vir_width, 'center')
    end

    love.graphics.setFont(scoreFont)
    love.graphics.print(tostring(player1Score), vir_width / 2 - 100,vir_height - 80)
    love.graphics.print(tostring(player2Score), vir_width / 2 + 100,vir_height - 80)

    player1:render()
    player2:render()

    ball:render()    
end
--