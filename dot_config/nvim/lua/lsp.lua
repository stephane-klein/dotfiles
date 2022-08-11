   -- Setup lspconfig.
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
require('lspconfig')['cssls'].setup({
    capabilities = capabilities
})
require('lspconfig')['svelte'].setup({
    capabilities = capabilities
})
-- require('lspconfig')['html-lsp'].setup{}
-- require('lspconfig')['lua-language-server'].setup{}
-- require('lspconfig')['prettierd'].setup{}
-- require('lspconfig')['sql-formatter'].setup{}
-- require('lspconfig')['sqls'].setup{}
-- require('lspconfig')['typescript-language-server'].setup{}
-- require('lspconfig')['vim-language-server'].setup{}

