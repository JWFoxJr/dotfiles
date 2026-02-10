local wezterm = require("wezterm")
local act = wezterm.action
local config = wezterm.config_builder()

-- 🧊 Make it look cool
config.window_background_opacity = 0.8
config.macos_window_background_blur = 20
config.hide_tab_bar_if_only_one_tab = true

-- 🪟 Basic chrome
config.color_scheme = "Catppuccin Mocha"
config.window_decorations = "TITLE | RESIZE"

-- 🖋 Fonts (simple = cheaper)
config.font = wezterm.font("Hack Nerd Font")
config.font_size = 16

-- 🪟 Window settings
config.initial_cols = 150
config.initial_rows = 50
wezterm.on("gui-startup", function(cmd)
	local tab, pane, window = wezterm.mux.spawn_window(cmd or {})
	local gui_window = window:gui_window()
	gui_window:set_position(150, 100)
end)

return config
