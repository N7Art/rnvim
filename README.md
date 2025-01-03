```git clone https://github.com/N7Art/rnvim```
```lua
-- ~/.config/river/init
#!/usr/bin/env lua

package.path = package.path .. ";" .. os.getenv("HOME") .. "/.config/river/rnvim/?.lua"
require "rnvim"

local ctl = require("utils").ctl
local map = require("riverctl").Map

map("n", "<leader>\'", "spawn $TERMINAL")
```
