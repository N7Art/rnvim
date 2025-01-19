#!/usr/bin/env lua

if not package.loaded["rnvim"] then
	package.path = package.path .. ";" .. os.getenv("HOME") .. "/.config/river/rnvim/rnvim.lua"
end
local sh = os.execute
while true do
	local rnvim = require("rnvim")
	local mode = rnvim.getCurMode()
	print(mode)
	sh("sleep 1")
end
