return {
  {
    'nvim-telescope/telescope.nvim',
    version = '0.2.1',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('telescope').setup {}

      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>fd', builtin.find_files, {})
      vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
      vim.keymap.set('n', '<leader>en', function()
        builtin.find_files { cwd = vim.fn.stdpath('config')
        }
      end)
    end
  }
}
