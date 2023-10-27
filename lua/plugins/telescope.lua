return {
  'nvim-telescope/telescope.nvim', tag = '0.1.4',
  keys = {
    { '<leader>f', '<Cmd>Telescope find_files<CR>', desc = 'Find Files' },
  },
  dependencies = {
    'nvim-lua/plenary.nvim'
  },
}
