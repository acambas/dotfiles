return {
	{
		enabled = false,
		"VonHeikemen/lsp-zero.nvim",
		branch = "v3.x",
		event = "VeryLazy",
		dependencies = {
			{ "neovim/nvim-lspconfig" },
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/nvim-cmp" },
			{ "L3MON4D3/LuaSnip" },
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-path" },
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
							javascript = { { "prettierd", "prettier" } },
							typescript = { { "prettierd", "prettier" } },
							javascriptreact = { { "prettierd", "prettier" } },
							typescriptreact = { { "prettierd", "prettier" } },
							json = { { "prettierd", "prettier" } },
							html = { { "prettierd", "prettier" } },
							css = { { "prettierd", "prettier" } },
							yaml = { { "prettierd", "prettier" } },
							markdown = { { "prettierd", "prettier" } },
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
				"pmizio/typescript-tools.nvim",
				dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
				-- opts = {},
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
			local lsp_zero = require("lsp-zero")
			---@diagnostic disable-next-line: unused-local
			lsp_zero.on_attach(function(client, bufnr)
				-- see :help lsp-zero-keybindings
				-- to learn the available actions
				lsp_zero.default_keymaps({ buffer = bufnr })
				local nmap = function(keys, func, desc)
					if desc then
						desc = "LSP: " .. desc
					end
					vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
				end

				nmap("gd", require("telescope.builtin").lsp_definitions, "go to definition")
				nmap("gD", vim.lsp.buf.declaration, "go to Declaration")
				nmap("gi", vim.lsp.buf.implementation, "go to implementation")
				nmap("gt", require("telescope.builtin").lsp_type_definitions, "go to type definitions")
				nmap("gh", vim.lsp.buf.hover, "go to hover")
				nmap("<leader>cd", require("telescope.builtin").diagnostics, "go to diagnostics")
				nmap("gr", require("telescope.builtin").lsp_references, "go to references")

				nmap("<leader>cr", require("telescope.builtin").lsp_references, "go to references")
				vim.keymap.set({ "v", "n" }, "<leader>ca", require("actions-preview").code_actions)
				vim.keymap.set("n", "ge", "<cmd>lua vim.diagnostic.open_float()<cr>")
				vim.keymap.set("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<cr>")
				vim.keymap.set("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<cr>")
			end)

			vim.diagnostic.config({
				virtual_text = false,
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
				},
			})

			-------------------------------------AUTOCOMPLETE------------------------------------------------
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			require("luasnip.loaders.from_vscode").lazy_load()
			luasnip.config.setup()

			cmp.setup({
				sources = {
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "path" },
					{ name = "buffer" },
				},
				formatting = lsp_zero.cmp_format(),
				mapping = {
					["<CR>"] = cmp.mapping.confirm({ select = false }),
					-- ['<C-e>'] = cmp.mapping.abort(),
					["<Up>"] = cmp.mapping.select_prev_item({ behavior = "select" }),
					["<Down>"] = cmp.mapping.select_next_item({ behavior = "select" }),
					["<C-j>"] = cmp.mapping(function(fallback)
						if luasnip.expand_or_locally_jumpable() then
							luasnip.expand_or_jump()
						else
							fallback()
						end
					end),
					["<C-p>"] = cmp.mapping(function()
						if cmp.visible() then
							cmp.select_prev_item({ behavior = "insert" })
						else
							cmp.complete()
						end
					end),
					["<C-n>"] = cmp.mapping(function()
						if cmp.visible() then
							cmp.select_next_item({ behavior = "insert" })
						else
							cmp.complete()
						end
					end),
				},
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
			})
		end,
	},
}
