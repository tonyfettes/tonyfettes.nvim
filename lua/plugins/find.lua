return {
  'nvim-telescope/telescope.nvim',
  cmd = 'Telescope',
  keys = {
    { '<Leader>f', '<Cmd>Telescope find_files<CR>', desc = 'Find Files' },
    { '<Leader>b', '<Cmd>Telescope buffers<CR>',    desc = 'Buffers' },
    { '<Leader>/', '<Cmd>Telescope live_grep<CR>',  desc = 'Live Grep' },
  },
  dependencies = {
    'nvim-lua/plenary.nvim'
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
