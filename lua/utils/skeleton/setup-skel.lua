local M = {}

M.setup = function()
  local skconf = require("utils.skeleton.skel-config")
  local cmake_skconf = require("utils.skeleton.cmake-skconf")
  require("skel-nvim").setup({

    -- file pattern -> template mappings
    mappings = {
      -- ["*.cpp"] = "cpp.skel",
      ["*.hpp"] = "hpp.skel",
      ["*.h"] = "h.skel",
      ["*.go"] = "go.skel",
      ["*.cs"] = "csharp.skel",

      -- Other's skels
      ["*CMakeLists.txt"] = "cmake.skel",

      -- patterns can map to multiple templates
      ["LICENSE"] = { "license.gpl.skel" },
    },

    substitutions = {
      ["FOLDER_NAMESPACE"] = skconf.folder_namespace,
      ["END_FOLDER_NAMESPACE"] = skconf.end_folder_namespace,
      ["HEADER_GUARD"] = skconf.guard_name,
      ["FOLDER_NAME"] = skconf.folder_name,
      ["NAME"] = "Beloin Rodrigues",

      -- Csharp only
      ["CS_CLASS_NAME"] = skconf.get_classname,
      ["CS_NAMESPACE"] = skconf.get_cs_namespace,
      ["CS_TYPE"] = skconf.get_type,

      -- CMAKE Only
      ["CMAKE_VERSION"] = cmake_skconf.cmake_version,
      ["LIB_OR_PROJECT"] = cmake_skconf.lib_or_project,
    },
  })
end

return M
