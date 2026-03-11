return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
    },
    keys = {
      { '<Leader>e', '<Cmd>Neotree toggle<CR>', desc = "Open Tree" },
    },
    -- neo-tree will lazily load itself
    lazy = false,
    ---@type neotree.Config
    opts = {
      default_component_configs = {
        indent = {
          padding = -1,
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
            unstaged = "",
            staged = "S",
            conflict = "!",
          },
        },
      },
    },
  },
}
