vim.g.mapleader = " "
vim.g.maplocalleader = " "

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
            }
        },
        config = function()
            require("telescope").load_extension("live_grep_args")
            require("telescope").load_extension("fzf")

            local telescope = require("telescope")
            local builtin = require("telescope.builtin")

            -- My (Stéphane Klein) custom keymap
            vim.keymap.set(
                "n", "<leader>/",
                telescope.extensions.live_grep_args.live_grep_args,
                { desc = "[/] Live ripgrep" }
            )
            vim.keymap.set(
                "n", "<leader>*",
                function()
                    telescope.extensions.live_grep_args.live_grep_raw({
                        default_text = vim.fn.expand("<cword>")
                    })
                end,
                { desc = "[*] Live ripgrep with word under cursor"}
            )
            vim.keymap.set(
                "n", "<leader>t", builtin.builtin,
                { desc = "[t] See all Telescrope pickers"}
            )
            vim.keymap.set(
                "n", "<leader>o", builtin.find_files,
                { desc = "[o] Lists files in current working directory"}
            )
            vim.keymap.set(
                "n", "<leader>b", builtin.buffers,
                { desc = "[b] Lists open buffers"}
            )

            -- https://github.com/nvim-lua/kickstart.nvim/blob/master/init.lua keymap
            vim.keymap.set(
                "n", "<leader>sg",
                telescope.extensions.live_grep_args.live_grep_args,
                { desc = "[S]earch [S]elect Telescope" }
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
                "n", "<leader>ss", builtin.builtin,
                { desc = "[S]earch [S]elect Telescope"}
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
            "hrsh7th/cmp-path"
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
                    { name = "path" },
                    { name = "buffer" },
                },
            }
        end
    }
})
