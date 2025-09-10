vim.pack.add({
    { src = "https://github.com/catppuccin/nvim", name = "catpuccin" },
    { src = "https://github.com/rebelot/kanagawa.nvim" },
    { src = "https://github.com/nvim-lua/plenary.nvim" },
    { src = "https://github.com/nvim-telescope/telescope.nvim" },
    { src = "https://github.com/nvim-telescope/telescope-ui-select.nvim" },
    { src = "https://github.com/mason-org/mason.nvim" },
    { src = "https://github.com/neovim/nvim-lspconfig" },
    { src = "https://github.com/mason-org/mason-lspconfig.nvim" },
    { src = "https://github.com/Saghen/blink.cmp", version = "v1.6.0" }, -- vim.pack doesn't support wildcard versions
    { src = "https://github.com/NeogitOrg/neogit" },
    { src = "https://github.com/sindrets/diffview.nvim" },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
    { src = "https://github.com/ThePrimeagen/harpoon", version = "harpoon2" },

    -- Not mandatory
    { src = "https://github.com/echasnovski/mini.icons" },
    { src = "https://github.com/nvim-lualine/lualine.nvim" },
    { src = "https://github.com/prichrd/netrw.nvim" },
})

-- After install
-- Not working I think
vim.api.nvim_create_autocmd('PackChanged', {
    callback = function(args)
        if args.data.kind == "update" then
            vim.cmd("TSUpdate")
        end
    end
})
