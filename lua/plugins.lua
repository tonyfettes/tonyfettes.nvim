return {
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    opts = {
      indent = {
        highlight = 'VertSplit',
        char = '▏'
      },
      scope = {
        highlight = 'VertSplit',
        char = '▎',
        show_start = false,
        show_end = false,
        show_exact_scope = false
      },
    }
  },

  {
    'numToStr/Comment.nvim',
    opts = {},
    lazy = false,
  },

  {
    'lambdalisue/vim-suda',
    lazy = false
  },

  {
    'moonbit-community/moonbit.nvim',
    ft = { 'moonbit' },
    opts = {}
  },

  {
    "numToStr/Navigator.nvim",
    config = function()
      local navigator = require 'Navigator'
      navigator.setup {}
      vim.keymap.set({ 'n', 't' }, '<M-h>', '<Cmd>NavigatorLeft<CR>')
      vim.keymap.set({ 'n', 't' }, '<M-l>', '<Cmd>NavigatorRight<CR>')
      vim.keymap.set({ 'n', 't' }, '<M-k>', '<Cmd>NavigatorUp<CR>')
      vim.keymap.set({ 'n', 't' }, '<M-j>', '<Cmd>NavigatorDown<CR>')
    end
  },

  {
    'MeanderingProgrammer/render-markdown.nvim',
    opts = {}
  }
}
