vim.lsp.config('howtospellsp', {
  cmd = { '/home/reece/Projects/spellchecker/main' },
  filetypes = { 'text' }
})

vim.lsp.enable('howtospellsp')
