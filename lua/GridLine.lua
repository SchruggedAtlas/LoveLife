require "class"

GridLine = class(
  function(a, name)
    a.name = name
    GridLine:init()
  end
)

function GridLine:init()
  self.color = {1,1,1,0.6}
end

function GridLine:setColor(color)
  self.color = color
end

function GridLine:setCoordinates(x1, y1, x2, y2)
  self.x1 = x1
  self.x2 = x2
  self.y1 = y1
  self.y2 = y2
end

function GridLine:setHline(y)
  self.x1 = 0
  self.y1 = y
  self.x2 = love.graphics.getWidth()
  self.y2 = y
end

function GridLine:setVline(x)
  self.x1 = x
  self.y1 = 0
  self.x2 = x
  self.y2 = love.graphics.getHeight()
end

function GridLine:draw()
  love.graphics.setColor(self.color)
  love.graphics.line(self.x1, self.y1, self.x2, self.y2)
end
