return {
	{
		--        Highlight, edit, and navigate code
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		dependencies = {
			{
				"windwp/nvim-ts-autotag",
				event = "VeryLazy",
				config = function()
					require("nvim-ts-autotag").setup({
						opts = {
							-- Defaults
							enable_close = true, -- Auto close tags
							enable_rename = true, -- Auto rename pairs of tags
							enable_close_on_slash = false, -- Auto close on trailing </
						},
					})
				end,
			},
			{
				"nvim-treesitter/nvim-treesitter-context",
				event = "VeryLazy",
				opts = {
					enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
					max_lines = 3, -- How many lines the window should span. Values <= 0 mean no limit.
					min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
					line_numbers = true,
					multiline_threshold = 5, -- Maximum number of lines to show for a single context
					trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
					mode = "cursor", -- Line used to calculate context. Choices: 'cursor', 'topline'
					-- Separator between context and content. Should be a single character string, like '-'.
					-- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
					separator = "-",
					zindex = 20, -- The Z-index of the context window
					on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
				},
			},
		},
		build = ":TSUpdate",
		config = function()
			local treesitter = require("nvim-treesitter")

			treesitter.install({
				"c",
				"go",
				"javascript",
				"typescript",
				"css",
				"html",
				"json",
				"regex",
				"lua",
				"http",
			})
		end,
	},
}
