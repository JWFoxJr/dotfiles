return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    local ll = require('lualine')
    local ls = require('lazy.status')     -- configures lazy pending updates count

    -- Catppuccin Mocha palette
local colors = {
  blue        = "#89b4fa",
  green       = "#a6e3a1",
  violet      = "#cba6f7",
  yellow      = "#f9e2af",
  red         = "#f38ba8",
  fg          = "#cdd6f4", -- text
  bg          = "#1e1e2e", -- base
  inactive_bg = "#313244", -- surface0
  semilight   = "#6c7086", -- overlay1
}

local my_lualine_theme = {
  normal = {
    a = { bg = colors.blue, fg = colors.bg, gui = "bold" },
    b = { bg = colors.bg, fg = colors.fg },
    c = { bg = colors.bg, fg = colors.fg },
  },
  insert = {
    a = { bg = colors.green, fg = colors.bg, gui = "bold" },
    b = { bg = colors.bg, fg = colors.fg },
    c = { bg = colors.bg, fg = colors.fg },
  },
  visual = {
    a = { bg = colors.violet, fg = colors.bg, gui = "bold" },
    b = { bg = colors.bg, fg = colors.fg },
    c = { bg = colors.bg, fg = colors.fg },
  },
  command = {
    a = { bg = colors.yellow, fg = colors.bg, gui = "bold" },
    b = { bg = colors.bg, fg = colors.fg },
    c = { bg = colors.bg, fg = colors.fg },
  },
  replace = {
    a = { bg = colors.red, fg = colors.bg, gui = "bold" },
    b = { bg = colors.bg, fg = colors.fg },
    c = { bg = colors.bg, fg = colors.fg },
  },
  inactive = {
    a = { bg = colors.inactive_bg, fg = colors.semilight, gui = "bold" },
    b = { bg = colors.inactive_bg, fg = colors.semilight },
    c = { bg = colors.inactive_bg, fg = colors.semilight },
  },
}

    ll.setup({
      options = {
        theme = my_lualine_theme,
      },
      sections = {
        lualine_x = {
          {
            ls.updates,
            cond = ls.has_updates,
            color = { fg = '#ff9e64' },
          },
          { 'encoding' },
          { 'fileformat' },
          { 'filetype' },
        },
      },
    })
  end,
}
