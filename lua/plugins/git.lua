return {
  {
    "NeogitOrg/neogit",
    keys = {
      { '<leader>g', '<Cmd>Neogit kind=auto<CR>', desc = 'Toggle Neogit' },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
      "nvim-telescope/telescope.nvim",
    },
    opts = {
      auto_show_console = false
    }
  },

  {
    'lewis6991/gitsigns.nvim',
    opts = {
      signcolumn = false,
      current_line_blame = true,
    },
  }
}
