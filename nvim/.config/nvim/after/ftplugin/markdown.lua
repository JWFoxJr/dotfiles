vim.opt_local.textwidth = 80
vim.opt_local.colorcolumn = "80"

-- Visual wrapping niceties
vim.opt_local.wrap = true
vim.opt_local.linebreak = true

-- Use Neovim's internal formatter for paragraph wrapping
vim.opt_local.formatprg = ""
vim.opt_local.formatexpr = ""

-- Known-good formatoptions for Markdown/prose wrapping
vim.opt_local.formatoptions = "tcroqn"
