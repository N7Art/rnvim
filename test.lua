package.path = package.path .. ";" .. os.getenv("HOME") .. "/.config/river/rnvim/?.lua"
require "rnvim"
local fmt = require("stringfmt")
local ut = require("utils")

local fn = ut.getConfigStr
local function test(name, data)
  if type(data) == "nil" then
    data = name
  end
  local res = fn(data)
print(res)
end



test("as")
test("<C-a>")
test("<C-A>")
test("<")
test("<CR>a<CR>")
test("<LEADER>a")
test("<leader>A")
test("<leader><CR>")
print()
test("<leader>M")
test(2)
test("<leader> ")
test("<M3-a>")
test("<M5-a>")
test("<leader><C-M-M3-M5-A>")
test("<leader><S-C->")
test("<XF86MonBrightnessDown>")
