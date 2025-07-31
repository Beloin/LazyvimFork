-- Overrides for defaults Lazyvim

return {
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      table.insert(opts.sections.lualine_x, "encoding")
    end,
  },

  -- { "mason-org/mason.nvim", version = "2.0.1" },
  -- { "mason-org/mason-lspconfig.nvim", version = "2.0.1" },
}
