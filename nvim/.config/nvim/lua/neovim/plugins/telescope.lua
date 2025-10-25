return {
  'nvim-telescope/telescope.nvim',
  branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    'nvim-tree/nvim-web-devicons',
    'folke/todo-comments.nvim',
  },
  config = function()
    local telescope = require('telescope')
    local actions = require('telescope.actions')

    telescope.setup({
      defaults = {
        path_display = { 'smart' },
        mappings = {
          i = {
            ['<C-k>'] = actions.move_selection_previous,
            ['<C-j>'] = actions.move_selection_next,
            ['<C-q>'] = actions.send_selected_to_qflist + actions.open_qflist,
          },
        },
      },
    })

    telescope.load_extension('fzf')

    -- set keymaps
    local km = vim.keymap

    km.set('n', '<leader>ff', '<cmd>Telescope find_files<CR>', { desc = 'Fuzzy find files in cwd' })
    km.set('n', '<leader>fr', '<cmd>Telescope oldfiles<CR>', { desc = 'Fuzzy find recent files' })
    km.set('n', '<leader>fs', '<cmd>Telescope live_grep<CR>', { desc = 'Find string in cwd' })
    km.set('n', '<leader>fc', '<cmd>Telescope grep_string<CR>', { desc = 'Find string under cursor in cwd' })
    km.set('n', '<leader>ft', '<cmd>TodoTelescope<CR>', { desc = 'Find todos' })
  end,
}
