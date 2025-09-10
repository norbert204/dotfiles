vim.g.netrw_bufsettings = "noma nomod nu relativenumber nobl nowrap ro"
vim.g.netrw_banner = 0

require("netrw").setup()

vim.api.nvim_create_autocmd("FileType", {
    pattern = "netrw",
    callback = function()
        vim.opt_local.statuscolumn = "%l %s"
    end
})
