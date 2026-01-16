local M = {}

local utils = require("utils")

-- actions

-- Close the focused view.
M.close = function()
	utils.ctl("close")
	--return "close"
end

-- map function
-- usage:
-- map('n', '<C-a>', 'spawn kitty')
local generalMapFunction = function(mapcmd, mode, configExp, cmd)
	local configStr = utils.getConfigStr(configExp)

	if type(cmd) == "function" then
		-- execute and return result if function
		local res = cmd()
		--function not returning?
		if type(res) == "nil" then
			cmd = 'spawn lua -e "' .. cmd .. '()"'
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
		local m = utils.modeValidate(mode)
end

M.Map = function(mode, configExp, cmd)
	generalMapFunction("map", mode, configExp, cmd)
end

M.MapPointer = function(mode, configExp, cmd)
	generalMapFunction("map-pointer", mode, configExp, cmd)
end

-- adds arguments for map-switch to cmd not to configExp
-- configExp is empty
M.MapSwitch = function(mode, lidOrTablet, state, cmd)
	if type(lidOrTablet) ~= "string" then
		print("error: in MapSwitch function, variable 'lidOrTablet' is not string type")
		return
	end

	lidOrTablet = lidOrTablet:lower()

	if lidOrTablet ~= "lid" and lidOrTablet ~= "tablet" then
		print("error: in MapSwitch function, unknown value '" .. lidOrTablet .. "' of variable 'lidOrTablet'")
		return
	end

	if type(state) ~= "string" then
		print("error: in MapSwitch function, variable 'state' is not string type")
		return
	end

	state = state:lower()

	if state ~= "close" and state ~= "open" and state ~= "on" and state ~= "off" then
		print("error: in MapSwitch function, unknown value '" .. state .. "' of variable 'state'")
		return
	end

	if lidOrTablet == "lid" and (state == "on" or state == "off") then
		print("error: in MapSwitch function, wrong value '" .. state .. "' for " .. lidOrTablet)
		return
	end

	if lidOrTablet == "tablet" and (state == "open" or state == "close") then
		print("error: in MapSwitch function, wrong value '" .. state .. "' for " .. lidOrTablet)
		return
	end

	cmd =  lidOrTablet .. " " .. state .. " " .. cmd
	generalMapFunction("map-switch", mode, '', cmd)
end

return M
