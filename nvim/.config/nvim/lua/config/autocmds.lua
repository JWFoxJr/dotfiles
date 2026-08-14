local autocmds = {
  transparent_terminal = {
    clear = true,
    {
      event = "TermOpen",
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
    },
  },
}

for group_name, group in pairs(autocmds) do
  local augroup = vim.api.nvim_create_augroup(group_name, {
    clear = group.clear,
  })

  for _, autocmd in ipairs(group) do
    vim.api.nvim_create_autocmd(autocmd.event, {
      group = augroup,
      pattern = autocmd.pattern,
      callback = autocmd.callback,
    })
  end
end
