return {
  'nvim-tree/nvim-tree.lua',
  keys = {
    { '<Leader>e', '<Cmd>NvimTreeFindFileToggle<CR>', desc = "Open Tree" },
  },
  config = function()
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    local tree = require 'nvim-tree'
    local api = require 'nvim-tree.api'

    local function on_attach(bufnr)
      api.config.mappings.default_on_attach(bufnr)

      local function change_directory_to(node)
        if node == nil then
          node = api.tree.get_node_under_cursor()
        end
        if node ~= nil and node.type == "directory" then
          vim.api.nvim_set_current_dir(node.absolute_path)
        end
        api.tree.change_root_to_node(node)
      end
      vim.keymap.set('n', '<C-]>', change_directory_to,
        { buffer = bufnr, noremap = true, silent = true, desc = "Change Directory to Node" })
    end

    tree.setup {
      on_attach = on_attach,
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
