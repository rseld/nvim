return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = 'main',
    lazy = false,
    build = ":TSUpdate",

    config = function()
      require("nvim-treesitter").setup {
        install_dir = vim.fn.stdpath('data') .. '/lazy/nvim-treesitter/'
      }
    end
  },
}
