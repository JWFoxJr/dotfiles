return {
  'goolord/alpha-nvim',
  event = 'VimEnter',
  config = function()
    local a = require('alpha')
    local d = require('alpha.themes.dashboard')

    -- set header
    d.section.header.val = {
      "                                                     ",
      "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
      "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
      "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
      "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
      "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
      "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
      "                                                     ",
    }

    -- set menu
    d.section.buttons.val = {
      d.button('e', '  > New file', '<cmd>ene<CR>'),
      d.button('SPC ee', '  > Toggle file explorer', '<cmd>NvimTreeToggle<CR>'),
      d.button('SPC ff', '󰱼  > Find file', '<cmd>Telescope find_files<CR>'),
      d.button('SPC fs', '  > Find word', '<cmd>Telescope live_grep<CR>'),
      d.button('SPC wr', '󰁯  > Restore session for current directory', '<cmd>SessionRestore<CR>'),
      d.button('q', '  > Quit Neovim', '<cmd>qa<CR>'),
    }

    -- send config to alpha
    a.setup(d.opts)

    -- disable folding on alpha buffer
    vim.cmd([[autocmd FileType alpha setlocal nofoldenable]])
  end,
}
