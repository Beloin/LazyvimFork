local M = {}

local data_path = vim.fn.stdpath("data") .. "/jdtls_vmargs.json"

-- Load JSON data with guardrail and backup on invalid JSON or invalid structure
local function load_data()
  local f = io.open(data_path, "r")
  if not f then return { vmargs = {}, profiles = {}, active_profile = nil } end
  local content = f:read("*a")
  f:close()
  local ok, decoded = pcall(vim.fn.json_decode, content)
  if not ok or type(decoded) ~= "table" then
    -- backup corrupted file
    local bak_path = data_path .. ".bak"
    os.rename(data_path, bak_path)
    print("[JDTLS] Invalid JSON config detected, backup created at " .. bak_path)
    return { vmargs = {}, profiles = {}, active_profile = nil }
  end
  -- Validate decoded fields
  if type(decoded.vmargs) ~= "table" or type(decoded.profiles) ~= "table" then
    local bak_path = data_path .. ".bak"
    os.rename(data_path, bak_path)
    print("[JDTLS] Invalid config structure detected, backup created at " .. bak_path)
    return { vmargs = {}, profiles = {}, active_profile = nil }
  end
  decoded.vmargs = decoded.vmargs or {}
  decoded.profiles = decoded.profiles or {}
  if decoded.active_profile ~= nil and type(decoded.active_profile) ~= "string" then
    decoded.active_profile = nil
  end
  return decoded
end

-- Save JSON data
local function save_data(data)
  local f = io.open(data_path, "w")
  if f then
    f:write(vim.fn.json_encode(data))
    f:close()
  end
end

local state = load_data()

local function update_dap_config()
  local args = vim.deepcopy(state.vmargs)
  if state.active_profile and state.active_profile ~= "" then
    table.insert(args, "-Dspring.profiles.active=" .. state.active_profile)
  end
  require("jdtls.dap").setup_dap_main_class_configs({
    config_overrides = { vmArgs = table.concat(args, " ") },
  })
end

local has_fzflua, fzf = pcall(require, "fzf-lua")
if not has_fzflua then
  vim.api.nvim_echo({{"[JDTLS] fzf-lua not found, FZF commands disabled.", "WarningMsg"}}, false, {})
end

-- helper to open input in insert mode
local function input_insert_mode(opts, on_confirm)
  vim.ui.input(opts, function(value)
    on_confirm(value)
  end)
  vim.schedule(function() vim.cmd("startinsert!") end)
end

-- VMARGS
function M.edit_vmarg_fzf()
  local function refresh_list()
    local list = vim.deepcopy(state.vmargs)
    table.insert(list, "<Create new>")
    return list
  end

  local function prompt_add()
    input_insert_mode({ prompt = "Add new VM arg: " }, function(input)
      if input and input ~= "" then
        table.insert(state.vmargs, input)
        save_data(state)
        update_dap_config()
        print("Added VM arg: " .. input)
      end
      M.edit_vmarg_fzf()
    end)
  end

  fzf.fzf_exec(refresh_list(), {
    prompt = "Edit VM args > ",
    fzf_opts = { ["--multi"] = "" },
    actions = {
      ["default"] = function(selected)
        if selected and #selected > 0 and selected[1] == "<Create new>" then
          prompt_add()
        else
          M.edit_vmarg_fzf()
        end
      end,
      ["ctrl-a"] = function() prompt_add() end,
      ["ctrl-x"] = function(selected)
        if not selected or #selected == 0 then return end
        for _, item in ipairs(selected) do
          for i = #state.vmargs, 1, -1 do
            if state.vmargs[i] == item then
              table.remove(state.vmargs, i)
              print("Removed VM arg: " .. item)
            end
          end
        end
        save_data(state)
        update_dap_config()
        M.edit_vmarg_fzf()
      end,
      ["esc"] = function() print("Cancelled.") end,
    },
  })
end

-- PROFILES
function M.edit_profile_fzf()
  local function refresh_list()
    local list = {}
    for _, p in ipairs(state.profiles) do
      if p == state.active_profile then
        table.insert(list, "✔ " .. p)
      else
        table.insert(list, p)
      end
    end
    table.insert(list, "<Create new>")
    return list
  end

  local function clean_name(name)
    return name:gsub("^✔%s*", "")
  end

  local function prompt_add()
    input_insert_mode({ prompt = "Add new profile: " }, function(input)
      if input and input ~= "" then
        table.insert(state.profiles, input)
        state.active_profile = input
        save_data(state)
        update_dap_config()
        print("Added and set profile: " .. input)
      end
      M.edit_profile_fzf()
    end)
  end

  fzf.fzf_exec(refresh_list(), {
    prompt = "Edit Profiles > ",
    fzf_opts = { ["--multi"] = "" },
    actions = {
      ["default"] = function(selected)
        if not selected or #selected == 0 then
          M.edit_profile_fzf()
          return
        end
        local choice = clean_name(selected[1])
        if choice == "<Create new>" then
          prompt_add()
        else
          state.active_profile = choice
          save_data(state)
          update_dap_config()
          print("Active profile set to: " .. choice)
          M.edit_profile_fzf()
        end
      end,
      ["ctrl-x"] = function(selected)
        if not selected or #selected == 0 then return end
        for _, prof in ipairs(selected) do
          local p = clean_name(prof)
          for i = #state.profiles, 1, -1 do
            if state.profiles[i] == p then
              table.remove(state.profiles, i)
              print("Removed profile: " .. p)
              if state.active_profile == p then
                state.active_profile = nil
              end
            end
          end
        end
        save_data(state)
        update_dap_config()
        M.edit_profile_fzf()
      end,
      ["ctrl-a"] = function() prompt_add() end,
      ["esc"] = function() print("Cancelled.") end,
    },
  })
end

function M.show_current_profile()
  if state.active_profile then
    print("Current Spring profile: " .. state.active_profile)
  else
    print("No active profile set")
  end
end

vim.api.nvim_create_user_command("JdtEditVMArgs", M.edit_vmarg_fzf, {})
vim.api.nvim_create_user_command("JdtEditProfile", M.edit_profile_fzf, {})
vim.api.nvim_create_user_command("JdtShowProfile", M.show_current_profile, {})

function M.setup()
  state = load_data()

  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      if client and client.name == "jdtls" then
        update_dap_config()
      end
    end,
  })

  vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*.java",
    callback = function()
      update_dap_config()
    end,
  })
end

return M
