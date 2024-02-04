return {
	"j-morano/buffer_manager.nvim",
	event = "VeryLazy",
	enabled = true,
	cond = function()
		if vim.g.vscode then
			return false
		else
			return true
		end
	end,
	config = function()
		local opts = { noremap = true }
		local map = vim.keymap.set
		-- Setup
		require("buffer_manager").setup({
			select_menu_item_commands = {
				v = {
					key = "<C-v>",
					command = "vsplit",
				},
				h = {
					key = "<C-h>",
					command = "split",
				},
			},
			focus_alternate_buffer = false,
			short_file_names = true,
			short_term_names = true,
			loop_nav = false,
		})
		local bmui = require("buffer_manager.ui")
		map({ "t", "n" }, "<leader><space>", bmui.toggle_quick_menu, opts)
		map({ "t", "n" }, "<leader>bb", bmui.toggle_quick_menu, opts)
	end,
}
