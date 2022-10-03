require('lualine').setup({
    options = {
        theme = 'tokyonight',
    },
    extensions = { 'fugitive' },
    sections = {
        lualine_a = {
            {
                'filename',
                file_status = true,
                path = 1
            }
        }
    }
})
