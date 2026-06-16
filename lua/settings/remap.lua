vim.g.mapleader = " "
vim.keymap.set("n", "<leader>ex", vim.cmd.Ex)
vim.keymap.set("n", "<leader>cd", function()
  local dir = vim.fn.expand("%:p:h")
  if dir ~= "" then
    vim.cmd("cd " .. vim.fn.fnameescape(dir))
    vim.print(vim.fn.fnameescape(dir))
  end
end, { desc = "cd to current file or directory" })
