lua require('plugins')

" Configure keyboard shortcuts
let mapleader =" "

" Configure Telescope
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fs <cmd>Telescope grep_string<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fgb <cmd>Telescope git_branches<cr>
nnoremap <leader><leader>cd <cmd>cd %:p:h<cr>
nnoremap <leader><leader>lcd <cmd>lcd %:p:h<cr>

