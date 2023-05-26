vim.keymap.set("n", "<leader>gs", vim.cmd.Git, { desc = "Fugitive: open Fugitive" })
vim.keymap.set("n", "<leader>gb", function()
    vim.cmd.Git "blame"
end, { desc = "Fugitive: git blame" })
vim.keymap.set("n", "<leader>ga", function()
    vim.cmd.Git "add -p"
end, { desc = "Fugitive: git add -p" })
-- TODO: would be nice to have git log -p <current_file> open in a vertical split
vim.keymap.set("n", "<leader>gl", function()
    vim.cmd.Git "log"
end, { desc = "Fugitive: git log" })
