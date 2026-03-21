local harpoon = require "harpoon"
harpoon:setup()

vim.keymap.set("n", "<C-e>a", function() harpoon:list():add() end, { desc = "harpoon: mark file" })
vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "harpoon: toggle quick menu" })

vim.keymap.set("n", "<C-e>1", function() harpoon:list():select(1) end, { desc = "harpoon: go to 1" })
vim.keymap.set("n", "<C-e>2", function() harpoon:list():select(2) end, { desc = "harpoon: go to 2" })
vim.keymap.set("n", "<C-e>3", function() harpoon:list():select(3) end, { desc = "harpoon: go to 3" })
vim.keymap.set("n", "<C-e>n", function() harpoon:list():next() end, { desc = "harpoon: go to next" })
vim.keymap.set("n", "<C-e>p", function() harpoon:list():prev() end, { desc = "harpoon: go to previous" })
