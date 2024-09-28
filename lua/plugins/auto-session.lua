return {
    "rmagatti/auto-session",
    config = function()
        require("auto-session").setup {
            auto_restore = false,
            log_level = "error",
            suppressed_dirs = {"~/", "~/Downloads", "~/work", "/"}
        }
    end
}
