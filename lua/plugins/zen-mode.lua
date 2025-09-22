return {
    "folke/zen-mode.nvim",
    opts = {
        window = {
            backdrop = 0.95,
            width = 120,
        },
        plugins = {
            alacritty = {
                enabled = true,
                font = "22", -- default font size is 14 + 8 = 22
            },
            kitty = {
                enabled = true,
                font = "+8", -- default font size is 14 + 8 = 22
            },
        },
    },
}
