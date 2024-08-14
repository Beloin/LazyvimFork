-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

-- TODO: Not necessary: <leader>ss does the job
-- map("n", "gs", "<cmd>Telescope lsp_dynamic_workspace_symbols<CR>", { desc = "Telescope find Symbol" })
-- map("n", "<leadler>fs", "<cmd>Telescope lsp_dynamic_workspace_symbols<CR>", { desc = "Telescope find Symbol" })

map("i", "jk", "<ESC>", { desc = "Escape insert mode" })

map({ "i", "n" }, "<C-n>", "<cmd>Neotree<cr>", { desc = "Open Neotree" })
map({ "i", "n" }, "<C-N>", "<cmd>Neotree toggle<cr>", { desc = "Toggle Neotree" })

-- LSP Mappings
local function opts(desc)
    return {
        buffer = bufnr,
        desc = desc
    }
end

map("i", "<C-p>", vim.lsp.buf.signature_help, opts "Lsp Show signature help")
map("n", "<C-p>", vim.lsp.buf.signature_help, opts "Lsp Show signature help")

local neoscroll = require('neoscroll')
neoscroll.setup({
  -- Default easing function used in any animation where
  -- the `easing` argument has not been explicitly supplied
  easing = "quadratic"
})
local keymap = {
  -- Use the "sine" easing function
  ["<C-u>"] = function() neoscroll.ctrl_u({ duration = 250; easing = 'sine' }) end;
  ["<C-d>"] = function() neoscroll.ctrl_d({ duration = 250; easing = 'sine' }) end;
  -- Use the "circular" easing function
  ["<C-b>"] = function() neoscroll.ctrl_b({ duration = 450; easing = 'circular' }) end;
  ["<C-f>"] = function() neoscroll.ctrl_f({ duration = 450; easing = 'circular' }) end;
  -- When no value is passed the `easing` option supplied in `setup()` is used
  ["<C-y>"] = function() neoscroll.scroll(-0.1, { move_cursor=false; duration = 100 }) end;
  ["<C-e>"] = function() neoscroll.scroll(0.1, { move_cursor=false; duration = 100 }) end;
}
local modes = { 'n', 'v', 'x' }
for key, func in pairs(keymap) do
    vim.keymap.set(modes, key, func)
end

map({"i","n"}, "<F8>", "<cmd>DapStepOver<CR>", { desc="Step Over" })
map({"i","n"}, "<F7>", "<cmd>DapStepInto<CR>", { desc="Step Into" })
map({"i","n"}, "<F10>", "<cmd>DapTerminate<CR>", { desc="Terminate DAP" })
