--- filtered-buffer.lua
local M = {}

local function filter_lines(input_buf, output_buf, regex)
  local lines = vim.api.nvim_buf_get_lines(input_buf, 0, -1, false)

  local filtered_lines = vim.tbl_filter(function(line)
    return line:match(regex) ~= nil
  end, lines)

  local current_win = vim.api.nvim_get_current_win()

  local wins = vim.fn.win_findbuf(output_buf)
  if #wins > 0 then
    vim.api.nvim_set_current_win(wins[1])
  end

  vim.api.nvim_buf_set_lines(output_buf, 0, -1, false, filtered_lines)

  local last_line = #filtered_lines
  if last_line > 0 then
    vim.api.nvim_win_set_cursor(0, { last_line, 0 })
  else
    vim.api.nvim_win_set_cursor(0, { 1, 0 }) -- Default to the first line if empty
  end

  vim.api.nvim_set_current_win(current_win)
end

M.filter_lines = filter_lines

return M
