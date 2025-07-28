return {
	{
		enabled = true,
		"VonHeikemen/lsp-zero.nvim",
		branch = "v3.x",
		event = "VeryLazy",
		dependencies = {
			{ "neovim/nvim-lspconfig" },
			{
				"rachartier/tiny-inline-diagnostic.nvim",
				event = "VeryLazy", -- Or `LspAttach`
				priority = 1000, -- needs to be loaded in first
				config = function()
					require("tiny-inline-diagnostic").setup()
				end,
			},
			{
				"saghen/blink.cmp",
				lazy = false, -- lazy loading handled internally
				-- optional: provides snippets for the snippet source
				dependencies = "rafamadriz/friendly-snippets",

				enabled = true,

				-- use a release tag to download pre-built binaries
				version = "*",
				opts = {
					keymap = { preset = "enter" },

					completion = {
						list = { selection = { preselect = false, auto_insert = true } },
					},
				},
			},
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			{
				"stevearc/conform.nvim",
				-- opts = {},
				config = function()
					require("conform").setup({
						format_on_save = {
							-- These options will be passed to conform.format()
							timeout_ms = 300,
							lsp_format = "fallback",
						},
						formatters_by_ft = {
							lua = { "stylua" },
							-- Conform will run multiple formatters sequentially
							-- Use a sub-list to run only the first available formatter
							--     javascript = { "prettierd", "prettier", stop_after_first = true },

							javascript = { "prettierd", "prettier", stop_after_first = true },
							typescript = { "prettierd", "prettier", stop_after_first = true },
							javascriptreact = { "prettierd", "prettier", stop_after_first = true },
							typescriptreact = { "prettierd", "prettier", stop_after_first = true },
							json = { "prettierd", "prettier", stop_after_first = true },
							html = { "prettierd", "prettier", stop_after_first = true },
							css = { "prettierd", "prettier", stop_after_first = true },
							yaml = { "prettierd", "prettier", stop_after_first = true },
							markdown = { "prettierd", "prettier", stop_after_first = true },
						},
					})
				end,
			},
			{
				"aznhe21/actions-preview.nvim",
			},
			{
				"dmmulroy/ts-error-translator.nvim",
				config = function()
					require("ts-error-translator").setup()
				end,
			},
			{
				"windwp/nvim-autopairs",
				event = "InsertEnter",
				config = true,
				-- use opts = {} for passing setup options
				-- this is equalent to setup({}) function
			},
			{
				"RRethy/vim-illuminate",
				config = function()
					require("illuminate").configure({
						-- providers: provider used to get references in the buffer, ordered by priority
						providers = {
							"lsp",
							"treesitter",
							-- 'regex',
						},
						modes_allowlist = { "n" },
						-- case_insensitive_regex: sets regex case sensitivity
						case_insensitive_regex = false,
					})
				end,
			},
			{
				"zeioth/garbage-day.nvim",
				dependencies = "neovim/nvim-lspconfig",
				event = "VeryLazy",
				opts = {
					-- your options here
					-- grace_period = 60 * 5
				},
			},
		},
		config = function()
			vim.keymap.set("n", "gh", vim.lsp.buf.hover, { desc = "go to hover" })
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "go to hover" })
			vim.opt.signcolumn = "yes"
			vim.diagnostic.config({
				virtual_text = false,
				-- virtual_lines = {
				-- 	-- Only show virtual line diagnostics for the current cursor line
				-- 	current_line = true,
				-- },
				signs = true,
				-- virtual_text = { current_line = true },
			})

			-------------------------------------MASON------------------------------------------------

			-- to learn how to use mason.nvim
			-- read this: https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guide/integrate-with-mason-nvim.md
			require("mason").setup({})
			require("mason-lspconfig").setup({
				ensure_installed = {
					"vtsls",
					"cssls",
					"jsonls",
					"eslint",
					"marksman",
					"lua_ls",
					"bashls",
				},
				handlers = {
					--- this first function is the "default handler"
					--- it applies to every language server without a "custom handler"
					function(server_name)
						require("lspconfig")[server_name].setup({})
					end,
					vtsls = function()
						require("lspconfig").vtsls.setup({
							settings = {
								typescript = {
									preferences = {
										includePackageJsonAutoImports = "off",
										updateImportsOnPaste = "off",
									},
								},
								vtsls = {
									experimental = {
										completion = {
											entriesLimit = 25,
											enableServerSizeFuzzyMatch = true,
										},
									},
								},
							},
						})
					end,
					cssls = function()
						local capabilities = vim.lsp.protocol.make_client_capabilities()
						capabilities.textDocument.completion.completionItem.snippetSupport = true
						require("lspconfig").cssls.setup({
							capabilities = capabilities,
						})
					end,
				},
			})
		end,
	},
}
