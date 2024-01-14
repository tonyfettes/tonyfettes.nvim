return {
  {
    'akinsho/toggleterm.nvim',
    version = "*",
    keys = {
      { '<C-\\>', '<Cmd>ToggleTerm<CR>', desc = 'Toggle Terminal' }
    },
    opts = {
      open_mapping = [[<C-\>]]
    }
  }
}
