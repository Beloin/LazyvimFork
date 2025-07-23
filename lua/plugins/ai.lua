return {
  -- "olimorris/codecompanion.nvim",
  -- dependencies = {
  --   "nvim-lua/plenary.nvim",
  --   "nvim-treesitter/nvim-treesitter",
  -- },
  -- config = function()
  --   require("codecompanion").setup({
  --     adapters = {
  --       ollama = function()
  --         return require("codecompanion.adapters").extend("openai_compatible", {
  --           env = {
  --             url = "http://localhost:11434",
  --             api_key = "YOUR_API_KEY",
  --             model = "qwen2.5-coder:14b",
  --           },
  --         })
  --       end,
  --     },
  --     strategies = {
  --       chat = { adapter = "ollama" },
  --       inline = { adapter = "ollama" },
  --       agent = { adapter = "ollama" },
  --     },
  --   })
  -- end,

  -- TODO: Implement llm.nvim
  -- Giving error 500
  -- {
  --   "huggingface/llm.nvim",
  --   config = function()
  --     local llm = require("llm")
  --     llm.setup({
  --       backend = "ollama",
  --       model = "qwen2.5-coder:14b",
  --       url = "http://localhost:11434", -- llm-ls uses "/api/generate"
  --       -- cf https://github.com/ollama/ollama/blob/main/docs/api.md#parameters
  --       request_body = {
  --         -- Modelfile options for the model you use
  --         options = {
  --           temperature = 0.2,
  --           top_p = 0.95,
  --         },
  --       },
  --     })
  --   end,
  -- },
  {
    "yetone/avante.nvim",
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    -- ⚠️ must add this setting! ! !
    build = function()
      -- conditionally use the correct build system for the current OS
      if vim.fn.has("win32") == 1 then
        return "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
      else
        return "make BUILD_FROM_SOURCE=true"
      end
    end,
    event = "VeryLazy",
    version = false, -- Never set this value to "*"! Never!
    ---@module 'avante'
    ---@type avante.Config
    opts = {
      -- add any opts here
      -- for example
      provider = "ollama",
      providers = {
        ollama = {
          endpoint = "http://100.83.175.60:11434",
          -- model = "qwen2.5-coder:14b",
          model = "codellama:13b",
          -- timeout = 30000, -- Timeout in milliseconds
          -- extra_request_body = {
          --   temperature = 0.75,
          --   max_tokens = 20480,
          -- },
        },
      },
      selector = {
        --- @alias avante.SelectorProvider "native" | "fzf_lua" | "mini_pick" | "snacks" | "telescope" | fun(selector: avante.ui.Selector): nil
        --- @type avante.SelectorProvider
        provider = "fzf",
        -- Options override for custom providers
        provider_opts = {},
      },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below dependencies are optional,
      "echasnovski/mini.pick", -- for file_selector provider mini.pick
      "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
      "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
      "ibhagwan/fzf-lua", -- for file_selector provider fzf
      "stevearc/dressing.nvim", -- for input provider dressing
      "folke/snacks.nvim", -- for input provider snacks
      "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
      "zbirenbaum/copilot.lua", -- for providers='copilot'
      {
        -- support for image pasting
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          -- recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- required for Windows users
            use_absolute_path = true,
          },
        },
      },
      {
        -- Make sure to set this up properly if you have lazy=true
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
    },
  },

  -- {
  --   "yetone/avante.nvim",
  --   event = "VeryLazy",
  --   version = false, -- Never set this value to "*"! Never!
  --   opts = {
  --     -- add any opts here
  --     -- for example
  --     provider = "ollama",
  --     providers = {
  --       ollama = {
  --         endpoint = "http://100.83.175.60:11434",
  --         -- model = "qwen2.5-coder:14b",
  --         model = "codellama:13b",
  --       },
  --     },
  --     -- Too slow to use ollama provider, maybe create another faster AI to use as a provider
  --     -- ollama_fast = {
  --     --   endpoint = "",
  --     --   model = ""
  --     -- }
  --     -- auto_suggestions_provider = "ollama",
  --   },
  --   -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
  --   build = "make",
  --   -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
  --   dependencies = {
  --     "nvim-treesitter/nvim-treesitter",
  --     "stevearc/dressing.nvim",
  --     "nvim-lua/plenary.nvim",
  --     "MunifTanjim/nui.nvim",
  --     --- The below dependencies are optional,
  --     "echasnovski/mini.pick", -- for file_selector provider mini.pick
  --     "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
  --     "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
  --     "ibhagwan/fzf-lua", -- for file_selector provider fzf
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
}
