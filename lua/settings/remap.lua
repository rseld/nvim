vim.g.mapleader = " "
vim.keymap.set("n", "<leader>ex", vim.cmd.Ex)
vim.keymap.set("n", "<leader>u", ":Undotree<CR>", { desc = "undo tree" })
vim.keymap.set("n", "<C-f>", function()
  vim.fn.system("tmux display-popup -E sessionizer")
end)
