-- NetRW related settings
vim.g.netrw_bufsettings = "noma nomod nu nobl nowrap ro"
vim.g.netrw_keepdir = 0
vim.g.netrw_banner = 0

vim.api.nvim_create_autocmd("FileType", {
    pattern = "netrw",
    callback = function()
        vim.opt_local.statuscolumn = "%l %s"
    end,
})

-- Plugins
return {
    {
        "prichrd/netrw.nvim",
        opts = {},
        config = true
    }
}
