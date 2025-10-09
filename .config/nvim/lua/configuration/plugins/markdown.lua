return {
    {
        "MeanderingProgrammer/render-markdown.nvim",
        dependencies = {
            'nvim-treesitter/nvim-treesitter'
        },
        config = function()
            require("render-markdown").setup {
                completions = { lsp = { enabled = true } },
            }
        end
    },
    {
        "HakonHarnes/img-clip.nvim",
        opts = {
            default = {
                dir_path = ".assets"
            }
        }
    },
    {
        "iamcco/markdown-preview.nvim"
    }
}
