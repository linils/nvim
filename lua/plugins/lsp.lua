return {
        {
                "hrsh7th/nvim-cmp",
                dependencies = {
                        "hrsh7th/cmp-nvim-lsp",
                        "hrsh7th/cmp-buffer",
                        "hrsh7th/cmp-path",
                        "hrsh7th/cmp-cmdline",
                },
                config = function()
                        local cmp = require("cmp")

                        cmp.setup({
                                snippet = {
                                        expand = function(_) end,
                                },
                                mapping = cmp.mapping.preset.insert({
                                        ["<Tab>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
                                        ["<S-Tab>"] = cmp.mapping.select_prev_item({
                                                behavior = cmp.SelectBehavior
                                                    .Insert
                                        }),
                                        ["<CR>"] = cmp.mapping.confirm({ select = true }),
                                        ["<C-Space>"] = cmp.mapping.complete(),
                                }),
                                sources = cmp.config.sources({
                                        { name = "nvim_lsp" },
                                        { name = "buffer" },
                                        { name = "path" },
                                }),
                        })

                        cmp.setup.cmdline(":", {
                                mapping = cmp.mapping.preset.cmdline(),
                                sources = {
                                        { name = "path" },
                                        { name = "cmdline" },
                                },
                        })

                        cmp.setup.cmdline("/", {
                                mapping = cmp.mapping.preset.cmdline(),
                                sources = {
                                        { name = "buffer" },
                                },
                        })
                end,
        },
        {
                "stevearc/conform.nvim",
                opts = {
                        formatters_by_ft = {
                                lua = { "stylua" },
                                c = { "clang-format" },
                                cpp = { "clang-format" },
                                python = { "black" },
                                javascript = { "prettier" },
                                html = { "prettier" },
                                css = { "prettier" },
                        },
                },
        },
        {
                "neovim/nvim-lspconfig",
                config = function()
                        local cmp = require("cmp_nvim_lsp")
                        local lspconfig = require("lspconfig")
                        local servers = {
                                clangd = { cmd = { "clangd", "--compile-commands-dir=$(pwd)", "-header-insertion=never" } },
                                lua_ls = {
                                        settings = {
                                                Lua = {
                                                        diagnostics = {
                                                                globals = {
                                                                        "vim",
                                                                        "require",
                                                                },
                                                        },
                                                        workspace = {
                                                                library = vim.api.nvim_get_runtime_file("", true),
                                                        },
                                                        telemetry = {
                                                                enable = false,
                                                        },
                                                },
                                        },
                                },
                                glsl_analyzer = {},
                                pylsp = {},
                        }

                        local capabilities = cmp.default_capabilities()
                        for server, config in pairs(servers) do
                                config.capabilities = capabilities
                                lspconfig[server].setup(config)
                        end

                        vim.diagnostic.config({
                                virtual_text = true,
                                signs = true,
                                update_in_insert = false,
                                underline = true,
                                severity_sort = false,
                                float = true,
                        })
                end,
        },
        {
                "nvim-treesitter/nvim-treesitter",
                build = ":TSUpdate",
                config = function()
                        local config = require("nvim-treesitter.configs")
                        config.setup({
                                highlight = { enable = true },
                                auto_install = true,
                        })
                end,
        },
}
