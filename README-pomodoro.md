# Pomodoro.nvim

A simple Pomodoro timer plugin for Neovim with configurable DND start/stop commands. Commands can be provided as Lua callables or as executable strings.

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

Or using any other plugin manager, add the following to your `init.lua`:

```lua
require("pomodoro").setup()
```

### Configuration Options

- `duration`: Pomodoro duration in seconds (default is `25 * 60` seconds).
- `start_cmd`: Command to execute on start. Can be a Lua callable or a string command.
- `stop_cmd`: Command to execute on stop. Can be a Lua callable or a string command.

## Usage

- **Start Pomodoro:** `:Pomodoro start`
- **Stop Pomodoro:** `:Pomodoro stop`

The timer will be shown in your statusline if you're using [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim).

## Custom DND Commands

It is possible to use custom commands to toggle Do Not Disturb mode on your system. Here are some examples:

For example: on macOS you can use the built-in `shortcuts` command. Either as a string:

```lua
require("pomodoro").setup({
  start_cmd = 'shortcuts run "Start Work Focus"',
  stop_cmd  = 'shortcuts run "Stop Work Focus"',
})
```

> You will still have to setup the "Start Work Focus" and "Stop Work Focus" shortcuts in the Shortcuts app. I have setup mine to toggle Do Not Disturb focus mode.

You can also use Lua callables:

```lua
require("pomodoro").setup({
  start_cmd = function()
    vim.cmd 'ZenMode'
    os.execute('shortcuts run "Start Work Focus"')
    os.execute('start_pomodoro_music')
  end,
  stop_cmd = function()
    vim.cmd 'ZenMode'
    os.execute('shortcuts run "Stop Work Focus"')
  end,
})
```

In this Linux example, if you use [dunst](https://dunst-project.org/) as your notification daemon, you might want to pause notifications during a Pomodoro. For example, using `dunstctl`:

```lua
require("pomodoro").setup({
  start_cmd = "dunstctl set-paused true",
  stop_cmd  = "dunstctl set-paused false",
})
```
