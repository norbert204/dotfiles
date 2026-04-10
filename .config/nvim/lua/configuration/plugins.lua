vim.pack.add({
    -- Dependencies
    { src = "https://github.com/nvim-lua/plenary.nvim" },
    -- Appearance
    { src = "https://github.com/catppuccin/nvim", name = "catpuccin" },
    { src = "https://github.com/nvim-mini/mini.icons" },
    { src = "https://github.com/nvim-lualine/lualine.nvim" },
    { src = "https://github.com/neovim-treesitter/nvim-treesitter" },
    { src = "https://github.com/prichrd/netrw.nvim" },
    -- LSP
    { src = "https://github.com/Saghen/blink.cmp", version = "v1.6.0" }, -- vim.pack doesn't support wildcard versions
    { src = "https://github.com/mason-org/mason-lspconfig.nvim" },
    { src = "https://github.com/mason-org/mason.nvim" },
    { src = "https://github.com/neovim/nvim-lspconfig" },
    { src = "https://github.com/stevearc/conform.nvim" },
    -- Debugger
    { src = "https://github.com/mfussenegger/nvim-dap" },
    { src = "https://github.com/igorlfs/nvim-dap-view" },
    -- Navigation
    { src = "https://github.com/ThePrimeagen/harpoon", version = "harpoon2" },
    { src = "https://github.com/ibhagwan/fzf-lua" },
    -- Git
    { src = "https://github.com/NeogitOrg/neogit" },
    { src = "https://github.com/sindrets/diffview.nvim" },
    { src = "https://github.com/nvim-mini/mini.diff" },
    -- Unit test
    { src = "https://github.com/nvim-neotest/neotest" },
    { src = "https://github.com/nvim-neotest/nvim-nio" },
    { src = "https://github.com/antoinemadec/FixCursorHold.nvim" },
    -- C#
    { src = "https://github.com/seblyng/roslyn.nvim" },
    { src = "https://github.com/Issafalcon/neotest-dotnet" },
    -- Rust
    { src = "https://github.com/Saecki/crates.nvim" },
})

-- After update/install
vim.api.nvim_create_autocmd('PackChanged', {
    callback = function(args)
        local name = args.data.spec.name
        local kind = args.data.kind

        if name == "nvim-treesitter" and kind == "update" or kind == "install" then
            vim.cmd("TSUpdate")
        end
    end
})
