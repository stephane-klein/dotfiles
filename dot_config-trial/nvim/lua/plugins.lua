vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
    use 'wbthomason/packer.nvim'
    use 'nvim-lua/plenary.nvim'
    use {
        'nvim-telescope/telescope.nvim',
        requires = {
            { 'nvim-lua/plenary.nvim' },
            { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
            { 'nvim-telescope/telescope-live-grep-args.nvim' }
        },
        config = function()
            require("telescope").load_extension("live_grep_args")
        end
    }

    -- Theme
    use {
        'rebelot/kanagawa.nvim',
        config = function()
            vim.cmd("colorscheme kanagawa")
        end
    }

    -- Git
    use { 'tpope/vim-fugitive' }
    use {
        'shumphrey/fugitive-gitlab.vim',
        requires = {
            { 'tpope/vim-fugitive' }
        }
    }
    use {
      'lewis6991/gitsigns.nvim',
      config = function()
        require('gitsigns').setup()
      end
    }

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
    use { 'p00f/nvim-ts-rainbow' }
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
                matchup = {
                    enable = true
                },
                indent = {
                    enable = true
                },
                incremental_selection = {
                    enable = true
                },
                autopairs = {
                    enable = true
                },
                rainbow = {
                    enable = true,
                    extended_mode = true
                }
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
                open_files_in_last_window = false,
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
                },
                filesystem = {
                    hijack_netrw_behavior = "open_current"
                }
            })
        end
    }

    use { 'ntpeters/vim-better-whitespace' }

    use {
        'terrortylor/nvim-comment',
        config = function ()
            require('nvim_comment').setup()
        end
    }

    use { 'tpope/vim-repeat' }
    -- https://github.com/stephane-klein/dotfiles/issues/18
    use {
        'ggandor/leap.nvim',
        requires = {
            { 'tpope/vim-repeat' }
        },
        config = function()
            -- require('leap').setup()
            require('leap').set_default_keymaps()
        end
    }

    use {
        'hrsh7th/nvim-cmp',
        requires = {
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'hrsh7th/cmp-cmdline' },
        },
        config = function()
            vim.g.completeopt='menu,menuone,noselect'
            local cmp = require'cmp'
            cmp.setup({
                sources = {
                    { name = 'nvim-lsp' },
                    { name = 'buffer' },
                    { name = 'path' }
                },
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered()
                },
                mapping = cmp.mapping.preset.insert({
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<C-e>'] = cmp.mapping.abort(),
                    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
                }),
            })
            cmp.setup.cmdline('/', {
                completion = {
                    autocomplete = false
                },
                mapping = cmp.mapping.preset.cmdline({
                    ['<C-Space>'] = { c = cmp.mapping.complete() },
                    ['<Down>'] = { c = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert })},
                    ['<Up>'] = { c = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert })},
                    ['<CR>'] = { c = cmp.mapping.confirm({ select = true })}, -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
                }),
                sources = {
                    { name = 'buffer' }
                }
            })
            cmp.setup.cmdline(':', {
                completion = {
                    autocomplete = false
                },
                mapping = cmp.mapping.preset.cmdline({
                    ['<C-Space>'] = { c = cmp.mapping.complete() },
                    ['<Down>'] = { c = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert })},
                    ['<Up>'] = { c = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert })},
                    ['<CR>'] = { c = cmp.mapping.confirm({ select = true })}, -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
                }),
                sources = cmp.config.sources(
                    {{ name = 'path' }},
                    {{ name = 'cmdline' }}
                )
            })
        end
    }

    use { 'andymass/vim-matchup' }

    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true },
        config = function()
            require('lualine').setup({
                options = {
                    theme = 'kanagawa',
                },
                extensions = { 'fugitive' }
            })
        end
    }
    use {
        'stevearc/dressing.nvim',
        config = function()
            require('dressing').setup()
        end
    }
    use {'machakann/vim-sandwich'}
    use {
        "AckslD/nvim-neoclip.lua",
        requires = {
            {'nvim-telescope/telescope.nvim'},
        },
        config = function()
            require('neoclip').setup()
        end
    }

    use {
        'svermeulen/vim-cutlass',
        config = function()
            vim.g['yoinkIncludeDeleteOperations'] = 1
            vim.keymap.set({'n', 'x'}, 'm',  'd', { noremap = true, desc = "Cut current character"})
            vim.keymap.set('n',        'mm', 'dd', { noremap = true, desc = "Cut current line"})
            vim.keymap.set('n',        'M',  'D', { noremap = true, desc = "Cut until end of line"})
        end
    }
    use {
        'svermeulen/vim-yoink',
        config = function()
            vim.keymap.set('n', 'p', '<plug>(YoinkPaste_p)', { desc = "Paste" })
            vim.keymap.set('n', 'P', '<plug>(YoinkPaste_P)')

            -- " Also replace the default gp with yoink paste so we can toggle paste in this case too
            vim.keymap.set('n', 'gp', '<plug>(YoinkPaste_gp)')
            vim.keymap.set('n', 'gP', '<plug>(YoinkPaste_gP)')
        end
    }

    use {
        'goolord/alpha-nvim',
        config = function ()
            require('alpha').setup(require('alpha.themes.startify').config)
        end
    }

    use {
        'beauwilliams/focus.nvim',
        config = function()
            require("focus").setup()
        end
    }

    use {
        'nyngwang/NeoZoom.lua',
        branch = 'neo-zoom-original',
        config = function()
            vim.api.nvim_set_keymap(
                'n', '<leader>z',
                '<cmd>NeoZoomToggle<CR>',
                {
                    noremap=true,
                    silent=true,
                    nowait=true,
                    desc="Zoom"
                }
            )
        end
    }
end)
