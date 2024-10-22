-- took from: https://github.com/nvim-lualine/lualine.nvim/blob/master/examples/evil_lualine.lua
local conditions = {
    buffer_not_empty = function()
        return vim.fn.empty(vim.fn.expand "%:t") ~= 1
    end,
}

return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons", "mfussenegger/nvim-dap" },
    opts = {
        options = {
            icons_enabled = true,
            -- theme = "palenight",
            -- theme = "auto",
            component_separators = { left = "", right = "" },
            section_separators = { left = "", right = "" },
            disabled_filetypes = {
                statusline = {},
                winbar = {},
            },
            ignore_focus = {},
            always_divide_middle = true,
            -- globalstatus = false,
            globalstatus = true,
            refresh = {
                statusline = 1000,
                tabline = 1000,
                winbar = 1000,
            },
        },
        sections = {
            lualine_a = {
                { "mode" },
                {
                    function()
                        return "  " .. require("dap").status()
                    end,
                    cond = function()
                        return require("dap").status() ~= ""
                    end,
                    -- color = function()
                    --     return { fg = "#FFB86C" }
                    -- end,
                },
            },
            lualine_b = { "branch", "diff", "diagnostics" },
            lualine_c = {
                {
                    "filesize",
                    cond = conditions.buffer_not_empty,
                    draw_empty = true,
                },
                "filename",
                {
                    "navic",
                    color_correction = nil,
                    navic_opts = nil,
                },
            },
            lualine_x = { "encoding", "fileformat", "filetype" },
            lualine_y = { "progress" },
            lualine_z = {
                "location",
                -- I already have time in TMUX top bar
                -- function()
                --     return "  " .. os.date "%R"
                -- end,
            },
        },
        inactive_sections = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = { "filename" },
            lualine_x = { "location" },
            lualine_y = {},
            lualine_z = {},
        },
        tabline = {},
        winbar = {},
        inactive_winbar = {},
        extensions = {},
    },
}
