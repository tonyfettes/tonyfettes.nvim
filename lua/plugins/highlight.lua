return {
  {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = ':TSUpdate',
    config = function()
      require 'nvim-treesitter'.install { 'rust', 'ocaml', 'python', 'typescript', 'javascript', 'wit' }
    end
  }
}
