local vim = vim
local api = vim.api
local timer = vim.loop.new_timer()
local os = require "os"

local pomodoro_time = 25 * 60 -- 25 minutes in seconds
local countdown = pomodoro_time

local M = {}

function M.set_dnd(enable)
    if enable then
        os.execute 'shortcuts run "Start Work Focus"'
    else
        os.execute 'shortcuts run "Stop Work Focus"'
    end
end

local function update_statusline()
    local minutes = math.floor(countdown / 60)
    local seconds = countdown % 60
    local formatted_time = string.format("%02d:%02d", minutes, seconds)
    vim.g.pomodoro_timer = formatted_time
    api.nvim_command "redrawstatus"
end

function M.start_pomodoro()
    countdown = pomodoro_time
    M.set_dnd(true)
    timer:start(
        0,
        1000,
        vim.schedule_wrap(function()
            if countdown > 0 then
                countdown = countdown - 1
                update_statusline()
            else
                timer:stop()
                M.set_dnd(false)
                vim.notify "Pomodoro finished!"
            end
        end)
    )
end

function M.stop_pomodoro()
    timer:stop()
    M.set_dnd(false)
    vim.g.pomodoro_timer = nil
    api.nvim_command "redrawstatus"
    vim.notify "Pomodoro stopped prematurely!"
end

function M.get_statusline()
    return vim.g.pomodoro_timer or ""
end

-- Command to start Pomodoro
vim.api.nvim_create_user_command("StartPomodoro", function()
    M.start_pomodoro()
end, {})

-- Command to stop Pomodoro
vim.api.nvim_create_user_command("StopPomodoro", function()
    M.stop_pomodoro()
end, {})

function M.setup()
    vim.g.pomodoro_timer = nil

    -- Statusline integration for lualine
    if pcall(require, "lualine") then
        require("lualine").setup {
            sections = {
                lualine_c = { M.get_statusline },
            },
        }
    end
end

return M
