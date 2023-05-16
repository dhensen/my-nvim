require("neotest").setup {
    adapters = {
        require "neotest-python" {
            args = { "-svv" },
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
