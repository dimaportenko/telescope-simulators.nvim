local M = {}

M.is_simulator_running = function()
  local checkCmd = "ps aux | grep -v grep | grep -c Simulator.app"
  local checkCmdOutput = vim.fn.system(checkCmd)
  -- parse number from string output
  checkCmdOutput = checkCmdOutput:match("%d+")
  -- print(vim.inspect(checkCmdOutput))
  return checkCmdOutput == "0"
end

M.open_simulator = function()
  local simulatorCmd = "open -a Simulator"
  vim.fn.system(simulatorCmd)
end

M.boot_simulator = function(udid)
  local simulatorCmd = "xcrun simctl boot " .. udid
  vim.fn.system(simulatorCmd)
end

M.get_available_json = function()
  local cmd = "xcrun simctl list devices available --json"
  local cmd_output = vim.fn.system(cmd)
  local json = vim.fn.json_decode(cmd_output)
  return json
end

M.convert_json_to_table = function(json)
  local devicesTable = {}
  for _, runtime in pairs(json) do
    for runtimeKey, devices in pairs(runtime) do
      local osName, major, minor = runtimeKey:match("(%a+)-(%d+)-(%d+)")
      local osVersion = osName .. " " .. major .. "." .. minor

      for _, device in pairs(devices) do
        device.osVersion = osVersion
        table.insert(devicesTable, device)
      end

    end
  end
  return devicesTable
end

M.get_available = function()
  local devicesJson = M.get_available_json()
  local devicesTable = M.convert_json_to_table(devicesJson)
  return devicesTable
end

return M
