require "class"

LivingNode = class(
  function(a, name)
    a.name = name
  end
)

function LivingNode:setPosition(x,y)
  self.x = x
  self.y = y
end


  