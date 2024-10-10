return {
	{
		"j-morano/buffer_manager.nvim",
		event = "VeryLazy",
		config = function()
			require("buffer_manager").setup({})
			local bmui = require("buffer_manager.ui")
			local opts = { noremap = true }
			local map = vim.keymap.set
			map({ "t", "n" }, "<leader>sb", bmui.toggle_quick_menu, opts)
		end,
	},
}
