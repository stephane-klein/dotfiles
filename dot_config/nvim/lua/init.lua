-- make certain folding is turned off
vim.opt.foldenable = false

-- ignore case in search patterns;
-- can be overridden using \C
vim.opt.ignorecase = true

-- override the ignorecase option IFF the search pattern contains upper-case characters
vim.opt.smartcase = true

-- highlight all matches for the most recent search
vim.opt.hlsearch = true

-- show search matches as it is being typed
vim.opt.incsearch = true

-- show the cursorline
vim.opt.cursorline = true

-- https://github.com/stephane-klein/dotfiles/issues/19
-- use spaces instead of tabs
vim.opt.expandtab = true

-- how many spaces to move when <tab> is pressed
-- vim.opt.tabstop = 4
vim.opt.tabstop = 4

-- spaces when << or >> are used
vim.opt.shiftwidth = 4

-- use spaces when tab used at front of line
vim.opt.smarttab = true
vim.opt.softtabstop = 4
vim.opt.smartindent = true

vim.opt.mouse = 'a'

vim.opt.number = true
vim.opt.relativenumber = false
-- width granted to line numbers (default is 4)
vim.opt.numberwidth = 4

vim.opt.ruler = true

-- where to place new windows by default
vim.opt.splitbelow = true
vim.opt.splitright = true

-- typing
vim.opt.timeoutlen = 600

-- undo
vim.opt.undofile = true
vim.opt.undodir = vim.env.XDG_DATA_HOME .. '/nvim/undo'
-- reduce from default (1000)
vim.opt.undolevels = 500
vim.opt.history = 10000

vim.opt.clipboard = 'unnamedplus'

vim.opt.showmatch = true

-- 'enhanced' command-line completion (sensible turns this on)
vim.opt.wildmenu = true
vim.opt.wildmode = 'longest:full,full'

--  swap and backup files
vim.opt.directory = vim.env.XDG_DATA_HOME .. '/nvim/swap'
vim.opt.backupdir = vim.env.XDG_DATA_HOME .. '/nvim/backup'

-- buffer control; usetab = use already open buffer(s) or tab(s), if possible, when switching tabs
vim.opt.switchbuf = 'usetab'

-- terminal
-- scroll buffer; 100000 is the max
vim.opt.scrollback = 100000
-- vim.opt.scrolloff = 25

-- -- color scheme -- set actual scheme in colorscheme.vim
vim.opt.termguicolors = true
vim.opt.background = 'dark'

vim.opt.scrolloff = 999


vim.opt.list = true
vim.opt.listchars:append("space:⋅")
vim.opt.listchars:append("eol:↴")

vim.api.nvim_create_autocmd(
    { "BufRead", "BufNewFile" },
    { command = "set wrap" }
)
vim.opt.laststatus = 3

vim.opt.swapfile = off

vim.g.vim_markdown_folding_disabled = 1
vim.g.vim_markdown_no_default_key_mappings = 1
vim.g.vim_markdown_frontmatter = 1

vim.opt.diffopt='internal,filler,closeoff,vertical'
