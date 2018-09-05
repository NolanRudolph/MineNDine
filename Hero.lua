local Hero = {
    speed = 6000
}

-- Example used newHero(650, 650, 50)

function Hero:newHero(xPos, yPos, width, height)
    self.body = love.physics.newBody(world, xPos/2-width/2, yPos/2-height/2, "dynamic")
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
    love.graphics.rectangle("fill", x, y, 50, 50)
end

function Hero:update()
    if love.keyboard.isDown('up') then
        Hero.body:applyForce(0, -self.speed)
    end
    if love.keyboard.isDown('down') then
        Hero.body:applyForce(0, self.speed)
    end
    if love.keyboard.isDown('left') then
        Hero.body:applyForce(-self.speed, 0)
    end
    if love.keyboard.isDown('right') then
        Hero.body:applyForce(self.speed, 0)
    end
end


return Hero