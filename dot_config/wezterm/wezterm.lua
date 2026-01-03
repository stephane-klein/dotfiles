local wezterm = require 'wezterm'
local act = wezterm.action

-- Fullscreen au démarrage
wezterm.on('gui-startup', function(cmd)
  local tab, pane, window = wezterm.mux.spawn_window(cmd or {})
  window:gui_window():toggle_fullscreen()
end)

-- Fonction pour obtenir la branche git
local function get_git_branch(cwd)
  if not cwd then return '' end
  
  local success, stdout, stderr = wezterm.run_child_process({
    'git',
    '-C',
    cwd,
    'branch',
    '--show-current'
  })
  
  if success and stdout and stdout ~= '' then
    return ' ' .. stdout:gsub('\n', '')
  end
  return ''
end

-- Fonction pour obtenir CPU et RAM sur Linux
local function get_system_info()
  local info = ''
  
  -- CPU usage sur Linux
  local cpu_success, cpu_stdout = wezterm.run_child_process({
    'sh',
    '-c',
    "top -bn1 | grep 'Cpu(s)' | awk '{print $2}' | cut -d'%' -f1"
  })
  
  if cpu_success and cpu_stdout and cpu_stdout ~= '' then
    local cpu = cpu_stdout:gsub('\n', '')
    info = '💻 ' .. cpu .. '%'
  end
  
  -- RAM usage sur Linux
  local ram_success, ram_stdout = wezterm.run_child_process({
    'sh',
    '-c',
    "free | grep Mem | awk '{print int($3/$2 * 100)}'"
  })
  
  if ram_success and ram_stdout and ram_stdout ~= '' then
    local ram = ram_stdout:gsub('\n', '')
    if info ~= '' then info = info .. ' ' end
    info = info .. '🧠 ' .. ram .. '%'
  end
  
  return info
end

-- Mettre à jour la barre de statut
wezterm.on('update-status', function(window, pane)
  -- Leader key actif ?
  local leader = ''
  if window:leader_is_active() then
    leader = '🔴 LEADER | '
  end
  
  -- Répertoire courant
  local cwd = pane:get_current_working_dir()
  local cwd_path = ''
  local cwd_str = ''
  if cwd then
    cwd_str = cwd.file_path
    cwd_path = cwd_str:gsub(os.getenv('HOME'), '~')
  end
  
  -- Branche git
  local git_branch = get_git_branch(cwd_str)
  
  -- User et hostname
  local user = os.getenv('USER') or 'user'
  local hostname_success, hostname_stdout = wezterm.run_child_process({'hostname', '-s'})
  local hostname = 'localhost'
  if hostname_success and hostname_stdout then
    hostname = hostname_stdout:gsub('\n', '')
  end
  
  -- Indicateur de zoom
  local zoom = ''
  local tab = pane:tab()
  if tab then
    for _, p in ipairs(tab:panes()) do
      if p:is_zoomed() then
        zoom = '🔍 ZOOM | '
        break
      end
    end
  end
  
  -- Infos système (CPU/RAM)
  local system_info = get_system_info()
  
  -- Heure
  local time = wezterm.strftime('%H:%M')
  
  -- Composition de la barre
  window:set_right_status(wezterm.format {
    { Text = leader },
    { Text = zoom },
    { Text = '👤 ' .. user .. '@' .. hostname .. ' | ' },
    { Text = '📁 ' .. cwd_path },
    { Text = git_branch },
    { Text = ' | ' },
    { Text = system_info },
    { Text = ' | ' },
    { Text = '🕐 ' .. time .. ' ' },
  })
end)

return {
  -- Apparence
  font = wezterm.font 'JetBrains Mono',
  font_size = 13.0,
  color_scheme = 'Catppuccin Mocha',
  
  -- Barre en haut
  tab_bar_at_bottom = false,
  hide_tab_bar_if_only_one_tab = false,
  use_fancy_tab_bar = false,
  tab_max_width = 32,
  
  -- Désactiver les décorations système mais garder la barre de tabs
  window_decorations = "RESIZE",
  
  -- Mise à jour automatique de la barre de statut toutes les secondes
  status_update_interval = 1000,
  
  -- Couleurs de la barre
  colors = {
    tab_bar = {
      background = '#1e1e2e',
      active_tab = {
        bg_color = '#89b4fa',
        fg_color = '#1e1e2e',
        intensity = 'Bold',
      },
      inactive_tab = {
        bg_color = '#45475a',
        fg_color = '#cdd6f4',
      },
      inactive_tab_hover = {
        bg_color = '#585b70',
        fg_color = '#cdd6f4',
      },
    },
  },
  
  leader = { key = 'b', mods = 'CTRL', timeout_milliseconds = 1000 },
  
  keys = {
    -- Splits
    {
      key = '%',
      mods = 'LEADER',
      action = act.SplitHorizontal { domain = 'CurrentPaneDomain' },
    },
    {
      key = '"',
      mods = 'LEADER',
      action = act.SplitVertical { domain = 'CurrentPaneDomain' },
    },
    
    -- Navigation flèches
    {
      key = 'LeftArrow',
      mods = 'LEADER',
      action = act.ActivatePaneDirection 'Left',
    },
    {
      key = 'RightArrow',
      mods = 'LEADER',
      action = act.ActivatePaneDirection 'Right',
    },
    {
      key = 'UpArrow',
      mods = 'LEADER',
      action = act.ActivatePaneDirection 'Up',
    },
    {
      key = 'DownArrow',
      mods = 'LEADER',
      action = act.ActivatePaneDirection 'Down',
    },
    
    -- Navigation tabs
    {
      key = 'n',
      mods = 'LEADER',
      action = act.ActivateTabRelative(1),
    },
    {
      key = 'p',
      mods = 'LEADER',
      action = act.ActivateTabRelative(-1),
    },
    
    -- Zoom
    {
      key = 'z',
      mods = 'LEADER',
      action = act.TogglePaneZoomState,
    },
    
    -- Nouveau tab
    {
      key = 'c',
      mods = 'LEADER',
      action = act.SpawnTab 'CurrentPaneDomain',
    },
    
    -- Mode copie
    {
      key = '[',
      mods = 'LEADER',
      action = act.ActivateCopyMode,
    },
    
    -- Coller
    {
      key = ']',
      mods = 'LEADER',
      action = act.PasteFrom 'Clipboard',
    },
    
    -- Renommer tab
    {
      key = ',',
      mods = 'LEADER',
      action = act.PromptInputLine {
        description = 'Nouveau nom du tab:',
        action = wezterm.action_callback(function(window, pane, line)
          if line then
            window:active_tab():set_title(line)
          end
        end),
      },
    },
    
    -- Toggle fullscreen
    {
      key = 'f',
      mods = 'LEADER',
      action = act.ToggleFullScreen,
    },
  },
  
  key_tables = {
    copy_mode = {
      { key = 'LeftArrow', mods = 'NONE', action = act.CopyMode 'MoveLeft' },
      { key = 'RightArrow', mods = 'NONE', action = act.CopyMode 'MoveRight' },
      { key = 'UpArrow', mods = 'NONE', action = act.CopyMode 'MoveUp' },
      { key = 'DownArrow', mods = 'NONE', action = act.CopyMode 'MoveDown' },
      { key = 'PageUp', mods = 'NONE', action = act.CopyMode 'PageUp' },
      { key = 'PageDown', mods = 'NONE', action = act.CopyMode 'PageDown' },
      { key = 'Home', mods = 'NONE', action = act.CopyMode 'MoveToStartOfLine' },
      { key = 'End', mods = 'NONE', action = act.CopyMode 'MoveToEndOfLineContent' },
      { key = 'v', mods = 'NONE', action = act.CopyMode{ SetSelectionMode = 'Cell' } },
      { key = 'V', mods = 'SHIFT', action = act.CopyMode{ SetSelectionMode = 'Line' } },
      {
        key = 'y',
        mods = 'NONE',
        action = act.Multiple {
          { CopyTo = 'ClipboardAndPrimarySelection' },
          { CopyMode = 'Close' },
        },
      },
      {
        key = 'Enter',
        mods = 'NONE',
        action = act.Multiple {
          { CopyTo = 'ClipboardAndPrimarySelection' },
          { CopyMode = 'Close' },
        },
      },
      { key = 'q', mods = 'NONE', action = act.CopyMode 'Close' },
      { key = 'Escape', mods = 'NONE', action = act.CopyMode 'Close' },
      { key = '/', mods = 'NONE', action = act.Search 'CurrentSelectionOrEmptyString' },
      { key = 'n', mods = 'NONE', action = act.CopyMode 'NextMatch' },
      { key = 'N', mods = 'SHIFT', action = act.CopyMode 'PriorMatch' },
    },
    search_mode = {
      { key = 'Enter', mods = 'NONE', action = act.CopyMode 'PriorMatch' },
      { key = 'Escape', mods = 'NONE', action = act.CopyMode 'Close' },
    },
  },
}
