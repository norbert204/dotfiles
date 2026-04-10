-- This one line is needed to make Razor files work
---@diagnostic disable-next-line: unused-local
local mason_root = require("mason.settings").current.install_root_dir

vim.lsp.config("roslyn", {
    settings = {
        ["csharp|code_lens"] = {
            dotnet_enable_references_code_lens = true,
            dotnet_enable_tests_code_lens = true,
        },
        ["csharp|completion"] = {
            dotnet_show_completion_items_from_unimported_namespaces = true
        },
        ["csharp|inlay_hints"] = {
            csharp_enable_inlay_hints_for_implicit_object_creation = true,
            csharp_enable_inlay_hints_for_implicit_variable_types = true,
            csharp_enable_inlay_hints_for_lambda_parameter_types = true,
            dotnet_enable_inlay_hints_for_object_creation_parameters = true,
            dotnet_enable_inlay_hints_for_parameters = true,
            dotnet_suppress_inlay_hints_for_parameters_that_differ_only_by_suffix = true,
            dotnet_suppress_inlay_hints_for_parameters_that_match_argument_name = true,
            dotnet_suppress_inlay_hints_for_parameters_that_match_method_intent = true,
        },
        ["csharp|symbol_search"] = {
            dotnet_search_reference_assemblies = true,
        }
    }
})

vim.filetype.add {
    extension = {
        razor = 'razor',
        cshtml = 'razor',
    },
}

vim.api.nvim_create_autocmd("FileType", {
    pattern = {"cs", "csproj", "razor"},
    callback = function (_)
        vim.g.dotnet_errors_only = true
        vim.g.dotnet_show_project_file = false

        vim.cmd("compiler dotnet")
    end
})
