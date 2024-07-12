return {
	"folke/which-key.nvim",
	cond = function()
		if vim.g.vscode then
			return false
		else
			return true
		end
	end,
	config = true,
}
