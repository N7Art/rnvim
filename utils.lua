local sh = os.execute
local M = {}

M.sh = sh
local rnvim = require("rnvim")
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
	if str == "n" then
		return rnvim.Modes.normal
	end
end
-- translates expression to string
M.getConfigStr = function(configExp)
	if configExp == "" then
		return configExp
	end
	local e = require("stringfmt").evaluateConfigExpr(configExp)

	local key = e.key
	local mods = e.mods
	local modstr = ""

	for _, mod in pairs(mods) do
		modstr = modstr .. mod .. "+"
	end
	-- stripping last '+'
	modstr = string.sub(modstr, 1, #modstr - 1)
	local out = modstr .. " " .. key

	return out
end


return M
