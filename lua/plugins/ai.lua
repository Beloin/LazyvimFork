return {

  {
    "ravitemer/mcphub.nvim",
    build = "npm install -g mcp-hub@latest",
    config = function()
      require("mcphub").setup({
        port = 37373,
        extensions = {
          avante = {
            make_slash_commands = true, -- make /slash commands from MCP server prompts
          },
        },
      })
    end,
  },

  -- Avante
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
  --     -- add any opts here
  --     -- this file can contain specific instructions for your project
  --     instructions_file = "avante.md",
  --     auto_suggestions_provider = "ollama",
  --     provider = "xai",
  --     providers = {
  --       deepseek = {
  --         __inherited_from = "openai",
  --         api_key_name = "DEEPSEEK_API_KEY",
  --         endpoint = "https://api.deepseek.com",
  --         model = "deepseek-chat",
  --       },
  --       ollama = {
  --         model = "codegemma:7b",
  --         endpoint = "http://localhost:11434",
  --         is_env_set = true,
  --         temperature = 0.1,
  --         max_tokens = 2048,
  --
  --         -- IMPORTANT: enable FIM mode
  --         use_fim = true,
  --       },
  --       deepseek_fast = {
  --         __inherited_from = "openai",
  --         endpoint = "http://localhost:11434",
  --         model = "deepseek-coder:1.3b",
  --       },
  --       xai = {
  --         api_key_name = "XAI_API_KEY",
  --         -- model = "grok-code-fast-1",
  --         model = "grok-4-1-fast-reasoning",
  --       },
  --       openai = {
  --         model = "GPT-5.2-Codex",
  --       },
  --       claude = {
  --         endpoint = "https://api.anthropic.com",
  --         auth_type = "api", -- Set to "max" to sign in with Claude Pro/Max subscription
  --         model = "claude-haiku-4-5-20251001",
  --       },
  --     },
  --     shortcuts = {
  --       {
  --         name = "ask",
  --         description = "Ask only promtp",
  --         details = "Only ask wihtout making any changes to code.",
  --         prompt = "Please answer me without making any changes to code.",
  --       },
  --     },
  --   },
  --   -- behaviour = {
  --   --   auto_suggestions = true,
  --   -- },
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --     "MunifTanjim/nui.nvim",
  --     --- The below dependencies are optional,
  --     "nvim-mini/mini.pick", -- for file_selector provider mini.pick
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
  --   -- system_prompt as function ensures LLM always has latest MCP server state
  --   -- This is evaluated for every message, even in existing chats
  --   system_prompt = function()
  --     local hub = require("mcphub").get_hub_instance()
  --     return hub and hub:get_active_servers_prompt() or ""
  --   end,
  --   -- Using function prevents requiring mcphub before it's loaded
  --   custom_tools = function()
  --     return {
  --       require("mcphub.extensions.avante").mcp_tool(),
  --     }
  --   end,
  -- },

  -- Code Companion works quite well as a Sidekick
  -- {
  --   "olimorris/codecompanion.nvim",
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --     "nvim-treesitter/nvim-treesitter",
  --     "MeanderingProgrammer/render-markdown.nvim",
  --     -- "OXY2DEV/markview.nvim",
  --     "nvim-mini/mini.diff",
  --     "ravitemer/mcphub.nvim",
  --     "ravitemer/codecompanion-history.nvim",
  --     "lalitmee/codecompanion-spinners.nvim",
  --     "j-hui/fidget.nvim",
  --   },
  --   config = function()
  --     --#region Keymaps
  --     local map = vim.keymap.set
  --     local wk = require("which-key")
  --     map({ "n" }, "<Leader>ac", "<cmd>CodeCompanionChat Toggle<cr>", { desc = "Code Companion Chat" })
  --     map({ "v" }, "<Leader>ac", "<cmd>CodeCompanionChat Add<cr>", { desc = "Code Companion Chat" })
  --     map({ "n" }, "<Leader>ah", "<cmd>CodeCompanionHistory<cr>", { desc = "Code Companion history" })
  --     map(
  --       { "n", "v" },
  --       "<Leader>ag",
  --       '<cmd>CodeCompanion you can use @{files}, @{fetch_webpage}, @{insert_edit_into_file}, @{cmd_runner}, @{mcphub}, @{agent} Answer only with "Ok!" respecting any schema and wait for my next prompts<cr>',
  --       { desc = "Code Companion Agent" }
  --     )
  --
  --     -- Models
  --     wk.add({
  --       { "<leader>as", group = "Select Model" },
  --     })
  --     map({ "n" }, "<Leader>asx", "<cmd>CodeCompanionChat adapter=grok<cr>", { desc = "Grok" })
  --     map({ "n" }, "<Leader>asc", "<cmd>CodeCompanionChat adapter=anthropic<cr>", { desc = "Cláudia" })
  --     map({ "n" }, "<Leader>asg", "<cmd>CodeCompanionChat adapter=openai<cr>", { desc = "GPTelson" })
  --
  --     map({ "n", "v" }, "<Leader>aa", "<cmd>CodeCompanionActions<cr>", { desc = "Code Companion Actions" })
  --     map({ "n", "v" }, "<Leader>ai", ":CodeCompanion @{files} #{lsp} #{buffer} ", { desc = "Code Companion Inline" })
  --
  --     map(
  --       { "n", "v" },
  --       "<Leader>af",
  --       "<cmd>CodeCompanion /fix #{lsp} #{buffer} @{agent} <cr>",
  --       { desc = "Code Companion Fix" }
  --     )
  --     map({ "v" }, "<Leader>ae", "<cmd>CodeCompanion /explain<cr>", { desc = "Code Companion Explain" })
  --     --#endregion
  --
  --     require("codecompanion").setup({
  --       prompt_library = {
  --         markdown = {
  --           dirs = {
  --             vim.fn.getcwd() .. "/.prompts",
  --             vim.fn.stdpath("config") .. "/prompts",
  --           },
  --         },
  --       },
  --
  --       display = {
  --         chat = {
  --           window = {
  --             layout = "vertical",
  --             width = 0.30,
  --           },
  --         },
  --       },
  --
  --       adapters = {
  --         http = {
  --           openai = function()
  --             return require("codecompanion.adapters").extend("openai", {
  --               env = {
  --                 api_key = "OPENAI_API_KEY",
  --                 model = "GPT-5.2-Codex",
  --               },
  --               schema = {
  --                 model = {
  --                   default = "GPT-5.2-Codex",
  --                 },
  --               },
  --             })
  --           end,
  --           claude = function()
  --             return require("codecompanion.adapters").extend("anthropic", {
  --               env = {
  --                 api_key = "ANTHROPIC_API_KEY",
  --               },
  --               schema = {
  --                 model = {
  --                   default = "claude-sonnet-4-6",
  --                 },
  --               },
  --             })
  --           end,
  --           ollama = function()
  --             return require("codecompanion.adapters").extend("ollama", {
  --               env = {
  --                 url = "http://localhost:11434",
  --                 api_key = "OLLAMA_API_KEY",
  --                 model = "qwen2.5-coder:14b",
  --               },
  --               headers = {
  --                 ["Content-Type"] = "application/json",
  --                 ["Authorization"] = "Bearer ${api_key}",
  --               },
  --               parameters = {
  --                 sync = true,
  --               },
  --             })
  --           end,
  --           deepseek = function()
  --             return require("codecompanion.adapters").extend("deepseek", {
  --               env = {
  --                 api_key = "DEEPSEEK_API_KEY",
  --                 model = "deepseek-chat",
  --               },
  --               schema = {
  --                 model = {
  --                   default = "deepseek-chat",
  --                 },
  --               },
  --             })
  --           end,
  --           xai = function()
  --             return require("codecompanion.adapters").extend("xai", {
  --               schema = {
  --                 model = {
  --                   -- default = "grok-code-fast-1",
  --                   -- default = "grok-4-1-fast-reasoning",
  --                   default = "grok-4-fast-reasoning",
  --                   choices = {
  --                     "grok-4-fast-reasoning",
  --                     "grok-4-1-fast-reasoning",
  --                     "grok-code-fast-1",
  --                   },
  --                 },
  --                 presence_penalty = {
  --                   hidden = true,
  --                 },
  --                 frequency_penalty = {
  --                   hidden = true,
  --                 },
  --               },
  --             })
  --           end,
  --           grok = function()
  --             return require("codecompanion.adapters").extend("openai_compatible", {
  --               name = "grok",
  --               url = "https://api.x.ai/v1/chat/completions",
  --               env = {
  --                 api_key = "XAI_API_KEY",
  --               },
  --               schema = {
  --                 model = {
  --                   -- default = "grok-code-fast-1",
  --                   default = "grok-4-1-fast-reasoning",
  --                 },
  --                 presence_penalty = {
  --                   hidden = true,
  --                 },
  --                 frequency_penalty = {
  --                   hidden = true,
  --                 },
  --               },
  --             })
  --           end,
  --         },
  --       },
  --       strategies = {
  --         chat = { adapter = "xai", yolo = true },
  --         inline = { adapter = "xai" },
  --         agent = { adapter = "xai", yolo = true },
  --       },
  --       extensions = {
  --         mcphub = {
  --           callback = "mcphub.extensions.codecompanion",
  --           opts = {
  --             make_vars = true,
  --             make_slash_commands = true,
  --             show_result_in_chat = true,
  --           },
  --         },
  --         history = {
  --           enabled = true,
  --           opts = {
  --             dir_to_save = vim.fn.stdpath("data") .. "/codecompanion_chats.json",
  --           },
  --         },
  --         spinner = {
  --           enabled = true,
  --           opts = {
  --             -- Your spinner configuration goes here
  --             style = "cursor-relative",
  --           },
  --         },
  --       },
  --     })
  --   end,
  -- },

  -- Claude Code
  {
    "coder/claudecode.nvim",
    dependencies = { "folke/snacks.nvim" },
    config = true,
    -- opts = {
    --   terminal_cmd = "ollama launch claude --model minimax-m2.7:cloud",
    -- },
    keys = {
      { "<leader>a", nil, desc = "AI/Claude Code" },
      { "<leader>ac", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
      { "<leader>af", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
      { "<leader>ar", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },
      { "<leader>aC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
      { "<leader>am", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select Claude model" },
      { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer" },
      { "<leader>as", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude" },
      {
        "<leader>as",
        "<cmd>ClaudeCodeTreeAdd<cr>",
        desc = "Add file",
        ft = { "NvimTree", "neo-tree", "oil", "minifiles", "netrw" },
      },
      -- Diff management
      { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
      { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },
    },
  },

  {
    "nickjvandyke/opencode.nvim",
    version = "*", -- Latest stable release
    dependencies = {
      {
        -- `snacks.nvim` integration is recommended, but optional
        ---@module "snacks" <- Loads `snacks.nvim` types for configuration intellisense
        "folke/snacks.nvim",
        optional = true,
        opts = {
          input = {}, -- Enhances `ask()`
          picker = { -- Enhances `select()`
            actions = {
              opencode_send = function(...)
                return require("opencode").snacks_picker_send(...)
              end,
            },
            win = {
              input = {
                keys = {
                  ["<a-a>"] = { "opencode_send", mode = { "n", "i" } },
                },
              },
            },
          },
        },
      },
    },
    config = function()
      ---@type opencode.Opts
      vim.g.opencode_opts = {
        -- Your configuration, if any; goto definition on the type or field for details
      }

      vim.o.autoread = true -- Required for `opts.events.reload`

      -- Recommended/example keymaps
      vim.keymap.set({ "n", "x" }, "<C-a>", function()
        require("opencode").ask("@this: ", { submit = true })
      end, { desc = "Ask opencode…" })
      vim.keymap.set({ "n", "x" }, "<C-x>", function()
        require("opencode").select()
      end, { desc = "Execute opencode action…" })
      vim.keymap.set({ "n", "t" }, "<C-z>", function()
        require("opencode").toggle()
      end, { desc = "Toggle opencode" })

      vim.keymap.set({ "n", "x" }, "go", function()
        return require("opencode").operator("@this ")
      end, { desc = "Add range to opencode", expr = true })
      vim.keymap.set("n", "goo", function()
        return require("opencode").operator("@this ") .. "_"
      end, { desc = "Add line to opencode", expr = true })

      vim.keymap.set("n", "<S-C-u>", function()
        require("opencode").command("session.half.page.up")
      end, { desc = "Scroll opencode up" })
      vim.keymap.set("n", "<S-C-d>", function()
        require("opencode").command("session.half.page.down")
      end, { desc = "Scroll opencode down" })

      -- You may want these if you use the opinionated `<C-a>` and `<C-x>` keymaps above — otherwise consider `<leader>o…` (and remove terminal mode from the `toggle` keymap)
      vim.keymap.set("n", "+", "<C-a>", { desc = "Increment under cursor", noremap = true })
      vim.keymap.set("n", "-", "<C-x>", { desc = "Decrement under cursor", noremap = true })
    end,
  },

  -- {
  --   "kkrampis/codex.nvim",
  --   lazy = true,
  --   cmd = { "Codex", "CodexToggle" }, -- Optional: Load only on command execution
  --   keys = {
  --     {
  --       "<leader>agc", -- Change this to your preferred keybinding
  --       function()
  --         require("codex").toggle()
  --       end,
  --       desc = "Toggle Codex popup or side-panel",
  --       mode = { "n", "t" },
  --     },
  --   },
  --   opts = {
  --     keymaps = {
  --       toggle = nil, -- Keybind to toggle Codex window (Disabled by default, watch out for conflicts)
  --       quit = "<C-q>", -- Keybind to close the Codex window (default: Ctrl + q)
  --     }, -- Disable internal default keymap (<leader>cc -> :CodexToggle)
  --     border = "rounded", -- Options: 'single', 'double', or 'rounded'
  --     width = 0.35, -- Width of the floating window (0.0 to 1.0)
  --     height = 0.8, -- Height of the floating window (0.0 to 1.0)
  --     model = nil, -- Optional: pass a string to use a specific model (e.g., 'o3-mini')
  --     autoinstall = true, -- Automatically install the Codex CLI if not found
  --     panel = true, -- Open Codex in a side-panel (vertical split) instead of floating window
  --     use_buffer = false, -- Capture Codex stdout into a normal buffer instead of a terminal buffer
  --   },
  -- },

  -- UI for CodeCompanion
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown", "codecompanion" },
  },

  -- Only one of both can be used
  -- {
  --   "OXY2DEV/markview.nvim",
  --   lazy = false,
  --   opts = {
  --     preview = {
  --       filetypes = { "markdown", "codecompanion" },
  --       ignore_buftypes = {},
  --     },
  --   },
  -- },

  {
    "nvim-mini/mini.diff",
    config = function()
      local diff = require("mini.diff")
      diff.setup({
        -- Disabled by default
        source = diff.gen_source.none(),
      })
    end,
  },

  {
    "milanglacier/minuet-ai.nvim",
    dependencies = {
      "saghen/blink.cmp",
    },
    config = function()
      require("minuet").setup({
        -- Deepseek
        -- provider = "openai_fim_compatible",
        -- provider_options = {
        --   openai_fim_compatible = {
        --     api_key = "",
        --     name = "deepseek",
        --     -- optional = {
        --     --   max_tokens = 256,
        --     --   top_p = 0.9,
        --     -- },
        --   },
        -- },

        throttle = 200, -- only send the request every x milliseconds, use 0 to disable throttle.
        -- debounce the request in x milliseconds, set to 0 to disable debounce
        debounce = 300,

        provider = "openai_fim_compatible",
        n_completions = 1, -- recommend for local model for resource saving

        -- I recommend beginning with a small context window size and incrementally
        -- expanding it, depending on your local computing power. A context window
        -- of 512, serves as an good starting point to estimate your computing
        -- power. Once you have a reliable estimate of your local computing power,
        -- you should adjust the context window to a larger value.
        context_window = 12000,
        provider_options = {
          openai_fim_compatible = {
            name = "Ollama",
            end_point = "http://localhost:11434/v1/completions",
            model = "qwen2.5-coder:3b-base", -- medium end
            -- model = "qwen2.5-coder:1.5b-base", -- low end
            -- model = "qwen2.5-coder:7b-base", -- slower high end
            -- model = " qwen-opus-9b", -- ultra high-end 9b destiled from Claude Opus
            -- model = "deepseek-coder-v2-lite-base", -- slower medium

            optional = {
              max_tokens = 200,
              top_p = 0.9,

              -- FIM tuning (IMPORTANT)
              -- temperature = 0.1,

              -- Required for CodeGemma
              fim = {
                enabled = true,
              },
            },
          },
        },

        -- Virtualtext completion
        virtualtext = {
          auto_trigger_ft = { "go", "lua", "java", "markdown", "dart", "js", "ts", "elixir" },
          keymap = {
            -- accept whole completion
            accept = "<A-A>",
            -- accept one line
            accept_line = "<A-a>",
            -- accept n lines (prompts for number)
            -- e.g. "A-z 2 CR" will accept 2 lines
            accept_n_lines = "<A-z>",
            -- Cycle to prev completion item, or manually invoke completion
            prev = "<A-[>",
            -- Cycle to next completion item, or manually invoke completion
            next = "<A-]>",
            dismiss = "<A-e>",
          },
        },
      })
    end,
  },

  -- Opencode
  -- {
  --   "NickvanDyke/opencode.nvim",
  --   dependencies = {
  --     -- Recommended for `ask()` and `select()`.
  --     -- Required for default `toggle()` implementation.
  --     { "folke/snacks.nvim", opts = { input = {}, picker = {}, terminal = {} } },
  --   },
  --   config = function()
  --     ---@type opencode.Opts
  --     vim.g.opencode_opts = {
  --       -- Your configuration, if any — see `lua/opencode/config.lua`, or "goto definition".
  --     }
  --
  --     -- Required for `opts.auto_reload`.
  --     vim.o.autoread = true
  --
  --     -- Recommended/example keymaps.
  --     vim.keymap.set({ "n", "x" }, "<C-a>", function()
  --       require("opencode").ask("@this: ", { submit = true })
  --     end, { desc = "Ask opencode" })
  --     vim.keymap.set({ "n", "x" }, "<C-x>", function()
  --       require("opencode").select()
  --     end, { desc = "Execute opencode action…" })
  --     vim.keymap.set({ "n", "x" }, "ga", function()
  --       require("opencode").prompt("@this")
  --     end, { desc = "Add to opencode" })
  --     vim.keymap.set({ "n", "t" }, "<leader>ao", function()
  --       require("opencode").toggle()
  --     end, { desc = "Toggle opencode" })
  --     vim.keymap.set("n", "<S-C-u>", function()
  --       require("opencode").command("session.half.page.up")
  --     end, { desc = "opencode half page up" })
  --     vim.keymap.set("n", "<S-C-d>", function()
  --       require("opencode").command("session.half.page.down")
  --     end, { desc = "opencode half page down" })
  --     -- You may want these if you stick with the opinionated "<C-a>" and "<C-x>" above — otherwise consider "<leader>o".
  --     vim.keymap.set("n", "+", "<C-a>", { desc = "Increment", noremap = true })
  --     vim.keymap.set("n", "-", "<C-x>", { desc = "Decrement", noremap = true })
  --   end,
  -- },
}
