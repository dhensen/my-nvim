require "plugins"
require "keybindings"
require "options"
require "auto-theme"

-- prevent netrw from loading because I will use nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("telescope").load_extension "fzf"
require("nvim-tree").setup()

vim.api.nvim_create_autocmd({ "BufEnter" }, {
    pattern = "NvimTree*",
    callback = function()
        local api = require "nvim-tree.api"
        local view = require "nvim-tree.view"

        if not view.is_visible() then
            api.tree.open()
        end
    end,
})

-- vim.o.background = "dark" -- or "light" for light mode
-- vim.cmd([[colorscheme gruvbox]])

require("nvim-treesitter.configs").setup {
    ensure_installed = {
        "vimdoc",
        "python",
        "javascript",
        "lua",
        "typescript",
        "go",
        "rust",
        "c",
        "php",
        "terraform",
        "comment",
    },
    sync_install = false,
    highlight = { enable = true, additional_vim_regex_highlighting = false },
    indent = { enable = true },
    -- context_commentstring nvim-treesitter module is deprecated, use require('ts_context_commentstring').setup {} and set vim.g.skip_ts_context_commentstring_module = true to speed up loading instead.
    -- This feature will be removed in ts_context_commentstring version in the future (see https://github.com/JoosepAlviste/nvim-ts-context-commentstring/issues/82 for more info)
    -- context_commentstring = {
    --     enable = true,
    --     enable_autocmd = false,
    -- },
}

-- took from: https://github.com/nvim-lualine/lualine.nvim/blob/master/examples/evil_lualine.lua
local conditions = {
    buffer_not_empty = function()
        return vim.fn.empty(vim.fn.expand "%:t") ~= 1
    end,
}

require("lualine").setup {
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
        lualine_a = { "mode" },
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
        lualine_z = { "location" },
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
    winbar = {
        lualine_c = {
            { "navic", color_correction = nil, navic_opts = nil },
        },
    },
    inactive_winbar = {},
    extensions = {},
}

require "autocomplete"
require "nullls"
require "testing"

vim.g.python3_host_prog = os.getenv "HOME" .. "/.nvim-venv/bin/python3"

-- function ColorMyPencils(color)
--     color = color or "rose-pine"
--     -- color = color or "tokyonight-day"
--     require("rose-pine").setup {
--         dark_variant = "moon",
--     }
--     vim.cmd.colorscheme(color)
--
--     -- enable these if you want transparent bg:
--     -- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
--     -- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
-- end
--
-- ColorMyPencils()

require("mason").setup {
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
        },
    },
}
require("mason-lspconfig").setup { automatic_installation = true }
require("mason-nvim-dap").setup {
    ensure_installed = { "python" },
}

-- hide tilde for empty lines
vim.cmd [[hi NonText guifg=bg]]

-- vim.cmd([[
--   augroup disable_lsp_json
--     autocmd!
--     autocmd BufEnter *.json if vim.fn.getfsize(vim.fn.expand('%')) > 1048576 | let b:did_disable_lsp = 1 | set filetype=json_nols | endif
--     autocmd BufEnter *.json if exists('b:did_disable_lsp') | echom "LSP disabled for large JSON file" | endif
--   augroup END
-- ]])
vim.cmd [[augroup disable_lsp_json
  autocmd!
  autocmd BufEnter *.json if getfsize(expand('%')) > 1048576 | setlocal filetype=json_nols | echom "LSP disabled for large JSON file" | endif
augroup END
]]

in_wsl = os.getenv "WSL_DISTRO_NAME" ~= nil

if in_wsl then
    local script_path = vim.fn.stdpath "config" .. "/nvim_paste"
    vim.g.clipboard = {
        name = "wsl clipboard",
        copy = { ["+"] = { "clip.exe" }, ["*"] = { "clip.exe" } },
        paste = { ["+"] = { script_path }, ["*"] = { script_path } },
        cache_enabled = true,
    }
end

-- Display diagnostics as virtual text only if not in insert mode
-- vim.api.nvim_create_autocmd("InsertEnter", {
--     pattern = "*",
--     callback = function()
--         vim.diagnostic.config {
--             virtual_text = false,
--         }
--     end,
-- })
-- vim.api.nvim_create_autocmd("InsertLeave", {
--     pattern = "*",
--     callback = function()
--         vim.diagnostic.config {
--             virtual_text = true,
--         }
--     end,
-- })
