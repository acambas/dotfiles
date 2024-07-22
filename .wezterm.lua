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
	-- Make Option-Left equivalent to Alt-b which many line editors interpret as backward-word
	{ key = "LeftArrow", mods = "OPT", action = wezterm.action({ SendString = "\x1bb" }) },
	-- Make Option-Right equivalent to Alt-f; forward-word
	{ key = "RightArrow", mods = "OPT", action = wezterm.action({ SendString = "\x1bf" }) },
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
config.window_background_opacity = 0.98
-- and finally, return the configuration to wezterm
return config
