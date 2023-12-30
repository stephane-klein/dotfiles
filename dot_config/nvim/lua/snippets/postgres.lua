local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require("luasnip.util.events")
local ai = require("luasnip.nodes.absolute_indexer")
local extras = require("luasnip.extras")
local l = extras.lambda
local rep = extras.rep
local p = extras.partial
local m = extras.match
local n = extras.nonempty
local dl = extras.dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local conds = require("luasnip.extras.expand_conditions")
local postfix = require("luasnip.extras.postfix").postfix
local types = require("luasnip.util.types")
local parse = require("luasnip.util.parser").parse_snippet
local ms = ls.multi_snippet
local k = require("luasnip.nodes.key_indexer").new_key

-- ls.cleanup()
ls.add_snippets("sql",
    {
        s(
            "plfunc",
            fmt(
                [[
                    DROP FUNCTION IF EXISTS {1}:{2};
                    CREATE FUNCTION {4}.{5}(
                        arg1 INTEGER
                        arg2 VARCHAR
                    ) RETURNS JSON
                    LANGUAGE 'plpgsql' SECURITY DEFINER
                    AS $$
                    DECLARE
                        _response JSON;
                        _invitation auth.invitations;
                    BEGIN
                        {3}
                    END;
                    $$;
                ]],
                {
                    i(1, "schema"),
                    i(2, "name"),
                    i(3, "..."),
                    rep(1),
                    rep(2)
                }
            )
        )
    }
)
