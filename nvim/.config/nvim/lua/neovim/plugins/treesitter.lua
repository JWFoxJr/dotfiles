return {
	"nvim-treesitter/nvim-treesitter",
	event = { "BufReadPre", "BufNewFile" },
	build = ":TSUpdate",
	dependencies = {
		"windwp/nvim-ts-autotag",
	},
	config = function()
		-- import nvim-treesitter plugin
		local ts = require("nvim-treesitter.configs")

		-- configure treesitter
		ts.setup({ --enable syntax highlighting
			highlight = {
				enable = true,
			},
			-- enable indentation
			indent = { enable = true },
			-- enable autotagging (w/ nvim-ts-autotage plugin)
			autotag = {
				enable = true,
			},
			-- ensure these language servers are installed
			ensure_installed = {
				-- Core and Editor
				"lua",
				"vim",
				"vimdoc",
				"query",
				"regex",

				-- General programming
				"python",
				"c",

				-- Web/React
				"javascript",
				"typescript",
				"tsx",
				"html",
				"css",
				"scss",
				"json",
				"jsonc",

				-- Markdown/Hugo
				"markdown",
				"markdown_inline",
				"toml", -- Hugo front matter (TOML)
				"yaml", -- Hugo front matter (YAML)
				"gotmpl", -- Go templates used by Hugo

				-- DevOps/Sysadmin
				"bash",
				"dockerfile",
				"ini",
				"make",
				"cmake",
				"nginx", -- Just in case we start using nginx

				-- Git
				"gitcommit",
				"gitignore",
				"git_rebase",
				"diff",
			},
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<C-space>",
					node_incremental = "<C-space>",
					scope_incremental = false,
					node_decremental = "<bs>",
				},
			},
		})
	end,
}
