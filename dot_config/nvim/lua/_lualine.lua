require('lualine').setup({
    options = {
        theme = 'tokyonight',
        globalstatus = true
    },
    extensions = { 'fugitive' },
    sections = {
        lualine_c = {}
    },
    winbar = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {
            {
                'filename',
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
                'filename',
                path = 1
            }
        },
        lualine_x = {},
      lualine_y = {},
      lualine_z = {}
    }
})
