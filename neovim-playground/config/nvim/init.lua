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
    {"catppuccin/nvim"},
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
    }
})
