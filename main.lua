
-- load function
function love.load()
    love.graphics.setBackgroundColor(0.2, 0.2, 0.5)

    bullets = {}
    bulletSpeed = 300

    player = {
        x = 250,
        y = 250,
        width = 15,
        height = 15,
        speed = 12,
    }

    -- monster = {}

    math.randomseed(os.time())
end

-- update function
function love.update(dt)
    if love.keyboard.isDown("w") then
        player.y = player.y - player.speed * dt
    end
    if love.keyboard.isDown("a") then
        player.x = player.x - player.speed * dt
    end
    if love.keyboard.isDown("s") then
        player.y = player.y + player.speed * dt
    end
    if love.keyboard.isDown("d") then
        player.x = player.x + player.speed * dt
    end

end

-- draw function
function love.draw()

end
