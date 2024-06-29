-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
-- config.color_scheme = 'AdventureTime'

config.window_background_opacity = 0.8

config.font = wezterm.font_with_fallback {
  'Intel One Mono',
}
config.font_rules = {
	{
		italic = true,
		font = wezterm.font {
			family = 'Intel One Mono',
			style = 'Italic',
		}

	},
	{
		intensity = 'Bold',
		font = wezterm.font {
			family = 'Intel One Mono',
			weight = 'Bold',
		}
	},
	{
		intensity = 'Bold',
		italic = true,
		font = wezterm.font {
			family = 'Intel One Mono',
			weight = 'Bold',
			style = 'Italic',
		}
	},
}
-- Leader is the same as my old tmux prefix
config.leader = { key = 'b', mods = 'CTRL', timeout_milliseconds = 1000 }
-- tmux key bindings
local act = wezterm.action
config.keys = {
	-- splitting
	{
		mods   = "LEADER|SHIFT",
		key    = '"',
		action = act.SplitVertical({ domain = 'CurrentPaneDomain' }),
	},
	{
		mods   = "LEADER|SHIFT",
		key    = "%",
		action = act.SplitHorizontal({ domain = 'CurrentPaneDomain' }),
	},
	{
		mods = "LEADER",
		key = "Space",
		action = act.RotatePanes "Clockwise"
	},
	{
		mods = 'LEADER',
		key = 'x',
		action = act.CloseCurrentPane { confirm = false },
	},
	{ 
		mods = 'LEADER',
		key = 'c',
		action = act.SpawnTab 'CurrentPaneDomain',
	},  
	{
		mods = 'LEADER|SHIFT',
		key = '&',
		action = act.CloseCurrentTab { confirm = true },
	}, 
	{
		mods = 'LEADER',
		key = 'm',
		action = act.TogglePaneZoomState
	},
	{
		mods = 'LEADER',
		key = 'o',
		action = act.PaneSelect
	}, 
	{
		mods = 'LEADER',
		key = 'n',
		action = act.ActivateTabRelative(1),
	},
	{
		mods = 'LEADER',
		key = 'p',
		action = act.ActivateTabRelative(-1),
	},
}

-- and finally, return the configuration to wezterm
return config
