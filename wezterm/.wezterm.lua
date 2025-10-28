local wezterm = require("wezterm")
local act = wezterm.action
local config = wezterm.config_builder()

-- 🧊 Keep it cool
config.front_end = "Software" -- CPU rendering, avoids GPU wakeups
config.animation_fps = 30
config.max_fps = 30
config.window_background_opacity = 0.8
config.macos_window_background_blur = 20
config.use_fancy_tab_bar = false -- simpler tab bar, fewer redraws
config.hide_tab_bar_if_only_one_tab = false

-- 🪟 Basic chrome
config.color_scheme = "Catppuccin Mocha"
config.window_decorations = "TITLE | RESIZE"

-- 🖋 Fonts (simple = cheaper)
config.font = wezterm.font("MonaspiceKR Nerd Font")
config.font_size = 14

wezterm.on("gui-startup", function(cmd)
	local tab, pane, window = wezterm.mux.spawn_window(cmd or {})
	local gui_window = window:gui_window()
	gui_window:toggle_fullscreen()
end)

-- 🔀 Use the WezTerm multiplexer (persists across GUI restarts)
config.unix_domains = { { name = "daily" } }
config.default_domain = "daily"

-- 🎹 Tmux-like keybindings (leader = Ctrl-a)
config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 }
config.keys = {
	-- Splits
	{ key = "-", mods = "LEADER", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
	{ key = "|", mods = "LEADER|SHIFT", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },

	-- Pane nav
	{ key = "h", mods = "LEADER", action = act.ActivatePaneDirection("Left") },
	{ key = "j", mods = "LEADER", action = act.ActivatePaneDirection("Down") },
	{ key = "k", mods = "LEADER", action = act.ActivatePaneDirection("Up") },
	{ key = "l", mods = "LEADER", action = act.ActivatePaneDirection("Right") },

	-- Tabs
	{ key = "c", mods = "LEADER", action = act.SpawnTab("CurrentPaneDomain") },
	{ key = "x", mods = "LEADER", action = act.CloseCurrentPane({ confirm = true }) },
	{ key = "n", mods = "LEADER", action = act.ActivateTabRelative(1) },
	{ key = "p", mods = "LEADER", action = act.ActivateTabRelative(-1) },
	{ key = "z", mods = "LEADER", action = act.TogglePaneZoomState },
	{ key = "s", mods = "LEADER", action = act.ShowTabNavigator },
	{ key = "b", mods = "LEADER", action = wezterm.action.EmitEvent("toggle-blur") },

	-- Workspaces (like tmux sessions)
	{
		key = "w",
		mods = "LEADER",
		action = act.PromptInputLine({
			description = "Workspace name:",
			action = wezterm.action_callback(function(window, pane, line)
				if line and #line > 0 then
					window:perform_action(act.SwitchToWorkspace({ name = line }), pane)
				end
			end),
		}),
	},
}

table.insert(config.keys, {
	key = "a",
	mods = "LEADER|CTRL",
	action = wezterm.action.SendKey({ key = "a", mods = "CTRL" }),
})

-- Show workspace name in window title
wezterm.on("format-window-title", function(tab, pane, tabs, panes, cfg)
	local ws = wezterm.mux.get_active_workspace()
	return string.format("WS: %s — %s", ws, tab.active_pane.title)
end)

-- Show workspace name at right side of tab bar
wezterm.on("update-status", function(window, pane)
	local ws = wezterm.mux.get_active_workspace()
	window:set_right_status("WS: " .. ws)
end)

wezterm.on("toggle-blur", function(window, pane)
	local overrides = window:get_config_overrides() or {}
	if overrides.macos_window_background_blur and overrides.macos_window_background_blur > 0 then
		overrides.macos_window_background_blur = 0
		overrides.window_background_opacity = 0.8
	else
		overrides.macos_window_background_blur = 20
		overrides.window_background_opacity = 0.8
	end
	window:set_config_overrides(overrides)
end)

return config
