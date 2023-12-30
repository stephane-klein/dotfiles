" let g:yoinkIncludeDeleteOperations = 1
lua require('plugins')

if $PACKER_INSTALL_ONLY != "1"
    lua require('keymap')
    lua require('_telescope')
    lua require('lsp')
    lua require('_cmp')
    lua require('_null-ls')
    lua require('_lualine')
    lua require('_catppuccin');
    lua require('init')
    lua require('snippets/postgres')
endif
