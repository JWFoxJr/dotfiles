-- Markdown-specific settings

local opt = vim.opt_local

-- Layout & wrapping: better for prose
opt.wrap = true -- enable wrapping for markdown
opt.linebreak = true -- wrap at word boundaries, not mid-word
opt.breakindent = true -- keep indent on wrapped lines
opt.showbreak = "↳ " -- prefix for wrapped lines (pick what you like)

-- Line numbers: usually absolute is nicer for writing
opt.number = true
opt.relativenumber = false

-- Spelling
opt.spell = true
opt.spelllang = { "en_us" } -- add more: { "en_us", "en_gb" } etc.

-- Concealment: make markdown look nicer but not *too* magical
opt.conceallevel = 2 -- conceal things like emphasis markers
opt.concealcursor = "nc" -- no conceal in insert mode (only normal/command)

-- Preview / formatting friendly
opt.colorcolumn = "" -- no hard column ruler for prose
opt.textwidth = 0 -- don't auto-wrap text on insert
opt.signcolumn = "yes" -- keep layout stable if signs show up

-- Cursor line: optional, but some people find it distracting in prose
-- opt.cursorline = false
