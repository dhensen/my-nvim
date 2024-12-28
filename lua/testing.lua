local neotest = require "neotest"
neotest.setup {
    adapters = {
        require "neotest-python" {
            args = { "-svv" },
            dap = { justMyCode = false },
            runner = "pytest",
        },
    },
}

vim.api.nvim_create_user_command("NeotestRun", require("neotest").run.run, {})
vim.api.nvim_create_user_command("NeotestOutput", require("neotest").output.open, {})
vim.api.nvim_create_user_command("NeotestSummary", require("neotest").summary.toggle, {})

vim.keymap.set("n", "<leader>r", function()
    require("neotest").run.run()
end, { noremap = true, desc = "NeotestRun" })
vim.keymap.set("n", "<leader>o", function()
    require("neotest").output.open()
end, { noremap = true, desc = "NeotestOutput" })
vim.keymap.set("n", "<leader>s", function()
    require("neotest").summary.toggle()
end, { noremap = true, desc = "NeotestSummary" })

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
