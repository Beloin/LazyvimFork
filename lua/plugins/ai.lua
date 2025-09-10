return {
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("codecompanion").setup({
        adapters = {
          deepseek = function()
            return require("codecompanion.adapters").extend("deepseek", {
              env = {
                api_key = "---",
              },
              schema = {
                model = {
                  default = "deepseek-chat",
                },
              },
            })
          end,
          ollama = function()
            return require("codecompanion.adapters").extend("ollama", {
              env = {
                url = "http://100.83.175.60:11434",
                api_key = "OLLAMA_API_KEY",
                model = "qwen2.5-coder:14b",
              },
              headers = {
                ["Content-Type"] = "application/json",
                ["Authorization"] = "Bearer ${api_key}",
              },
              parameters = {
                sync = true,
              },
              schema = {
                model = {
                  default = "qwen2.5-coder:14b",
                },
              },
            })
          end,
        },
        strategies = {
          -- chat = { adapter = "ollama" },
          -- inline = { adapter = "ollama" },
          -- agent = { adapter = "ollama" },

          chat = { adapter = "deepseek", model = "deepseek-chat" },
          inline = { adapter = "deepseek", model = "deepseek-chat" },
          agent = { adapter = "deepseek", model = "deepseek-chat" },
        },
      })
    end,
  },

  -- {
  --   "yetone/avante.nvim",
  --   -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
  --   -- ⚠️ must add this setting! ! !
  --   build = vim.fn.has("win32") ~= 0 and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
  --     or "make",
  --   event = "VeryLazy",
  --   version = false, -- Never set this value to "*"! Never!
  --   ---@module 'avante'
  --   ---@type avante.Config
  --   opts = {
  --     provider = "ollama",
  --     providers = {
  --       ollama = {
  --         endpoint = "http://localhost:11434",
  --         model = "gpt-oss:20b",
  --       },
  --     },
  --   },
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --     "MunifTanjim/nui.nvim",
  --     --- The below dependencies are optional,
  --     "echasnovski/mini.pick", -- for file_selector provider mini.pick
  --     "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
  --     "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
  --     "ibhagwan/fzf-lua", -- for file_selector provider fzf
  --     "stevearc/dressing.nvim", -- for input provider dressing
  --     "folke/snacks.nvim", -- for input provider snacks
  --     "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
  --     "zbirenbaum/copilot.lua", -- for providers='copilot'
  --     {
  --       -- support for image pasting
  --       "HakonHarnes/img-clip.nvim",
  --       event = "VeryLazy",
  --       opts = {
  --         -- recommended settings
  --         default = {
  --           embed_image_as_base64 = false,
  --           prompt_for_file_name = false,
  --           drag_and_drop = {
  --             insert_mode = true,
  --           },
  --           -- required for Windows users
  --           use_absolute_path = true,
  --         },
  --       },
  --     },
  --     {
  --       -- Make sure to set this up properly if you have lazy=true
  --       "MeanderingProgrammer/render-markdown.nvim",
  --       opts = {
  --         file_types = { "markdown", "Avante" },
  --       },
  --       ft = { "markdown", "Avante" },
  --     },
  --   },
  -- },
  --
  -- {
  --   "NickvanDyke/opencode.nvim",
  --   dependencies = { "folke/snacks.nvim" },
  --   ---@type opencode.Config
  --   opts = {
  --     -- Your configuration, if any
  --   },
  --   -- stylua: ignore
  --   keys = {
  --     { '<leader>ot', function() require('opencode').toggle() end, desc = 'Toggle embedded opencode', },
  --     { '<leader>oa', function() require('opencode').ask() end, desc = 'Ask opencode', mode = 'n', },
  --     { '<leader>oa', function() require('opencode').ask('@selection: ') end, desc = 'Ask opencode about selection', mode = 'v', },
  --     { '<leader>op', function() require('opencode').select_prompt() end, desc = 'Select prompt', mode = { 'n', 'v', }, },
  --     { '<leader>on', function() require('opencode').command('session_new') end, desc = 'New session', },
  --     { '<leader>oy', function() require('opencode').command('messages_copy') end, desc = 'Copy last message', },
  --     { '<S-C-u>',    function() require('opencode').command('messages_half_page_up') end, desc = 'Scroll messages up', },
  --     { '<S-C-d>',    function() require('opencode').command('messages_half_page_down') end, desc = 'Scroll messages down', },
  --   },
  -- },
}
