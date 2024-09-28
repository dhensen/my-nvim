return {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
        require("toggleterm").setup {
            size = function(term)
                if term.direction == "horizontal" then
                    return 20
                elseif term.direction == "vertical" then
                    return vim.o.columns * 0.4
                end
            end,
            start_in_insert = false,
            on_open = function()
                vim.keymap.set("n", "<C-q>", "<cmd>close<CR>",
                               {buffer = true, noremap = true, silent = true})
                vim.keymap.set("t", "<C-q>",
                               "<C-\\><C-n><cmd>close<CR><C-w><C-p>",
                               {buffer = true, noremap = true, silent = true})
                vim.keymap.set("t", "<C-x>", "<C-\\><C-n>",
                               {buffer = true, noremap = true, silent = true})
                vim.wo.cursorcolumn = false
                vim.wo.cursorline = false
                vim.cmd "wincmd="
            end,
            highlights = {
                Normal = {link = "NormalFloat"},
                NormalFloat = {link = "NormalFloat"},
                FloatBorder = {link = "FloatBorder"}
            },
            float_opts = {
                border = {" ", " ", " ", " ", " ", " ", " ", " "},
                winblend = 0,
                width = vim.o.columns - 20,
                height = vim.o.lines - 9,
                highlights = {
                    border = "FloatBorder",
                    background = "NormalFloat"
                }
            }
        }
    end
}
