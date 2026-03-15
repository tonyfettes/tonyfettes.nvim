return {
  {
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
        api.map.on_attach.default(bufnr)

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
        diagnostics = {
          enable = true,
          show_on_dirs = true,
          icons = {
            error = "E",
            warning = "W",
            info = "I",
            hint = "H",
          },
        },
        on_attach = on_attach,
        renderer = {
          add_trailing = true,
          group_empty = true,
          highlight_git = "all",
          highlight_diagnostics = "all",
          highlight_hidden = "name",
          icons = {
            show = {
              file = false,
              folder = false,
              folder_arrow = false,
              git = true,
              modified = true,
              hidden = false,
              diagnostics = true,
              bookmarks = false,
            },
            git_placement = "signcolumn",
            diagnostics_placement = "right_align",
            glyphs = {
              git = {
                unstaged = "┃",
                staged = "┃",
                unmerged = "┃",
                renamed = "~",
                untracked = "┇",
                deleted = "-",
                ignored = "",
              },
            },
          }
        }
      }

      vim.cmd [[
        :hi link NvimTreeGitNewIcon Added
        :hi link NvimTreeGitDirtyIcon Changed
        :hi link NvimTreeGitDeletedIcon Removed
        :hi link NvimTreeGitRenamedIcon Changed
        :hi link NvimTreeGitStagedIcon GitSignsStagedAdd
      ]]
    end
  },

  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
    },
    enabled = false,
    keys = {
      { '<Leader>e', '<Cmd>Neotree toggle<CR>', desc = "Open Tree" },
    },
    -- neo-tree will lazily load itself
    lazy = false,
    ---@type neotree.Config
    opts = {
      default_component_configs = {
        indent = {
          with_markers = false,
        },
        icon = {
          folder_closed = "",
          folder_open = "",
          folder_empty = "",
          folder_empty_open = "",
          default = "",
          use_filtered_colors = true,
        },
        name = {
          trailing_slash = true
        },
        git_status = {
          symbols = {
            added = "A",
            modified = "M",
            deleted = "D",
            renamed = "R",
            -- Status type
            untracked = "?",
            unstaged = "U",
            staged = "S",
            conflict = "!",
          },
        },
      },
    },
  },
}
