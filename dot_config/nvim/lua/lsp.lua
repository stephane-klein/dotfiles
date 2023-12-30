-- Setup lspconfig.
local nvim_lsp = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

-- Disable because this issue: https://github.com/stephane-klein/dotfiles/issues/27
-- nvim_lsp['cssls'].setup({
--     capabilities = capabilities
-- })
nvim_lsp.svelte.setup({
    capabilities = capabilities,
    settings = {
        svelte = {
            plugin = {
                svelte = {
                    compilerWarnings = {
                        -- I found this configuration here:
                        -- https://github.com/DaikyXendo/dotfile/blob/7ff5f84b170d6a50365a775c79bbd5dd84cd6093/nvim/lua/plug_configs/lspconfig.lua#L159
                        ["a11y-no-redundant-roles"] = "ignore"
                    }
                }
            }
        }
    }
})
nvim_lsp['html'].setup{
    capabilities = capabilities
}
-- nvim_lsp['sqlls'].setup{
--     capabilities = capabilities
-- }
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
