vim.cmd("colorscheme kanagawa")

require('mini.icons').setup()
MiniIcons.mock_nvim_web_devicons() -- Insanely cool

require('lualine').setup()

-- Put treesitter stuff here
vim.api.nvim_create_autocmd('BufEnter', {
    callback = function(args)
        if not pcall(vim.treesitter.start, args.buf) then
            -- Auto install TreeSitter parsers if available
            local treesitter = require("nvim-treesitter")
            local filetype = vim.bo[args.buf].filetype

            if vim.tbl_contains(treesitter.get_available(), filetype) then
                treesitter.install(filetype)
                -- TODO: Autostart treesitter once we have a callback after the async install
            end
        end
    end
})
