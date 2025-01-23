-- [[ Setting options ]]
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- ignore case in search patterns;
-- can be overridden using \C
vim.opt.ignorecase = true
--
-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300

-- Sync clipboard between OS and Neovim.
vim.opt.clipboard = 'unnamedplus'

-- override the ignorecase option IFF the search pattern contains upper-case characters
vim.opt.smartcase = true

-- highlight all matches for the most recent search
vim.opt.hlsearch = true

-- show search matches as it is being typed
vim.opt.incsearch = true

-- show the cursorline
vim.opt.cursorline = true

-- https://github.com/stephane-klein/dotfiles/issues/19
-- use spaces instead of tabs
vim.opt.expandtab = true

-- how many spaces to move when <tab> is pressed
-- vim.opt.tabstop = 4
vim.opt.tabstop = 4

-- spaces when << or >> are used
vim.opt.shiftwidth = 4

-- use spaces when tab used at front of line
vim.opt.smarttab = true
vim.opt.softtabstop = 4
vim.opt.smartindent = true

vim.opt.mouse = 'a'

vim.opt.number = true
vim.opt.relativenumber = false
-- width granted to line numbers (default is 4)
vim.opt.numberwidth = 4

vim.opt.ruler = true

-- where to place new windows by default
vim.opt.splitbelow = true
vim.opt.splitright = true

-- typing
vim.opt.timeoutlen = 600

-- undo
vim.opt.undofile = true
vim.opt.undodir = vim.env.XDG_DATA_HOME .. '/nvim/undo'
-- reduce from default (1000)
vim.opt.undolevels = 500
vim.opt.history = 10000

vim.opt.showmatch = true

-- 'enhanced' command-line completion (sensible turns this on)
vim.opt.wildmenu = true
vim.opt.wildmode = 'longest:full,full'

--  swap and backup files
vim.opt.directory = vim.env.XDG_DATA_HOME .. '/nvim/swap'
vim.opt.backupdir = vim.env.XDG_DATA_HOME .. '/nvim/backup'

-- buffer control; usetab = use already open buffer(s) or tab(s), if possible, when switching tabs
vim.opt.switchbuf = 'usetab'

-- terminal
-- scroll buffer; 100000 is the max
vim.opt.scrollback = 100000

vim.opt.scrolloff = 999

vim.opt.list = true
vim.opt.listchars:append("space:⋅")
vim.opt.listchars:append("eol:↴")

vim.opt.laststatus = 3

vim.opt.swapfile = off

-- [[ Basic Keymaps ]]
--
-- Disable Neovim builtin keyword completion
vim.api.nvim_set_keymap('i', '<C-n>', '<Nop>', { noremap = true, silent = true });

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
        "vhyrro/luarocks.nvim",
        priority = 1000,
        config = true,
    },
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        keys = {
            { "<leader><leader>", group = "split windows" },
            { "<leader>s", group = "[S]earch" }
        }
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
        branch = "master",
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
            local actions = require("telescope.actions")
            local builtin = require("telescope.builtin")

            telescope.setup({
                defaults = {
                    layout_config = {
                        scroll_speed = 1
                    },
                    mappings = {
                        i = {
                            ["<C-Left>"] = actions.results_scrolling_left,
                            ["<C-Right>"] = actions.results_scrolling_right,
                            ["<A-Left>"] = actions.preview_scrolling_left,
                            ["<A-Right>"] = actions.preview_scrolling_right,
                            ["<A-Up>"] = actions.preview_scrolling_up,
                            ["<A-Down>"] = actions.preview_scrolling_down
                        },
                    },
                },
                pickers = {
                    buffers = {
                        show_all_buffers = true,
                        sort_lastused = true,
                        previewer = false,
                        mappings = {
                            i = {
                                ["<c-d>"] = "delete_buffer",
                            }
                        }
                    },
                    lsp_references = {
                        layout_strategy = 'vertical'
                    }
                }
            })

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
        },
        config = function()
            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
                callback = function(event)
                    local map = function(keys, func, desc)
                        vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
                    end

                    map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
                    map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
                    map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
                    map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
                    map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
                    map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
                    map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
                    map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
                    map("K", vim.lsp.buf.hover, "Hover Documentation")
                    map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

                    local client = vim.lsp.get_client_by_id(event.data.client_id)
                    if client and client.server_capabilities.documentHighlightProvider then
                        local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
                        vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                            buffer = event.buf,
                            group = highlight_augroup,
                            callback = vim.lsp.buf.document_highlight,
                        })

                        vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
                            buffer = event.buf,
                            group = highlight_augroup,
                            callback = vim.lsp.buf.clear_references,
                        })

                        vim.api.nvim_create_autocmd("LspDetach", {
                            group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
                            callback = function(event2)
                                vim.lsp.buf.clear_references()
                                vim.api.nvim_clear_autocmds { group = "kickstart-lsp-highlight", buffer = event2.buf }
                            end,
                        })
                    end
                    if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
                        map("<leader>th", function()
                            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
                        end, "[T]oggle Inlay [H]ints")
                    end
                end;
            })
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())
            local servers = {
                lua_ls = {
                    -- cmd = {...},
                    -- filetypes = { ...},
                    -- capabilities = {},
                    settings = {
                        Lua = {
                            completion = {
                                callSnippet = "Replace",
                            },
                            -- You can toggle below to ignore Lua_LS"s noisy `missing-fields` warnings
                            -- diagnostics = { disable = { "missing-fields" } },
                        },
                    },
                },
            }
            require("mason").setup()
            local ensure_installed = vim.tbl_keys(servers or {})
            vim.list_extend(ensure_installed, {
                "css-lsp",
                "prettierd",
                "svelte-language-server",
                "tailwindcss-language-server",
                "typescript-language-server"
            })
            require("mason-tool-installer").setup { ensure_installed = ensure_installed }

            require("mason-lspconfig").setup {
                handlers = {
                    function(server_name)
                        local server = servers[server_name] or {}
                        server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
                        require("lspconfig")[server_name].setup(server)
                    end,
                },
            }
        end,
    },
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        event = "VimEnter",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
        },
        keys = {
            {
                "<leader>.",
                "<Cmd>:Neotree position=float<CR>",
                desc = "Open Neotree float explorer"
            },
            {
                "<leader><tab>",
                "<Cmd>:Neotree toggle position=left reveal_force_cwd<CR>",
                desc = "Open Neotree drawer"
            }
        },
        config = function()
            require("neo-tree").setup({
                popup_border_style = "rounded",
                sort_case_insensitive = false,
                default_component_configs = {
                    file_size = { enabled = false },
                    last_modified = { enabled = false },
                    created = { enabled = false },
                    type = { enabled = false }
                },
                window = {
                    position = "float",
                    popup = {
                        size = { height = "95%", width = "50%" }
                    }
                }
            })
        end
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
                            require("luasnip.loaders.from_lua").lazy_load()
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
                completion = {
                    autocomplete = false,
                    completeopt = "menu,menuone,noinsert"
                },
                mapping = cmp.mapping.preset.insert {

                    -- Scroll the documentation window [b]ack / [f]orward
                    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),


                    ["<CR>"] = cmp.mapping.confirm { select = true },
                    -- Select the [n]ext item
                    ["<C-n>"] = cmp.mapping.select_next_item(),
                    -- Select the [p]revious item
                    ["<C-p>"] = cmp.mapping.select_prev_item(),

                    -- Manually trigger a completion from nvim-cmp.
                    --  Generally you don"t need this, because nvim-cmp will display
                    --  completions whenever it has completion options available.
                    ["<C-Space>"] = cmp.mapping.complete {},
                    ["<C-n>"] = cmp.mapping.complete {},

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
                "diff", "lua", "luadoc", "vim", "vimdoc",
                "terraform"
            },
            auto_install = false,
            sync_install = false,
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
            -- require("nvim-treesitter.install").prefer_git = true
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
        version = "v3.8.1",
        lazy = false,
        ft = "markdown",
        event = {
            "BufReadPre ~/vaults/main/**.md",
            "BufNewFile ~/vaults/main/**.md"
        },
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        opts = {
            notes_subdir = "",
            new_notes_location = "notes_subdir",
            note_id_func = function(title)
                local suffix = ""
                if title ~= nil then
                    return title
                else
                    for _ = 1, 4 do
                        suffix = suffix .. string.char(math.random(65, 90))
                    end
                end
                return tostring(os.time()) .. "-" .. suffix
            end,
            workspaces = {
                {
                    name = "main",
                    path = "~/vaults/main/",
                },
                {
                    name = "notes",
                    path = "~/git/github.com/stephane-klein/obsidian-quartz-playground/content/src/",
                }
            },
            ui = {
                enable = false
            },
            follow_url_func = function(url)
                vim.fn.jobstart({"xdg-open", url})
            end,
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
    },
    {
        "ggandor/leap.nvim",
        config = function()
            require("leap").set_default_keymaps()
        end
    },
    {
        "gbprod/cutlass.nvim",
        opts = {
            cut_key = "m"
        }
    },
    {
        "nvimtools/none-ls.nvim",
        dependencies = {
            "nvimtools/none-ls-extras.nvim",
        },
        config = function()
            local null_ls = require("null-ls")

            null_ls.setup({
                sources = {
                    require("none-ls.diagnostics.eslint")
                },
            })
        end
    },
    {
        "folke/trouble.nvim",
        opts = {},
        cmd = "Trouble",
        keys = {
            {
                "<leader>xx",
                "<cmd>Trouble diagnostics toggle<cr>",
                desc = "Diagnostics (Trouble)",
            },
            {
                "<leader>xX",
                "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
                desc = "Buffer Diagnostics (Trouble)",
            },
            {
                "<leader>cs",
                "<cmd>Trouble symbols toggle focus=false<cr>",
                desc = "Symbols (Trouble)",
            },
            {
                "<leader>cl",
                "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
                desc = "LSP Definitions / references / ... (Trouble)",
            },
            {
                "<leader>xL",
                "<cmd>Trouble loclist toggle<cr>",
                desc = "Location List (Trouble)",
            },
            {
                "<leader>xQ",
                "<cmd>Trouble qflist toggle<cr>",
                desc = "Quickfix List (Trouble)",
            },
        }
    },
    -- I decided to temporarily disable Activity Watch because of flood in gnome-shell logs
    -- {
    --     "ActivityWatch/aw-watcher-vim"
    -- },
    {
        "TheGrandmother/peggy-vim"
    },
    {
        'numToStr/Comment.nvim',
        opts = {}
    },
    -- Avante (Code Assistant) https://github.com/yetone/avante.nvim/
    {
        "yetone/avante.nvim",
        -- event = "VeryLazy",
        lazy = false,
        version = false,
        opts = {
            provider = "copilot",
            auto_suggestions_provider = "copilot",
            copilot = {
                model = "claude-3.5-sonnet"
            }
        },
        build = "make",
        dependencies = {
            "stevearc/dressing.nvim",
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
            "hrsh7th/nvim-cmp",
            "nvim-tree/nvim-web-devicons",
            {
                "zbirenbaum/copilot.lua",
                config = function()
                    require("copilot").setup({})
                end
            },
            {
                "HakonHarnes/img-clip.nvim",
                event = "VeryLazy",
                opts = {
                    default = {
                        embed_image_as_base64 = false,
                        prompt_for_file_name = false,
                        drag_and_drop = {
                            insert_mode = true,
                        },
                    },
                },
            },
            {
                'MeanderingProgrammer/render-markdown.nvim',
                opts = {
                    file_types = { "markdown", "Avante" },
                },
                ft = { "markdown", "Avante" },
            },
        }
    }
})

vim.api.nvim_create_user_command(
    "GoToVaultMain",
    function()
        vim.loop.chdir(vim.fn.expand("~/vaults/main/"))
    end,
    {}
)

vim.api.nvim_create_user_command(
    "GoToVaultNotes",
    function()
        vim.loop.chdir(vim.fn.expand("~/git/github.com/stephane-klein/obsidian-quartz-playground/content/src/"))
    end,
    {}
)
