lua require('plugins')
lua require('keymap')
lua require('_telescope')

" Theme
set background=dark
colorscheme gruvbox

" Misc config to be documented
set clipboard=unnamedplus

set cmdheight=1
set cursorline

" Indentline
set expandtab
set shiftwidth=4
set smartindent
set tabstop=4

set ignorecase
set mouse=a

set number
set numberwidth=2
set norelativenumber
set ruler

set signcolumn=yes
set splitbelow
set splitright
set termguicolors

set timeoutlen=600 " keyboard sequence

set undofile

" End misc config
"
" " Configure Telescope
" nnoremap <leader>ff <cmd>Telescope find_files<cr>
" nnoremap <leader>fg <cmd>Telescope live_grep<cr>
" nnoremap <leader>fs <cmd>Telescope grep_string<cr>
" nnoremap <leader>fb <cmd>Telescope buffers<cr>
" nnoremap <leader>fgb <cmd>Telescope git_branches<cr>
" nnoremap <leader><leader>cd <cmd>cd %:p:h<cr>
" nnoremap <leader><leader>lcd <cmd>lcd %:p:h<cr>
"
