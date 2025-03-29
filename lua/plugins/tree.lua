return {
  'nvim-tree/nvim-tree.lua',
  keys = {
    { '<Leader>e', '<Cmd>NvimTreeFindFile<CR>', desc = "Open Tree" },
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

    local function smart_toggle()
      vim.notify('smart_toggle')
      local buffer = vim.api.nvim_get_current_buf()
      local filetype = vim.api.nvim_get_option_value("filetype", { buf = buffer })
      if filetype == "NvimTree" then
        api.tree.toggle()
      else
        api.tree.find_file({ open = true, focus = true })
      end
    end

    vim.keymap.set('n', '<Leader>e', smart_toggle)

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
