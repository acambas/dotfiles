return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	keys = {
		{
			"<leader><space>",
			function()
				require("snacks").picker.smart({
					layout = {
						-- preset = "ivy",
						-- preset = "vscode",
						-- preset = "dafault",
						-- preset = "dropdown",
						preset = "vertical",
					},
				})
			end,
			desc = "Smart Find Files",
		},
		{
			"<leader>/",
			function()
				require("snacks").picker.grep({
					-- finder = "grep",
					regex = false,
					-- format = "file",
					-- show_empty = true,
					-- live = true, -- live grep by default
					-- supports_live = true,
				})
			end,
			desc = "Grep",
		},
		{
			"<leader>/",
			function()
				require("snacks").picker.grep_word({ regex = false })
			end,
			desc = "Visual selection or word",
			mode = { "v" },
		},
		{
			"<leader>sb",
			function()
				require("snacks").picker.buffers()
			end,
			desc = "Buffers",
		},
		{
			"<leader>sn",
			function()
				require("snacks").picker.notifications()
			end,
			desc = "Notification History",
		},
		{
			"<leader>sj",
			function()
				require("snacks").picker.jumps()
			end,
			desc = "Jumps",
		},
		{
			"<leader>sq",
			function()
				require("snacks").picker.qflist()
			end,
			desc = "Quickfix List",
		},
		-- lsp picker
		{
			"<leader>sd",
			function()
				require("snacks").picker.diagnostics()
			end,
			desc = "Diagnostics",
		},
		{
			"gd",
			function()
				require("snacks").picker.lsp_definitions()
			end,
			desc = "Goto Definition",
		},
		{
			"gD",
			function()
				require("snacks").picker.lsp_declarations()
			end,
			desc = "Goto Declaration",
		},
		{
			"gr",
			function()
				require("snacks").picker.lsp_references()
			end,
			nowait = true,
			desc = "References",
		},
		{
			"gI",
			function()
				require("snacks").picker.lsp_implementations()
			end,
			desc = "Goto Implementation",
		},
		{
			"gt",
			function()
				require("snacks").picker.lsp_type_definitions()
			end,
			desc = "Goto T[y]pe Definition",
		},
		{
			"<leader>ss",
			function()
				require("snacks").picker.lsp_symbols()
			end,
			desc = "LSP Symbols",
		},
	},
	config = function()
		local snacks = require("snacks")
		snacks.setup({
			image = { enabled = true },
			layout = {
				preview = "main",
				preset = "ivy",
			},
			picker = {
				win = {
					input = {
						keys = {
							["<c-q>"] = { "close", mode = { "i" } },
							["<leader>q"] = { "qflist", mode = { "n" } },
						},
					},
				},
			},
		})
		vim.keymap.set("n", "<leader>gf", function()
			snacks.lazygit.log_file()
		end)
		vim.keymap.set("n", "<leader>gg", function()
			snacks.lazygit.open()
		end)
		vim.keymap.set("n", "<leader>gl", function()
			snacks.lazygit.log()
		end)
	end,
}
