require("config.lazy")
require("settings")

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('auto-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})
