local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.leader = { mods = "CTRL", key = "b" }
config.color_scheme = "tokyonight_night"

-- Start in fullscreen {{{
wezterm.on('gui-startup', function(cmd)
  local tab, pane, window = wezterm.mux.spawn_window(cmd or {})
  window:gui_window():toggle_fullscreen()
end)
-- }}}

require("plugins.wez-tmux.plugin").apply_to_config(config, {})

-- Init https://github.com/michaelbrusegard/tabline.wez {{{
local tabline = wezterm.plugin.require("https://github.com/michaelbrusegard/tabline.wez")
tabline.setup({
  options = {
    theme = 'Tokyo Night',
    theme_overrides = {
      normal_mode = {
        a = { fg = '#1a1b26', bg = '#7aa2f7', gui = 'bold' },
      },
      copy_mode = {
        a = { fg = '#1a1b26', bg = '#ff9e64', gui = 'bold' },
      },
      search_mode = {
        a = { fg = '#1a1b26', bg = '#bb9af7', gui = 'bold' },
      },
    },
  },
  sections = {
    tabline_a = {
      {
        "mode",
        padding = { left = 1, right = 2 },
        fmt = function(mode, window)
          if window:leader_is_active() then
            return wezterm.nerdfonts.md_keyboard_outline
          elseif mode == "NORMAL" then
            return wezterm.nerdfonts.cod_terminal
          elseif mode == "COPY" then
            return wezterm.nerdfonts.md_scissors_cutting
          elseif mode == "SEARCH" then
            return wezterm.nerdfonts.oct_search
          end

          return mode
        end,
      }
    },
    tabline_b = { 'workspace' },
    tabline_c = { ' ' },
    tab_active = {
      'index',
      { 'cwd', padding = { left = 0, right = 1 } },
      { 'zoomed', padding = 0 },
    },
    tab_inactive = { 'index', { 'cwd', padding = { left = 0, right = 1 } } },
    tabline_x = {},
    tabline_y = { 'ram', 'cpu' },
    tabline_z = { 'hostname' },
  },
})
tabline.apply_to_config(config)
wezterm.log_info('Theme:', tabline.get_theme())
--- }}}

table.insert(
  config.keys,
  {
    key = 'f',
    mods = 'LEADER',
    action = wezterm.action.ToggleFullScreen,
  }
)

return config
