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
function opts(desc)
    return {
        buffer = bufnr,
        desc = desc
    }
end

map("i", "<C-p>", vim.lsp.buf.signature_help, opts "Lsp Show signature help")
map("n", "<C-p>", vim.lsp.buf.signature_help, opts "Lsp Show signature help")
