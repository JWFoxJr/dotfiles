return {
  'gbprod/substitute.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    local substitute = require('substitute')

    substitute.setup()

    -- set keymaps
    local km = vim.keymap

    km.set('n', 's', substitute.operator, { desc = 'Substitute with motion' })
    km.set('n', 'ss', substitute.line, { desc = 'Subtitute line' })
    km.set('n', 'S', substitute.eol, { desc = 'Substitute to end of line' })
    km.set('x', 's', substitute.visual, { desc = 'Substitute in visual mode' })
  end,
}
