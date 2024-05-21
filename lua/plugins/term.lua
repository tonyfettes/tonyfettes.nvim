return {
  {
    'akinsho/toggleterm.nvim',
    version = "*",
    keys = {
      { '<C-\\>', '<Cmd>ToggleTerm<CR>', desc = 'Toggle Terminal' },
      { '<M-Enter>', '<Cmd>ToggleTerm<CR>', desc = 'Toggle Terminal' }
    },
    opts = {
      open_mapping = { 'C-\\', '<M-Enter>' }
    }
  }
}
