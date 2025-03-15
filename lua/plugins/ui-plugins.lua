-- All Plugins based on UI

return {

  {
    "petertriho/nvim-scrollbar",
    config = function()
      require("scrollbar").setup()
      require("scrollbar.handlers.gitsigns").setup()
    end,
  },

  -- {
  --   "dstein64/nvim-scrollview",
  --   config = function() end,
  -- },

  {
    "rmagatti/goto-preview",
    event = "BufEnter",
    config = function()
      require("goto-preview").setup({
        default_mappings = true,
      })
    end,
  },

  {
    "akinsho/git-conflict.nvim",
    version = "*",
    config = function()
      require("git-conflict").setup({})

      local wk = require("which-key")
      wk.add({
        { "<leader>gC", group = "Git Conflict" }, -- Adds a description to the "gt" group
      })

      vim.keymap.set("n", "<leader>gCo", "<cmd>GitConflictChooseOurs<cr>", { desc = "Conflit: Choose Ours" })
      vim.keymap.set("n", "<leader>gCt", "<cmd>GitConflictChooseTheirs<cr>", { desc = "Conflit: Choose Theirs" })
      vim.keymap.set("n", "<leader>gCb", "<cmd>GitConflictChooseBoth<cr>", { desc = "Conflit: Choose Both" })
      vim.keymap.set("n", "<leader>gC0", "<cmd>GitConflictChooseNone<cr>", { desc = "Conflit: Choose None" })

      return true
    end,
  },

  -- {
  --   "tiagovla/scope.nvim",
  --   config = function()
  --     require("scope").setup({})
  --   end,
  -- },

  -- TODO: How to use only this instead of both?
  -- {
  --   "ray-x/lsp_signature.nvim",
  --   event = "VeryLazy",
  --   opts = {},
  --   config = function(_, opts)
  --     require("lsp_signature").setup(opts)
  --   end,
  -- },

  -- TODO: This gives too much text
  {
    "ray-x/navigator.lua",
    dependencies = {
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
    },
  },

  {
    "ray-x/guihua.lua",
  },

  {
    "shellRaining/hlchunk.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("hlchunk").setup({
        chunk = {
          enable = true,
          -- ...
        },
        -- indent = {
        --   enable = true,
        --   -- ...
        -- },
      })
    end,
  },

  -- {
  --   "sphamba/smear-cursor.nvim",
  --   opts = {
  --     -- Cursor color. Defaults to Cursor gui color
  --     cursor_color = "#d3cdc3",
  --
  --     -- Background color. Defaults to Normal gui background color
  --     normal_bg = "#282828",
  --
  --     -- Smear cursor when switching buffers
  --     smear_between_buffers = true,
  --
  --     -- Smear cursor when moving within line or to neighbor lines
  --     smear_between_neighbor_lines = true,
  --
  --     -- Use floating windows to display smears over wrapped lines or outside buffers.
  --     -- May have performance issues with other plugins.
  --     use_floating_windows = true,
  --
  --     -- Set to `true` if your font supports legacy computing symbols (block unicode symbols).
  --     -- Smears will blend better on all backgrounds.
  --     legacy_computing_symbols_support = false,
  --   },
  -- },

  {
    "fei6409/log-highlight.nvim",
    config = function()
      require("log-highlight").setup({})
    end,
  },

  {
    "j-hui/fidget.nvim",
    opts = {
      -- options
    },
  },

  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy", -- Or `LspAttach`
    priority = 1000, -- needs to be loaded in first
    config = function()
      require("tiny-inline-diagnostic").setup()

      -- Remove virtual text cause of
      vim.diagnostic.config({ virtual_text = false })
    end,
  },
}
