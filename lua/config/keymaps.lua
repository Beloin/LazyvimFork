-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set
local wk = require("which-key")

map("i", "jk", "<ESC>", { desc = "Escape insert mode" })

-- Re-maping default per-line up and down
map("n", "<C-e>", "5<C-e>")
map("n", "<C-y>", "5<C-y>")

local dap = require("dap")
map({ "i", "n" }, "<F5>", "<cmd>DapContinue<CR>", { desc = "Continue" })
map({ "i", "n" }, "<F7>", "<cmd>DapStepInto<CR>", { desc = "Step Into" })
map({ "i", "n" }, "<F8>", "<cmd>DapStepOver<CR>", { desc = "Step Over" })
map({ "i", "n" }, "<F9>", "<cmd>DapStepOut<CR>", { desc = "Step Out" })
map({ "i", "n" }, "<F10>", function()
  dap.restart()
end, { desc = "Restart DAP Session" })
map({ "i", "n" }, "<F11>", "<cmd>DapTerminate<CR>", { desc = "Terminate DAP" })

--#region Refactor
-- Prime Refactor maps
wk.add({
  { "<leader>r", group = "Prime Refactor" },
})

map("x", "<leader>re", ":Refactor extract ")
map("x", "<leader>rf", ":Refactor extract_to_file ")
map("x", "<leader>rv", ":Refactor extract_var ")
map({ "n", "x" }, "<leader>ri", ":Refactor inline_var")
map("n", "<leader>rI", ":Refactor inline_func")
map("n", "<leader>rb", ":Refactor extract_block")
map("n", "<leader>rbf", ":Refactor extract_block_to_file")
--#endregion

map("n", "<leader>we", "<cmd>Neotree<cr>", { desc = "Neotree from Here" })

map({ "n", "x" }, "d", '"_d')

map({ "n" }, "<Leader><Tab>n", "<cmd>tabnext<cr>", { desc = "Next Tab" })
map({ "n" }, "<Leader><Tab>p", "<cmd>tabprevious<cr>", { desc = "Prev Tab" })

--#region AI
wk.add({
  { "<leader>a", group = "AI Integrations" },
})
map({ "n" }, "<Leader>ac", "<cmd>CodeCompanionChat<cr>", { desc = "Code Companion Chat" })
map({ "n" }, "<Leader>aa", "<cmd>CodeCompanionActions<cr>", { desc = "Code Companion Actions" })
--#endregion

--#region Finder
-- Command to look for current main file
vim.api.nvim_create_user_command("GotoMain", function(opts)
  local mainFinder = require("utils.main_finder.main_finder")
  local found, main = mainFinder.getMain()
  if found then
    vim.cmd("edit " .. main)
  else
    print("Fuck off")
  end
end, {
  desc = "Look for main file",
})

map({ "n" }, "gm", "<cmd>GotoMain<cr>", { desc = "Go to main file" })

--#endregion

vim.keymap.set("n", "<leader>df", function()
  local widgets = require("dap.ui.widgets")
  widgets.centered_float(widgets.frames)
end, { desc = "Open Floating" })

--#region Hurl Keymaps

wk.add({
  { "<leader>h", group = "Hurl Keymaps" },
})

map({ "n" }, "<leader>hA", "<cmd>HurlRunner<CR>", { desc = "Run All requests" })
map({ "n" }, "<leader>ha", "<cmd>HurlRunnerAt<CR>", { desc = "Run Api request" })
map({ "n" }, "<leader>he", "<cmd>HurlRunnerToEnd<CR>", { desc = "Run Api request from current entry to end" })
map({ "n" }, "<leader>hh", "<cmd>HurlRunnerToEntry<CR>", { desc = "Run Api request to entry" })
map({ "v" }, "<leader>ha", ":HurlRunner<CR>", { desc = "Run Api Request" })

--#endregion
