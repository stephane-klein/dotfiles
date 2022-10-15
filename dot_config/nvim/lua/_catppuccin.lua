require("catppuccin").setup({
    integrations = {
        gitsigns = true,
        nvimtree = true,
        telescope = true,
        treesitter = true,
        which_key = true
    }
})

vim.g.catppuccin_flavour = "mocha" -- latte, frappe, macchiato, mocha
-- vim.cmd('colorscheme catppuccin')
vim.cmd('Catppuccin ' .. "mocha")
vim.cmd [[ hi! link debugPC TSNote ]]

-- toggle colorscheme between light and dark
vim.api.nvim_create_user_command('ToggleDarkMode', function()
    if vim.g.catppuccin_flavour == "mocha" then
        vim.g.catppuccin_flavour = "latte"
        vim.cmd('Catppuccin ' .. "latte")
    else
        vim.g.catppuccin_flavour = "mocha"
        vim.cmd('Catppuccin ' .. "mocha")
    end

    vim.cmd [[ hi! link debugPC TSNote ]]
end, {})
