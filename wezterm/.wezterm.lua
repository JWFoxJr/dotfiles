local wezterm = require("wezterm")
local act = wezterm.action
local config = wezterm.config_builder()

-- 🧊 Make it look cool
-- config.window_background_opacity = 0.5
-- config.macos_window_background_blur = 20
config.hide_tab_bar_if_only_one_tab = true

-- 🪟 Basic chrome
config.color_scheme = "Catppuccin Mocha"
config.window_decorations = "TITLE | RESIZE"

-- 🖋 Fonts (simple = cheaper)
config.font = wezterm.font("JetBrainsMono Nerd Font")
config.font_size = 16

-- ---------------------------
-- Dynamic font sizing by display
-- ---------------------------
local function font_size_for_window(window)
	local dims = window:get_dimensions()
	-- dims.pixel_width / pixel_height exist across platforms
	local pw = dims.pixel_width
	local ph = dims.pixel_height

	-- Tune these to taste.
	-- Example: 4K-ish external monitor
	-- (window large enough that it could only comfortably exist on 4K/Retina)
	if (pw >= 3000) or (ph >= 1800) then
		return 16.0
	end

	-- Example: 1440p-ish
	if (pw >= 2000) or (ph >= 1200) then
		return 15.0
	end

	-- 1080p-ish and below
	return 14.0
end

local function apply_dynamic_font(window)
	local overrides = window:get_config_overrides() or {}
	local desired = font_size_for_window(window)

	if not desired then
		return
	end

	if overrides.font_size ~= desired then
		overrides.font_size = desired
		window:set_config_overrides(overrides)
	end
end

-- Fires frequently; good for catching window moves across monitors
wezterm.on("update-right-status", function(window, _pane)
	apply_dynamic_font(window)
end)

-- Also catch resizes (handy, and it fires when macOS changes scaling)
wezterm.on("window-resized", function(window, _pane)
	apply_dynamic_font(window)
end)

-- 🪟 Window settings
config.initial_cols = 150
config.initial_rows = 50
wezterm.on("gui-startup", function(cmd)
	local tab, pane, window = wezterm.mux.spawn_window(cmd or {})
	local gui_window = window:gui_window()
	gui_window:set_position(150, 100)

	-- Apply font sizing once at startup too
	apply_dynamic_font(gui_window)
end)

return config
