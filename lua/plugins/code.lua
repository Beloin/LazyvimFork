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

  {
    "ThePrimeagen/refactoring.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    keys = {
      { "<leader>r", "", desc = "+refactor", mode = { "n", "v" } },
      {
        "<leader>rs",
        pick,
        mode = "v",
        desc = "Refactor",
      },
      {
        "<leader>ri",
        function()
          require("refactoring").refactor("Inline Variable")
        end,
        mode = { "n", "v" },
        desc = "Inline Variable",
      },
      {
        "<leader>rb",
        function()
          require("refactoring").refactor("Extract Block")
        end,
        desc = "Extract Block",
      },
      {
        "<leader>rf",
        function()
          require("refactoring").refactor("Extract Block To File")
        end,
        desc = "Extract Block To File",
      },
      {
        "<leader>rP",
        function()
          require("refactoring").debug.printf({ below = false })
        end,
        desc = "Debug Print",
      },
      {
        "<leader>rp",
        function()
          require("refactoring").debug.print_var({ normal = true })
        end,
        desc = "Debug Print Variable",
      },
      {
        "<leader>rc",
        function()
          require("refactoring").debug.cleanup({})
        end,
        desc = "Debug Cleanup",
      },
      {
        "<leader>rf",
        function()
          require("refactoring").refactor("Extract Function")
        end,
        mode = "v",
        desc = "Extract Function",
      },
      {
        "<leader>rF",
        function()
          require("refactoring").refactor("Extract Function To File")
        end,
        mode = "v",
        desc = "Extract Function To File",
      },
      {
        "<leader>rx",
        function()
          require("refactoring").refactor("Extract Variable")
        end,
        mode = "v",
        desc = "Extract Variable",
      },
      {
        "<leader>rp",
        function()
          require("refactoring").debug.print_var()
        end,
        mode = "v",
        desc = "Debug Print Variable",
      },
    },
    opts = {
      prompt_func_return_type = {
        go = false,
        java = false,
        cpp = false,
        c = false,
        h = false,
        hpp = false,
        cxx = false,
      },
      prompt_func_param_type = {
        go = false,
        java = false,
        cpp = false,
        c = false,
        h = false,
        hpp = false,
        cxx = false,
      },
      printf_statements = {},
      print_var_statements = {},
      show_success_message = true, -- shows a message with information about the refactor on success
      -- i.e. [Refactor] Inlined 3 variable occurrences
    },
    config = function(_, opts)
      require("refactoring").setup(opts)
      if LazyVim.has("telescope.nvim") then
        LazyVim.on_load("telescope.nvim", function()
          require("telescope").load_extension("refactoring")
        end)
      end
    end,
  },

  {
    "eatgrass/maven.nvim",
    cmd = { "Maven", "MavenExec" },
    dependencies = "nvim-lua/plenary.nvim",
    config = function()
      require("maven").setup({
        executable = "./mvnw",
      })
    end,
  },

  {
    "nvim-flutter/flutter-tools.nvim",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "stevearc/dressing.nvim", -- optional for vim.ui.select
    },
    config = function()
      require("flutter-tools").setup({
        debugger = {
          enabled = true,
        },
        decorations = {
          statusline = {
            app_version = false,
            device = true,
            project_config = false,
          },
        },
      })
    end,
  },

  {
    "dart-lang/dart-vim-plugin",
  },

  {
    "nvim-java/nvim-java",
    config = function()
      require("java").setup()
      require("lspconfig").jdtls.setup({})
    end,
  },

  {
    "rcasia/neotest-java",
    ft = "java",
    dependencies = {
      "mfussenegger/nvim-dap", -- for the debugger
      "rcarriga/nvim-dap-ui", -- recommended
      "theHamsta/nvim-dap-virtual-text", -- recommended
    },
    init = function()
      -- override the default keymaps.
      -- needed until neotest-java is integrated in LazyVim
      -- local keys = require("lazyvim.plugins.lsp.keymaps").get()
      -- -- run test file
      -- keys[#keys + 1] = {
      --   "<leader>tt",
      --   function()
      --     require("neotest").run.run(vim.fn.expand("%"))
      --   end,
      --   mode = "n",
      -- }
      -- -- run nearest test
      -- keys[#keys + 1] = {
      --   "<leader>tr",
      --   function()
      --     require("neotest").run.run()
      --   end,
      --   mode = "n",
      -- }
      -- -- debug test file
      -- keys[#keys + 1] = {
      --   "<leader>tD",
      --   function()
      --     require("neotest").run.run({ strategy = "dap" })
      --   end,
      --   mode = "n",
      -- }
      -- -- debug nearest test
      -- keys[#keys + 1] = {
      --   "<leader>td",
      --   function()
      --     require("neotest").run.run({ vim.fn.expand("%"), strategy = "dap" })
      --   end,
      --   mode = "n",
      -- }
    end,
  },
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      adapters = {
        ["neotest-java"] = {
          -- config here
        },
      },
    },
  },
}
