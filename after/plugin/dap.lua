local global = require "global"
local dapui_status_ok, dapui = pcall(require, "dapui")
if not dapui_status_ok then
    return
end
local dap_status_ok, dap = pcall(require, "dap")
if not dap_status_ok then
    return
end
dapui.setup {
    icons = {
        expanded = "▾",
        collapsed = "▸",
    },
    mappings = {
        expand = {
            "<CR>",
            "<2-LeftMouse>",
        },
        open = "o",
        remove = "d",
        edit = "e",
        repl = "r",
    },
    layouts = {
        {
            elements = {
                { id = "scopes", size = 0.33 },
                { id = "breakpoints", size = 0.17 },
                { id = "stacks", size = 0.25 },
                { id = "watches", size = 0.25 },
            },
            size = 0.33,
            position = "left",
        },
        {
            elements = {
                { id = "repl", size = 0.45 },
                { id = "console", size = 0.55 },
            },
            size = 0.27,
            position = "bottom",
        },
    },
    floating = {
        max_height = nil,
        max_width = nil, -- Floats will be treated as percentage of your screen.
        -- border = single, -- Border style. Can be 'single', 'double' or 'rounded'
        mappings = {
            ["close"] = { "q", "<Esc>" },
        },
    },
    windows = {
        indent = 1,
    },
    controls = {
        enabled = true,
        element = "repl",
        icons = {
            pause = "",
            play = "",
            step_over = "",
            step_into = "",
            step_back = "",
            step_out = "",
            run_last = "",
            terminate = "",
        },
    },
    render = {
        max_type_length = nil,
        max_value_lines = 100,
        indent = 1,
    },
}
dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open {}
end
dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close {}
end
dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close {}
end
vim.fn.sign_define("DapBreakpoint", {
    text = "",
    texthl = "",
    linehl = "",
    numhl = "",
})
vim.fn.sign_define("DapStopped", {
    text = "",
    texthl = "",
    linehl = "",
    numhl = "",
})
vim.fn.sign_define("DapLogPoint", {
    text = "▶",
    texthl = "",
    linehl = "",
    numhl = "",
})
vim.api.nvim_create_user_command("LuaDapLaunch", 'lua require"osv".run_this()', {})
vim.api.nvim_create_user_command("DapToggleBreakpoint", 'lua require("dap").toggle_breakpoint()', {})
vim.api.nvim_create_user_command("DapContinue", 'lua require"dap".continue()', {})
vim.api.nvim_create_user_command("DapStepInto", 'lua require"dap".step_into()', {})
vim.api.nvim_create_user_command("DapStepOver", 'lua require"dap".step_over()', {})
vim.api.nvim_create_user_command("DapStepOut", 'lua require"dap".step_out()', {})
vim.api.nvim_create_user_command("DapUp", 'lua require"dap".up()', {})
vim.api.nvim_create_user_command("DapDown", 'lua require"dap".down()', {})
vim.api.nvim_create_user_command("DapPause", 'lua require"dap".pause()', {})
vim.api.nvim_create_user_command("DapClose", 'lua require"dap".close()', {})
vim.api.nvim_create_user_command("DapDisconnect", 'lua require"dap".disconnect()', {})
vim.api.nvim_create_user_command("DapRestart", 'lua require"dap".restart()', {})
vim.api.nvim_create_user_command("DapToggleRepl", 'lua require"dap".repl.toggle()', {})
vim.api.nvim_create_user_command("DapGetSession", 'lua require"dap".session()', {})
vim.api.nvim_create_user_command(
    "DapUIClose",
    'lua require"dap".close(); require"dap".disconnect(); require"dapui".close()',
    {}
)
vim.keymap.set("n", "<A-1>", function()
    dap.toggle_breakpoint()
end, { noremap = true, silent = true, desc = "DapToggleBreakpoint" })
vim.keymap.set("n", "<A-2>", function()
    dap.continue()
end, { noremap = true, silent = true, desc = "DapContinue" })
vim.keymap.set("n", "<A-3>", function()
    dap.step_into()
end, { noremap = true, silent = true, desc = "DapStepInto" })
vim.keymap.set("n", "<A-4>", function()
    dap.step_over()
end, { noremap = true, silent = true, desc = "DapStepOver" })
vim.keymap.set("n", "<A-5>", function()
    dap.step_out()
end, { noremap = true, silent = true, desc = "DapStepOut" })
vim.keymap.set("n", "<A-6>", function()
    dap.up()
end, { noremap = true, silent = true, desc = "DapUp" })
vim.keymap.set("n", "<A-7>", function()
    dap.down()
end, { noremap = true, silent = true, desc = "DapDown" })
vim.keymap.set("n", "<A-8>", function()
    dap.close()
    dap.disconnect()
    dapui.close()
end, { noremap = true, silent = true, desc = "DapUIClose" })
vim.keymap.set("n", "<A-9>", function()
    dap.restart()
end, { noremap = true, silent = true, desc = "DapRestart" })
vim.keymap.set("n", "<A-0>", function()
    dap.repl.toggle()
end, { noremap = true, silent = true, desc = "DapToggleRepl" })

dap.adapters.python = {
    type = "executable",
    command = global.mason_path .. "/packages/debugpy/venv/bin/python",
    args = { "-m", "debugpy.adapter" },
}
dap.configurations.python = {
    {
        type = "python",
        request = "launch",
        name = "Debug",
        program = "${file}",
        pythonPath = function()
            local venv_path = os.getenv "VIRTUAL_ENV"
            if venv_path then
                return venv_path .. "/bin/python"
            end
            if vim.fn.executable(global.mason_path .. "/packages/debugpy/venv/" .. "bin/python") == 1 then
                return global.mason_path .. "/packages/debugpy/venv/" .. "bin/python"
            else
                return "python"
            end
        end,
    },
    {
        type = "python",
        request = "launch",
        name = "Launch",
        program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
        end,
        pythonPath = function()
            local venv_path = os.getenv "VIRTUAL_ENV"
            if venv_path then
                return venv_path .. "/bin/python"
            end
            if vim.fn.executable(global.mason_path .. "/packages/debugpy/venv/" .. "bin/python") == 1 then
                return global.mason_path .. "/packages/debugpy/venv/" .. "bin/python"
            else
                return "python"
            end
        end,
    },
}
