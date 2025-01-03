package.path = package.path .. ";" .. os.getenv("HOME") .. "/.config/river/rnvim/?.lua"
Modes = { normal = 'normal' }
Mods = {
  super = "Super",
  alt = "Alt",
  ctrl = "Control",
  shift = "Shift",
  mod3 = "Mod3",
  mod5 = "Mod5",
  none = "None"
}

Leader = Mods.super


 require("riverctl")
