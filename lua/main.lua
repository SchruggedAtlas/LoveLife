require "GridLine"
require "Grid"

function love.load()
  love.window.setMode(0,0)
  settings_alpha = 1 -- no transparency
  fade_time = 3 -- seconds
  cell_sz = 20 -- pixels
  total_time = 0
  update_enabled = true
  interval_idx = #intervals
  update_interval = intervals[interval_idx]
  grid = Grid()
  grid:init(cell_sz)
  love.graphics.setFont(love.graphics.newFont(48))
  love.window.setFullscreen(true, "desktop")
end

function love.keypressed(key)
  if key == "escape" then
    love.event.push("quit")
  end
  if key == "i" then
    grid:init(cell_sz)
  end
  if key == "up" then
    interval_idx = interval_idx + 1
    interval_idx = math.min(interval_idx, #intervals)
    settings_alpha = 1
  end
  if key == "down" then
    interval_idx = interval_idx - 1
    interval_idx = math.max(interval_idx, 1)
    settings_alpha = 1
  end
end

function change_settings(delta_time)
  settings_alpha = settings_alpha - (delta_time * (1 / fade_time)) -- so it takes 3 seconds to remove all the alpha
  if settings_alpha < 0 then
    settings_alpha = 0
  end -- to ensure that a 0 is the lowest value we get
end

function love.update(dt)
    if update_enabled then
      -- This scope could be used to wrap
      -- all updates.  It is not time based
      -- so updates could be switched on or off.
    end

    total_time = total_time + dt
    if total_time >= intervals[interval_idx] then
      total_time = 0
      grid:update()
    end

    if settings_alpha > 0 then
      change_settings(dt)
    end
end

function draw_settings()
  love.graphics.setColor(1,0,0,settings_alpha)
  love.graphics.print("Update Interval : " .. tostring(intervals[interval_idx]),100,100)
end

function love.draw()
  grid:draw()
  if settings_alpha > 0 then
    draw_settings()
  end
end
