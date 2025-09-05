--
--  Basic vim.options
vim.opt.encoding = "utf-8"
vim.opt.number = true
vim.opt.relativenumber = true

--  New splits in the correct place
--
vim.opt.splitright = true
vim.opt.splitbelow = true

--  Indentation and tabs
--
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.smarttab = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

--  Other
--
vim.opt.mouse = 'a'
vim.opt.clipboard = "unnamedplus"
vim.opt.cursorline = true
vim.opt.wrap = false
vim.opt.signcolumn = "yes"
vim.opt.scrolloff = 4
vim.opt.swapfile = false
vim.opt.laststatus = 3
vim.opt.fixendofline = false
vim.opt.colorcolumn = "160"

vim.opt.listchars = {
    trail = "•",
    tab = "→ ",
}
vim.opt.list = true

vim.opt.winborder = "rounded"

if vim.fn.has("termguicolors") then
    vim.opt.termguicolors = true
end

vim.api.nvim_create_autocmd("FileType", {
    pattern = "json",
    callback = function()
        vim.opt_local.tabstop = 2
        vim.opt_local.shiftwidth = 2
    end,
})
