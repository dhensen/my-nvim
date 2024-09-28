-- usage:
-- require("large-files").setup {
--     size = 1048576,
--     filetypes = {
--         json = "json_nols",
--         xml = "xml_nols",
--     },
-- }
--
-- @copilot: implement the `setup` function

local M = {}

function M.setup(opts)
    local size = opts.size or 1048576
    local filetypes = opts.filetypes or {}

    for filetype, new_filetype in pairs(filetypes) do
        local group_name = "disable_lsp_" .. filetype
        local group = vim.api.nvim_create_augroup(group_name, { clear = true })

        vim.api.nvim_create_autocmd("BufEnter", {
            group = group,
            pattern = "*." .. filetype,
            callback = function()
                local file_size = vim.fn.getfsize(vim.fn.expand "%:p")
                if file_size > size then
                    vim.bo.filetype = new_filetype
                    vim.notify("LSP disabled for large " .. filetype .. " file", vim.log.levels.INFO)
                end
            end,
        })
    end
end

return M

-- vim.cmd([[
--   augroup disable_lsp_json
--     autocmd!
--     autocmd BufEnter *.json if vim.fn.getfsize(vim.fn.expand('%')) > 1048576 | let b:did_disable_lsp = 1 | set filetype=json_nols | endif
--     autocmd BufEnter *.json if exists('b:did_disable_lsp') | echom "LSP disabled for large JSON file" | endif
--   augroup END
-- ]])

-- -- disable LSP for large JSON file
-- vim.cmd [[augroup disable_lsp_json
--   autocmd!
--   autocmd BufEnter *.json if getfsize(expand('%')) > 1048576 | setlocal filetype=json_nols | echom "LSP disabled for large JSON file" | endif
-- augroup END
-- ]]
--
-- -- disable LSP for large XML file
-- vim.cmd [[augroup disable_lsp_xml
--   autocmd!
--   autocmd BufEnter *.xml if getfsize(expand('%')) > 1048576 | setlocal filetype=xml_nols | echom "LSP disabled for large XML file" | endif
-- augroup END
-- ]]
