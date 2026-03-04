return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
    },
    config = function()
        require("mason").setup()

        local servers = {
            clangd = {},    -- C/C++
            jdtls = {},     -- Java
            pyright = {},   -- Python
            lua_ls = {      -- Lua
                settings = {
                    Lua = { diagnostics = { globals = { "vim" } } }
                }
            },
        }

        require("mason-lspconfig").setup({
            ensure_installed = vim.tbl_keys(servers),
        })

        local lspconfig = require("lspconfig")
        local capabilities = vim.lsp.protocol.make_client_capabilities()

        for name, config in pairs(servers) do
            config.capabilities = capabilities
            lspconfig[name].setup(config)
        end

        vim.api.nvim_create_autocmd("LspAttach", {
            callback = function(args)
                local map = function(keys, func, desc)
                    vim.keymap.set("n", keys, func, { buffer = args.buf, desc = "LSP: " .. desc })
                end

                map("gd", vim.lsp.buf.definition, "[G]o to [D]efinition")
                map("K", vim.lsp.buf.hover, "Hover Documentation")
                map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
                map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

            end,
        })
    end,
}
