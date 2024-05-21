return {
  'nvim-telescope/telescope.nvim',
  cmd = 'Telescope',
  keys = {
    { '<leader>f', '<Cmd>Telescope find_files<CR>', desc = 'Find Files' },
    { '<leader>/', '<Cmd>Telescope live_grep<CR>', desc = 'Live Grep' },
  },
  dependencies = {
    'nvim-lua/plenary.nvim'
  },
}
