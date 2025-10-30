-- Save as snippets/hugo_frontmatter_luasnip.lua
local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

ls.add_snippets("markdown", {
  s("frontmatter", {
    t({"---"}),
    t({"title: ""}), i(1, "Post Title"), t({"""}),
    t({"date: "}), i(2, os.date("!%Y-%m-%dT%H:%M:%S-04:00")), t({""}),
    t({"draft: true"}),
    t({""}),
    t({"tags: []"}),
    t({""}),
    t({"categories: []"}),
    t({""}),
    t({"summary: ""}), i(3, ""), t({"""}),
    t({""}),
    t({"cover: ""}), i(4, ""), t({"""}),
    t({""}),
    t({"---", "", ""}),
    i(0),
  }),
  s("figure", {
    t({'{{< figure src="/images/'}), i(1, "image.jpg"), t({'" caption="'}), i(2, "Caption"), t({'" >}}'}),
  }),
})
