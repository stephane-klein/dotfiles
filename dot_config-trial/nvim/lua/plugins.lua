vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
    use 'wbthomason/packer.nvim'
    use 'nvim-lua/plenary.nvim'
    use {
        'nvim-telescope/telescope.nvim',
        requires = {
            {'nvim-lua/plenary.nvim'},
            { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
        }
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

    -- https://github.com/folke/which-key.nvim/
    -- displays a popup with possible keybindings of the command you started typing
    -- ressources: https://old.reddit.com/r/neovim/comments/vwud6m/whichkeynvim_whats_the_best_workflow/
    use {
        "folke/which-key.nvim",
        config = function()
            require("which-key").setup {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
            }
        end
    }

    -- https://github.com/nvim-treesitter/nvim-treesitter
    use {
        "nvim-treesitter/nvim-treesitter",
        config = function()
            require('nvim-treesitter.configs').setup({
              -- A list of parser names, or "all"
              ensure_installed = {
                  "python", "lua", "javascript", "bash", "css",
                  "go", "graphql", "html", "json", "markdown",
                  "ninja", "sql", "svelte", "toml",
                  "vim", "yaml"
              },
              auto_install = true,
              highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
              },
            })
        end
    }

end)
