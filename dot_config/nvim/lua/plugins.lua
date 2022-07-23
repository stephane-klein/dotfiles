vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
    use 'wbthomason/packer.nvim'
    use 'nvim-lua/plenary.nvim'
    use {
        'nvim-telescope/telescope.nvim',
        requires = { {'nvim-lua/plenary.nvim'} }
    }

    -- Theme
    use { 'morhetz/gruvbox' }

    -- Git
    use 'tpope/vim-fugitive'

    -- Svelte packages (https://github.com/evanleck/vim-svelte)
    use {
        'evanleck/vim-svelte',
        requires = {
            {'othree/html5.vim'},
            {'pangloss/vim-javascript'}
        }
    }

    -- for handel .editorconfig files
    use { 'gpanders/editorconfig.nvim' }
end)
