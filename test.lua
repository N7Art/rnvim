#!/usr/bin/env lua
package.path = package.path .. ";" .. os.getenv("HOME") .. "/.config/river/rnvim/?.lua"
local rnvim = require "rnvim"

local ctl = require("riverctl").ctl
local map = require("riverctl").Map
local close = require("riverctl").close
local mapPointer = require("riverctl").MapPointer
local mapSwitch = require("riverctl").MapSwitch

rnvim.setLeader(rnvim.Mods.super)


os.execute("riverctl spawn \"notify-send 'os.execute -> hehe'\"")

ctl("spawn", "notify-send 'ctl -> hehe'")
--

mapSwitch("n", "lid", "close", "spawn 'swaylock -f -c 000000'")

