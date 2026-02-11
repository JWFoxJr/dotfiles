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

-- ---------------------------
-- Dynamic font sizing by *screen the window is on* (bulletproof)
-- ---------------------------

local function point_in_rect(px, py, r)
	return px >= r.x and px < (r.x + r.width) and py >= r.y and py < (r.y + r.height)
end

local function get_window_top_left(gui_window)
	-- gui_window:get_position() isn't documented on wezterm.org, so guard it.
	local ok, x, y = pcall(function()
		return gui_window:get_position()
	end)
	if ok and type(x) == "number" and type(y) == "number" then
		return x, y
	end
	return nil, nil
end

local function screen_for_window(window)
	local gui = wezterm.gui
	if not gui then
		return nil
	end

	local screens = gui.screens()
	if not screens or #screens == 0 then
		return nil
	end

	local gui_window = window:gui_window()
	if not gui_window then
		return nil
	end

	local x, y = get_window_top_left(gui_window)
	if not x or not y then
		return nil
	end

	local dims = window:get_dimensions()
	local cx = x + (dims.pixel_width / 2)
	local cy = y + (dims.pixel_height / 2)

	for _, s in ipairs(screens) do
		if point_in_rect(cx, cy, s) then
			return s
		end
	end

	return nil
end

local function font_size_for_screen(screen, window)
	-- You can key off screen.name, screen.width/height, or window:get_dimensions().dpi
	-- screen has x/y/width/height and name.  :contentReference[oaicite:3]{index=3}
	-- window:get_dimensions() has dpi.          :contentReference[oaicite:4]{index=4}

	-- Example buckets based on the *screen bounds* (not window size):
	local w = screen.width
	local h = screen.height

	-- 4K-ish
	if (w >= 3800) or (h >= 2100) then
		return 16.0
	end

	-- 1440p-ish
	if (w >= 2500) or (h >= 1400) then
		return 15.0
	end

	-- 1080p-ish and below
	return 14.0
end

local function apply_dynamic_font(window)
	local overrides = window:get_config_overrides() or {}

	local screen = screen_for_window(window)
	local desired

	if screen then
		desired = font_size_for_screen(screen, window)
	else
		-- Fallback: use DPI if we couldn't resolve position/screen
		local dims = window:get_dimensions()
		local dpi = dims.dpi or 96
		desired = (dpi >= 150) and 16.0 or 14.0
	end

	if overrides.font_size ~= desired then
		overrides.font_size = desired
		window:set_config_overrides(overrides)
	end
end

-- Use update-status (recommended) rather than update-right-status
wezterm.on("update-status", function(window, _pane)
	apply_dynamic_font(window)
end)

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
