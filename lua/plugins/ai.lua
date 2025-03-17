return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    require("codecompanion").setup({
      adapters = {
        ollama = function()
          return require("codecompanion.adapters").extend("openai_compatible", {
            env = {
              url = "http://localhost:11434",
              api_key = "YOUR_API_KEY",
              model = "qwen2.5-coder:14b",
            },
          })
        end,
      },
      strategies = {
        chat = { adapter = "ollama" },
        inline = { adapter = "ollama" },
        agent = { adapter = "ollama" },
      },
    })
  end,

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

}
