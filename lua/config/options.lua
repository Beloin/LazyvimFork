-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.g.autoformat = false

local dap = require("dap")

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open({})
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  -- dapui.close({})
end
dap.listeners.before.event_exited["dapui_config"] = function()
  -- dapui.close({})
end

vim.api.nvim_create_user_command("CloseAllFloatingWindows", function(opts)
  local closed_windows = {}
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local config = vim.api.nvim_win_get_config(win)
    if config.relative ~= "" then -- is_floating_window?
      vim.api.nvim_win_close(win, false) -- do not force
      table.insert(closed_windows, win)
    end
  end
  print(string.format("Closed %d windows: %s", #closed_windows, vim.inspect(closed_windows)))
end, {
  nargs = 0,
  desc = "Remove all floating windows. Usually good when Plugins messes up",
})

vim.opt.laststatus = 3


vim.filetype.add({
  extension = {
    arb = "json"
  },
})
