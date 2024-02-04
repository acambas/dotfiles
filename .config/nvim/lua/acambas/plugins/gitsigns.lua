return {
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
}
