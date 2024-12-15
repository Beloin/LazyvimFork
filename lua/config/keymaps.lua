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
map({ "i", "n" }, "<F7>", "<cmd>DapStepInto<CR>", { desc = "Step Into" })
map({ "i", "n" }, "<F8>", "<cmd>DapStepOver<CR>", { desc = "Step Over" })
map({ "i", "n" }, "<F9>", "<cmd>DapStepOut<CR>", { desc = "Step Out" })
map({ "i", "n" }, "<F10>", function()
  dap.restart()
end, { desc = "Restart DAP Session" })
map({"i","n"}, "<F11>", "<cmd>DapTerminate<CR>", { desc="Terminate DAP" })


-- Refactor maps
wk.add({
  { "<leader>r", group = "Prime Refactor" },
})

map("x", "<leader>re", ":Refactor extract ")
map("x", "<leader>rf", ":Refactor extract_to_file ")

map("x", "<leader>rv", ":Refactor extract_var ")

map({ "n", "x" }, "<leader>ri", ":Refactor inline_var")

map( "n", "<leader>rI", ":Refactor inline_func")

map("n", "<leader>rb", ":Refactor extract_block")
map("n", "<leader>rbf", ":Refactor extract_block_to_file")

