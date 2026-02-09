return {
  {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = ':TSUpdate',
    config = function()
      require 'nvim-treesitter'.install { 'lua', 'vim', 'vimdoc', 'query', 'rust', 'ocaml', 'python', 'typescript', 'javascript', 'wit', }
    end
  }
}
