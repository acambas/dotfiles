return {
	"stevearc/conform.nvim",
	cond = function()
		if vim.g.vscode then
			return false
		else
			return true
		end
	end,
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")
		conform.setup({
			formatters_by_ft = {
				javascript = { "biome" },
				typescript = { "biome" },
				javascriptreact = { "biome" },
				typescriptreact = { "biome" },
				json = { "biome" },
				html = { "prettier" },
				css = { "prettier" },
				yaml = { "prettier" },
				markdown = { "prettier" },
				lua = { "stylua" },
			},
			format_on_save = {
				lsp_fallback = true,
				async = false,
				timeout_ms = 350,
			},
		})

		vim.keymap.set({ "n", "v" }, "<c-f>", function()
			conform.format({
				lsp_fallback = true,
				async = false,
				timeout_ms = 350,
			})
		end, { desc = "[f]ormat" })
	end,
}
