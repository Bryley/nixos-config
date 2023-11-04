local lsp = require("lspconfig")
local cmp = require("cmp_nvim_lsp")
local navic = require("nvim-navic")

local capabilities = cmp.default_capabilities()
local on_attach = function(client, bufnr)
    if client.server_capabilities.documentSymbolProvider then
        navic.attach(client, bufnr)
    end
end

-- If you need any more language setups look at:
-- https://github.com/williamboman/mason-lspconfig.nvim#available-lsp-servers
lsp.lua_ls.setup({
    capabilities = capabilities,
    settings = {
        Lua = {
            diagnostics = {
                globals = {
                    "vim",
                    "describe",
                    "it",
                    "before_each",
                    "after_each",
                    "before",
                    "after",
                    "assert",
                    "spy",
                    "mock",
                    "stub",
                    "pending",
                    "teardown",
                    "setup",
                    "lazy_setup",
                    "lazy_teardown",
                },
            },
        },
    },
})
-- lsp.tsserver.setup({
-- 	capabilities = capabilities,
-- 	on_attach = on_attach,
-- })
lsp.pyright.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
        python = {
            analysis = {
                autoSearchPaths = true,
                diagnosticMode = "workspace",
                useLibraryCodeForTypes = true,
            },
        },
    },
})
lsp.vtsls.setup({
    capabilities = capabilities,
    on_attach = on_attach,
})
lsp.svelte.setup({
    capabilities = capabilities,
    on_attach = on_attach,
})
lsp.tailwindcss.setup({
    capabilities = capabilities,
    on_attach = on_attach,
})
lsp.rust_analyzer.setup({
    capabilities = capabilities,
    on_attach = on_attach,
})
lsp.dockerls.setup({
    capabilities = capabilities,
    on_attach = on_attach,
})
lsp.jsonls.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
        json = {
            schemas = require("schemastore").json.schemas(),
            validate = { enable = true },
        },
    },
})
lsp.yamlls.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
        yaml = {
            schemas = require("schemastore").yaml.schemas(),
        },
    },
})
lsp.ltex.setup({
    capabilities = capabilities,
    on_attach = on_attach,
})
lsp.kotlin_language_server.setup({
    capabilities = capabilities,
    on_attach = on_attach,
})
lsp.gopls.setup({
    capabilities = capabilities,
    on_attach = on_attach,
})
lsp.volar.setup({
    capabilities = capabilities,
    on_attach = on_attach,
})
lsp.hls.setup({
    capabilities = capabilities,
    on_attach = on_attach,
})
lsp.nixd.setup({
    capabilities = capabilities,
    on_attach = on_attach,
})
lsp.dartls.setup({
    capabilities = capabilities,
    on_attach = on_attach,
})
