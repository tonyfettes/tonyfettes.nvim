return {
  'saghen/blink.cmp',
  version = '1.*',
  event = { 'InsertEnter', 'CmdlineEnter' },
  dependencies = {
    'L3MON4D3/LuaSnip',
    'zbirenbaum/copilot.lua',
    'fang2hou/blink-copilot',
    'Kaiser-Yang/blink-cmp-git',
    "Kaiser-Yang/blink-cmp-avante",
  },
  opts = function()
    return {
      snippets = { preset = 'luasnip' },
      keymap = { preset = 'super-tab' },
      completion = {
        documentation = {
          auto_show = true,
        },
        menu = {
          draw = {
            columns = { { 'kind' }, { 'label', 'label_description', gap = 1 } },
            components = {
              kind = {
                text = function(ctx) return '[' .. ctx.kind .. ']' end,
              },
            },
          },
        },
      },
      sources = {
        default = { 'avante', 'copilot', 'lsp', 'path', 'snippets', 'buffer', 'git' },
        per_filetype = {
          gitcommit = { 'git', 'buffer' },
        },
        providers = {
          avante = {
            module = 'blink-cmp-avante',
            name = 'Avante',
            opts = {
              -- options for blink-cmp-avante
            }
          },
          lsp = {
            -- Show buffer items even when the LSP returns matches.
            fallbacks = {},
          },
          copilot = {
            name = 'copilot',
            module = 'blink-copilot',
            score_offset = 100,
            async = true,
          },
          git = {
            name = 'Git',
            module = 'blink-cmp-git',
            enabled = function()
              return vim.bo.filetype == 'gitcommit'
            end,
          },
        },
      },
      cmdline = {
        sources = function()
          local cmdtype = vim.fn.getcmdtype()
          if cmdtype == '/' or cmdtype == '?' then
            return { 'buffer' }
          end
          if cmdtype == ':' then
            return { 'path', 'cmdline' }
          end
          return { 'cmdline' }
        end,
      },
    }
  end,
  opts_extend = { 'sources.default' },
}
