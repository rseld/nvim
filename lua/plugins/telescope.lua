return {
  {
    'nvim-telescope/telescope.nvim',
    version = '0.2.1',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('telescope').setup {
        defaults = {
          border = true,
          borderchars = {
            prompt = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
            results = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
            preview = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
          },
        },
        pickers = {
          find_files = {
            hidden = false,
            no_ignore = true,
          }
        },
      }

      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>fd', function()
        builtin.find_files { cwd = vim.fn.getcwd(-1)
      }
      end)
      vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
      vim.keymap.set('n', '<leader>en', function()
        builtin.find_files { cwd = vim.fn.stdpath('config')
        }
      end)
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('telescope-lsp-attach', { clear = true }),
        callback = function(event)
          local buf = event.buf
          vim.keymap.set('n', '<leader>gd', builtin.lsp_definitions, { buffer = buf, desc = '[G]oto [Definition]' })
        end
      })
    end
  }
}
