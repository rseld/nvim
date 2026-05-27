return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = 'main',
    lazy = false,
    build = ":TSUpdate",

    init = function()
      local parsers = {
        "lua",
        "c",
        "vimdoc",
        "vim",
        "markdown",
        "query",
      }
      vim.api.nvim_create_autocmd("User", {
        group = group,
        pattern = "VeryLazy",
        once = true,
        callback = function()
          require("nvim-treesitter").install(parsers)
        end,
      })
    end
  },
}
