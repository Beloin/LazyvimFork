--- cmake-skconf.lua
local M = {}

local cmd = require("utils.cmd")

function M.cmake_version(config)
  local status, result = cmd.run("cmake --version | sed 1q | cut -d' ' -f3 | cut -d'.' -f1,2")
  if not status or not result then
    return "3.22"
  end

  return string.gsub(result, "\n", "")
end

function M.lib_or_project(config)
  -- Read current folder, if folder is cwd, return project(folder_name),
  -- else, return add_library(folder_name_lib)
  local folder_name = vim.fs.dirname(config.filename)
  local cwd = vim.fn.getcwd()

  local is_project = folder_name == cwd

  local folderarr = vim.fn.split(folder_name, "/")
  local folder = folderarr[#folderarr]

  if is_project then
    return "project(" .. folder .. ")"
  end

  return "add_library(" .. folder .. "_lib)"
end

return M
