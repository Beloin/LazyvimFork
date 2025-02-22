return {

  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "nvim-neotest/nvim-nio" },
    -- stylua: ignore
    keys = {{
        "<leader>du",
        function()
            require("dapui").toggle({})
        end,
        desc = "Dap UI"
    }, {
        "<leader>de",
        function()
            require("dapui").eval()
        end,
        desc = "Eval",
        mode = {"n", "v"}
    }},
    opts = { floating = { border = "rounded" } },
    config = function(_, opts)
      local dap = require("dap")
      local dapui = require("dapui")
      dapui.setup(opts)
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open({})
        vim.cmd("Neotree close")
      end
      -- TODO: Removed since conflicts with tests and is annoying
      -- dap.listeners.before.event_terminated["dapui_config"] = function()
      --     dapui.close({})
      -- end
      -- dap.listeners.before.event_exited["dapui_config"] = function()
      --     dapui.close({})
      -- end
    end,
  },
}
