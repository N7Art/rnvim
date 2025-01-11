#!/usr/bin/env lua

package.path = package.path .. ";" .. os.getenv("HOME") .. "/.config/river/?.lua"

local sh = os.execute
local leader = require("rnvim").getLeader()

while true do
	print(leader)
	sh("sleep 1")
end
