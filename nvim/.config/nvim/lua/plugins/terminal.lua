vim.api.nvim_create_autocmd("TermOpen", {
  group = vim.api.nvim_create_augroup("transparent_terminal", { clear = true }),
  callback = function()
    vim.wo.winhighlight = table.concat({
      "Normal:Normal",
      "NormalNC:Normal",
      "EndOfBuffer:EndOfBuffer",
      "SignColumn:SignColumn",
      "StatusLine:StatusLine",
      "StatusLineNC:StatusLineNC",
    }, ",")
  end,
})
