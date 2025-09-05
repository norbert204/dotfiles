return {
    {
        "nvim-lualine/lualine.nvim",
        config = true,
    },
    {
        "catppuccin/nvim",
        name = "catppuccin",
        config = function()
            vim.cmd.colorscheme "catppuccin-mocha"
        end
    },
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup {
                auto_install = true,
                highlight = {
                    enable = true,
                },
                indent = {
                    enable = true,
                },
            }
        end
    },
    {
        "akinsho/bufferline.nvim",
        version = "*",
        opts = {
            options = {
                diagnostics = "nvim_lsp",
                numbers = "buffer_id",
            }
        }
    },
    {
        "echasnovski/mini.icons",
        config = function()
            require("mini.icons").setup()

            MiniIcons.mock_nvim_web_devicons()
        end
    },
}
