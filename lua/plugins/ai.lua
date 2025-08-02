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
          ollama = function()
            return require("codecompanion.adapters").extend("ollama", {
              env = {
                url = "http://localhost:11434",
                api_key = "OLLAMA_API_KEY",
                model = "codellama:13b",
              },
              headers = {
                ["Content-Type"] = "application/json",
                ["Authorization"] = "Bearer ${api_key}",
              },
              parameters = {
                sync = true,
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
  },
}
