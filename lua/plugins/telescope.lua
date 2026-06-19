return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.4",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope-fzf-native.nvim",
    },
    config = function()
        require("telescope").setup()
        require("telescope").load_extension "fzf"
    end,
}
