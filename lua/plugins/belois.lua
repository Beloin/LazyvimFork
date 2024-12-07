-- Most of cool pluguins are here: https://github.com/rockerBOO/awesome-neovim

return {

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

  -- {
  --   "petertriho/nvim-scrollbar",
  --   config = function()
  --     require("scrollbar").setup()
  --   end,
  -- },

  {
    "dstein64/nvim-scrollview",
    config = function() end,
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

  {
    "rmagatti/goto-preview",
    event = "BufEnter",
    config = true, -- necessary as per https://github.com/rmagatti/goto-preview/issues/88
  },

  {
    "akinsho/git-conflict.nvim",
    version = "*",
    config = function()
      require("git-conflict").setup({})

      local wk = require("which-key")
      wk.add({
        { "<leader>gC", group = "Git Conflict" }, -- Adds a description to the "gt" group
      })

      vim.keymap.set("n", "<leader>gCo", "<cmd>GitConflictChooseOurs<cr>", { desc = "Conflit: Choose Ours" })
      vim.keymap.set("n", "<leader>gCt", "<cmd>GitConflictChooseTheirs<cr>", { desc = "Conflit: Choose Theirs" })
      vim.keymap.set("n", "<leader>gCb", "<cmd>GitConflictChooseBoth<cr>", { desc = "Conflit: Choose Both" })
      vim.keymap.set("n", "<leader>gC0", "<cmd>GitConflictChooseNone<cr>", { desc = "Conflit: Choose None" })

      return true
    end,
  },

  {
    "tiagovla/scope.nvim",
    config = function()
      require("scope").setup({})
    end,
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

  -- TODO: This gives too much text
  {
    "ray-x/navigator.lua",
    dependencies = {
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
    },
  },

  {
    "ray-x/guihua.lua",
  },

  {
    "shellRaining/hlchunk.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("hlchunk").setup({
        chunk = {
          enable = true,
          -- ...
        },
        -- indent = {
        --   enable = true,
        --   -- ...
        -- },
      })
    end,
  },

  {
    "sphamba/smear-cursor.nvim",

    opts = {
      -- Cursor color. Defaults to Cursor gui color
      cursor_color = "#d3cdc3",

      -- Background color. Defaults to Normal gui background color
      normal_bg = "#282828",

      -- Smear cursor when switching buffers
      smear_between_buffers = true,

      -- Smear cursor when moving within line or to neighbor lines
      smear_between_neighbor_lines = true,

      -- Use floating windows to display smears over wrapped lines or outside buffers.
      -- May have performance issues with other plugins.
      use_floating_windows = true,

      -- Set to `true` if your font supports legacy computing symbols (block unicode symbols).
      -- Smears will blend better on all backgrounds.
      legacy_computing_symbols_support = false,
    },
  },

  {
    "fabridamicelli/cronex.nvim",
    opts = {},
  },
}
