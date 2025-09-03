--- main_finder.lua
local M = {}

local langs = require("utils.langs")
local javafd = require("utils.main_finder.java_finder")
local gofd = require("utils.main_finder.go_finder")

M.map = {}
M.map["java"] = javafd.finder
M.map["go"] = gofd.finder

---@param finder fun(workspace: string): boolean, string Returns the file name containing the main file
---@param workspace string Current workspace
local function getFinderFunction(finder, workspace)
  return function()
    return finder(workspace)
  end
end

local function getMain()
  local lang = langs.findCurrentLangName()
  local cwd = vim.fn.getcwd()
  local finder = M.map[lang]
  local fn = getFinderFunction(finder, cwd)
  return fn()
end

M.getMain = getMain

return M
