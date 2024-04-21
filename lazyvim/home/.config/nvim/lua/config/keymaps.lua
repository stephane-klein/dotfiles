-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

require("config/disable-keymaps")

vim.keymap.set('n', '<Leader><Up>', '<C-W><C-K>', { desc = "Move to up window" })
vim.keymap.set('n', '<Leader><Left>', '<C-W><C-H>', { desc = "Move to left window" })
vim.keymap.set('n', '<Leader><Right>', '<C-W><C-L>', { desc = "Move to right window" })
vim.keymap.set('n', '<Leader><Down>', '<C-W><C-J>', { desc = "Move to down window" })

vim.keymap.set('n', '<Leader>c', '<C-W><C-C>', { desc = "Close current window" })

vim.keymap.set('n', '<Leader><Leader><Up>', '<Cmd>:sp<CR><C-W><C-K>', { desc = "Split on the top" })
vim.keymap.set('n', '<Leader><Leader><Left>', '<Cmd>:vs<CR><C-W><C-H>', { desc = "Split on the left" })
vim.keymap.set('n', '<Leader><Leader><Right>', '<Cmd>:vs<CR>', { desc = "Split on the right" })
vim.keymap.set('n', '<Leader><Leader><Down>', '<Cmd>:sp<CR>', { desc = "Split on the bottom" })

vim.keymap.set('n', '<leader>.', '<Cmd>:Neotree action=show position=current reveal_force_cwd<CR>',
  { desc = "Open Neotree explorer" })
vim.keymap.set('n', '<leader><tab>', '<Cmd>:Neotree toggle position=left reveal_force_cwd<CR>',
  { desc = "Open Neotree drawer" })
