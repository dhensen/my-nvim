local neotest = require "neotest"
local wk = require "which-key"

wk.add {
    { "<leader>c", group = "Code / Clipboard / Coverage" },
    { "<leader>r", desc = "Run Nearest Test" },
    { "<leader>o", desc = "Open Test Output" },
    { "<leader>s", desc = "Toggle Test Summary" },
}

neotest.setup {
    adapters = {
        require "neotest-python" {
            args = { "-svvv" }, -- yes, you really need 3 v's to get full diffs
            dap = { justMyCode = false },
            runner = "pytest",
        },
    },
}

vim.api.nvim_create_user_command("NeotestRun", require("neotest").run.run, {})
vim.api.nvim_create_user_command("NeotestOutput", require("neotest").output.open, {})
vim.api.nvim_create_user_command("NeotestSummary", require("neotest").summary.toggle, {})

vim.keymap.set("n", "<space>cc", "<cmd>Coverage<CR>", { desc = "Show Coverage" })
vim.keymap.set("n", "<space>ct", "<cmd>CoverageToggle<CR>", { desc = "Toggle Coverage" })

vim.keymap.set("n", "<leader>r", function()
    require("neotest").run.run()
end, { noremap = true, desc = "Run Nearest Test" })
vim.keymap.set("n", "<leader>o", function()
    require("neotest").output.open()
end, { noremap = true, desc = "Open Test Output" })
vim.keymap.set("n", "<leader>s", function()
    require("neotest").summary.toggle()
end, { noremap = true, desc = "Toggle Test Summary" })

-- Function to toggle watching a directory or file
local function toggle_watch(path)
    if neotest.watch.is_watching(path) then
        neotest.watch.stop(path)
        print("Stopped watching: " .. path)
    else
        neotest.watch.toggle(path)
        print("Watching: " .. path)
    end
end

-- Command to toggle watch on a path
vim.api.nvim_create_user_command("NeotestToggleWatch", function(opts)
    toggle_watch(opts.args)
end, { nargs = 1, complete = "file" })

-- Command to stop all watches
vim.api.nvim_create_user_command("NeotestStopAllWatches", function()
    neotest.watch.stop() -- stops all if no specific position is provided
    print "Stopped all watches"
end, {})
