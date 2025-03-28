return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      "b0o/schemastore.nvim",
    },
    config = function()
      local lspconfig = require 'lspconfig'
      local capabilities = require 'cmp_nvim_lsp'.default_capabilities()

      lspconfig.clangd.setup {
        capabilities = capabilities
      }
      lspconfig.ocamllsp.setup {
        capabilities = capabilities
      }
      lspconfig.jsonls.setup {
        capabilities = capabilities,
        settings = {
          json = {
            schemas = require 'schemastore'.json.schemas {
              extra = {
                {
                  description = 'MoonBit Module JSON schema',
                  fileMatch = { 'moon.mod.json' },
                  name = 'moon.mod.json',
                  url = '/home/tonyfettes/workspace/moonbit.nvim/schemas/mod.schema.json',
                },
                {
                  description = 'MoonBit Package JSON schema',
                  fileMatch = { 'moon.pkg.json' },
                  name = 'moon.pkg.json',
                  url = '/home/tonyfettes/workspace/moonbit.nvim/schemas/pkg.schema.json',
                },
              },
            },
            validate = { enable = true },
          }
        }
      }
      lspconfig.html.setup {
        capabilities = capabilities
      }
      lspconfig.ts_ls.setup {
        capabilities = capabilities
      }
      lspconfig.pyright.setup {
        capabilities = capabilities
      }
      lspconfig.texlab.setup {
        capabilities = capabilities,
        settings = {
          texlab = {
            forwardSearch = {
              executable = "evince-synctex",
              args = { "-f", "%l", "%p", "\"texlab -i %f -l %l\"" }
            }
          }
        }
      }
      lspconfig.lua_ls.setup {
        capabilities = capabilities,
        on_init = function(client)
          local path = client.workspace_folders[1].name
          if vim.loop.fs_stat(path .. '/.luarc.json') or vim.loop.fs_stat(path .. '/.luarc.jsonc') then
            return
          end
          client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
            runtime = {
              -- Tell the language server which version of Lua you're using
              -- (most likely LuaJIT in the case of Neovim)
              version = 'LuaJIT'
            },
            workspace = {
              checkThirdParty = false,
              library = {
                vim.env.VIMRUNTIME
                -- Depending on the usage, you might want to add additional paths here.
                -- "${3rd}/luv/library"
                -- "${3rd}/busted/library",
              }
              -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
              -- library = vim.api.nvim_get_runtime_file("", true)
            }
          })
        end,
        settings = {
          Lua = {}
        }
      }

      -- Global mappings.
      -- See `:help vim.diagnostic.*` for documentation on any of the below functions
      vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float)
      vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)

      -- Use LspAttach autocommand to only map the following keys
      -- after the language server attaches to the current buffer
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspConfig', {}),
        callback = function(args)
          local bufnr = args.buf
          local client = vim.lsp.get_client_by_id(args.data.client_id)

          -- Enable auto-completion. Note: Use CTRL-Y to select an item. |complete_CTRL-Y|
          if client and client:supports_method('textDocument/completion') then
            -- Optional: trigger autocompletion on EVERY keypress. May be slow!
            -- local chars = {}; for i = 32, 126 do table.insert(chars, string.char(i)) end
            -- client.server_capabilities.completionProvider.triggerCharacters = chars

            vim.lsp.completion.enable(true, client.id, args.buf, {autotrigger = true})
          end

          -- Buffer local mappings.
          -- See `:help vim.lsp.*` for documentation on any of the below functions
          local opts = { buffer = args.buf }
          vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
          vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
          vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
          vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
          vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
          vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
          vim.keymap.set('n', '<leader>wl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          end, opts)
          vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
          vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
          vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
          vim.keymap.set('n', '<leader>cl', vim.lsp.codelens.run, {})
          vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
          vim.keymap.set('n', '<leader>=', function()
            vim.lsp.buf.format { async = true }
          end, opts)

          -- Open a float window when there are diagnostics under cursor.
          vim.api.nvim_create_autocmd('CursorHold', {
            buffer = args.buf,
            callback = function()
              vim.diagnostic.open_float(nil, {
                focusable = false,
                close_events = { 'BufLeave', 'CursorMoved', 'InsertEnter', 'FocusLost' },
                source = 'if_many',
                scope = 'cursor'
              })
            end
          })

          vim.api.nvim_create_autocmd({ 'BufEnter', 'CursorHold', 'InsertLeave' }, {
            buffer = args.buf,
            callback = function()
              vim.lsp.codelens.refresh({ bufnr = 0 })
            end
          })

          if client and client.server_capabilities.documentHighlightProvider then
            vim.api.nvim_create_augroup('lsp_document_highlight', {
              clear = false
            })
            vim.api.nvim_clear_autocmds({
              buffer = bufnr,
              group = 'lsp_document_highlight',
            })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              group = 'lsp_document_highlight',
              buffer = bufnr,
              callback = vim.lsp.buf.document_highlight,
            })
            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              group = 'lsp_document_highlight',
              buffer = bufnr,
              callback = vim.lsp.buf.clear_references,
            })
          end
        end,
      })

      vim.diagnostic.config {
        signs = false,
      }
    end,
  },

  {
    'nvimtools/none-ls.nvim',
    config = function()
      local null_ls = require 'null-ls'
      null_ls.setup {
        sources = {
          null_ls.builtins.formatting.ocamlformat
        }
      }
    end
  },
}
