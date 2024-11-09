local wezterm = require 'wezterm'
local act = wezterm.action

local config = wezterm.config_builder()

config.color_scheme = 'catppuccin-frappe'
-- config.hide_tab_bar_if_only_one_tab = true
config.font = wezterm.font_with_fallback {'JetBrains Mono', 'Fira Code'}
config.font_size = 16.5
config.line_height = 1.0
config.pane_focus_follows_mouse = true
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}

-- local SOLID_LEFT_ARROW = wezterm.nerdfonts.pl_right_hard_divider
-- local SOLID_RIGHT_ARROW = wezterm.nerdfonts.pl_left_hard_divider

wezterm.on('update-right-status', function(window, pane)
  local tty = pane:get_tty_name() or "unknown"

  window:set_right_status(
    pane:get_title() ..
    " < " ..
    tty ..
    " < " ..
    window:active_workspace()
  )
end)

wezterm.on('format-tab-title', function(tab, tabs, tabconfig, hover, max_width)
  local ok, err = pcall(function ()
    return tab.active_pane.current_working_dir .. " " .. tab.active_pane.title;
  end);

  if not ok then
    wezterm.log_error(err)
  end
end)

config.leader = { key = 'Space', mods = 'CTRL', timeout_milliseconds = 1000 }

config.keys = {
  -- Delete a word
  {
    key = 'Backspace',
    mods = 'CTRL',
    action = wezterm.action.SendKey { mods = 'CTRL', key = 'w' },
  },
  -- Move word left
  {
    key = 'LeftArrow',
    mods = 'OPT',
    action = wezterm.action.SendString '\x1bb'
  },
  -- Move word right
  {
    key = 'RightArrow',
    mods = 'OPT',
    action = wezterm.action.SendString '\x1bf'
  },
  {
    key = '|',
    mods = 'LEADER',
    action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
  },
  {
    key = '-',
    mods = 'LEADER',
    action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
  },
  {
    key = 't',
    mods = 'LEADER',
    action = act.SpawnTab 'CurrentPaneDomain',
  },
  {
    key = 'r',
    mods = 'LEADER',
    action = wezterm.action.ReloadConfiguration,
  },
  {
    key = 'z',
    mods = 'LEADER',
    action = wezterm.action.TogglePaneZoomState,
  },
  -- Send "CTRL-K" to the terminal when pressing CTRL-K, CTRL-K
  {
    key = 'k',
    mods = 'LEADER|CTRL',
    action = wezterm.action.SendKey { key = 'k', mods = 'CTRL' },
  },
  {
    key = 'e',
    mods = 'CMD',
    action = wezterm.action.SendKey { key = 'e', mods = 'CMD' },
  },
  {
    key = 'h',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.ActivatePaneDirection 'Left'
  },
  {
    key = 'j',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.ActivatePaneDirection 'Down'
  },
  {
    key = 'k',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.ActivatePaneDirection 'Up'
  },
  {
    key = 'l',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.ActivatePaneDirection 'Right'
  },
  {
    key = 'T',
    mods = 'CTRL|SHIFT',
    action = act.PromptInputLine {
      description = 'Enter new name for tab',
      action = wezterm.action_callback(function(window, pane, line)
        -- line will be `nil` if they hit escape without entering anything
        -- An empty string if they just hit enter
        -- Or the actual line of text they wrote
        if line then
          window:active_tab():set_title(line)
        end
      end),
    },
  },
  {
    key = 'w',
    mods = 'LEADER',
    action = act.ShowLauncherArgs {
      flags = 'FUZZY|WORKSPACES',
    },
  },
  -- Prompt for a name to use for a new workspace and switch to it.
  {
    key = 'c',
    mods = 'LEADER',
    action = act.PromptInputLine {
      description = wezterm.format {
        { Attribute = { Intensity = 'Bold' } },
        { Foreground = { AnsiColor = 'Fuchsia' } },
        { Text = 'Enter name for new workspace' },
      },
      action = wezterm.action_callback(function(window, pane, line)
        -- line will be `nil` if they hit escape without entering anything
        -- An empty string if they just hit enter
        -- Or the actual line of text they wrote
        if line then
          window:perform_action(
            act.SwitchToWorkspace {
              name = line,
            },
            pane
          )
        end
      end),
    },
  },
}

return config
