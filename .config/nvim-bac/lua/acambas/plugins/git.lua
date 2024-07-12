return {
	{ "akinsho/git-conflict.nvim", version = "*", config = true },
	{ "sindrets/diffview.nvim" },
	{
		"FabijanZulj/blame.nvim",
		config = function()
			require("blame").setup()
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		event = "VeryLazy",
		cond = function()
			if vim.g.vscode then
				return false
			else
				return true
			end
		end,
		config = function()
			require("gitsigns").setup()
		end,
	},
}
