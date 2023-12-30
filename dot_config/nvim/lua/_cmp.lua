vim.g.completeopt='menu,menuone,noselect'
local cmp = require('cmp')
local luasnip = require('luasnip')

local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

cmp.setup({
    completion = {
        autocomplete = false
    },
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
        ["<Tab>"] = cmp.mapping(
            function(fallback)
                if cmp.visible() then
                    cmp.select_next_item()
                    -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
                    -- that way you will only jump inside the snippet region
                elseif luasnip.expand_or_locally_jumpable() then
                   luasnip.expand_or_jump()
                elseif has_words_before() then
                   cmp.complete()
                else
                    fallback()
                end
            end,
            { "i", "s" }
        ),
        ["<S-Tab>"] = cmp.mapping(
            function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item()
                elseif luasnip.jumpable(-1) then
                    luasnip.jump(-1)
                else
                    fallback()
                end
            end,
            { "i", "s" }
        ),
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
