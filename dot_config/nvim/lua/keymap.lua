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

function toggle_style()
  if vim.g.tokyonight_style == "night" then
    vim.g.tokyonight_style = "day"
    vim.opt.background = "light"
  elseif vim.g.tokyonight_style == "day" then
    vim.g.tokyonight_style = "night"
    vim.opt.background = "dark"
  end

  vim.cmd("colorscheme tokyonight")
end
vim.keymap.set('n', '<leader>ts', ":lua toggle_style()<CR>")

-- Configure ToggleTerm
local Terminal  = require('toggleterm.terminal').Terminal
local float_terminal = Terminal:new({
    direction = "float",
    float_opts = {
        border = "curved",
    },
    on_open = function(term)
        vim.cmd("startinsert!")
        vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", {noremap = true, silent = true})
        vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
    end,
})
function open_float_term()
    float_terminal:toggle()
end
vim.keymap.set('n', '<leader>t<up>', ":lua open_float_term()<CR>")

local bottom_terminal = Terminal:new({
    direction = "horizontal",
    on_open = function(term)
        vim.cmd("startinsert!")
        vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", {noremap = true, silent = true})
        vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
    end,
})
function open_bottom_terminal()
    bottom_terminal:open()
end
vim.keymap.set('n', '<leader>t<down>', ":lua open_bottom_terminal()<CR>")

-- Emmet
vim.g['user_emmet_leader_key'] = '<C-e>'

-- LSP
vim.keymap.set('n', '<leader><leader>rn', vim.lsp.buf.rename, { desc = '[R]e[n]ame' })
vim.keymap.set('n', '<leader><leader>ca', vim.lsp.buf.code_action, { desc = '[C]ode [A]ction' })
vim.keymap.set('n', '<leader><leader>f', vim.lsp.buf.formatting, { desc = '[F]ormat' })

vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = '[G]oto [D]efinition' })
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { desc = '[G]oto [I]mplementation' })
vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references)
vim.keymap.set('n', '<leader>ds', require('telescope.builtin').lsp_document_symbols, { desc = '[D]ocument [S]ymbols' })
vim.keymap.set('n', '<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, { desc = '[W]orkspace [S]ymbols' })

vim.keymap.set('n', 'h', vim.lsp.buf.hover, { desc = 'Hover Documentation' })
vim.keymap.set('n', '<C-h>', vim.lsp.buf.signature_help, { desc = 'Signature Documentation' })
