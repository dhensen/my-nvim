return {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
        require("ibl").setup {
            enabled = false,
            scope = { enabled = false },
            indent = {
                char = "▏",
                tab_char = "▏",
            },
        }
    end,
}
