-- Code related plugins
--
return {
  {
    "Wansmer/symbol-usage.nvim",
    event = "BufReadPre", -- need run before LspAttach if you use nvim 0.9. On 0.10 use 'LspAttach'
    config = function()
      require("symbol-usage").setup()
    end,
  },

  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
  },

  {
    "L3MON4D3/LuaSnip",
    -- follow latest release.
    version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
    -- install jsregexp (optional!).
    build = "make install_jsregexp",
    dependencies = { "rafamadriz/friendly-snippets" },
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
      require("luasnip.loaders.from_vscode").lazy_load({ paths = vim.fn.stdpath("config") .. "/snippets/" })
    end,
  },

  {
    "madskjeldgaard/cheeky-snippets.nvim",
    requires = {
      "L3MON4D3/LuaSnip",
    },
    event = "VeryLazy",
    config = function()
      local cheeky = require("cheeky")
      cheeky.setup({
        langs = {
          all = true,
          lua = true,
          cpp = true,
          asm = true,
          cmake = true,
          markdown = true,
          supercollider = true,
        },
      })
    end,
  },

  { "Sirver/ultisnips", event = { "InsertEnter" } },

  -- C++ code generator - Need to have LSP configured
  {
    "eriks47/generate.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
  },

  {
    "iabdelkareem/csharp.nvim",
    dependencies = {
      "williamboman/mason.nvim", -- Required, automatically installs omnisharp
      "mfussenegger/nvim-dap",
      "Tastyep/structlog.nvim", -- Optional, but highly recommended for debugging
    },
    config = function()
      require("mason").setup() -- Mason setup must run before csharp
      require("csharp").setup()
    end,
  },

  {
    "vim-perl/vim-perl",
    lazy = true,
    ft = "perl",
    build = "make clean carp dancer highlight-all-pragmas moose test-more try-tiny",
  },
}
