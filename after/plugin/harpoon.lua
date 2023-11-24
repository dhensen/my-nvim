local mark = require "harpoon.mark"
local ui = require "harpoon.ui"

vim.keymap.set("n", "<C-e>a", mark.add_file, { desc = "harpoon: mark file" })
vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu, { desc = "harpoon: toggle quick menu" })

vim.keymap.set("n", "<C-e>1", function()
    ui.nav_file(1)
end, { desc = "harpoon: go to 1" })
vim.keymap.set("n", "<C-e>2", function()
    ui.nav_file(2)
end, { desc = "harpoon: go to 2" })
vim.keymap.set("n", "<C-e>3", function()
    ui.nav_file(3)
end, { desc = "harpoon: go to 3" })
vim.keymap.set("n", "<C-e>n", function()
    ui.nav_next()
end, { desc = "harpoon: go to next" })
vim.keymap.set("n", "<C-e>p", function()
    ui.nav_prev()
end, { desc = "harpoon: go to previous" })
