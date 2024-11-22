return {
  { "ellisonleao/gruvbox.nvim", priority = 1000, config = true },
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
  { "EdenEast/nightfox.nvim" },
  { "bluz71/vim-moonfly-colors", name = "moonfly", lazy = false },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "moonfly",
    },
  },
}
