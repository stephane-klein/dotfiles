-- [[ Setting options ]]
vim.g.mapleader = " "
vim.g.maplocalleader = " "
--
-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300

-- [[ Basic Keymaps ]]
--
-- [[Window management]]
vim.keymap.set("n", "<Leader><Up>",    "<C-W><C-K>", { desc = "Move to up window"})
vim.keymap.set("n", "<Leader><Left>",  "<C-W><C-H>", { desc = "Move to left window"})
vim.keymap.set("n", "<Leader><Right>", "<C-W><C-L>", { desc = "Move to right window"})
vim.keymap.set("n", "<Leader><Down>",  "<C-W><C-J>", { desc = "Move to down window"})

vim.keymap.set("n", "<Leader>c",     "<C-W><C-C>", { desc = "Close current window"})

vim.keymap.set("n", "<Leader><Leader><Up>",    "<Cmd>:sp<CR><C-W><C-K>", { desc = "Split on the top"})
vim.keymap.set("n", "<Leader><Leader><Left>",  "<Cmd>:vs<CR><C-W><C-H>", { desc = "Split on the left"})
vim.keymap.set("n", "<Leader><Leader><Right>", "<Cmd>:vs<CR>",           { desc = "Split on the right"})
vim.keymap.set("n", "<Leader><Leader><Down>",  "<Cmd>:sp<CR>",           { desc = "Split on the bottom"})

-- A lot of code is taken from https://github.com/nvim-lua/kickstart.nvim/blob/master/init.lua
-- [[ Install `lazy.nvim` plugin manager ]]
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath }
end
vim.opt.rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]

-- Au fur et à mesure que j'ajoute ici des plugins, je les supprimes de le fichier d'origin plugins.lua
require("lazy").setup({
    {
        "folke/which-key.nvim",
        event = "VimEnter",
        config = function()
            require("which-key").setup()

            -- Document existing key chains
            require("which-key").register {
                ["<leader><leader>"] = { name = "split windows", _ = "which_key_ignore" },
                ["<leader>s"] = { name = "[S]earch", _ = "which_key_ignore" }
            }
        end
    },
    {
        "catppuccin/nvim",
        priority = 1000,
        init = function()
            require("catppuccin").setup({
                integrations = {
                    -- See https://github.com/catppuccin/nvim/tree/d97387aea8264f484bb5d5e74f2182a06c83e0d8?tab=readme-ov-file#integrations
                    telescope = {
                        enabled = true
                    }
                }
            })

            vim.cmd.colorscheme "catppuccin"
        end,
    },
    {"tpope/vim-fugitive"},
    {"shumphrey/fugitive-gitlab.vim"},
    {"lewis6991/gitsigns.nvim"},
    { -- Fuzzy Finder (files, lsp, etc)
        "nvim-telescope/telescope.nvim",
        event = "VimEnter",
        branch = "0.1.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "make",
                cond = function()
                  return vim.fn.executable "make" == 1
                end
            },
            {
                -- To enables passing arguments to the grep command
                "nvim-telescope/telescope-live-grep-args.nvim" ,
                version = "^1.0.0"
            },
            { "nvim-tree/nvim-web-devicons", enabled = true },
            { "benfowler/telescope-luasnip.nvim" }
        },
        config = function()
            require("telescope").load_extension("live_grep_args")
            require("telescope").load_extension("fzf")
            require("telescope").load_extension("luasnip")

            local telescope = require("telescope")
            local builtin = require("telescope.builtin")

            -- My (Stéphane Klein) custom keymap
            vim.keymap.set(
                "n", "<leader>/",
                telescope.extensions.live_grep_args.live_grep_args,
                { desc = "Live ripgrep" }
            )
            vim.keymap.set(
                "n", "<leader>*",
                function()
                    telescope.extensions.live_grep_args.live_grep_raw({
                        default_text = vim.fn.expand("<cword>")
                    })
                end,
                { desc = "Live ripgrep with word under cursor"}
            )
            vim.keymap.set(
                "n", "<leader>t", builtin.builtin,
                { desc = "See all [T]elescrope pickers"}
            )
            vim.keymap.set(
                "n", "<leader>o", builtin.find_files,
                { desc = "Lists files in current working directory"}
            )
            vim.keymap.set(
                "n", "<leader>b", builtin.buffers,
                { desc = "Lists open [b]uffers"}
            )

            -- https://github.com/nvim-lua/kickstart.nvim/blob/master/init.lua keymap
            vim.keymap.set(
                "n", "<leader>sg",
                telescope.extensions.live_grep_args.live_grep_args,
                { desc = "[S]earch with [G]rep" }
            )
            vim.keymap.set(
                "n", "<leader>sw",
                function()
                    telescope.extensions.live_grep_args.live_grep_raw({
                        default_text = vim.fn.expand("<cword>")
                    })
                end,
                { desc = "[S]earch current [W]ord"}
            )
            vim.keymap.set(
                "n", "<leader>st", builtin.builtin,
                { desc = "[S]earch all [T]elescope pickers"}
            )
            vim.keymap.set(
                "n", "<leader>ss", telescope.extensions.luasnip.luasnip,
                { desc = "[S]earch [S]nippet picker"}
            )
        end
    },
    { -- LSP Configuration & Plugins
        "neovim/nvim-lspconfig",
        dependencies = {
            -- Automatically install LSPs and related tools to stdpath for Neovim
            { "williamboman/mason.nvim", config = true }, -- NOTE: Must be loaded before dependants
            "williamboman/mason-lspconfig.nvim",
            "WhoIsSethDaniel/mason-tool-installer.nvim",

            -- Useful status updates for LSP.
            -- NOTE: `opts = {}` is the same as calling `require("fidget").setup({})`
            { "j-hui/fidget.nvim", opts = {} },

            -- `neodev` configures Lua LSP for your Neovim config, runtime and plugins
            -- used for completion, annotations and signatures of Neovim apis
            { "folke/neodev.nvim", opts = {} },
        }
    },
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
        },
        keys = {
            {
                "<leader>.",
                "<Cmd>:Neotree action=show position=current reveal_force_cwd<CR>",
                desc = "Open Neotree explorer"
            },
            {
                "<leader><tab>",
                "<Cmd>:Neotree toggle position=left reveal_force_cwd<CR>",
                desc = "Open Neotree drawer"
            }
        }
    },
    { -- Autocompletion
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            -- Snippet Engine & its associated nvim-cmp source
            {
                "L3MON4D3/LuaSnip",
                dependencies = {
                    {
                        "rafamadriz/friendly-snippets",
                        config = function()
                            require("luasnip.loaders.from_vscode").lazy_load()
                        end,
                    }
                }
            },
            "saadparwaiz1/cmp_luasnip",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-buffer"
        },
        config = function()
            local cmp = require "cmp"
            local luasnip = require "luasnip"
            luasnip.config.setup {}

            cmp.setup {
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end
                },
                completion = { completeopt = "menu,menuone,noinsert" },
                mapping = cmp.mapping.preset.insert {
                    -- Select the [n]ext item
                    ["<C-n>"] = cmp.mapping.select_next_item(),
                    -- Select the [p]revious item
                    ["<C-p>"] = cmp.mapping.select_prev_item(),

                    -- Scroll the documentation window [b]ack / [f]orward
                    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),

                    -- Accept ([y]es) the completion.
                    --  This will auto-import if your LSP supports it.
                    --  This will expand snippets if the LSP sent a snippet.
                    ["<C-y>"] = cmp.mapping.confirm { select = true },

                    -- If you prefer more traditional completion keymaps,
                    -- you can uncomment the following lines
                    --["<CR>"] = cmp.mapping.confirm { select = true },
                    --["<Tab>"] = cmp.mapping.select_next_item(),
                    --["<S-Tab>"] = cmp.mapping.select_prev_item(),

                    -- Manually trigger a completion from nvim-cmp.
                    --  Generally you don"t need this, because nvim-cmp will display
                    --  completions whenever it has completion options available.
                    ["<C-Space>"] = cmp.mapping.complete {},

                    -- Think of <c-l> as moving to the right of your snippet expansion.
                    --  So if you have a snippet that"s like:
                    --  function $name($args)
                    --    $body
                    --  end
                    --
                    -- <c-l> will move you to the right of each of the expansion locations.
                    -- <c-h> is similar, except moving you backwards.
                    ["<C-l>"] = cmp.mapping(function()
                        if luasnip.expand_or_locally_jumpable() then
                            luasnip.expand_or_jump()
                        end
                    end, { "i", "s" }),
                    ["<C-h>"] = cmp.mapping(function()
                        if luasnip.locally_jumpable(-1) then
                            luasnip.jump(-1)
                        end
                    end, { "i", "s" }),

                    -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
                    --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
                },
                sources = {
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                    {
                        name = "buffer",
                        option = {
                            get_bufnrs = function()
                                return vim.api.nvim_list_bufs()
                            end
                        }
                    },
                    { name = "path" },
                },
            }
        end
    },
    {
        "goolord/alpha-nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function ()
            require"alpha".setup(require"alpha.themes.startify".config)
        end
    },
    {"gpanders/editorconfig.nvim"},
    {
        "hiphish/rainbow-delimiters.nvim",
        event = "VeryLazy",
    },
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("lualine").setup({
                    options = {
                    theme = "catppuccin",
                    globalstatus = true
                    },
                    extensions = { "fugitive" },
                    sections = {
                    lualine_c = {}
                    },
                    winbar = {
                    lualine_a = {},
                    lualine_b = {},
                    lualine_c = {
                    {
                    "filename",
                    path = 1
                    }
                    },
                    lualine_x = {},
                    lualine_y = {},
                    lualine_z = {}
                    },
                    inactive_winbar = {
                        lualine_a = {},
                        lualine_b = {},
                        lualine_c = {
                            {
                                "filename",
                                path = 1
                            }
                        },
                        lualine_x = {},
                        lualine_y = {},
                        lualine_z = {}
                    }
            })
        end
    },
    { -- Highlight, edit, and navigate code
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        opts = {
            ensure_installed = {
                "python", "lua", "javascript", "bash", "css",
                "go", "graphql", "html", "json", "markdown",
                "ninja", "svelte", "toml",
                "yaml",
                "diff", "lua", "luadoc", "vim", "vimdoc"
            },
            auto_install = true,
            sync_install = true,
            highlight = {
                enable = true,
            },
            indent = { enable = true },
            matchup = {
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
        },
        config = function(_, opts)
            require("nvim-treesitter.install").prefer_git = true
            require("nvim-treesitter.configs").setup(opts)
        end
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        opts = {},
        config = function(_, opts)
            require("ibl").setup()
        end
    },
    {
        "epwalsh/obsidian.nvim",
        version = "v3.7.12",
        lazy = true,
        ft = "markdown",
        event = {
            "BufReadPre ~/vaults/main/**.md",
            "BufNewFile ~/vaults/main/**.md"
        },
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        opts = {
            workspaces = {
                {
                    name = "personal",
                    path = "~/vaults/main/",
                }
            },
        }
    },
    {
        "kylechui/nvim-surround",
        version = "*",
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({
            })
        end
    }
})
