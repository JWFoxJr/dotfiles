-- Pull in wezterm API
local wezterm = require("wezterm")
local mux = wezterm.mux -- <<< add this

-- This will hold the configuration
local config = wezterm.config_builder and wezterm.config_builder() or {}

-- Theme & font
config.color_scheme = "Catppuccin Mocha"
config.font = wezterm.font("Hack Nerd Font")
config.font_size = 12
config.enable_tab_bar = false
config.window_decorations = "TITLE | RESIZE"
config.window_background_opacity = 0.8
--config.scrollback_lines = 100000000

-- Lay out panes on GUI startup
wezterm.on("gui-startup", function(cmd)
	local tab, pane, window = mux.spawn_window(cmd or {})

	-- split to create a right-hand pane (30% of width)
	--  local right = pane:split{ direction = "Right", size = 0.30 }

	-- split the right pane horizontally to make a bottom-right pane (50% of right pane height)
	--  right:split{ direction = "Bottom", size = 0.50 }

	window:gui_window():maximize()
end)

return config
