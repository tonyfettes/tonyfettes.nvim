return {
  {
    "NeogitOrg/neogit",
    keys = {
      { '<leader>g', '<Cmd>Neogit kind=auto<CR>', desc = 'Toggle Neogit' },
      { '<M-g>', '<Cmd>Neogit kind=auto<CR>', desc = 'Toggle Neogit' },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "sindrets/diffview.nvim",
      "ibhagwan/fzf-lua",
    },
    config = true
  },

  {
    'lewis6991/gitsigns.nvim',
    opts = {
      signcolumn = false,
      current_line_blame = true,
    },
  }
}
