-- Set leader key to space
vim.g.mapleader = ' '

local km = vim.keymap

-- General keymaps

-- Use jk to exit insert mode
--km.set('i', 'jk', '<ESC>', { desc = 'Exit insert mode with jk' })		-- Disabled on systems that can have CapsLk remapped to Esc/Ctrl 

-- Clear search highlights
km.set('n', '<leader>nh', ':nohl<CR>', { desc = 'Clear search highlights' })

-- Delete single character without copying into register
-- km.set('n', 'x', '"_x')							-- Don't know why disabled, will ask Josean Martinez

-- Increment/decrement numbers
km.set('n', '<leader>+', '<C-a>', { desc = 'Increment number' })
km.set('n', '<leader>-', '<C-x>', { desc = 'Decrement number' })

-- Window management
km.set('n', '<leader>sv', '<C-w>v', { desc = 'Split window vertically' })
km.set('n', '<leader>sh', '<C-w>s', { desc = 'Split window horizontally' })
km.set('n', '<leader>se', '<C-w>=', { desc = 'Make splits equal size' })
km.set('n', '<leader>sx', '<cmd>close<CR>', { desc = 'Close current split' })

km.set('n', '<leader>to', '<cmd>tabnew<CR>', { desc = 'Open new tab' })
km.set('n', '<leader>tx', '<cmd>tabclose<CR>', { desc = 'Close current tab' })
km.set('n', '<leader>tn', '<cmd>tabn<CR>', { desc = 'Go to next tab' })
km.set('n', '<leader>tp', '<cmd>tabp<CR>', { desc = 'Go to previous tab' })
km.set('n', '<leader>tf', '<cmd>tabnew %<CR>', { desc = 'Open current buffer in a new tab' })
