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
