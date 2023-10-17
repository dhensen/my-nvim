local mark = require "harpoon.mark"
local ui = require "harpoon.ui"

vim.keymap.set("n", "<C-e>a", mark.add_file)
vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)

vim.keymap.set("n", "<C-e>1", function()
    ui.nav_file(1)
end)
vim.keymap.set("n", "<C-e>2", function()
    ui.nav_file(2)
end)
vim.keymap.set("n", "<C-e>3", function()
    ui.nav_file(3)
end)
vim.keymap.set("n", "<C-e>n", function()
    ui.nav_next()
end, { desc = "harpoon: go to next" })
vim.keymap.set("n", "<C-e>p", function()
    ui.nav_prev()
end, { desc = "harpoon: go to previous" })
