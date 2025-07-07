return {
	{
		"Saghen/blink.cmp",
		opts = {
			completion = { documentation = { auto_show = true } },
			fuzzy = { implementation = "lua" },
			keymap = {
				preset = "default", -- start with default preset
				["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
				["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
				["<CR>"] = { "accept", "fallback" },
				["<Esc>"] = { "hide", "fallback" },
				["<PageUp>"] = { "scroll_documentation_up", "fallback" },
				["<PageDown>"] = { "scroll_documentation_down", "fallback" },
			},
		},
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
			local cmp = require("blink.cmp")
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

			for server, config in pairs(servers) do
				config.capabilities = cmp.get_lsp_capabilities(config.capabilities)
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
				indent = { enable = true },
				auto_install = true,
			})
		end,
	},
}
