return {
	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "v3.x",
		enabled = true,
		cond = function()
			if vim.g.vscode then
				return false
			else
				return true
			end
		end,

		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			-- { "j-hui/fidget.nvim", tag = "legacy", opts = {} },
			"folke/neodev.nvim",
			"neovim/nvim-lspconfig",
			"hrsh7th/nvim-cmp",
			"nvim-tree/nvim-web-devicons",
			"onsails/lspkind.nvim",
			{
				"L3MON4D3/LuaSnip",
				-- follow latest release.
				version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
				-- install jsregexp (optional!).
				build = "make install_jsregexp",
			},
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-buffer",
			"rafamadriz/friendly-snippets",
			"aznhe21/actions-preview.nvim",
			-- "jmbuhr/otter.nvim",
			"pmizio/typescript-tools.nvim",
			"nvim-lua/plenary.nvim",
		},
		config = function()
			local lsp_zero = require("lsp-zero")
			require("actions-preview").setup()
			lsp_zero.on_attach(function(_, bufnr)
				local nmap = function(keys, func, desc)
					if desc then
						desc = "LSP: " .. desc
					end
					vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
				end
				-- see :help lsp-zero-keybindings
				-- to learn the available actions
				lsp_zero.default_keymaps({ buffer = bufnr })

				nmap("gD", vim.lsp.buf.declaration, "[g]o to [D]eclaration")
				nmap("<leader>rn", vim.lsp.buf.rename, "[r]e[n]ame")
				nmap("gD", vim.lsp.buf.declaration, "[g]o to [D]eclaration")
				nmap("gd", vim.lsp.buf.definition, "[g]o to [d]efinition")
				nmap("gh", vim.lsp.buf.hover, "go to [h]over")
				nmap("gi", vim.lsp.buf.implementation, "[g]o to [i]mplementation")
				nmap("gI", require("telescope.builtin").lsp_implementations, "[g]oto [I]mplementations")
				nmap("gt", vim.lsp.buf.type_definition, "[g]o to [t]ype definition")
				nmap("<leader>sd", require("telescope.builtin").diagnostics, "[S]earch [D]iagnostics")
				nmap("<leader>rn", vim.lsp.buf.rename, "[r]e[n]ame")
				nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[d]ocument [s]ymbols")
				nmap("gr", require("telescope.builtin").lsp_references, "[g]oto [R]eferences")
				vim.keymap.set(
					{ "n", "v" },
					"<leader>ca",
					-- vim.lsp.buf.code_action,
					require("actions-preview").code_actions,
					{ buffer = bufnr, desc = "[C]ode [A]ctions" }
				)
			end)

			local ok, util = pcall(require, "lspconfig.util")
			if not ok then
				vim.notify("lspconfig.util could not be loaded")
				return
			end
			local lspconfig = require("lspconfig")
			local eslint_config = {
				root_dir = util.root_pattern(
					".eslintrc.js",
					".eslintrc.cjs",
					".eslintrc.yaml",
					".eslintrc.yml",
					".eslintrc.json"
				),
				single_file_support = false,
			}

			local biome_config = {
				root_dir = util.root_pattern("biome.json"),
				single_file_support = false,
			}

			require("mason").setup({})
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"rust_analyzer",
					-- "vtsls",
					-- "tsserver",
					"eslint",
					"html",
					"cssls",
					"jsonls",
					-- "tailwindcss",
					-- "prettier",
					-- "prettierd",
				},
				-- automatic_installation = true,

				handlers = {
					lsp_zero.default_setup,
					eslint = function()
						lspconfig.eslint.setup(eslint_config)
					end,
					biome = function()
						lspconfig.biome.setup(biome_config)
					end,
					--
				},
			})
			require("typescript-tools").setup({
				-- spawn additional tsserver instance to calculate diagnostics on it
				separate_diagnostic_server = true,
				-- "change"|"insert_leave" determine when the client asks the server about diagnostic
				publish_diagnostic_on = "insert_leave",
			})
			local cmp = require("cmp")

			local luasnip = require("luasnip")
			require("luasnip.loaders.from_vscode").lazy_load()
			luasnip.config.setup()
			cmp.setup({
				sources = {
					-- { name = "otter" },
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "buffer" },
					{ name = "path" },
				},
				formatting = lsp_zero.cmp_format(),
				mapping = cmp.mapping.preset.insert({
					["<C-n>"] = cmp.mapping.select_next_item(),
					["<C-p>"] = cmp.mapping.select_prev_item(),
					["<C-d>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<CR>"] = cmp.mapping.confirm({
						behavior = cmp.ConfirmBehavior.Replace,
						select = true,
					}),
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.expand_or_locally_jumpable() then
							luasnip.expand_or_jump()
						else
							fallback()
						end
					end, { "i", "s" }),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.locally_jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
				}),
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
			})
		end,
	},
}
