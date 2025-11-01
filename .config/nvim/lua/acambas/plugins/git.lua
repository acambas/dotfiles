return {
	{
		"akinsho/git-conflict.nvim",
		version = "*",
		config = false,
		event = "VeryLazy",
	},
	{
		"sindrets/diffview.nvim",
		version = "*",
		config = true,
		event = "VeryLazy",
	},
	{
		"FabijanZulj/blame.nvim",
		event = "VeryLazy",
		config = function()
			require("blame").setup()
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		event = "VeryLazy",
		enabled = false,
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
