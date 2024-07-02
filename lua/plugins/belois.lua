-- Most of cool pluguins are here: https://github.com/rockerBOO/awesome-neovim

return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = true,
    event = "VeryLazy",
    keys = {
      { "<M-h>", "<cmd>ToggleTerm<cr>", desc = "Toggle terminal" },
    },
  },

  {
    "karb94/neoscroll.nvim",
    config = function()
      require("neoscroll").setup({})
    end,
  },

  {
    "Shatur/neovim-session-manager",
    event = "VimEnter",
  },

  {
    "smoka7/multicursors.nvim",
    event = "VeryLazy",
    dependencies = {
      "smoka7/hydra.nvim",
    },
    opts = {},
    cmd = { "MCstart", "MCvisual", "MCclear", "MCpattern", "MCvisualPattern", "MCunderCursor" },
    keys = {
      {
        mode = { "v", "n" },
        "<Leader>m",
        "<cmd>MCstart<cr>",
        desc = "Create a selection for selected text or word under the cursor",
      },
    },
  },

  {
    "braxtons12/blame_line.nvim",
    config = function()
      require("blame_line").setup({})
    end,
  },

  {
    "petertriho/nvim-scrollbar",
    config = function()
      require("scrollbar").setup()
    end,
  },

  {
    "derektata/lorem.nvim",
    config = function()
      require("lorem").setup({
        sentenceLength = "medium",
        comma_chance = 0.2,
        max_commas_per_sentence = 2,
      })
    end,
  },

  { "Tastyep/structlog.nvim" },

  -- TODO: Configure scissors
  -- https://github.com/chrisgrieser/nvim-scissors

  -- TODO: Learn how to add this snippets to friedly-snippets
  -- { "norcalli/snippets.nvim", event = "VeryLazy" },

  -- TODO: Add skeleton
  -- https://github.com/cvigilv/esqueleto.nvim
  -- https://github.com/motosir/skel-nvim
}