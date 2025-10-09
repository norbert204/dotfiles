function ClearTrailingWhitespaces()
    local view = vim.fn.winsaveview()
    vim.cmd("%s/\\s\\+$//e")
    vim.fn.winrestview(view)
end

vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    callback = ClearTrailingWhitespaces,
})
