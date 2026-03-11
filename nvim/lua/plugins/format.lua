return {
    "stevearc/conform.nvim",
    event = { "BufWritePre", "InsertLeave" },
    cmd = { "ConformInfo" },
    keys = {
        {
            "<leader>f",
            function()
                require("conform").format({ async = true, lsp_fallback = true })
            end,
            mode = "",
            desc = "[F]ormat buffer",
        },
    },
    opts = {
        formatters_by_ft = {
            lua = { "stylua" },
            python = { "isort", "black" },
            cpp = { "clang-format" },
            c = { "clang-format" },
            java = { "google-java-format" },
        },
        format_on_save = {
            timeout_ms = 500,
            lsp_fallback = true,
        },
    },
    config = function(_, opts)
        require("conform").setup(opts)
        vim.api.nvim_create_autocmd("InsertLeave", {
            pattern = "*",
            callback = function()
                require("conform").format({ async = true, lsp_fallback = true })
            end,
        })
    end,
}
