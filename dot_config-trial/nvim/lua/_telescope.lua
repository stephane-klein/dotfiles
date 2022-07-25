-- This source code inspiration come from https://github.com/talha-akram/anvil/blob/220e21e46154da965b0ce16b497a0d99355a7570/lua/plugins/telescope.lua#L153
local telescope = require('telescope')
local telescope_builtin = require('telescope.builtin')

vim.cmd([[
    highlight link TelescopePromptCounter TelescopeNormal
    highlight link TelescopeSelection TelescopePromptPrefix
]])

local themes = {
  popup_list = {
    theme = 'popup_list',
    border = true,
    preview = false,
    prompt_title = false,
    results_title = false,
    sorting_strategy = 'ascending',
    layout_strategy = 'center',
    borderchars = {
      prompt  = { '─', '│', '─', '│', '┌', '┐', '┤', '└' },
      results = { '─', '│', '─', '│', '├', '┤', '┘', '└' },
      preview = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
    },
  },
  popup_extended = {
    theme = 'popup_extended',
    prompt_title = false,
    results_title = false,
    layout_strategy = 'center',
    layout_config = {
      width = 0.7,
      height = 0.3,
      mirror = true,
      preview_cutoff = 1,
    },
    borderchars = {
      prompt  = { '─', '│', ' ', '│', '┌', '┐', '│', '│' },
      results = { '─', '│', '─', '│', '├', '┤', '┘', '└' },
      preview = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
    },
  },
  command_pane = {
    theme = 'command_pane',
    preview = false,
    prompt_title = false,
    results_title = false,
    sorting_strategy = 'descending',
    layout_strategy = 'bottom_pane',
    layout_config = {
      height = 13,
      preview_cutoff = 1,
      prompt_position = 'bottom'
    },
  },
  ivy_plus = {
    theme = 'ivy_plus',
    preview = false,
    prompt_title = false,
    results_title = false,
    layout_strategy = 'bottom_pane',
    layout_config = {
      height = 13,
      preview_cutoff = 120,
      prompt_position = 'bottom'
    },
    borderchars = {
      prompt  = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
      results = { '─', '│', '─', '│', '┌', '┬', '┴', '└' },
      preview = { '─', '│', ' ', ' ', '─', '┐', '│', ' ' },
    },
  },
}

telescope.setup({
  defaults = {
    border = true,
    prompt_title = false,
    results_title = false,
    color_devicons = false,
    layout_strategy = 'horizontal',
    borderchars = {
      prompt  = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
      results = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
      preview = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
    },
    layout_config = {
      bottom_pane = {
        height = 20,
        preview_cutoff = 120,
        prompt_position = 'top'
      },
      center = {
        height = 0.4,
        preview_cutoff = 40,
        prompt_position = 'top',
        width = 0.7
      },
      horizontal = {
        prompt_position = 'top',
        preview_cutoff = 40,
        height = 0.9,
        width = 0.8
      }
    },
    sorting_strategy = 'ascending',
    prompt_prefix = ' ',
    selection_caret = ' → ',
    entry_prefix = '   ',
    file_ignore_patterns = {'node_modules'},
    path_display = { 'truncate' },
    results_title = false,
    prompt_title =false,
    preview = {
      treesitter = {
        enable = {
          'css', 'dockerfile', 'elixir', 'erlang', 'fish',
          'html', 'http', 'javascript', 'json', 'lua', 'php',
          'python', 'regex', 'ruby', 'rust', 'scss', 'svelte',
          'typescript', 'vue', 'yaml', 'markdown', 'bash', 'c',
          'cmake', 'comment', 'cpp', 'dart', 'go', 'jsdoc',
          'json5', 'jsonc', 'llvm', 'make', 'ninja', 'prisma',
          'proto', 'pug', 'swift', 'todotxt', 'toml', 'tsx',
        }
      }
    },
    mappings = {
      i = {
        ['<esc>'] = require('telescope.actions').close,
      },
    }
  },
  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = 'smart_case',        -- other options: 'ignore_case' or 'respect_case'
    }
  }
})

local use_layout = function(picker, layout)
  return function() picker(themes[layout]) end
end
--
-- Telescope
vim.keymap.set('n', '<leader>t', use_layout(telescope_builtin.builtin, 'popup_list'),           { noremap = true, desc = "See all Pickers"})
vim.keymap.set('n', '<leader>o', use_layout(telescope_builtin.find_files, 'popup_list'),        { noremap = true, desc = "Lists files in current working directory"})
vim.keymap.set('n', '<leader>b', use_layout(telescope_builtin.buffers, 'popup_extended'),       { noremap = true, desc = "Lists open buffers"})
vim.keymap.set('n', '<leader>p', use_layout(telescope_builtin.commands, 'command_pane'),        { noremap = true, desc = "Lists commands"})
vim.keymap.set('n', '<leader>gs', use_layout(telescope_builtin.git_status, 'popup_extended'),   { noremap = true, desc = "Lists git status"})
vim.keymap.set('n', '<leader>gb', use_layout(telescope_builtin.git_branches, 'popup_extended'), { noremap = true, desc = "Lists git branches"})
vim.keymap.set('n', '<leader>q', use_layout(telescope_builtin.quickfix, 'ivy_plus') ,           { noremap = true, desc = "Lists all quickfix lists"})
vim.keymap.set('n', '<leader>l', use_layout(telescope_builtin.loclist, 'ivy_plus'),             { noremap = true, desc = "Lists items from the current window's location list"})
vim.keymap.set('n', '<F1>',      use_layout(telescope_builtin.help_tags, 'popup_extended'),     { noremap = true, desc = "Lists available help tags"})
