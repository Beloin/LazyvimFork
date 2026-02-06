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
  {
    "yetone/avante.nvim",
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    -- ⚠️ must add this setting! ! !
    build = vim.fn.has("win32") ~= 0 and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
      or "make",
    event = "VeryLazy",
    version = false, -- Never set this value to "*"! Never!
    ---@module 'avante'
    ---@type avante.Config
    opts = {
      -- add any opts here
      -- this file can contain specific instructions for your project
      instructions_file = "avante.md",
      auto_suggestions_provider = "ollama",
      provider = "xai",
      providers = {
        deepseek = {
          __inherited_from = "openai",
          api_key_name = "DEEPSEEK_API_KEY",
          endpoint = "https://api.deepseek.com",
          model = "deepseek-chat",
        },
        ollama = {
          model = "codegemma:7b",
          endpoint = "http://localhost:11434",
          is_env_set = true,
          temperature = 0.1,
          max_tokens = 2048,

          -- IMPORTANT: enable FIM mode
          use_fim = true,
        },
        deepseek_fast = {
          __inherited_from = "openai",
          endpoint = "http://localhost:11434",
          model = "deepseek-coder:1.3b",
        },
        xai = {
          api_key_name = "XAI_API_KEY",
          model = "grok-code-fast-1",
        },
        claude = {
          endpoint = "https://api.anthropic.com",
          auth_type = "api", -- Set to "max" to sign in with Claude Pro/Max subscription
          model = "claude-haiku-4-5-20251001",
        },
      },
    },
    -- behaviour = {
    --   auto_suggestions = true,
    -- },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below dependencies are optional,
      "nvim-mini/mini.pick", -- for file_selector provider mini.pick
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
    -- system_prompt as function ensures LLM always has latest MCP server state
    -- This is evaluated for every message, even in existing chats
    system_prompt = function()
      local hub = require("mcphub").get_hub_instance()
      return hub and hub:get_active_servers_prompt() or ""
    end,
    -- Using function prevents requiring mcphub before it's loaded
    custom_tools = function()
      return {
        require("mcphub.extensions.avante").mcp_tool(),
      }
    end,
  },

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
  --   },
  --   config = function()
  --     require("codecompanion").setup({
  --       prompt_library = {
  --         markdown = {
  --           dirs = {
  --             vim.fn.getcwd() .. "/.prompts",
  --             vim.fn.stdpath("config") .. "/promtps"
  --           },
  --         },
  --       },
  --
  --       adapters = {
  --         http = {
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
  --           grok = function()
  --             return require("codecompanion.adapters").extend("openai_compatible", {
  --               name = "grok",
  --               url = "https://api.x.ai/v1/chat/completions",
  --               env = {
  --                 api_key = "XAI_API_KEY",
  --               },
  --               schema = {
  --                 model = {
  --                   default = "grok-code-fast-1",
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
  --         chat = { adapter = "grok" },
  --         inline = { adapter = "grok" },
  --         agent = { adapter = "grok" },
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
  --       },
  --     })
  --   end,
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

        throttle = 500, -- only send the request every x milliseconds, use 0 to disable throttle.
        -- debounce the request in x milliseconds, set to 0 to disable debounce
        debounce = 400,

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
            -- For Windows users, TERM may not be present in environment variables.
            -- Consider using APPDATA instead.
            name = "Ollama",
            end_point = "http://localhost:11434/v1/completions",
            model = "qwen2.5-coder:3b-base",
            -- model = "qwen2.5-coder:1.5b-base",
            -- model = "qwen2.5-coder:7b-base",
            -- model = "deepseek-coder-v2-lite-base",
            -- stream = false,

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
          auto_trigger_ft = { "go", "lua" },
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
