require "class"

Cells = class(
  function(a, name)
    a.name = name
  end
)

function Cells:evolve(cell)
  -- https://rosettacode.org/wiki/Conway%27s_Game_of_Life#Lua
  -- This implementation requires a square grid (rows == cols)
  -- It would be useful to maintain a shadow table of scores for
  -- each cell
  local m = #cell
  local n = #cell[1]
  local cell2 = {}
  -- make a copy of the input table
  for i = 1, m do
    cell2[i] = {}
    for j = 1, n do
      cell2[i][j] = cell[i][j]
    end
  end
  -- examine the copy and apply the life
  -- rules to the input table
  for i = 1, m do
    for j = 1, n do
      local count
      -- initialize the neighbor count
      if cell2[i][j] == 0 then 
        count = 0 
      else count = -1 
      end
      -- count neighbors
      for x = -1, 1 do
        for y = -1, 1 do
          if i+x >= 1 and i+x <= m and j+y >= 1 and j+y <= n and cell2[i+x][j+y] == 1 then 
            count = count + 1 
          end
        end
      end
      -- apply life rules
      if count < 2 or count > 3 then 
        cell[i][j] = 0 
      end
      if count == 3 then 
        cell[i][j] = 1 
      end
    end
  end
  -- return the modified input table
  return cell
end

function Cells:update()
  -- we will call evolve() here
  self.cell_table = Cells:evolve(self.cell_table)
end

function Cells:randomize(cols, rows, size)
  -- Create a table based on
  -- screen size. Randomly set
  -- cells to 0 or 1
  self.cell_size = size
  -- can use os.time()
  seed = math.random()
  math.randomseed(seed)
  print(seed)
  self.cell_table = {}
  for i = 1, cols do
    self.cell_table[i] = {}
    for j = 1, rows do
      self.cell_table[i][j] = math.random(0,1)
      -- Test code for generating keys for the living node table
      if self.cell_table[i][j] == 1 then
        xstr = tostring(i)
        ystr = tostring(j)
        node_key = xstr..","..ystr
        -- This is what the key would look like
        print(node_key)
      end
    end
  end
end

function Cells:draw()
  local row_size = #self.cell_table
  local col_size = #self.cell_table[1]
  local sqr_size = self.cell_size - 1
  love.graphics.setColor(0, 255, 0, 255)
  for i = 1, row_size do
    for j = 1, col_size do
      if self.cell_table[i][j] == 1 then
        love.graphics.rectangle("fill", self.cell_size*(i-1)+1,
                                        self.cell_size*(j-1)+1, 
                                        sqr_size, sqr_size)
      end
    end
  end
end
