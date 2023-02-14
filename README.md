# telescope-simulators.nvim

Welcome to the **telescope-simulators.nvim** a [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) extension! This extension is designed to make it easy to open iOS simulators and Android emulators directly from within the Neovim text editor. You can quickly launch simulators and emulators without having to leave the comfort of your text editor. Whether you're developing mobile apps or simply testing your code, this extension will save you time and improve your workflow. Get ready to take your mobile development experience to the next level with **telescope-simulators.nvim**!


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
