local state = {
  term = {
    win = -1,
    buf = -1,
  }
}

local function create_term_window(opts)
  opts = opts or {}
  local width = opts.width or math.floor(vim.o.columns * 0.8)
  local height = opts.height or math.floor(vim.o.lines * 0.8)
  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)

  local buf = nil
  if vim.api.nvim_buf_is_valid(opts.buf) then
    buf = opts.buf
  else
    buf = vim.api.nvim_create_buf(false, true)
  end

  local win_config = {
    relative = "editor",
    width = width,
    height = height,
    row = row,
    col = col,
    style = "minimal",
  }

  local win = vim.api.nvim_open_win(buf, true, win_config)
  return { buf = buf, win = win }
end

local toggle_terminal = function()
  if not vim.api.nvim_win_is_valid(state.term.win) then
    state.term = create_term_window { buf = state.term.buf }
    if vim.bo[state.term.buf].buftype ~= "terminal" then
      vim.cmd.terminal()
    end
  else
    vim.api.nvim_win_hide(state.term.win)
  end
end

vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>")
vim.api.nvim_create_user_command("NVterm", toggle_terminal, {})
vim.keymap.set("n", "<leader>tm", toggle_terminal)
