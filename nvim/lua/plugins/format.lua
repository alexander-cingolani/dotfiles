return {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
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
            html = { "prettier" },
            css = { "prettier" },
            json = { "prettier" },
            yaml = { "prettier" },
            markdown = { "prettier" },
            javascript = { "prettier" },
            typescript = { "prettier" },
            toml = { "taplo" },
            sh = { "shfmt" },
            bash = { "shfmt" },
        },
        format_on_save = {
            timeout_ms = 500,
            lsp_fallback = true,
        },
    },
    config = function(_, opts)
        require("conform").setup(opts)
    end,
}
