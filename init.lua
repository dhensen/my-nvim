vim.g.mapleader = " "
vim.g.maplocalleader = " "

require "config.lazy"
require "keybindings"
require "diagnostics"
require "options"

require "autocomplete"
require "nullls"
require "testing"

vim.g.python3_host_prog = os.getenv "HOME" .. "/.nvim-venv/bin/python3"

require("large-files").setup {
    size = 1048576, -- Default size (1 MB)
    filetypes = {
        json = 1048576,
        xml = 2097152,
    },
}

-- hide tilde for empty lines
vim.cmd [[hi NonText guifg=bg]]

local in_wsl = os.getenv "WSL_DISTRO_NAME" ~= nil

if in_wsl then
    local script_path = vim.fn.stdpath "config" .. "/nvim_paste"
    vim.g.clipboard = {
        name = "wsl clipboard",
        copy = { ["+"] = { "clip.exe" }, ["*"] = { "clip.exe" } },
        paste = { ["+"] = { script_path }, ["*"] = { script_path } },
        cache_enabled = true,
    }
end

if pcall(require, "live_prices") then
    require("live_prices").setup()
end
if pcall(require, "pomodoro") then
    require("pomodoro").setup()
end
