local M = {}

M.setup = function()
  local skconf = require("utils.skel-config")
  require("skel-nvim").setup({

    -- file pattern -> template mappings
    mappings = {
      -- ["*.cpp"] = "cpp.skel",
      ["*.hpp"] = "h.skel",
      -- patterns can map to multiple templates
      -- ["LICENSE"] = { "license.mit.skel", "license.gpl.skel" },
    },

    substitutions = {
      ["FOLDER_NAMESPACE"] = skconf.folder_namespace,
      ["END_FOLDER_NAMESPACE"] = skconf.end_folder_namespace,
      ["HEADER_GUARD"] = skconf.guard_name,
    },
  })
end

return M
