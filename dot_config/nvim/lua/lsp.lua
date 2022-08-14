   -- Setup lspconfig.
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

-- Disable because this issue: https://github.com/stephane-klein/dotfiles/issues/27
-- require('lspconfig')['cssls'].setup({
--     capabilities = capabilities
-- })
require('lspconfig')['svelte'].setup({
    capabilities = capabilities
})
require('lspconfig')['html'].setup{
    capabilities = capabilities
}
-- require('lspconfig')['lua-language-server'].setup{}
-- require('lspconfig')['prettierd'].setup{}
-- require('lspconfig')['sql-formatter'].setup{}
require('lspconfig')['sqls'].setup{
    capabilities = capabilities
}
require('lspconfig')['tsserver'].setup{
    capabilities = capabilities
}
-- require('lspconfig')['vim-language-server'].setup{}

