local pickers = require('telescope.pickers')
local finders = require('telescope.finders')
local conf = require('telescope.config').values
local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')

local apple_simulator = require('simulators.apple_simulator')

local M = {}

local select_default = function(prompt_bufnr)
  actions.close(prompt_bufnr)
  local selection = action_state.get_selected_entry()

  if apple_simulator.is_simulator_running() then
    -- open simulator app
    apple_simulator.open_simulator()
  end

  -- boot simulator
  apple_simulator.boot_simulator(selection.value.udid)
end

M.run = function(opts)
  opts = opts or {}
  -- cmd command xcrun simctl list devices available --json
  local devicesJson = apple_simulator.get_available_json()

  -- convert devices to table
  local devicesTable = apple_simulator.convert_json_to_table(devicesJson)

  -- entry_maker
  local entry_maker = function(entry)
    local display = entry.name .. " (" .. entry.osVersion .. ")" .. " (" .. entry.state .. ")"
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

return M

-- simulators()
-- simulators(require('telescope.themes').get_dropdown({}))
-- colors()

--   {
--   "devices" : {
--     "com.apple.CoreSimulator.SimRuntime.watchOS-8-5" : [
--
--     ],
--     "com.apple.CoreSimulator.SimRuntime.iOS-16-2" : [
--       {
--         "lastBootedAt" : "2022-12-15T22:26:55Z",
--         "dataPath" : "\/Users\/dmitriyportenko\/Library\/Developer\/CoreSimulator\/Devices\/D791B2EC-3E0A-473C-B62A-BF2C29A9FAD2\/data",
--         "dataPathSize" : 677961728,
--         "logPath" : "\/Users\/dmitriyportenko\/Library\/Logs\/CoreSimulator\/D791B2EC-3E0A-473C-B62A-BF2C29A9FAD2",
--         "udid" : "D791B2EC-3E0A-473C-B62A-BF2C29A9FAD2",
--         "isAvailable" : true,
--         "logPathSize" : 57344,
--         "deviceTypeIdentifier" : "com.apple.CoreSimulator.SimDeviceType.iPhone-SE-3rd-generation",
--         "state" : "Shutdown",
--         "name" : "iPhone SE (3rd generation)"
--       },
--       {
--         "lastBootedAt" : "2023-02-10T12:04:09Z",
--         "dataPath" : "\/Users\/dmitriyportenko\/Library\/Developer\/CoreSimulator\/Devices\/7C3DD19E-78EE-4773-B65B-2914B711736E\/data",
--         "dataPathSize" : 5184405504,
--         "logPath" : "\/Users\/dmitriyportenko\/Library\/Logs\/CoreSimulator\/7C3DD19E-78EE-4773-B65B-2914B711736E",
--         "udid" : "7C3DD19E-78EE-4773-B65B-2914B711736E",
--         "isAvailable" : true,
--         "logPathSize" : 761856,
--         "deviceTypeIdentifier" : "com.apple.CoreSimulator.SimDeviceType.iPhone-14",
--         "state" : "Booted",
--         "name" : "iPhone 14"
--       }
--     ],
--   }
-- }
