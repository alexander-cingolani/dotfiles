-- JDTLS Configuration for Java with DAP Support
local jdtls = require("jdtls")
local mason_path = vim.fn.stdpath("data") .. "/mason/"

-- Find the java-debug and java-test jars installed by Mason
local bundles = {
    vim.fn.glob(mason_path .. "packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar", true),
}
vim.list_extend(bundles, vim.split(vim.fn.glob(mason_path .. "packages/java-test/extension/server/*.jar", true), "\n"))

local workspace_dir = vim.fn.stdpath("data") .. "/site/java/workspace-root/" .. vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")

local config = {
    cmd = {
        -- JDTLS executable path from Mason
        mason_path .. "bin/jdtls",
        "-data", workspace_dir,
    },
    root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }),
    
    -- Add the debug and test bundles
    init_options = {
        bundles = bundles,
    },
}

-- Attach the JDTLS client
require("jdtls").start_or_attach(config)

-- After JDTLS is attached, load the main classes for DAP and setup test keybindings
vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client and client.name == "jdtls" then
            require("jdtls").setup_dap({ hotcodereplace = "auto" })
            require("jdtls.dap").setup_dap_main_class_configs()
            
            -- Optional Java-specific test bindings
            local map = function(keys, func, desc)
                vim.keymap.set("n", keys, func, { buffer = args.buf, desc = "Java: " .. desc })
            end
            map("<leader>jt", require("jdtls").test_class, "Test Class")
            map("<leader>jm", require("jdtls").test_nearest_method, "Test Method")
        end
    end,
})
