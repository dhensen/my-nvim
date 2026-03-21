local dap = require "dap"
local dapui = require "dapui"

-- debugpy path managed by Mason
require("dap-python").setup "/Users/dino/.local/share/nvim/mason/packages/debugpy/venv/bin/python"

dapui.setup()

-- auto-open/close UI with dap session lifecycle
dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end

-- F-key bindings for tight debug loop
vim.keymap.set("n", "<F5>", dap.continue, { desc = "DAP: continue / start" })
vim.keymap.set("n", "<F10>", dap.step_over, { desc = "DAP: step over" })
vim.keymap.set("n", "<F11>", dap.step_into, { desc = "DAP: step into" })
vim.keymap.set("n", "<F12>", dap.step_out, { desc = "DAP: step out" })

-- <leader>D group via which-key
local wk = require "which-key"
wk.add {
    { "<leader>D", group = "Debug" },
    -- session
    { "<leader>Dc", dap.continue, desc = "Continue / Start" },
    { "<leader>Dr", dap.restart, desc = "Restart" },
    { "<leader>Dq", dap.terminate, desc = "Terminate" },
    -- stepping
    { "<leader>Dn", dap.step_over, desc = "Step Over" },
    { "<leader>Di", dap.step_into, desc = "Step Into" },
    { "<leader>Do", dap.step_out, desc = "Step Out" },
    { "<leader>Dj", dap.step_back, desc = "Step Back" },
    { "<leader>Dh", dap.run_to_cursor, desc = "Run to Cursor" },
    -- breakpoints
    { "<leader>Db", dap.toggle_breakpoint, desc = "Toggle Breakpoint" },
    {
        "<leader>DB",
        function() dap.set_breakpoint(vim.fn.input "Condition: ") end,
        desc = "Conditional Breakpoint",
    },
    {
        "<leader>Dl",
        function() dap.set_breakpoint(nil, nil, vim.fn.input "Log message: ") end,
        desc = "Log Point",
    },
    { "<leader>Dx", dap.clear_breakpoints, desc = "Clear All Breakpoints" },
    { "<leader>D?", dap.list_breakpoints, desc = "List Breakpoints (quickfix)" },
    -- UI
    { "<leader>Du", dapui.toggle, desc = "Toggle UI" },
    {
        "<leader>De",
        function() dapui.eval(nil, { enter = true }) end,
        desc = "Eval Expression",
    },
    -- Python-specific
    { "<leader>Dp", group = "Python" },
    { "<leader>Dpm", require("dap-python").test_method, desc = "Debug Test Method" },
    { "<leader>DpM", require("dap-python").test_class, desc = "Debug Test Class" },
    { "<leader>Dps", require("dap-python").debug_selection, desc = "Debug Selection", mode = "v" },
}
