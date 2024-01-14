return {
  'nvim-telescope/telescope.nvim', tag = '0.1.4',
  keys = {
    { '<M-f>', '<Cmd>Telescope find_files<CR>', desc = 'Find files' },
    { '<M-/>', '<Cmd>Telescope live_grep<CR>', desc = 'Grep' },
  },
  dependencies = {
    'nvim-lua/plenary.nvim'
  },
}
