local function create_term_window(opts)
  opts = opts or {}
  local width = opts.width or math.floor(vim.o.columns * 0.4)
  local height = opts.height or math.floor(vim.o.lines * 0.4)


  local buf = vim.api.nvim_create_buf(false, true)

  local win_config = {
    split = "below",
    style = "minimal",
  }

  local win = vim.api.nvim_open_win(buf, true, win_config)
  return buf, win
end

local buf, win = create_term_window()
print(buf, win)
