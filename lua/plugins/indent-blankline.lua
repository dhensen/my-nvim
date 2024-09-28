return {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
        require("ibl").setup {indent = {char = "▏", tab_char = "▏"}}
    end
}
