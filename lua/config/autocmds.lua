-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

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
