lua require('plugins')

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

" Configure keyboard shortcuts
let mapleader =" "

" Some shortcut config to move between panes and create / close panes
nmap <Leader><Left> <C-W><C-H>
nmap <Leader><Right> <C-W><C-L>
nmap <Leader><Up> <C-W><C-K>
nmap <Leader><Down> <C-W><C-J>
nmap <Leader>c <C-W><C-C>
nmap <Leader><Leader><Left> <Cmd>:vs<CR><C-W><C-H>
nmap <Leader><Leader><Right> <Cmd>:vs<CR>
nmap <Leader><Leader><Up> <Cmd>:sp<CR><C-W><C-K>
nmap <Leader><Leader><Down> <Cmd>:sp<CR>


" Configure Telescope
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fs <cmd>Telescope grep_string<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fgb <cmd>Telescope git_branches<cr>
nnoremap <leader><leader>cd <cmd>cd %:p:h<cr>
nnoremap <leader><leader>lcd <cmd>lcd %:p:h<cr>

