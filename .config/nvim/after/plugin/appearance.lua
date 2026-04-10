vim.cmd("colorscheme catppuccin")

require('mini.icons').setup()
MiniIcons.mock_nvim_web_devicons() -- Insanely cool

require('lualine').setup()

require("nvim-treesitter").install {
    "rust",
    "c_sharp",
    "razor",
    "lua",
}

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "rust", "cs", "razor", "lua" },
    callback = function (args)
        vim.treesitter.start(args.buf)
    end
})
