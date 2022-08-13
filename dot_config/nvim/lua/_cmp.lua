vim.g.completeopt='menu,menuone,noselect'
local cmp = require('cmp')
cmp.setup({
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end
    },
    sources = {
        { name = 'nvim-lsp' },
        { name = 'buffer' },
        { name = 'path' },
        { name = 'luasnip' }
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered()
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
})
cmp.setup.cmdline('/', {
    completion = {
        autocomplete = false
    },
    mapping = cmp.mapping.preset.cmdline({
        ['<C-Space>'] = { c = cmp.mapping.complete() },
        ['<Down>'] = { c = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert })},
        ['<Up>'] = { c = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert })},
        ['<CR>'] = { c = cmp.mapping.confirm({ select = true })}, -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = {
        { name = 'buffer' }
    }
})
cmp.setup.cmdline(':', {
    completion = {
        autocomplete = false
    },
    mapping = cmp.mapping.preset.cmdline({
        ['<C-Space>'] = { c = cmp.mapping.complete() },
        ['<Down>'] = { c = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert })},
        ['<Up>'] = { c = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert })},
        ['<CR>'] = { c = cmp.mapping.confirm({ select = true })}, -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources(
        {{ name = 'path' }},
        {{ name = 'cmdline' }}
    )
})
require("luasnip.loaders.from_vscode").lazy_load();
