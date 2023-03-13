vim.keymap.set("n", "<leader>gs", vim.cmd.Git);
vim.keymap.set("n", "<leader>gb", function() vim.cmd.Git('blame') end);
vim.keymap.set("n", "<leader>ga", function() vim.cmd.Git('add -p') end);
-- TODO: would be nice to have git log -p <current_file> open in a vertical split
vim.keymap.set("n", "<leader>gl", function() vim.cmd.Git('log') end);
