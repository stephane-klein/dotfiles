-- I use this file separate from init.lua
-- in order to easily reload it during my debugging phase
-- with the command:
-- :luafile ~/.config/nvim/lua/custom.lua

vim.api.nvim_create_user_command(
    'DeleteFile',
    function()
        local current_file = vim.fn.expand('%')
        if current_file ~= '' then
            vim.fn.system('rm "' .. current_file .. '"')
            vim.cmd('bdelete')
        end
    end,
    {}
)

vim.keymap.set(
    "n", "<Leader><Leader>n",
    function()
        local obsidian = require("obsidian")
        local client = obsidian.get_client()

        obsidian.log.set_level(vim.log.levels.WARN)

        obsidian.Workspace.switch("main", { lock = true })
        local note = obsidian.Note.create({ title = nil })
        note:open({ sync= true })
    end,
    { desc = "Create Obsidian unique note" }
)
vim.keymap.set(
    "n", "<Leader><Leader>d",
    "<Cmd>:ObsidianToday<CR>",
    { desc = "Open (or create) the daily note for today" }
)
vim.keymap.set(
    "n", "<Leader><Leader>o",
    "<Cmd>:ObsidianQuickSwitch<CR>",
    { desc = "Quick switch to another note" }
)
