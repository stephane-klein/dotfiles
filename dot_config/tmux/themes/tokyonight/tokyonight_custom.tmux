set -g pane-border-status off
set -g pane-border-format " #{pane_title} "

setw -g window-status-format "#[fg=#1f2335,bg=#1f2335,nobold,nounderscore,noitalics]#[default] #{?window_name,#{window_name},#{b:pane_current_path}} #[fg=#1f2335,bg=#1f2335,nobold,nounderscore,noitalics]"
setw -g window-status-current-format "#[fg=#1f2335,bg=#3b4261,nobold,nounderscore,noitalics]#[fg=#7aa2f7,bg=#3b4261,bold] #{?window_name,#{window_name},#{b:pane_current_path}} #[fg=#3b4261,bg=#1f2335,nobold,nounderscore,noitalics]"
