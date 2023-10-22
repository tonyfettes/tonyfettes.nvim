return {
  'tonyfettes/adwaita.nvim',
  lazy = false,
  priority = 1000,
  config = function ()
    vim.cmd[[colorscheme adwaita]]
  end
}
