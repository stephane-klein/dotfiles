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

    -- https://github.com/neovim/nvim-lspconfig
    use { 'neovim/nvim-lspconfig' }

    -- Mason
    use {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end
    }
    use {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        requires = {
            "williamboman/mason.nvim"
        },
        config = function()
            require('mason-tool-installer').setup({
                ensure_installed = {
                    'lua-language-server',
                    'vim-language-server',
                    'sqls'
                    -- 'shellcheck',
                    -- 'ansible-language-server',
                    -- 'bash-language-server',
                    -- 'css-lsp',
                    -- 'flake8',
                    -- 'html-lsp',
                },
                auto_update = false,
                run_on_start = true
            })
        end
    }

    -- https://github.com/stephane-klein/dotfiles/issues/17
    use {
        's1n7ax/nvim-window-picker',
        tag = 'v1.*',
        config = function()
            require('window-picker').setup()
        end,
    }

    -- https://github.com/stephane-klein/dotfiles/issues/16

    use {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v2.x",
        requires = {
            "nvim-lua/plenary.nvim",
            "kyazdani42/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
            {
                "s1n7ax/nvim-window-picker",
                tag = "v1.*",
                config = function()
                    require'window-picker'.setup({
                        autoselect_one = true,
                        include_current = false,
                        filter_rules = {
                            -- filter using buffer options
                            bo = {
                                -- if the file type is one of following, the window will be ignored
                                filetype = { 'neo-tree', "neo-tree-popup", "notify", "quickfix" },

                                -- if the buffer type is one of following, the window will be ignored
                                buftype = { 'terminal' },
                            },
                        },
                        other_win_hl_color = '#e35e4f',
                    })
                end,
            }
        },
        config = function ()
            -- Unless you are still migrating, remove the deprecated commands from v1.x
            vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])
            require("neo-tree").setup({
                close_if_last_window = false, -- Close Neo-tree if it is the last window left in the tab
                popup_border_style = "rounded",
                enable_git_status = true,
                enable_diagnostics = true,
                window = {
                    mappings = {
                        ["<space>"] = {
                            "toggle_node",
                            nowait = false, -- disable `nowait` if you have existing combos starting with this char that you want to use
                        }
                    }
                }
            })
        end
    }
end)
