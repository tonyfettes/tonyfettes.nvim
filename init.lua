-- Bootstraps lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

local o = vim.o
local g = vim.g

-- Set <leader> key
g.mapleader = [[ ]]

-- Set the terminal to use true color
o.termguicolors = true

-- Loads plugins
require 'lazy'.setup('plugins', {
  install = {
    colorscheme = { 'default' },
  }
})

-- Shows the effects of substitution and search
o.inccommand = 'nosplit'

-- Set default tab size
o.tabstop = 2
o.shiftwidth = 2
o.softtabstop = 2
o.expandtab = true

o.wrap = false

o.updatetime = 250

-- Use global status line
o.laststatus = 3

-- Hide command line
o.cmdheight = 0

o.background = 'light'

vim.cmd [[filetype plugin indent on]]
vim.filetype.add {
  extension = {
    re = 'reason',
    rei = 'reason',
  }
}

-- Connect Neovim's clipboard to the system one.
vim.cmd [[set clipboard+=unnamedplus]]

o.exrc = true

-- Setup Emacs-like key-bindings in insert mode.
vim.keymap.set('i', '<C-a>', '<Home>')
vim.keymap.set('i', '<C-e>', '<End>')
vim.keymap.set('i', '<C-b>', '<Left>')
vim.keymap.set('i', '<C-f>', '<Right>')

vim.lsp.config['luals'] = {
  -- Command and arguments to start the server.
  cmd = { 'lua-language-server' },

  -- Filetypes to automatically attach to.
  filetypes = { 'lua' },

  -- Sets the "root directory" to the parent directory of the file in the
  -- current buffer that contains either a ".luarc.json" or a
  -- ".luarc.jsonc" file. Files that share a root directory will reuse
  -- the connection to the same LSP server.
  root_markers = { '.luarc.json', '.luarc.jsonc' },

  -- Specific settings to send to the server. The schema for this is
  -- defined by the server. For example the schema for lua-language-server
  -- can be found here https://raw.githubusercontent.com/LuaLS/vscode-lua/master/setting/schema.json
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
      },
      workspace = {
        library = {
          vim.env.VIMRUNTIME
        }
      }
    }
  }
}

vim.diagnostic.config({ virtual_lines = true, signs = false })

vim.cmd [[set completeopt+=menuone,noselect,popup]]
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('tonyfettes.lsp', {}),
  callback = function(args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
    if client:supports_method('textDocument/completion') then
      vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
      vim.keymap.set({ 'i', 's' }, '<Tab>', function()
        if vim.fn.pumvisible() ~= 0 then
          return '<C-N>'
        elseif vim.snippet.active({ direction = 1 }) then
          return '<Cmd>lua vim.snippet.jump(1)<CR>'
        else
          return '<Tab>'
        end
      end, { expr = true, silent = true })
      vim.keymap.set({ 'i', 's' }, '<CR>', function()
        local complete_info = vim.fn.complete_info({ "pum_visible", "selected" })
        if complete_info["pum_visible"] and complete_info["selected"] ~= -1 then
          return '<C-Y>'
        else
          return '<CR>'
        end
      end, { expr = true, silent = true })
    end

    -- Auto-format ("lint") on save.
    -- Usually not needed if server supports "textDocument/willSaveWaitUntil".
    if not client:supports_method('textDocument/willSaveWaitUntil')
        and client:supports_method('textDocument/formatting') then
      vim.api.nvim_create_autocmd('BufWritePre', {
        group = vim.api.nvim_create_augroup('tonyfettes.lsp', { clear = false }),
        buffer = args.buf,
        callback = function()
          vim.lsp.buf.format({ bufnr = args.buf, id = client.id, timeout_ms = 1000 })
        end,
      })
    end
  end,
})

vim.lsp.enable('luals')
