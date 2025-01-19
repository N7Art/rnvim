local M = {}

-- map function
--
-- map('n', '<C-a>', 'spawn kitty')
--
local utils = require("utils")
local generalMapFunction = function(mapcmd, mode, configExp, cmd)
	local configStr = utils.getConfigStr(configExp)

	if type(cmd) == "function" then
		local res = cmd()
		--function not returning?
		if type(res) == "nil" then
			cmd = "None"
		end
		if type(res) == "string" then
			cmd = res
		end
	end
	if type(cmd) == "nil" then
		cmd = "None"
	end

	if type(mode) == "table" then
		--TODO: make modes overlapping, not overriding
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
M.MapPointer = function(mode, configExp, cmd)
	generalMapFunction("map-pointer", mode, configExp, cmd)
end

return M
