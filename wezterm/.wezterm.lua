local wezterm = require("wezterm")
local act = wezterm.action
local config = wezterm.config_builder()

-- 🧊 Make it look cool
config.window_background_opacity = 0.8
config.macos_window_background_blur = 20
config.hide_tab_bar_if_only_one_tab = false

-- 🪟 Basic chrome
config.color_scheme = "Catppuccin Mocha"
config.window_decorations = "TITLE | RESIZE"

-- 🖋 Fonts (simple = cheaper)
config.font = wezterm.font("Hack Nerd Font")
config.font_size = 16
config.adjust_window_size_when_changing_font_size = false

-- ---- Dynamic font via DPI, debounced ----
local pending_token_by_window = {}
local last_applied_dpi_by_window = {}

local function desired_font_for_dpi(dpi)
	-- Your known good values from debug:
	-- MBP: dpi=144 -> 16
	-- Z24: dpi-72  -> 10
	if dpi and dpi >= 120 then
		return 16.0
	end
	return 10.0
end

local function schedule_apply(window)
	local wid = window:window_id()
	local dims = window:get_dimensions()
	local dpi = dims.dpi

	-- If we already applied for this dpi, do nothing
	if last_applied_dpi_by_window[wid] == dpi then
		return
	end

	-- Token cancels older scheduled applies
	local token = (pending_token_by_window[wid] or 0) + 1
	pending_token_by_window[wid] = token

	wezterm.time.call_after(0.25, function()
		-- If another schedule happened, abandon this one
		if pending_token_by_window[wid] ~= token then
			return
		end

		-- Recheck dpi after setting
		local now = window:get_dimensions()
		local now_dpi = now.dpi
		if now_dpi ~= dpi then
			return
		end

		local desired = desired_font_for_dpi(now_dpi)
		local overrides = window:get_config_overrides() or {}

		if overrides.font_size ~= desired then
			overrides.font_size = desired
			window:set_config_overrides(overrides)
		end

		last_applied_dpi_by_window[wid] = now_dpi
	end)
end

-- Use update-status (recommended) rather than update-right-status
wezterm.on("update-status", function(window, _pane)
	schedule_apply(window)

	-- Optional debug:
	local d = window:get_dimensions()
	local eff = window:effective_config()
	local o = window:get_config_overrides() or {}
	window:set_right_status(
		string.format("dpi=%s | eff=%.1f | ov=%s", tostring(d.dpi), eff.font_size or -1, tostring(o.font_size))
	)
end)

wezterm.on("window-resized", function(window, _pane)
	schedule_apply(window)
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
