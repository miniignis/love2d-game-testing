
-- load function
function love.load()
    love.graphics.setBackgroundColor(0.2, 0.2, 0.5)

    bullets = {}
    bulletSpeed = 300

    player = {
        x = 250,
        y = 250,
        dx = 0,
        dy = 0,
        width = 32,
        height = 32,
        speed = 35,
        sprite = love.graphics.newImage("lovesprite.png")
    }

    monster = {
        x = 0,
        y = 0,
        width = 32,
        height = 32,
    }

    math.randomseed(os.time())
end

-- update function
function love.update(dt)
    
    for k,v in ipairs(bullets) do
        v.x = v.x + (v.dx * dt)
        v.y = v.y + (v.dy * dt)

        v.life = v.life - dt
        if v.life <= 0 then
            table.remove(bullets, k)
        end

        if v.x >= monster.x and v.x <= (monster.x + monster.width) and
            v.y >= monster.y and v.y <= (monster.y + monster.height) then
                monster.x = math.random(0, 320)
                monster.y = math.random(0, 320)
        end
    end

    -- WASD movement.
    -- Up (W)
    if love.keyboard.isDown("w") then
        player.dy = player.dy - player.speed
    end

    -- Left (A)
    if love.keyboard.isDown("a") then
        player.dx = player.dx - player.speed
    end

    -- Down (S)
    if love.keyboard.isDown("s") then
        player.dy = player.dy + player.speed
    end

    -- Right (D)
    if love.keyboard.isDown("d") then
        player.dx = player.dx + player.speed
    end

    -- accerlative movement :D
    player.dx = player.dx * 0.9
    player.dy = player.dy * 0.9

    player.x = player.x + player.dx * dt
    player.y = player.y + player.dy * dt

    player.x = player.x % 820
    player.y = player.y % 560

end

-- draw function
function love.draw()
    for k, v in ipairs(bullets) do
        love.graphics.setColor(0, 0, 0)
        love.graphics.circle("fill", v.x, v.y, 4)
    end

    love.graphics.setColor(1, 1, 1)

    love.graphics.draw(player.sprite, player.x, player.y)
end

function love.mousepressed(x, y, button)
    if button == 1 then
        local sx, sy = player.x + player.width / 2, player.y + player.height / 2
        local mx, my = x, y

        local angle = math.atan2((mx - sx), (my - sy))

        local bdx = bulletSpeed * math.sin(angle)
        local bdy = bulletSpeed * math.cos(angle)

        -- Recoil
        player.dx = player.dx - bdx / 2
        player.dy = player.dy - bdy / 2

        table.insert(bullets, {
            x = sx,
            y = sy,
            dx = bdx,
            dy = bdy,
            life = 2, -- bullets shouldn't live forever!
        })
    end
end