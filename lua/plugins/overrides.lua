-- Overrides for defaults Lazyvim

return {
  {
    "nvim-lualine/lualine.nvim",
    config = function()
      require("lualine").setup({

        sections = {
          lualine_x = {
            {
              require("minuet.lualine"),
              -- the follwing is the default configuration
              -- the name displayed in the lualine. Set to "provider", "model" or "both"
              -- display_name = 'both',
              -- separator between provider and model name for option "both"
              -- provider_model_separator = ':',
              -- whether show display_name when no completion requests are active
              -- display_on_idle = false,
            },
            "encoding",
            "fileformat",
            "filetype",
          },
        },
      })
    end,
    opts = function(_, opts)
      table.insert(opts.sections.lualine_x, "encoding")
    end,
  },

  -- { "mason-org/mason.nvim", version = "2.0.1" },
  -- { "mason-org/mason-lspconfig.nvim", version = "2.0.1" },

  -- Blink setup to work with Avante
  {
    "saghen/blink.cmp",
    dependencies = {
      "Kaiser-Yang/blink-cmp-avante",
      -- ... Other dependencies
    },
    opts = {
      sources = {
        -- Add 'avante' to the list
        default = { "avante", "lsp", "path", "buffer" },
        providers = {
          avante = {
            module = "blink-cmp-avante",
            name = "Avante",
            opts = {
              -- options for blink-cmp-avante
            },
          },
        },
      },
    },
  },
}
