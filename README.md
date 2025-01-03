`git clone https://github.com/N7Art/rnvim`

-- ~/.config/river/init
#!/usr/bin/env lua

package.path = package.path .. ";" .. os.getenv("HOME") .. "/.config/river/rnvim/?.lua"
require "rnvim"
