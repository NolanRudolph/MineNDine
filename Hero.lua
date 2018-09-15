local Hero = {
    speed = 6000,
    roomCooldown = 0
}

-- Example used newHero(650, 650, 50)

function Hero:newHero(xPos, yPos, width, height)
    self.xPos = xPos
    self.yPos = yPos
    self.width = width
    self.height = height
    self.body = love.physics.newBody(world, xPos - width/2, yPos - height/2, "dynamic")
    self.body:setLinearDamping(20)
    self.shape = love.physics.newRectangleShape(width, height)
    self.fixture = love.physics.newFixture(self.body, self.shape)
end

function Hero:renderHero()

    --[[ Does Body Exist? ]]--
    if self.body == nil then
        print("Cannot Render Hero: Body Does not Exist")
        return
    end

    --[[ Draw Body ]]--
    x, y = self.body:getPosition()
    love.graphics.rectangle("fill", x, y, self.width, self.height)
end

function Hero:update()
    if love.keyboard.isDown('w') then
        Hero.body:applyForce(0, -self.speed)
    end
    if love.keyboard.isDown('s') then
        Hero.body:applyForce(0, self.speed)
    end
    if love.keyboard.isDown('a') then
        Hero.body:applyForce(-self.speed, 0)
    end
    if love.keyboard.isDown('d') then
        Hero.body:applyForce(self.speed, 0)
    end
end


return Hero