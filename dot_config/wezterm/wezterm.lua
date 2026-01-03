local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.leader = { mods = "CTRL", key = "b"  }
config.color_scheme = "tokyonight_night"

-- Start in fullscreen
wezterm.on('gui-startup', function(cmd)
  local tab, pane, window = wezterm.mux.spawn_window(cmd or {})
  window:gui_window():toggle_fullscreen()
end)

require("plugins.wez-tmux.plugin").apply_to_config(config, {})

table.insert(
  config.keys,
  {
    key = 'f',
    mods = 'LEADER',
    action = wezterm.action.ToggleFullScreen,
  }
)

return config
