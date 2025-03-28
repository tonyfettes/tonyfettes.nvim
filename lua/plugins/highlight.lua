return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      require 'nvim-treesitter.configs'.setup {
        ensure_installed = { 'lua', 'vim', 'vimdoc', 'query', 'rust', 'ocaml', 'python', 'typescript', 'javascript', 'wit', },
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
    config = function()
      require 'nvim-treesitter.configs'.setup {
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
}
