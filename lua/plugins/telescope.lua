return {
  {
    'nvim-telescope/telescope.nvim',
    version = '0.2.1',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      vim.keymap.set("n", "<leader>fd", require('telescope.builtin').find_files)
      vim.keymap.set("n", "<leader>en", function()
        require('telescope.builtin').find_files {
          cwd = vim.fn.stdpath("config")
        }
      end)
    end
  }
}
