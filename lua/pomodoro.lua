local vim = vim
local api = vim.api
local timer = vim.loop.new_timer()
local os = require "os"

local countdown = 0
local is_running = false

local M = {}

M.config = {
    duration = 25 * 60,
    start_cmd = "",
    stop_cmd = "",
}

function M.set_dnd(enable)
    local cmd = enable and M.config.start_cmd or M.config.stop_cmd
    if type(cmd) == "function" then
        cmd()
    elseif type(cmd) == "string" and cmd ~= "" then
        os.execute(cmd)
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
    if is_running then
        vim.notify("Pomodoro already running!", vim.log.levels.WARN)
        return
    end
    countdown = M.config.duration
    is_running = true
    M.set_dnd(true)
    timer:start(
        0,
        1000,
        vim.schedule_wrap(function()
            if not is_running then
                return
            end
            if countdown > 0 then
                countdown = countdown - 1
                update_statusline()
            else
                is_running = false
                timer:stop()
                M.set_dnd(false)
                vim.notify "Pomodoro finished!"
            end
        end)
    )
end

function M.stop_pomodoro()
    if not is_running then
        vim.notify("No active pomodoro.", vim.log.levels.WARN)
        return
    end
    is_running = false
    timer:stop()
    M.set_dnd(false)
    vim.g.pomodoro_timer = nil
    api.nvim_command "redrawstatus"
    vim.notify "Pomodoro stopped prematurely!"
end

function M.get_statusline()
    return vim.g.pomodoro_timer or ""
end

local function pomodoro_complete(arglead, cmdline, cursorpos)
    local subcommands = { "start", "stop" }
    local matches = {}
    for _, sub in ipairs(subcommands) do
        if sub:find("^" .. arglead) then
            table.insert(matches, sub)
        end
    end
    return matches
end

vim.api.nvim_create_user_command("Pomodoro", function(opts)
    if opts.args == "start" then
        M.start_pomodoro()
    elseif opts.args == "stop" then
        M.stop_pomodoro()
    else
        print "Usage: Pomodoro start|stop"
    end
end, { nargs = 1, complete = pomodoro_complete })

function M.setup(user_config)
    M.config = vim.tbl_extend("force", M.config, user_config or {})
    vim.g.pomodoro_timer = nil

    if pcall(require, "lualine") then
        require("lualine").setup {
            sections = { lualine_c = { M.get_statusline } },
        }
    end
end

return M
