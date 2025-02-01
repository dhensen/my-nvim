# Pomodoro Neovim Plugin

A simple Pomodoro timer plugin for Neovim with configurable DND commands.

## Installation

Using [lazy.nvim](https://github.com/folke/lazy.nvim), add the following to your lazy setup:

```lua
{
  "your-username/pomodoro.nvim",
  config = function()
    require("pomodoro").setup()
  end,
}
```

## Setup Examples

### Vanilla Setup

```lua
require("pomodoro").setup()
```

### Setup with Custom Shortcuts Commands

```lua
require("pomodoro").setup({
  start_cmd = 'shortcuts run "Start Work Focus"',
  stop_cmd = 'shortcuts run "Stop Work Focus"',
})
```

## Usage

- Start Pomodoro: `:Pomodoro start`
- Stop Pomodoro: `:Pomodoro stop`

## Statusline Integration

If [lualine](https://github.com/nvim-lualine/lualine.nvim) is installed, the plugin automatically displays the timer in the statusline.

