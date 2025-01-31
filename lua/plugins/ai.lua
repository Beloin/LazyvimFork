-- return {
--   "huggingface/llm.nvim",
--   enabled = true,
--   event = "VeryLazy",
--   keys = {
--     {
--       "<c-j>",
--       function()
--         require("llm.completion").complete()
--       end,
--       mode = "i",
--       desc = "complete",
--     },
--   },
--   opts = {
--     lsp = {
--       bin_path = "/etc/profiles/per-user/s1n7ax/bin/llm-ls",
--       cmd_env = { LLM_LOG_LEVEL = "DEBUG" },
--     },
--
--     backend = "ollama",
--     model = "deepseek-coder:6.7b",
--     url = "http://localhost:11434", -- llm-ls uses "/api/generate"
--     -- cf https://github.com/ollama/ollama/blob/main/docs/api.md#parameters
--     fim = {
--       enabled = true,
--       prefix = "<｜fim▁begin｜>",
--       suffix = "<｜fim▁hole｜>",
--       middle = "<｜fim▁end｜>",
--     },
--     request_body = {
--       -- Modelfile options for the model you use
--       options = {
--         temperature = 0.2,
--         top_p = 0.95,
--       },
--     },
--   },
-- }

-- return {
--   {
--     "milanglacier/minuet-ai.nvim",
--     opts = {
--       provider = "openai",
--       openai = {
--         base_url = "http://localhost:11434/v1", -- Ollama
--         -- or "http://localhost:8000/v1" for vLLM
--         api_key = "", -- No API key needed for local models
--         model = "deepseek-coder:6.7b",
--       },
--     },
--     -- config = function()
--     --   require("minuet").setup({
--     --     provider = "openai_fim_compatible",
--     --     n_completions = 1, -- recommend for local model for resource saving
--     --     -- I recommend you start with a small context window firstly, and gradually
--     --     -- increase it based on your local computing power.
--     --     context_window = 512,
--     --     provider_options = {
--     --       openai_fim_compatible = {
--     --         name = "deepseek",
--     --         end_point = "http://localhost:11434/v1/completions",
--     --         model = "deepseek-coder:6.7b",
--     --         optional = {
--     --           max_tokens = 256,
--     --           top_p = 0.9,
--     --         },
--     --       },
--     --     },
--     --
--     --     -- With blink
--     --     require("blink-cmp").setup({
--     --       keymap = {
--     --         -- Manually invoke minuet completion.
--     --         ["<A-y>"] = require("minuet").make_blink_map(),
--     --       },
--     --       sources = {
--     --         -- Enable minuet for autocomplete
--     --         default = { "lsp", "path", "buffer", "snippets", "minuet" },
--     --         -- For manual completion only, remove 'minuet' from default
--     --         providers = {
--     --           minuet = {
--     --             name = "minuet",
--     --             module = "minuet.blink",
--     --             score_offset = 8, -- Gives minuet higher priority among suggestions
--     --           },
--     --         },
--     --       },
--     --       -- Recommended to avoid unnecessary request
--     --       completion = { trigger = { prefetch_on_insert = false } },
--     --     }),
--     --   })
--     -- end,
--   },
--
--   -- { "nvim-lua/plenary.nvim" },
--   -- optional, if you are using virtual-text frontend, nvim-cmp is not
--   -- required.
--   -- { "hrsh7th/nvim-cmp" },
--   -- optional, if you are using virtual-text frontend, blink is not required.
--   -- { "Saghen/blink.cmp" },
-- }

-- return {
--   {
--     "olimorris/codecompanion.nvim",
--     dependencies = {
--       "nvim-lua/plenary.nvim",
--       "nvim-treesitter/nvim-treesitter",
--     },
--     config = function()
--       require("codecompanion").setup({
--         strategies = {
--           chat = {
--             adapter = "ollama",
--           },
--           inline = {
--             adapter = "ollama",
--           },
--         },
--       })
--     end,
--   },
-- }

-- return {
--   "olimorris/codecompanion.nvim",
--   opts = {
--     backend = "ollama",
--     backends = {
--       ollama = {
--         model = "deepseekcoder:6.7b",
--         url = "http://localhost:11434",
--       },
--     },
--   },
--   dependencies = {
--     "nvim-lua/plenary.nvim",
--     "nvim-treesitter/nvim-treesitter",
--   },
-- }

return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    require("codecompanion").setup({
      adapters = {
        deepseek = function()
          return require("codecompanion.adapters").extend("openai_compatible", {
            env = {
              url = "http://localhost:11434",
              api_key = "YOUR_API_KEY",
            },
          })
        end,
      },
      strategies = {
        chat = { adapter = "deepseek" },
        inline = { adapter = "deepseek" },
        agent = { adapter = "deepseek" },
      },
    })
  end,
}


