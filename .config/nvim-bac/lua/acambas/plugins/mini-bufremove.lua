return {
	"echasnovski/mini.bufremove",
	cond = function()
		if vim.g.vscode then
			return false
		else
			return true
		end
	end,
	version = "*",
	config = function()
		require("mini.bufremove").setup()

		vim.keymap.set(
			"n",
			"<C-x>",
			"<cmd>lua MiniBufremove.wipeout(0, true)<CR>",
			{ desc = "[q]uit buffer", silent = true, noremap = true }
		)
	end,
}
