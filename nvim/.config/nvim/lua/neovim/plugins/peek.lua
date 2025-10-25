return {
	"toppair/peek.nvim",
	build = "deno task --quiet build:fast",
	ft = { "markdown" },
	opts = { theme = "dark", app = "browser" }, -- or app = "webview" if supported on your OS
	keys = {
		{
			"<leader>md",
			function()
				local peek = require("peek")
				if peek.is_open() then
					peek.close()
				else
					peek.open()
				end
			end,
			desc = "Markdown Preview (Peek)",
		},
	},
}
