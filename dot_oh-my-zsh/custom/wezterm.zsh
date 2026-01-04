__my_git_branch_precmd() {
  local branch=$(git branch --show-current 2>/dev/null || echo "")
  __wezterm_set_user_var "GIT_BRANCH" "$branch"
}

precmd_functions+=(__my_git_branch_precmd)
