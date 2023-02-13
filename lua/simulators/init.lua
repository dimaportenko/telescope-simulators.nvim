local pickers = require('telescope.pickers')
local finders = require('telescope.finders')
local conf = require('telescope.config').values
local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')

local apple_simulator = require('simulators.apple_simulator')
local android_emulator = require('simulators.android_emulator')


local M = {}

M.config = {
  apple_simulator = true,
  android_emulator = false,
}

M.setup = function(config)
  M.config = vim.tbl_extend("force", M.config, config or {})
  -- print(vim.inspect(M.config))
end

local select_default = function(prompt_bufnr)
  actions.close(prompt_bufnr)
  local selection = action_state.get_selected_entry()

  if selection.value.osVersion == "Android" then
    android_emulator.run(selection.value.name)
    return
  end

  if apple_simulator.is_simulator_running() then
    -- open simulator app
    apple_simulator.open_simulator()
  end

  -- boot simulator
  apple_simulator.boot_simulator(selection.value.udid)
end

M.run = function(opts)
  opts = opts or {}
  local ios_devices, android_devices = {}, {}
  if M.config.apple_simulator then
    ios_devices = apple_simulator.get_available()
  end

  if M.config.android_emulator then
    android_devices = android_emulator.get_available()
  end

  local devicesTable = vim.tbl_extend("force", ios_devices, android_devices)
  -- entry_maker
  local entry_maker = function(entry)
    local display = entry.name .. " (" .. entry.osVersion .. ")"
    if entry.state then
      display = display .. " (" .. entry.state .. ")"
    end
    return {
      value = entry,
      display = display,
      ordinal = display,
    }
  end

  pickers.new(opts, {
    prompt_title = 'Search Simulator',
    finder = finders.new_table {
      results = devicesTable,
      entry_maker = entry_maker,
    },
    sorter = conf.generic_sorter(opts),
    attach_mappings = function(prompt_bufnr, _)
      actions.select_default:replace(function()
        select_default(prompt_bufnr)
      end)
      return true
    end,
  }):find()
end
-- M.run()
return M

