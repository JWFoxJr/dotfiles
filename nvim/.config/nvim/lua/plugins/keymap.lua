-- Exit insert mode with jj
vim.keymap.set("i", "jj", "<Esc>", { desc = "Exit insert mode" })

-- Exit insert mode in terminal with jj
vim.keymap.set("t", "jj", "<C-\\><C-n>", { desc = "Exit terminal mode" })
