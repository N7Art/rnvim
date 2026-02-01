package.path = package.path .. ";" .. os.getenv("HOME") .. "/.config/river/rnvim/?.lua"
local M = {}
M.Modes = { normal = "normal" }
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

M.setLeader = function(mod)
	if type(mod) ~= M.Mods then
		print("err")
		return
	end
	leader = mod
end

M.getLeader = function()
	return leader
end

return M
