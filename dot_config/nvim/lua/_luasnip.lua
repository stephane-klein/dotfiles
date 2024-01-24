require('snippets/docker-compose')
require('snippets/javascript')
require('snippets/postgres')
require('snippets/scripts')

local luasnip = require('luasnip')
luasnip.filetype_extend("svelte", {"javascript", "html"});
