vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
    use 'wbthomason/packer.nvim'
    use 'nvim-lua/plenary.nvim'
    use {
        'nvim-telescope/telescope.nvim',
        requires = {
            { 'nvim-lua/plenary.nvim' },
            { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
            {
                'nvim-telescope/telescope-live-grep-args.nvim',
                branch='improve-theme-support'
            },
            { 'benfowler/telescope-luasnip.nvim'}
        },
        config = function()
            require("telescope").load_extension("live_grep_args")
            require("telescope").load_extension('luasnip')
        end
    }

    -- Theme
    use {
        "catppuccin/nvim",
        as = "catppuccin",
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

    -- https://github.com/nvim-treesitter/nvim-treesitter/wiki/Extra-modules-and-plugins
    use { 'HiPhish/nvim-ts-rainbow2' }

    -- https://github.com/nvim-treesitter/nvim-treesitter
    use {
        "nvim-treesitter/nvim-treesitter",
        config = function()
            require('nvim-treesitter.configs').setup({
                -- A list of parser names, or "all"
                ensure_installed = {
                    "python", "lua", "javascript", "bash", "css",
                    "go", "graphql", "html", "json", "markdown",
                    "ninja", "svelte", "toml",
                    "vim", "yaml"
                },
                auto_install = false,
                sync_install = true,
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
                    'sqlls',
                    -- 'shellcheck',
                    -- 'ansible-language-server',
                    -- 'bash-language-server',
                    'css-lsp',
                    'html-lsp',
                    'pyright',
                    'autopep8',
                    'flake8',
                    'isort',
                    'prettierd',
                    'sql-formatter',
                    'svelte-language-server',
                    'typescript-language-server'
                },
                auto_update = false,
                run_on_start = false
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
                        },
                        ["A"]  = "git_add_all",
                        ["gu"] = "git_unstage_file",
                        ["ga"] = "git_add_file",
                        ["gr"] = "git_revert_file",
                        ["gc"] = "git_commit",
                        ["gp"] = "git_push",
                        ["gg"] = "git_commit_and_push"
                    }
                },
                filesystem = {
                    hijack_netrw_behavior = "open_current",
                    commands = {
                        copy_file_name =  function(state)
                            local node = state.tree:get_node()
                            vim.fn.setreg('*', node.path, 'c')
                        end
                    },
                    window = {
                        mappings = {
                            ["Y"] = "copy_file_name"
                        }
                    }
                }
            })
        end
    }

    use { 'ntpeters/vim-better-whitespace' }

    use { 'JoosepAlviste/nvim-ts-context-commentstring' }

    use {
        'terrortylor/nvim-comment',
        config = function ()
            require('nvim_comment').setup({
                hook = function()
                    require('ts_context_commentstring.internal').update_commentstring()
                end,
            })
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

    -- Snippet
    use({
        "L3MON4D3/LuaSnip",
        -- follow latest release.
        tag = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
        -- install jsregexp (optional!:).
        -- run = "make install_jsregexp"
    })

    -- See cmp configuration in _cmp.lua
    use {
        'hrsh7th/nvim-cmp',
        requires = {
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'hrsh7th/cmp-cmdline' },
            { 'saadparwaiz1/cmp_luasnip' },
            { 'rafamadriz/friendly-snippets' },
            { 'L3MON4D3/LuaSnip' }
        }
    }

    use { 'andymass/vim-matchup' }

    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true }
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
            vim.g['yoinkSyncSystemClipboardOnFocus'] = 0
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
        'nvim-focus/focus.nvim',
        config = function()
            require("focus").setup({
                enable = false,
                autoresize = {
                    enable = false
                }
            })
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
    use({
        "Pocco81/true-zen.nvim",
        config = function()
            require("true-zen").setup({})
        end
    })
    -- sudo dnf install luajit-devel libX11-devel wayland-devel extra-cmake-modules
    -- cd /home/stephane/.local/share/nvim/site/pack/packer/start/neoclip/src
    --
    -- $ cmake -B build -G Ninja && ninja -C build install/strip
    -- -- Found Wayland_Client: /usr/lib64/libwayland-client.so (found version "1.21.0")
    -- -- Found Wayland_Server: /usr/lib64/libwayland-server.so (found version "1.21.0")
    -- -- Found Wayland_Cursor: /usr/lib64/libwayland-cursor.so (found version "1.21.0")
    -- -- Found Wayland_Egl: /usr/lib64/libwayland-egl.so (found version "18.1.0")
    -- -- Configuring done
    -- -- Generating done
    -- -- Build files have been written to: /home/stephane/.local/share/nvim/site/pack/packer/start/neoclip/src/build
    -- ninja: Entering directory `build'
    -- [7/8] Installing the project stripped...
    -- -- Install configuration: "release"
    -- -- Up-to-date: /home/stephane/.local/share/nvim/site/pack/packer/start/neoclip/src/../lua/neoclip_x11.so
    -- -- Installing: /home/stephane/.local/share/nvim/site/pack/packer/start/neoclip/src/../lua/neoclip_wl.so
    use { 'matveyt/neoclip' }

    use {"akinsho/toggleterm.nvim", tag = 'v2.*', config = function()
        require("toggleterm").setup({
            open_mapping = false,
            terminal_mappings = true,
            insert_mappings = false
        })
    end}
    use {
        'jedrzejboczar/toggletasks.nvim',
        requires = {
            'nvim-lua/plenary.nvim',
            'akinsho/toggleterm.nvim',
        },
        config = function()
            require('telescope').load_extension('toggletasks')
        end
    }

    use { 'mattn/emmet-vim' }

    -- See configuration in _null-ls.lua
    use { 'jose-elias-alvarez/null-ls.nvim' }

    use({
        "iamcco/markdown-preview.nvim",
        run = function()
            vim.fn["mkdp#util#install"]()
        end,
        setup = function()
            vim.g.mkdp_filetypes = { "markdown" }
        end,
        ft = { "markdown" }
    })

    use {
        'preservim/vim-markdown',
        requires = {
            { 'godlygeek/tabular' }
        }
    } -- See configuration in init.lua
    use { 'kevinhwang91/nvim-bqf' } -- https://github.com/stephane-klein/dotfiles/issues/60

    use { 'direnv/direnv.vim' }

    use { 'sbdchd/neoformat' } -- Maybe later I will migrate to https://github.com/neoclide/coc.nvim 🤷🏻

    use { 'lukas-reineke/indent-blankline.nvim' }

    use { 'ledger/vim-ledger' }

    use { 'thoughtbot/vim-rspec' }

    use { 'hashivim/vim-terraform' }

    use {'kaarmu/typst.vim', ft = {'typst'}}

    use {'ActivityWatch/aw-watcher-vim' }

    use {'alunny/pegjs-vim'}

    use({
        "epwalsh/obsidian.nvim",
        tag = "*",  -- recommended, use latest release instead of latest commit
        requires = {
            "nvim-lua/plenary.nvim",
        },
        config = function()
            require("obsidian").setup({
                workspaces = {
                    {
                        name = "main",
                        path = "~/vaults/main",
                    }
                },
                follow_url_func = function(url)
                    vim.fn.jobstart({"xdg-open", url})  -- linux
                end,
            })
        end,
    })
    use { 'alker0/chezmoi.vim' }
    use { 'tpope/vim-abolish' } -- To convert CamelCase to snake_case and inversly
end)
