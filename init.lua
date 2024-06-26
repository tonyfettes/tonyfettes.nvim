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
require'lazy'.setup('plugins', {
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

vim.cmd[[filetype plugin indent on]]
vim.filetype.add {
  extension = {
    re = 'reason',
    rei = 'reason',
  }
}

-- Connect Neovim's clipboard to the system one.
vim.cmd[[set clipboard+=unnamedplus]]

o.exrc = true

-- Setup Emacs-like key-bindings in insert mode.
vim.keymap.set('i', '<C-a>', '<Home>')
vim.keymap.set('i', '<C-e>', '<End>')
vim.keymap.set('i', '<C-b>', '<Left>')
vim.keymap.set('i', '<C-f>', '<Right>')
