vim.cmd('let g:netwr_liststyle = 3')

local opt = vim.opt

-- Line numbers
opt.relativenumber = true			-- show relative line numbers
opt.number = true				-- show absolute line number on cursor line (when relative number is on)

-- Tabs and indentation
opt.tabstop = 2					-- 2 spaces for tabs (prettier default)
opt.shiftwidth = 2				-- 2 spaces for indent width
opt.expandtab = true				-- expand tabs to spaces
opt.autoindent = true				-- copy indent from current line when starting a new one

-- Line wrapping
opt.wrap = false				-- disable line wrapping

-- Search settings
opt.ignorecase = true				-- ignore case when searching
opt.smartcase = true				-- if you include mixed case in your search, assumes you want case-sensitive

-- Cursor line
opt.cursorline = true				-- hightlight the current cursor line

-- Appearance
opt.termguicolors = true			-- turn on termguicolors for nightfly colorscheme to work, have to use iTerm2 or any other true color terminal
opt.background = 'dark'				-- colorschemes that can be light or dark will be made dark
opt.signcolumn = 'yes'				-- show sign column so text doesn't shift

-- Backspace
opt.backspace = 'indent,eol,start'		-- allow backspace on indent, end of line, or insert mode start

-- Clipboard
opt.clipboard:append('unnamedplus')		-- use system clipboard as default register

-- Split windows
opt.splitright = true				-- split vertical window to the right
opt.splitbelow = true				-- split horizontal window to the bottom

-- Turn off swapfile
opt.swapfile = false
