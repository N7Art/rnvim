package.path = package.path .. ";" .. os.getenv("HOME") .. "/.config/river/rnvim/?.lua"
local M = {}
M.Modes = { normal = "normal", insert = "insert" }
M.Mods = {
  super = "Super",
  alt = "Alt",
  ctrl = "Control",
  shift = "Shift",
  mod3 = "Mod3",
  mod5 = "Mod5",
  none = "None",
}

local leader = M.Mods.super
local currentMode = M.Modes.normal

local windowsNumber = 0

M.setLeader = function(mod)
  if type(mod) ~= M.Mods then
    print("rnvim: setLeader: err")
    return
  end
  leader = mod
end

M.getLeader = function()
  return leader
end

M.setCurMode = function(mode)
  if type(mode) ~= M.Modes then
    print("rnvim: setCurMode: err")
    return
  end
  M.currentMode = mode
end

M.getCurMode = function()
  return currentMode
end

return M
