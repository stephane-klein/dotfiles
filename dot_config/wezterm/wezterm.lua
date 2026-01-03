local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.leader = { mods = "CTRL", key = "b"  }

require("plugins.wez-tmux.plugin").apply_to_config(config, {})

return config
