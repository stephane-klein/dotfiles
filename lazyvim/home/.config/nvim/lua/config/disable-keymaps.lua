-- disable default keymaps in LazyVim
-- https://www.lazyvim.org/configuration/keymaps

local function safe_keymap_del(mode, lhs)
  -- Check if keymap exists
  if vim.fn.maparg(lhs, mode) ~= "" then
    -- Delete it if exists
    vim.keymap.del(mode, lhs)
  else
    print("keymap do not exists : ", lhs)
  end
end

-- better up/down
safe_keymap_del("n", "j")
safe_keymap_del("x", "j")
safe_keymap_del("n", "k")
safe_keymap_del("x", "k")

-- Move to window using the <ctrl> hjkl keys
safe_keymap_del("n", "<C-h>")
safe_keymap_del("n", "<C-j>")
safe_keymap_del("n", "<C-k>")
safe_keymap_del("n", "<C-l>")

-- Move Lines
safe_keymap_del("n", "<A-j>")
safe_keymap_del("n", "<A-k>")
safe_keymap_del("i", "<A-j>")
safe_keymap_del("i", "<A-k>")
safe_keymap_del("v", "<A-j>")
safe_keymap_del("v", "<A-k>")

-- buffers
safe_keymap_del("n", "<S-h>")
safe_keymap_del("n", "<S-l>")
safe_keymap_del("n", "[b")
safe_keymap_del("n", "]b")
safe_keymap_del("n", "<leader>bb")
safe_keymap_del("n", "<leader>`")

safe_keymap_del("n", "<leader>ur")

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
safe_keymap_del("n", "n")
safe_keymap_del("x", "n")
safe_keymap_del("o", "n")
safe_keymap_del("n", "N")
safe_keymap_del("x", "N")
safe_keymap_del("o", "N")

-- Add undo break-points
safe_keymap_del("i", ",")
safe_keymap_del("i", ".")
safe_keymap_del("i", ";")

--keywordprg
safe_keymap_del("n", "<leader>K")

-- lazy
safe_keymap_del("n", "<leader>l")

-- new file
safe_keymap_del("n", "<leader>fn")

safe_keymap_del("n", "<leader>xl")
safe_keymap_del("n", "<leader>xq")

safe_keymap_del("n", "[q")
safe_keymap_del("n", "]q")

-- formatting
safe_keymap_del("n", "<leader>cf")
safe_keymap_del("v", "<leader>cf")

-- diagnostic
safe_keymap_del("n", "<leader>cd")
safe_keymap_del("n", "]d")
safe_keymap_del("n", "[d")
safe_keymap_del("n", "]e")
safe_keymap_del("n", "[e")
safe_keymap_del("n", "]w")
safe_keymap_del("n", "[w")

-- stylua: ignore start

-- toggle options
safe_keymap_del("n", "<leader>uf")
safe_keymap_del("n", "<leader>uF")
safe_keymap_del("n", "<leader>us")
safe_keymap_del("n", "<leader>uw")
safe_keymap_del("n", "<leader>uL")
safe_keymap_del("n", "<leader>ul")
safe_keymap_del("n", "<leader>ud")
safe_keymap_del("n", "<leader>uc")
safe_keymap_del("n", "<leader>uh")
safe_keymap_del("n", "<leader>uT")
safe_keymap_del("n", "<leader>ub")

-- lazygit
safe_keymap_del("n", "<leader>gg")
safe_keymap_del("n", "<leader>gG")
safe_keymap_del("n", "<leader>gb")

safe_keymap_del("n", "<leader>gf")

-- quit
safe_keymap_del("n", "<leader>qq")

-- highlights under cursor
safe_keymap_del("n", "<leader>ui")

-- LazyVim Changelog
safe_keymap_del("n", "<leader>L")

-- floating terminal
safe_keymap_del("n", "<leader>ft")
safe_keymap_del("n", "<leader>fT")
safe_keymap_del("n", "<c-/>")
safe_keymap_del("n", "<c-_>")

-- Terminal Mappings
safe_keymap_del("t", "<esc><esc>")
safe_keymap_del("t", "<C-h>")
safe_keymap_del("t", "<C-j>")
safe_keymap_del("t", "<C-k>")
safe_keymap_del("t", "<C-l>")
safe_keymap_del("t", "<C-/>")
safe_keymap_del("t", "<c-_>")

-- windows
safe_keymap_del("n", "<leader>ww")
safe_keymap_del("n", "<leader>wd")
safe_keymap_del("n", "<leader>w-")
safe_keymap_del("n", "<leader>w|")
safe_keymap_del("n", "<leader>-")
safe_keymap_del("n", "<leader>|")

-- tabs
safe_keymap_del("n", "<leader><tab>l")
safe_keymap_del("n", "<leader><tab>f")
safe_keymap_del("n", "<leader><tab><tab>")
safe_keymap_del("n", "<leader><tab>]")
safe_keymap_del("n", "<leader><tab>d")
safe_keymap_del("n", "<leader><tab>[")
