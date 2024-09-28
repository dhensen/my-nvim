local M = {}

function M.setup(opts)
    local default_size = opts.size or 1048576
    local filetypes = opts.filetypes or {}

    for filetype, size in pairs(filetypes) do
        local size_threshold = size or default_size
        local group_name = "disable_lsp_" .. filetype
        local group = vim.api.nvim_create_augroup(group_name, { clear = true })

        vim.api.nvim_create_autocmd("BufEnter", {
            group = group,
            pattern = "*." .. filetype,
            callback = function()
                local file_size = vim.fn.getfsize(vim.fn.expand "%:p")
                if file_size > size_threshold then
                    local bufnr = vim.api.nvim_get_current_buf()
                    local clients = vim.lsp.get_active_clients { bufnr = bufnr }
                    for _, client in pairs(clients) do
                        vim.lsp.buf_detach_client(bufnr, client.id)
                    end
                    vim.notify("LSP disabled for large " .. filetype .. " file", vim.log.levels.INFO)
                end
            end,
        })
    end
end

return M
