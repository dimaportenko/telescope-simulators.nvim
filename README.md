# telescope-simulators.nvim

A [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) extension to open iOS simulators and Android emulators. 

![demo](https://raw.githubusercontent.com/dimaportenko/telescope-simulators.nvim/main/docs/demo.gif)

## Installation

```lua
use "dimaportenko/telescope-simulators.nvim"
```

## Usage

```
Telescope simulators run
``` 

## Configuration

```lua
require("simulators").setup({
  android_emulator = false,
  apple_simulator = true,
})
```

## Dependencies
This project is intended for people who do mobile app development and already have the necessary dependencies installed. The following command line tools are used in this project:

- `emulator` (for Android)
- `xcrun` (for Apple simulators)

It has been tested on Mac OS, so if you are using a different operating system, your mileage may vary.

Please make sure that you have the latest version of these tools installed before using this project. If you encounter any issues, please refer to the official documentation for the relevant tool for guidance.
