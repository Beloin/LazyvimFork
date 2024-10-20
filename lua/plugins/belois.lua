-- Most of cool pluguins are here: https://github.com/rockerBOO/awesome-neovim

return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = true,
    event = "VeryLazy",
    keys = {
      { "<M-h>", "<cmd>ToggleTerm<cr>", desc = "Toggle terminal" },
    },
  },

  {
    "karb94/neoscroll.nvim",
    config = function()
      require("neoscroll").setup({})
    end,
  },

  {
    "smoka7/multicursors.nvim",
    event = "VeryLazy",
    dependencies = {
      "smoka7/hydra.nvim",
    },
    opts = {},
    cmd = { "MCstart", "MCvisual", "MCclear", "MCpattern", "MCvisualPattern", "MCunderCursor" },
    keys = {
      {
        mode = { "v", "n" },
        "<Leader>m",
        "<cmd>MCstart<cr>",
        desc = "Create a selection for selected text or word under the cursor",
      },
    },
  },

  {
    "braxtons12/blame_line.nvim",
    config = function()
      require("blame_line").setup({})
    end,
  },

  {
    "petertriho/nvim-scrollbar",
    config = function()
      require("scrollbar").setup()
    end,
  },

  {
    "derektata/lorem.nvim",
    event = "VeryLazy",
    config = function()
      require("lorem")
    end,
  },

  { "Tastyep/structlog.nvim" },

  -- Create a code window
  -- {
  --   "gorbit99/codewindow.nvim",
  --   config = function()
  --     local codewindow = require("codewindow")
  --     codewindow.setup()
  --     codewindow.apply_default_keybinds()
  --   end,
  -- },

  {
    "ziontee113/icon-picker.nvim",
    config = function()
      require("icon-picker").setup({ disable_legacy_commands = true })

      -- local opts = { noremap = true, silent = true }
      -- vim.keymap.set("n", "<Leader><Leader>i", "<cmd>IconPickerNormal<cr>", opts)
      -- vim.keymap.set("n", "<Leader><Leader>y", "<cmd>IconPickerYank<cr>", opts) --> Yank the selected icon into register
      -- vim.keymap.set("i", "<C-i>", "<cmd>IconPickerInsert<cr>", opts)
    end,
  },

  -- https://github.com/chrisgrieser/nvim-scissors
  -- Variable list  https://code.visualstudio.com/docs/editor/userdefinedsnippets#_variables
  {
    "chrisgrieser/nvim-scissors",
    dependencies = { "nvim-telescope/telescope.nvim", "garymjr/nvim-snippets" },
    opts = {
      snippetDir = vim.fn.stdpath("config") .. "/snippets/",
    },
  },

  -- TODO: Learn how to add this snippets to friedly-snippets
  -- { "norcalli/snippets.nvim", event = "VeryLazy" },

  {
    "motosir/skel-nvim",
    config = function()
      require("utils.skeleton.setup-skel").setup()
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter-context",
    config = function()
      require("treesitter-context").setup({
        enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
        max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
        min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
        line_numbers = true,
        multiline_threshold = 20, -- Maximum number of lines to show for a single context
        trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
        mode = "cursor", -- Line used to calculate context. Choices: 'cursor', 'topline'
        -- Separator between context and content. Should be a single character string, like '-'.
        -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
        separator = nil,
        zindex = 20, -- The Z-index of the context window
        on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
      })
    end,
    lazy = false,
  },

  -- TODO: How to use only this instead of both?
  -- {
  --   "ray-x/lsp_signature.nvim",
  --   event = "VeryLazy",
  --   opts = {},
  --   config = function(_, opts)
  --     require("lsp_signature").setup(opts)
  --   end,
  -- },

  {
    "javiorfo/nvim-soil",

    -- Optional for puml syntax highlighting:
    dependencies = { "javiorfo/nvim-nyctophilia" },

    lazy = true,
    ft = "plantuml",
    -- opts = {
    --   -- If you want to change default configurations
    --
    --   -- If you want to use Plant UML jar version instead of the install version
    --   puml_jar = "/path/to/plantuml.jar",
    --
    --   -- If you want to customize the image showed when running this plugin
    --   image = {
    --     darkmode = false, -- Enable or disable darkmode
    --     format = "png", -- Choose between png or svg
    --
    --     -- This is a default implementation of using nsxiv to open the resultant image
    --     -- Edit the string to use your preferred app to open the image (as if it were a command line)
    --     -- Some examples:
    --     -- return "feh " .. img
    --     -- return "xdg-open " .. img
    --     execute_to_open = function(img)
    --       return "nsxiv -b " .. img
    --     end,
    --   },
    -- },
  },

  {
    "https://gitlab.com/itaranto/plantuml.nvim",
    version = "*",
    config = function()
      require("plantuml").setup()
    end,
  },

  {
    "Beloin/machuquei-ipsum.nvim",
    config = function()
      require("Machuquei").setup()
    end,
  },

  {
    "Beloin/Launch.nvim",
    config = function()
      require("Launch").setup()
    end,
    dependencies = {
      "folke/noice.nvim",
    },
  },
}
