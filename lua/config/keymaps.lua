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

wk.add({
  { "<leader>am", group = "Minuet" },
})
map({ "n" }, "<leader>amv", "<cmd>Minuet virtualtext toggle<cr>", { desc = "Minuet toggle virtualtext" })
map({ "n" }, "<leader>ame", "<cmd>Minuet virtualtext enable<cr>", { desc = "Minuet enable virtualtext" })
map({ "n" }, "<leader>amb", "<cmd>Minuet blink toggle<cr>", { desc = "Minuet blink toggle" })
map({ "n" }, "<leader>ama", "<cmd>Minuet lsp attach<cr>", { desc = "Minuet lsp attach" })
map({ "n" }, "<leader>amd", "<cmd>Minuet lsp detach<cr>", { desc = "Minuet lsp detach" })

map({ "n" }, "<Leader>ac", "<cmd>CodeCompanionChat Toggle<cr>", { desc = "Code Companion Chat" })
map({ "v" }, "<Leader>ac", "<cmd>CodeCompanionChat Add<cr>", { desc = "Code Companion Chat" })
map({ "n" }, "<Leader>ah", "<cmd>CodeCompanionHistory<cr>", { desc = "Code Companion history" })
map(
  { "n", "v" },
  "<Leader>ag",
  '<cmd>CodeCompanion you can use @{files}, @{fetch_webpage}, @{insert_edit_into_file}, @{cmd_runner}, @{mcphub} Answer only with "Ok!" respecting any schema and wait for my next prompts<cr>',
  { desc = "Code Companion Agent" }
)

-- Models
wk.add({
  { "<leader>as", group = "Select Model" },
})
map({ "n" }, "<Leader>asx", "<cmd>CodeCompanionChat adapter=grok<cr>", { desc = "Grok" })
map({ "n" }, "<Leader>asc", "<cmd>CodeCompanionChat adapter=anthropic<cr>", { desc = "Cláudia" })
map({ "n" }, "<Leader>asg", "<cmd>CodeCompanionChat adapter=openai<cr>", { desc = "GPTelson" })

map({ "n", "v" }, "<Leader>aa", "<cmd>CodeCompanionActions<cr>", { desc = "Code Companion Actions" })
map({ "n", "v" }, "<Leader>ai", ":CodeCompanion @{files} #{lsp} #{buffer} ", { desc = "Code Companion Inline" })

map(
  { "n", "v" },
  "<Leader>af",
  "<cmd>CodeCompanion /fix #{lsp} #{buffer} @{files} <cr>",
  { desc = "Code Companion Fix" }
)
map({ "v" }, "<Leader>ae", "<cmd>CodeCompanion /explain<cr>", { desc = "Code Companion Explain" })

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

--#region Curl Keymaps

wk.add({
  { "<leader>h", group = "Curl Keymaps" },
})

local curl = require("curl")
curl.setup({})

vim.keymap.set("n", "<leader>hc", function()
  curl.open_curl_tab()
end, { desc = "Open a curl tab scoped to the current working directory" })

vim.keymap.set("n", "<leader>ho", function()
  curl.open_global_tab()
end, { desc = "Open a curl tab with gloabl scope" })

-- These commands will prompt you for a name for your collection
vim.keymap.set("n", "<leader>hsc", function()
  curl.create_scoped_collection()
end, { desc = "Create or open a collection with a name from user input" })

vim.keymap.set("n", "<leader>hgc", function()
  curl.create_global_collection()
end, { desc = "Create or open a global collection with a name from user input" })

vim.keymap.set("n", "<leader>fsc", function()
  curl.pick_scoped_collection()
end, { desc = "Choose a scoped collection and open it" })

vim.keymap.set("n", "<leader>fgc", function()
  curl.pick_global_collection()
end, { desc = "Choose a global collection and open it" })

--#endregion
