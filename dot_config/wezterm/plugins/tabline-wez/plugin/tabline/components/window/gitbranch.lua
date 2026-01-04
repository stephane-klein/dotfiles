local wezterm = require('wezterm')

return {
  default_opts = {
    icon = wezterm.nerdfonts.dev_git_branch
  },
  update = function(window, opts)
    local pane = window:active_pane()
    if pane then
      local git_branch = pane:get_user_vars().GIT_BRANCH
      if git_branch and git_branch ~= "" then
        return git_branch
      end
    end
    opts.icon = nil
    return ""
  end
}
