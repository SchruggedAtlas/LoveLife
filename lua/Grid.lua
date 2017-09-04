require "class"
require "GridLine"
require "Cells"

Grid = class(
  function(a, name)
    a.name = name
  end
)

function Grid:init(cell_size)
  self.cell_size = cell_size
  self.rows = math.floor(love.graphics.getHeight()/cell_size)
  self.cols = math.floor(love.graphics.getWidth()/cell_size)
  self.cells = Cells()
  self.cells:randomize(self.cols, self.rows, cell_size)
  self.hlines = {}
  self.vlines = {}
  
  for i=1,self.rows,1
  do
      local ypos = i*cell_size
      gline = GridLine()
      gline:setHline(ypos)
      gline:setColor({0,255,0,100})
      table.insert(self.hlines,gline)
  end
  
  for i=1,self.cols,1
  do
    local xpos = i*cell_size
    gline = GridLine()
    gline:setVline(xpos)
    gline:setColor({0,255,0,100})
    table.insert(self.vlines,gline)
  end
end

function Grid:update()
  self.cells:update()
end

function Grid:draw()
  -- Drawing hlines and vlines may be optional
  for index, hline in ipairs(self.hlines) do
    hline:draw()
  end
  for index, vline in ipairs(self.vlines)do
    vline:draw()
  end
  self.cells:draw()
end
