return {
  'nvim-telescope/telescope.nvim',
  cmd = 'Telescope',
  keys = {
    { '<Leader>ff', '<Cmd>Telescope find_files<CR>', desc = 'Find Files' },
    { '<Leader>fg', '<Cmd>Telescope live_grep<CR>', desc = 'Live grep' },
    { '<Leader>fb', '<Cmd>Telescope buffers<CR>',    desc = 'Buffers' },
    { '<Leader>fh', '<Cmd>Telescope help_tags<CR>',  desc = 'Help tags' },
  },
  dependencies = {
    'nvim-lua/plenary.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  },
  config = function()
    local telescope = require 'telescope'
    local actions = require 'telescope.actions'
    telescope.setup {
      defaults = {
        mappings = {
          i = {
            ["<C-g>"] = actions.close
          }
        }
      }
    }
  end
}
