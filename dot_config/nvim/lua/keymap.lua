vim.g.mapleader = ' '

-- Window management
vim.keymap.set('n', '<Leader><Up>',    '<C-W><C-K>', { desc = "Move to up window"})
vim.keymap.set('n', '<Leader><Left>',  '<C-W><C-H>', { desc = "Move to left window"})
vim.keymap.set('n', '<Leader><Right>', '<C-W><C-L>', { desc = "Move to right window"})
vim.keymap.set('n', '<Leader><Down>',  '<C-W><C-J>', { desc = "Move to down window"})

vim.keymap.set('n', '<Leader>c',     '<C-W><C-C>', { desc = "Close current window"})

vim.keymap.set('n', '<Leader><Leader><Up>',    '<Cmd>:sp<CR><C-W><C-K>', { desc = "Split on the top"})
vim.keymap.set('n', '<Leader><Leader><Left>',  '<Cmd>:vs<CR><C-W><C-H>', { desc = "Split on the left"})
vim.keymap.set('n', '<Leader><Leader><Right>', '<Cmd>:vs<CR>',           { desc = "Split on the right"})
vim.keymap.set('n', '<Leader><Leader><Down>',  '<Cmd>:sp<CR>',           { desc = "Split on the bottom"})

-- Telescope keymap are defined in _telescope.lua

vim.keymap.set(
    'n', '<leader>-',
    function()
        local picked_window_id = require('window-picker').pick_window() or vim.api.nvim_get_current_win()
        vim.api.nvim_set_current_win(picked_window_id)
    end,
    { desc = "Pick a window" }
)

vim.keymap.set('n', '<leader>.', '<Cmd>:Neotree action=show position=current reveal_force_cwd<CR>', { desc = "Open Neotree explorer"})
vim.keymap.set('n', '<leader><tab>', '<Cmd>:Neotree toggle position=left reveal_force_cwd<CR>', { desc = "Open Neotree drawer"})

-- Configure wildmenu
vim.keymap.set('c', '<up>', 'pumvisible() ? "<C-p>" : "<up>"', { expr = true })
vim.keymap.set('c', '<down>', 'pumvisible() ? "<C-n>" : "<down>"', { expr = true })
