return {
  'nvim-tree/nvim-tree.lua',
  keys = {
    { '<Leader>e', '<Cmd>NvimTreeToggle<CR>', desc = "Open Tree" },
    { '<M-e>',     '<Cmd>NvimTreeToggle<CR>', desc = "Open Tree" }
  },
  config = function()
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    require 'nvim-tree'.setup {
      renderer = {
        icons = {
          show = {
            file = false,
            folder = false,
            folder_arrow = false,
            git = false,
            modified = false,
            diagnostics = false,
            bookmarks = false,
          }
        }
      }
    }
  end
}
