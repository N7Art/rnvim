local sh = os.execute
local M = {}

--[[

leader = Mods.super
"<leader>a" = {mods = {Mods.super}, key = "a"}
"<leader>A" =  {mods = {Mods.super, Mods.shift}, key = "a"}


"leader" = {Mods.super, Mods.alt}
"<leader>a" = {mods = {Mods.super,Mods.alt}, key = "a"}
"<leader>A" =  {mods = {Mods.super, Mods.alt, Mods.shift}, key = "a"}


global leader is reqired
--]]

M.modeValidate = function(str)
  if str == 'n' then
   return Modes.normal 
  end
end
-- translates expression to string
M.getConfigStr = function(configExp)
  local e =  require("stringfmt").evaluateConfigExpr(configExp)

  local key = e.key
  local mods = e.mods
  local modstr = ''

  for _, mod in pairs(mods) do
    modstr = modstr .. mod .. "+"
  end
  -- stripping last '+'
  modstr = string.sub(modstr, 1, #modstr - 1)
  local out = modstr .. ' ' .. key

  return out
end

-- "riverctl [options] command [command specific arguments]"
M.ctl = function(command, args)
  if type(args) ~= "table" and type(args) ~= "string" then
    return 1
  end
  if type(args) == "string" then
    sh("riverctl " .. command .. " " .. args)
  else
    local res = " "
    for i = 1, #args do
      res = res .. args[i] .. " "
    end
    sh("riverctl " .. command .. res)
  end
end

return M
