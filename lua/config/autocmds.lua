-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

local autocmd = vim.api.nvim_create_autocmd

autocmd("VimEnter", {
  group = vim.api.nvim_create_augroup("restore_session", { clear = true }),
  callback = function()
    local args = vim.v.argv
    if #args >= 2 then
      if args[#args] == "." then
        print("neovim last arg was '.', running current dir session.")
        require("persistence").load()
      end
    end
  end,
  nested = true,
  -- once = true
})

autocmd("BufEnter", {
  callback = function()
    local gs = require("gitsigns")
    gs.toggle_current_line_blame(true)
  end,
  nested = true,
  once = true,
})

-- Command to create a filtered buffer with regex filtering
vim.api.nvim_create_user_command("FilteredBuffer", function(opts)
  local fb = require("external.filtered-buffer")
  local input_buf = vim.api.nvim_get_current_buf()
  local regex = opts.args
  if regex == "" then
    vim.notify("Please provide a valid regex as an argument.", vim.log.levels.ERROR)
    return
  end

  local output_buf = vim.api.nvim_create_buf(false, true)
  vim.cmd("vsplit")
  vim.api.nvim_set_current_buf(output_buf)

  fb.filter_lines(input_buf, output_buf, regex)

  vim.api.nvim_create_autocmd({ "TextChanged", "TextChangedI", "BufWritePost" }, {
    buffer = input_buf,
    callback = function()
      if vim.api.nvim_buf_is_valid(output_buf) then
        fb.filter_lines(input_buf, output_buf, regex)
      end
    end,
  })
end, {
  nargs = 1,
  desc = "Create a live filtered buffer using the provided regex to filter lines",
})
