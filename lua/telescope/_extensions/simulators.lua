return require("telescope").register_extension {
  setup = function(config)
    require("simulators").setup(config)
  end,
  exports = {
    run = require("simulators").run,
  }
}
