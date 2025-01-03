local M = {}

-- map function
--
-- map('n', '<C-a>', 'spawn kitty')
--
local utils = require("utils")
M.Map = function(mode, configExp, cmd)
  local configStr = utils.getConfigStr(configExp)

  if type(mode) == "table" then
    for i = 1, #mode do
      local m = utils.modeValidate(mode[i])
      utils.ctl("map ", { m, configStr .. " " .. cmd })
    end
  elseif type(mode) == "string" then
    local m = utils.modeValidate(mode)
    utils.ctl("map ", { m, configStr .. " " .. cmd })
  end
end

return M
