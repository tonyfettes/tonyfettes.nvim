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
  }
}
