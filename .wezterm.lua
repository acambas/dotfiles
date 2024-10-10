-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.color_scheme = "rose-pine-moon"
config.hide_tab_bar_if_only_one_tab = true
config.audible_bell = "Disabled"
config.keys = {
	-- { key = "LeftArrow", mods = "OPT", action = wezterm.action({ SendString = "\x1bb" }) },
	-- { key = "RightArrow", mods = "OPT", action = wezterm.action({ SendString = "\x1bf" }) },
	-- { mods = "CMD", key = "LeftArrow",  action = wezterm.action.SendKey({ mods = "CTRL", key = "a" }) },
	{ mods = "CMD", key = "RightArrow", action = wezterm.action.SendKey({ mods = "CTRL", key = "e" }) },
	{ mods = "CMD", key = "Backspace", action = wezterm.action.SendKey({ mods = "CTRL", key = "u" }) },
	{ mods = "OPT", key = "LeftArrow", action = wezterm.action.SendKey({ mods = "ALT", key = "b" }) },
	{ mods = "OPT", key = "RightArrow", action = wezterm.action.SendKey({ mods = "ALT", key = "f" }) },

	{ mods = "CMD", key = "h", action = wezterm.action.SendKey({ key = "LeftArrow" }) },
	{ mods = "CMD", key = "j", action = wezterm.action.SendKey({ key = "DownArrow" }) },
	{ mods = "CMD", key = "k", action = wezterm.action.SendKey({ key = "UpArrow" }) },
	{ mods = "CMD", key = "l", action = wezterm.action.SendKey({ key = "RightArrow" }) },
}
config.font = wezterm.font("JetBrainsMono Nerd Font Mono")

config.window_padding = {
	left = 15,
	right = 15,
	top = 5,
	bottom = 5,
}
config.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }
config.send_composed_key_when_left_alt_is_pressed = false
config.send_composed_key_when_right_alt_is_pressed = false
config.window_decorations = "RESIZE"
config.window_background_opacity = 0.95
-- and finally, return the configuration to wezterm
return config
