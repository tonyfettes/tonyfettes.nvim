return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function ()
      require'nvim-treesitter.configs'.setup {
        ensure_installed = { 'lua', 'vim', 'vimdoc', 'query', 'rust', 'ocaml', 'python' },
        highlight = {
          enable = true,
        },
        indent = {
          enable = true
        }
      }
    end
  },

  {
    "nvim-treesitter/playground",
    cmd = "TSPlaygroundToggle",
    config = function ()
      require'nvim-treesitter.configs'.setup {
        playground = {
          enable = true,
          disable = {},
          keybindings = {
            toggle_query_editor = 'o',
            toggle_hl_groups = 'i',
            toggle_injected_languages = 't',
            toggle_anonymous_nodes = 'a',
            toggle_language_display = 'I',
            focus_language = 'f',
            unfocus_language = 'F',
            update = 'R',
            goto_note = '<cr>',
            show_help = '?',
          }
        }
      }
    end
  },

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
  }
}
