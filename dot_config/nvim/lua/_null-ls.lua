local null_ls = require("null-ls")

require("null-ls").setup({
    sources = {
        null_ls.builtins.diagnostics.eslint,
        null_ls.builtins.code_actions.eslint,
        null_ls.builtins.formatting.prettierd,
        null_ls.builtins.diagnostics.flake8.with({
            cwd = function(params)
                return vim.fn.fnamemodify(params.bufname, ':h')
            end
        })
    }
})

