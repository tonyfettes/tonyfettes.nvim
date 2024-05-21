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
    dir = '~/workspace/moonbit.nvim',
    ft = { 'moonbit' },
    dependencies = {
      'mfussenegger/nvim-lint',
    },
    opts = {}
  },

  {
    'stevearc/overseer.nvim',
    keys = {
      { '<leader>o', '<Cmd>OverseerToggle bottom<CR>', desc = 'Toggle Overseer' },
    },
    config = function ()
      local overseer = require'overseer'
      overseer.setup {}
      vim.api.nvim_create_user_command(
        'Make',
        function(params)
          -- Insert args at the '$*' in the makeprg
          local cmd, num_subs = vim.o.makeprg:gsub('%$%*', params.args)
          if num_subs == 0 then
            cmd = cmd .. ' ' .. params.args
          end
          local task = overseer.new_task({
            cmd = vim.fn.expandcmd(cmd),
            components = {
              { 'on_output_quickfix', open = not params.bang, open_height = 8 },
              'default',
            },
          })
          task:start()
        end, {
          desc = 'Run your makeprg as an Overseer task',
          nargs = '*',
          bang = true,
        }
      )
    end
  },

  {
    "nvim-neorg/neorg",
    dependencies = {
      { "vhyrro/luarocks.nvim", priority = 1000, config = true }
    },
    ft = "norg",
    opts = {
      load = {
        ["core.defaults"] = {},
      },
    },
  },

  {
    'danielo515/nvim-treesitter-reason',
    ft = 'reason'
  },

  {
    dir = '~/.opam/merlin/vim',
    name = 'merlin.vim',
    ft = { 'reason', 'ocaml', },
  },

  {
    'tomtomjhj/coq-lsp.nvim',
    dependencies = {
      { 'whonore/Coqtail', ft = { 'coq' } }
    },
    ft = { 'coq' },
    config = function ()
      vim.g.loaded_coqtail = 1
      vim.g["coqtail#supported"] = 0
      require'coq-lsp'.setup {}
    end
  },

  {
    "lervag/vimtex",
  },

  {
    "numToStr/Navigator.nvim",
    config = function ()
      local navigator = require'Navigator'
      navigator.setup {}
      vim.keymap.set({ 'n', 't' }, '<M-h>', '<Cmd>NavigatorLeft<CR>')
      vim.keymap.set({ 'n', 't' }, '<M-l>', '<Cmd>NavigatorRight<CR>')
      vim.keymap.set({ 'n', 't' }, '<M-k>', '<Cmd>NavigatorUp<CR>')
      vim.keymap.set({ 'n', 't' }, '<M-j>', '<Cmd>NavigatorDown<CR>')
      vim.keymap.set({ 'n', 't' }, '<M-p>', '<Cmd>NavigatorPrevious<CR>')
    end
  },
}
