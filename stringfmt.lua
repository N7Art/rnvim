local M = {}
M.special = {
  --shif + number
  ['!'] = { key = '1', isUpper = true },
  ['@'] = { key = '2', isUpper = true },
  ['#'] = { key = '3', isUpper = true },
  ['$'] = { key = '4', isUpper = true },
  ['%'] = { key = '5', isUpper = true },
  ['^'] = { key = '6', isUpper = true },
  ['&'] = { key = '7', isUpper = true },
  ['*'] = { key = '8', isUpper = true },
  ['('] = { key = '9', isUpper = true },
  [')'] = { key = '0', isUpper = true },

  -- uniques
  ['-'] = { key = 'minus', isUpper = false },
  ['='] = { key = 'equal', isUpper = false },
  ['['] = { key = '[', isUpper = false },
  [']'] = { key = ']', isUpper = false },
  ['\\'] = { key = 'backslash', isUpper = false },
  [';'] = { key = 'semicolon', isUpper = false },
  ['\''] = { key = 'quoteright', isUpper = false },
  [','] = { key = 'Comma', isUpper = false },
  ['.'] = { key = 'Period', isUpper = false },
  ['/'] = { key = 'slash', isUpper = false },
  [' '] = { key = 'Space', isUpper = false },
  ['`'] = { key = '`', isUpper = false },
  ['<CR>'] = { key = 'Return', isUpper = false },


  --added
['<XF86AUDIORAISEVOLUME>'] = {key = 'XF86AudioRaiseVolume', isUpper = false},
['<XF86AUDIOLOWERVOLUME>'] = {key = 'XF86AudioLowerVolume', isUpper = false},
['<XF86MONBRIGHTNESSUP>'] = {key = 'XF86MonBrightnessUp', isUpper = false},
['<XF86MONBRIGHTNESSDOWN>'] = {key = 'XF86MonBrightnessDown', isUpper = false},
["<BTN_LEFT>"] = {key= "BTN_LEFT", isUpper = false},
["<BTN_RIGHT>"] = {key = "BTN_RIGHT", isUpper = false},
["<BTN_MIDDLE>"] = {key = "BTN_MIDDLE", isUpper = false},


-- repeated but with shift

['_'] = { key = 'minus', isUpper = true },
  ['+'] = { key = 'equal', isUpper = true },
  ['|'] = { key = 'backslash', isUpper = true },
  ['{'] = { key ='[', isUpper = true },
  ['}'] = { key = ']', isUpper = true },
  [':'] = { key = 'semicolon', isUpper = true },
  ['\"'] = { key = "quoteright", isUpper = true },
  ['?'] = { key = 'slash', isUpper = true },
  ['>'] = { key = 'colon', isUpper = true },
  ['<'] = { key = 'semicolon', isUpper = true },
  ['~'] = { key = '`', isUpper = true },
}

M.modsTable = {
  ['M'] = Mods.alt,
  ['C'] = Mods.ctrl,
  ['S'] = Mods.shift,
  ['<SUPER>'] = Mods.super,
  ['<M3>'] = Mods.mod3,
  ['<M5>'] = Mods.mod5,
  ['<LEADER>'] = Leader,
  ['<SHIFT>'] = Mods.shift,

}
M.stringValidate = function(str)
  if type(str) == "nil" then
    return "error: nil"
  end
  if type(str) == "function" then
    return "error: function type expresion"
  end

  if type(str) == "number" then
    str = tostring(str)
  end


  if type(str) == "table" then
    -- for catinating when table whith keys
    if #str == 0 then
      local s = ''
      for _, v in pairs(str) do
        s = s .. v
      end
      str = s
    else
      str = table.concat(str, '')
    end
  end

  if #str == 0 then
    return "error: empty"
  end
  return str
end
M.keyValidate = function(key)
  local special = M.special
  local checkUpper = function()
    local up = key:upper()
    if type(tonumber(key)) ~= "nil" then
      return false
    end
    return key == up
  end

  local isUpper = checkUpper()
  local specialKey = special[key]

  if specialKey then
    return { key = specialKey.key, isUpper = specialKey.isUpper }
  else
    key = key:upper()
  end

  return { key = key, isUpper = isUpper }
end

M.evaluateConfigExpr = function(str)
  str = M.stringValidate(str)
  -- modifire index strart/end

  local res = { mods = { Mods.none }, key = '' }

  --                                 "<C-a>"
  --                                 "^...^"
  local handle_block = function(b_start, b_end)
    --TODO:handle nil for <leader>

    local token = str:sub(b_start, b_end)
    local tokenSpecialKey = M.special[string.upper(token)]
    local modToken = M.modsTable[string.upper(token)]

    if tokenSpecialKey then
      res.key = tokenSpecialKey.key
      if tokenSpecialKey.isUpper then
        table.insert(res.mods, Mods.shift)
      end
    elseif modToken then
      table.insert(res.mods, modToken)
    else
      -- "<C-a>"
      --  .^.^.
      local start = 2
      local stop = #token - 1

      for i = start, stop, 1 do
        local ch = token:sub(i, i)
        local chNext = token:sub(i + 1, i + 1)

        if ch == '-' then
          i = i + 1
        elseif i == stop then
          local validKey = M.keyValidate(ch)
          res.key = validKey.key
          if validKey.isUpper then
            table.insert(res.mods, Mods.shift)
          end
        else
          -- handle M3,M5
          if ch == "M" and chNext ~= '-' then
            -- make ch to table format
            ch = '<' .. ch .. chNext .. '>'
            i = i + 2
          end

          local chInMods = M.modsTable[ch]
          if chInMods then
            table.insert(res.mods, chInMods)
          end
        end
      end
    end
  end
  --read by char
  local i = 1;

  while (i <= #str) do
    local ch = str:sub(i, i)

    if ch == '<' and i ~= #str then
      local block_end = string.find(str, '>', i)
      if block_end then
        handle_block(i, block_end)
        i = block_end
      end
    else
      local validKey = M.keyValidate(ch)
      res.key = validKey.key
      if validKey.isUpper then
        table.insert(res.mods, Mods.shift)
      end
    end
    i = i + 1
  end
  return res
end
return M
