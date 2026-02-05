local client = vim.lsp.start({
  name = "howtospellsp",
  cmd = { "/home/reece/Projects/spellchecker/main" },

})
if not client then
  vim.notify("No client")
  return
end

vim.api.nvim_create_autocmd("FileType", {
  pattern = "txt",
  callback = function()
    vim.lsp.buf_attach_client(0, client)
  end
})
