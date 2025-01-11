local M = {}

-- map function
--
-- map('n', '<C-a>', 'spawn kitty')
--
local utils = require("utils")
local generalMapFunction = function (mapcmd ,mode, configExp, cmd)
  local configStr = utils.getConfigStr(configExp)

  if type(mode) == "table" then
    for i = 1, #mode do
      local m = utils.modeValidate(mode[i])
      utils.ctl(mapcmd, { m, configStr .. " " .. cmd })
    end
  elseif type(mode) == "string" then
    local m = utils.modeValidate(mode)
    utils.ctl(mapcmd, { m, configStr .. " " .. cmd })
  end
end

M.Map = function(mode, configExp, cmd)
  generalMapFunction("map", mode, configExp, cmd)
end
M.MapPointer = function (mode, configExp, cmd)
  generalMapFunction("map-pointer", mode, configExp, cmd)
end


return M
