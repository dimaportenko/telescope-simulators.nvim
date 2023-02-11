local pickers = require('telescope.pickers')
local finders = require('telescope.finders')
local conf = require('telescope.config').values
local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')

local M = {}

M.run = function(opts)
  opts = opts or {}

  -- cmd command xcrun simctl list devices available --json
  local devicesCmd = "xcrun simctl list devices available --json"
  local devicesCmdOutput = vim.fn.system(devicesCmd)
  local devicesJson = vim.fn.json_decode(devicesCmdOutput)

  -- convert devices to table
  local devicesTable = {}
  for _, runtime in pairs(devicesJson) do
    for runtimeKey, devices in pairs(runtime) do
      local osName, major, minor = runtimeKey:match("(%a+)-(%d+)-(%d+)")
      local osVersion = osName .. " " .. major .. "." .. minor

      for _, device in pairs(devices) do
        device.osVersion = osVersion
        table.insert(devicesTable, device)
      end

    end
  end


  pickers.new(opts, {
    prompt_title = 'Colors',
    finder = finders.new_table {
      results = devicesTable,
      entry_maker = function(entry)
        local display = entry.name .. " (" .. entry.osVersion .. ")" .. " (" .. entry.state .. ")"
        return {
          value = entry,
          display = display,
          ordinal = display,
        }
      end
    },
    sorter = conf.generic_sorter(opts),
    attach_mappings = function(prompt_bufnr, _)
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local selection = action_state.get_selected_entry()

        -- print(vim.inspect(selection))
          -- print(vim.inspect(devicesTable))
        -- vim.api.nvim_put({ selection[1] }, "", false, true)

        -- check if simulator app is already running
        local checkCmd = "ps aux | grep -v grep | grep -c Simulator.app"
        local checkCmdOutput = vim.fn.system(checkCmd)
        -- parse number from string output
        checkCmdOutput = checkCmdOutput:match("%d+")
        print(vim.inspect(checkCmdOutput))
        if checkCmdOutput == "0" then
          -- open simulator app
          print("open simulator app")
          local simulatorCmd = "open -a Simulator --args -CurrentDeviceUDID " .. selection.value.udid
          vim.fn.system(simulatorCmd)
        end

        -- boot simulator
        local simulatorCmd = "xcrun simctl boot " .. selection.value.udid
        vim.fn.system(simulatorCmd)
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

