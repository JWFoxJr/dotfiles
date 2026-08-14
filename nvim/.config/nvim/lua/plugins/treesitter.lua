return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = function()
      -- Disable :TSUpdate during Lazy sync/update on NixOS.
    end,
    opts = function(_, opts)
      opts.ensure_installed = {}
      opts.auto_install = false
      opts.sync_install = false
    end,
  },
}
