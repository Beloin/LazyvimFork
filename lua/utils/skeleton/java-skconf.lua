local M = {}

local function reverse_table(t)
  local reversed = {}
  for i = #t, 1, -1 do
    table.insert(reversed, t[i])
  end
  return reversed
end

local function find_java_dir_recursive(dir, dirs_traversed)
  local current_dir_name = vim.fn.fnamemodify(dir, ":t")

  if current_dir_name == "java" then
    return dir
  end

  if dir == "/" or dir:match("^%a:[\\/]*$") then
    return nil
  end

  table.insert(dirs_traversed, current_dir_name)

  local parent_dir = vim.fn.fnamemodify(dir, ":h")
  return find_java_dir_recursive(parent_dir, dirs_traversed)
end

local function package(config)
  local current_dir = vim.fn.expand("%:p:h")
  local dirs_traversed = {}

  local java_dir = find_java_dir_recursive(current_dir, dirs_traversed)
  if not java_dir then
    return "packageNotFound"
  end

  local reversed = reverse_table(dirs_traversed)

  local package_parts = {}
  for _, dir in ipairs(reversed) do
    if dir ~= java_dir then
      table.insert(package_parts, dir)
    end
  end

  return table.concat(package_parts, ".")
end

M.get_package = package

M.get_classname = function()
  return vim.fn.expand("%:t:r")
end

M.get_type = function(config)
  return "class"
end

return M
