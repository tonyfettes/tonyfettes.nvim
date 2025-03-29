return {
  {
    'folke/trouble.nvim',
    opts = {
      modes = {
        diagnostics = {
          desc = "diagnostics",
          events = { "DiagnosticChanged", "BufEnter" },
          source = "diagnostics",
          groups = {
            { "directory", format = "{dirname}" },
            { "filename", format = "{basename} {count}" },
          },
          sort = { "severity", "filename", "pos", "message" },
          format = "{severity_icon} {message:md} {item.source} {code} {pos}",
        },
      },
      icons = {
        indent = {
          fold_open = "",
          fold_closed = "",
        },
      },
    },
    cmd = "Trouble",
    keys = {
      {
        '<Leader>x',
        '<Cmd>Trouble diagnostics toggle<CR>',
        desc = "Diagnostics"
      },
    }
  }
}
