-- Setup lspconfig.
local nvim_lsp = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

-- Disable because this issue: https://github.com/stephane-klein/dotfiles/issues/27
-- nvim_lsp['cssls'].setup({
--     capabilities = capabilities
-- })
nvim_lsp['svelte'].setup({
    capabilities = capabilities
})
nvim_lsp['html'].setup{
    capabilities = capabilities
}
nvim_lsp['sqls'].setup{
    capabilities = capabilities
}
nvim_lsp['tsserver'].setup{
    capabilities = capabilities
}

nvim_lsp['pyright'].setup{
    capabilities = capabilities,
    settings = {
        python = {
            analysis = {
                typeCheckingMode = "off"
            }
        }
    }
}
